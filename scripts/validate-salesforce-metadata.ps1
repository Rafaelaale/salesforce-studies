param([switch]$NoExit)

$ErrorActionPreference = 'Stop'

$projectRoot = Split-Path -Parent $PSScriptRoot
$metadataRoot = Join-Path $projectRoot 'force-app/main/default'
$manifestPath = Join-Path $projectRoot 'manifest/package.xml'
$forceIgnorePath = Join-Path $projectRoot '.forceignore'
$script:ValidationErrors = [System.Collections.Generic.List[string]]::new()
$script:ForceIgnoreExactFiles = @()

if (Test-Path -LiteralPath $forceIgnorePath) {
    $script:ForceIgnoreExactFiles = @(
        Get-Content -LiteralPath $forceIgnorePath |
            ForEach-Object { $_.Trim() } |
            Where-Object { $_ -and $_ -notmatch '^#' -and $_ -notmatch '[*?]' } |
            ForEach-Object { $_.TrimStart('/').Replace('\', '/') }
    )
}

function Add-ValidationError {
    param([string]$Message)
    [void]$script:ValidationErrors.Add($Message)
}

function Read-XmlFile {
    param([string]$Path)
    try {
        return [xml](Get-Content -LiteralPath $Path -Raw)
    }
    catch {
        Add-ValidationError "Invalid XML in $($Path.Replace($projectRoot, '.'))"
        return $null
    }
}

function Get-ValidationMembers {
    param(
        [string]$TypeName,
        [string]$Member
    )

    if ($Member -ne '*') {
        return @($Member)
    }

    switch ($TypeName) {
        'ApexClass' {
            $path = Join-Path $metadataRoot 'classes'
            if (Test-Path -LiteralPath $path) {
                return @(
                    Get-ChildItem -LiteralPath $path -Filter '*.cls' -File |
                        Where-Object {
                            $relativePath = $_.FullName.Substring($projectRoot.Length + 1).Replace('\', '/')
                            $script:ForceIgnoreExactFiles -notcontains $relativePath
                        } |
                        ForEach-Object { $_.BaseName }
                )
            }
        }
        'Flow' {
            $path = Join-Path $metadataRoot 'flows'
            if (Test-Path -LiteralPath $path) {
                return @(Get-ChildItem -LiteralPath $path -Filter '*.flow-meta.xml' -File | ForEach-Object { $_.Name -replace '\.flow-meta\.xml$', '' })
            }
        }
        'CustomObject' {
            $path = Join-Path $metadataRoot 'objects'
            if (Test-Path -LiteralPath $path) {
                return @(Get-ChildItem -LiteralPath $path -Directory | Where-Object {
                    Test-Path -LiteralPath (Join-Path $_.FullName "$($_.Name).object-meta.xml")
                } | ForEach-Object { $_.Name })
            }
        }
    }

    return @()
}

if (-not (Test-Path -LiteralPath $metadataRoot)) {
    Add-ValidationError "Salesforce source directory not found: $metadataRoot"
}
if (-not (Test-Path -LiteralPath $manifestPath)) {
    Add-ValidationError "Manifest not found: $manifestPath"
}

if (Test-Path -LiteralPath $metadataRoot) {
    $metadataDirectoryTypes = @{
        aura = @('AuraDefinitionBundle')
        classes = @('ApexClass')
        flows = @('Flow')
        lwc = @('LightningComponentBundle')
        namedCredentials = @('NamedCredential')
        objects = @('CustomObject', 'CustomField')
        pages = @('ApexPage')
        permissionsets = @('PermissionSet')
        remoteSiteSettings = @('RemoteSiteSetting')
        staticresources = @('StaticResource')
        triggers = @('ApexTrigger')
    }
    $intentionallyExcludedMetadataDirectories = @('aiAuthoringBundles')

    foreach ($sourceDirectory in (Get-ChildItem -LiteralPath $metadataRoot -Directory)) {
        if (-not $metadataDirectoryTypes.ContainsKey($sourceDirectory.Name) -and
            $intentionallyExcludedMetadataDirectories -notcontains $sourceDirectory.Name) {
            Add-ValidationError "Unmapped Salesforce source folder '$($sourceDirectory.Name)'; add its metadata type to the manifest or explicitly exclude the folder."
        }
    }

    $rootMetadataFiles = Get-ChildItem -LiteralPath $metadataRoot -File | Where-Object {
        $_.Name -match '\.(cls|trigger|page)$|\.(cls|trigger|page)-meta\.xml$|\.flow-meta\.xml$'
    }
    foreach ($rootMetadataFile in $rootMetadataFiles) {
        $relativePath = $rootMetadataFile.FullName.Substring($projectRoot.Length + 1).Replace('\', '/')
        if ($script:ForceIgnoreExactFiles -notcontains $relativePath) {
            Add-ValidationError "Salesforce source file '$relativePath' is outside its metadata folder and would be omitted from the manifest deploy."
        }
    }

    $flowsPath = Join-Path $metadataRoot 'flows'
    if (Test-Path -LiteralPath $flowsPath) {
        $xmlFiles = Get-ChildItem -LiteralPath $flowsPath -Filter '*.xml' -File -Recurse
        foreach ($xmlFile in $xmlFiles) {
            try {
                [xml]$candidate = Get-Content -LiteralPath $xmlFile.FullName -Raw
                if ($candidate.DocumentElement.LocalName -eq 'Flow' -and $xmlFile.Name -notmatch '\.flow-meta\.xml$') {
                    Add-ValidationError "Flow must use .flow-meta.xml: $($xmlFile.FullName.Replace($projectRoot, '.'))"
                }
            }
            catch {
                if ($xmlFile.Name -match 'flow|\.cls\.\.xml') {
                    Add-ValidationError "Cannot parse Flow metadata: $($xmlFile.FullName.Replace($projectRoot, '.'))"
                }
            }
        }
    }
}

$manifest = $null
if (Test-Path -LiteralPath $manifestPath) {
    $manifest = Read-XmlFile $manifestPath
}

if ($manifest) {
    $typeEntries = $manifest.SelectNodes("/*[local-name()='Package']/*[local-name()='types']")
    foreach ($sourceDirectory in (Get-ChildItem -LiteralPath $metadataRoot -Directory)) {
        if ($metadataDirectoryTypes.ContainsKey($sourceDirectory.Name)) {
            foreach ($metadataType in $metadataDirectoryTypes[$sourceDirectory.Name]) {
                $manifestType = $manifest.SelectSingleNode("/*[local-name()='Package']/*[local-name()='types'][*[local-name()='name']='$metadataType']")
                if (-not $manifestType) {
                    Add-ValidationError "Source folder '$($sourceDirectory.Name)' contains Salesforce metadata, but '$metadataType' is missing from the manifest."
                }
            }
        }
    }

    foreach ($typeEntry in $typeEntries) {
        $nameNode = $typeEntry.SelectSingleNode("./*[local-name()='name']")
        if (-not $nameNode) {
            Add-ValidationError 'Manifest contains a types block without a name.'
            continue
        }

        $typeName = $nameNode.InnerText
        foreach ($memberNode in $typeEntry.SelectNodes("./*[local-name()='members']")) {
            $manifestMember = $memberNode.InnerText
            foreach ($member in (Get-ValidationMembers -TypeName $typeName -Member $manifestMember)) {
            if ($typeName -eq 'ApexClass') {
                $classPath = Join-Path $metadataRoot "classes/$member.cls"
                if (-not (Test-Path -LiteralPath $classPath)) {
                    Add-ValidationError "Manifest ApexClass '$member' has no .cls file."
                }
                if (-not (Test-Path -LiteralPath "$classPath-meta.xml")) {
                    Add-ValidationError "Manifest ApexClass '$member' has no .cls-meta.xml file."
                }
                else {
                    [void](Read-XmlFile "$classPath-meta.xml")
                }
            }
            elseif ($typeName -eq 'Flow') {
                $flowPath = Join-Path $metadataRoot "flows/$member.flow-meta.xml"
                if (-not (Test-Path -LiteralPath $flowPath)) {
                    Add-ValidationError "Manifest Flow '$member' has no .flow-meta.xml file."
                    continue
                }

                $flow = Read-XmlFile $flowPath
                if (-not $flow) { continue }

                foreach ($action in $flow.SelectNodes("//*[local-name()='actionCalls']")) {
                    $actionTypeNode = $action.SelectSingleNode("./*[local-name()='actionType']")
                    if (-not $actionTypeNode -or $actionTypeNode.InnerText -ne 'apex') { continue }
                    $actionNameNode = $action.SelectSingleNode("./*[local-name()='actionName']")
                    if (-not $actionNameNode) {
                        Add-ValidationError "Flow '$member' has an Apex action without actionName."
                        continue
                    }

                    $actionName = $actionNameNode.InnerText
                    if ($actionName.Contains('.')) {
                        Add-ValidationError "Flow '$member' must reference the Apex class name, not '$actionName'."
                        continue
                    }

                    $classPath = Join-Path $metadataRoot "classes/$actionName.cls"
                    if (-not (Test-Path -LiteralPath $classPath)) {
                        Add-ValidationError "Flow '$member' references missing Apex class '$actionName'."
                        continue
                    }

                    if ((Get-Content -LiteralPath $classPath -Raw) -notmatch '@InvocableMethod\b') {
                        Add-ValidationError "Flow '$member' references '$actionName' without an @InvocableMethod."
                    }
                }

                foreach ($apexType in $flow.SelectNodes("//*[local-name()='apexClass']")) {
                    $typeParts = $apexType.InnerText -split '\.'
                    if ($typeParts.Count -lt 2) { continue }
                    $classPath = Join-Path $metadataRoot "classes/$($typeParts[0]).cls"
                    if (-not (Test-Path -LiteralPath $classPath)) {
                        Add-ValidationError "Flow '$member' references missing Apex-defined class '$($typeParts[0])'."
                        continue
                    }
                    $nestedPattern = '\bclass\s+' + [regex]::Escape($typeParts[-1]) + '\b'
                    if ((Get-Content -LiteralPath $classPath -Raw) -notmatch $nestedPattern) {
                        Add-ValidationError "Flow '$member' references missing Apex type '$($apexType.InnerText)'."
                    }
                }
            }
            elseif ($typeName -eq 'CustomObject') {
                $objectPath = Join-Path $metadataRoot "objects/$member/$member.object-meta.xml"
                if (-not (Test-Path -LiteralPath $objectPath)) {
                    Add-ValidationError "Manifest CustomObject '$member' has no matching object metadata file."
                }
            }
            }
        }
    }
}

if ($script:ValidationErrors.Count -gt 0) {
    Write-Host 'Salesforce metadata preflight failed:' -ForegroundColor Red
    foreach ($validationError in $script:ValidationErrors) {
        Write-Host "- $validationError" -ForegroundColor Red
    }
    if ($NoExit) { return $false }
    exit 1
}

Write-Host 'Salesforce metadata preflight passed.' -ForegroundColor Green
return $true