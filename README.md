# Salesforce Studies & Projects

Repositório público dos estudos e projetos práticos de Rafael Alexandre Oliveira
Araújo na plataforma Salesforce.

## Projetos

### Gestão de Academia

Aplicação para cadastro de alunos, controle de mensalidades e acompanhamento de
presença.

- Objetos customizados: `Aluno__c`, `Mensalidade__c` e `Presenca__c`.
- Apex: `MensalidadeService` e `PresencaService`.
- LWC: painel de presença e mensalidades atrasadas.
- Permission Set: `AcademiaUser`.
- Testes Apex e Jest executados com sucesso.

### Exercício de Passagens

Exercício com Aura/Apex para busca de aeroportos, consulta de voos e criação de
tickets.

- `TicketsController`.
- Objetos: `Estado__c`, `Aeroporto__c`, `Voo__c` e `Ticket__c`.
- Consultas com `WITH USER_MODE`.

## Conteúdos Estudados

- Apex, SOQL, DML, classes e testes unitários.
- Aura Components, Controller, Helper, Events e `AuraEnabled`.
- Lightning Web Components, JavaScript, HTML e CSS.
- Objetos, campos, relacionamentos e Permission Sets.
- CRUD, FLS, Sharing e boas práticas de segurança.
- Salesforce CLI, deploy orientado a fonte, Git e GitHub.

> Este repositório contém uma classe Apex chamada `SaudacaoFlow`, mas ainda não
> possui um recurso Salesforce Flow (`*.flow-meta.xml`).

## Validação

```powershell
npm install
npm run lint
npm test
sf apex run test --target-org academia --tests MensalidadeServiceTest --tests PresencaServiceTest --wait 10
```

## Objetivo

Consolidar conhecimentos para atuar como Desenvolvedor Salesforce, construindo
soluções organizadas, seguras, testáveis e orientadas a problemas reais.

## Contato

- Rafael Alexandre Oliveira Araújo
- LinkedIn: https://www.linkedin.com/in/rafael-araujo-aa10a423/
- Email: Rafex113@gmail.com

