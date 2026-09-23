# Exercício do curso: Passagens Salesforce

Este projeto preserva o exercício `TicketsController` separado do projeto `academia-salesforce`.

O controller depende dos objetos customizados `Aeroporto__c`, `Voo__c` e `Ticket__c`, que precisam existir neste projeto antes do deploy.

## Arquivo principal

`force-app/main/default/classes/TicketsController.cls`

## Deploy

```powershell
sf project deploy start --source-dir force-app/main/default --target-org <org-do-curso> --wait 10
```

Não faça esse deploy na org ou no projeto da academia.
