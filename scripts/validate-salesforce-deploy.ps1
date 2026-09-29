param(
    [Parameter(Mandatory = $true)]
    [string]$TargetOrg,

    [string]$Manifest = 'manifest/package.xml',

    [ValidateRange(1, 120)]
    [int]$WaitMinutes = 30,

    [switch]$Deploy
)

$ErrorActionPreference = 'Stop'
$projectRoot = Split-Path -Parent $PSScriptRoot
$manifestPath = Join-Path $projectRoot $Manifest
$metadataCheck = Join-Path $PSScriptRoot 'validate-salesforce-metadata.ps1'

if (-not (Get-Command sf -ErrorAction SilentlyContinue)) {
    throw 'Salesforce CLI (sf) is not installed or not on PATH.'
}
if (-not (Test-Path -LiteralPath $manifestPath)) {
    throw "Manifest not found: $manifestPath"
}
$localCheck = & $metadataCheck -NoExit
if ($localCheck -contains $false) {
    throw 'Local metadata validation failed; remote validation was not started.'
}

$predictionCredentialPath = Join-Path $projectRoot 'force-app/main/default/namedCredentials/API_Previsao_Demanda_NC.namedCredential-meta.xml'
if (Test-Path -LiteralPath $predictionCredentialPath) {
    [xml]$predictionCredential = Get-Content -LiteralPath $predictionCredentialPath -Raw
    $endpointNode = $predictionCredential.SelectSingleNode("/*[local-name()='NamedCredential']/*[local-name()='endpoint']")
    if (-not $endpointNode -or [string]::IsNullOrWhiteSpace($endpointNode.InnerText)) {
        throw 'Prediction Named Credential has no endpoint.'
    }

    $predictionEndpoint = $endpointNode.InnerText.TrimEnd('/')
    $predictionBody = @{
        Recursos_Marketing = 1.5
        Eventos_Promocionais = 2
        Historico_Vendas_Mes_Anterior = 10
    } | ConvertTo-Json
    try {
        $predictionResult = Invoke-RestMethod -Method Post -Uri "$predictionEndpoint/prever" -ContentType 'application/json' -Body $predictionBody -TimeoutSec 20
    }
    catch {
        throw "Prediction API preflight failed at '$predictionEndpoint': $($_.Exception.Message)"
    }
    if ($null -eq $predictionResult.previsao) {
        throw "Prediction API returned no 'previsao' value from '$predictionEndpoint'."
    }
    Write-Host "Prediction API preflight passed: $($predictionResult.previsao)" -ForegroundColor Green
}

Push-Location $projectRoot
try {
    $testArgs = @('--test-level', 'RunLocalTests')
    & sf project deploy start --dry-run @testArgs --manifest $Manifest --target-org $TargetOrg --wait $WaitMinutes
    if ($LASTEXITCODE -ne 0) {
        throw 'Salesforce dry-run validation failed. No metadata was deployed.'
    }
}
finally {
    Pop-Location
}

Write-Host 'Salesforce dry-run passed. No metadata was deployed.' -ForegroundColor Green

if (-not $Deploy) {
    return
}

$confirmation = Read-Host "Type DEPLOY to publish the validated manifest to '$TargetOrg'"
if ($confirmation -cne 'DEPLOY') {
    Write-Host 'Deployment cancelled; no metadata was published.' -ForegroundColor Yellow
    return
}

Push-Location $projectRoot
try {
    & sf project deploy start @testArgs --manifest $Manifest --target-org $TargetOrg --wait $WaitMinutes
    if ($LASTEXITCODE -ne 0) {
        throw 'Salesforce deployment failed. Check the CLI output for details.'
    }
}
finally {
    Pop-Location
}

Write-Host 'Salesforce deployment completed.' -ForegroundColor Green

$smokeTestPath = Join-Path $projectRoot 'scripts/apex/smoke_previsao_api.apex'
if (Test-Path -LiteralPath $smokeTestPath) {
    Write-Host 'Running prediction API smoke test in Salesforce...' -ForegroundColor Cyan
    & sf apex run --target-org $TargetOrg --file $smokeTestPath
    if ($LASTEXITCODE -ne 0) {
        throw 'Post-deploy prediction API smoke test failed.'
    }
}