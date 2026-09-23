# Portfólio Salesforce: Gestão de Academia

Este projeto Salesforce resolve problemas reais de uma academia: cadastro de alunos,
acompanhamento de presença e controle de mensalidades em atraso.

## O Que O Projeto Demonstra

- Modelagem de dados com objetos customizados.
- Relacionamentos entre aluno, mensalidade e presença.
- Apex com `with sharing` e consultas SOQL.
- Métodos `@AuraEnabled(cacheable=true)` para integração com LWC.
- Testes unitários executados na org Salesforce.
- Lightning Web Component com validação, carregamento e tratamento de erros.
- Deploy orientado a fonte usando Salesforce CLI.

## Visão Geral

O projeto demonstra uma solução para cadastro de alunos, controle de mensalidades e
registro de presença. O painel Lightning permite consultar o histórico de presença de um
aluno e visualizar mensalidades vencidas e não pagas.

## Conteúdo do Repositório

### Objetos Personalizados

- **Aluno__c**: cadastro do aluno, matrícula, contato, data de nascimento e status.
- **Mensalidade__c**: controle de vencimento, valor, pagamento e aluno relacionado.
- **Presenca__c**: registro de presença por aluno e data.

### Lightning Web Components

- **painelAcademia**: painel para consultar presença por período e listar mensalidades atrasadas.

### Classes Apex

- **PresencaService**: consulta o histórico de presença de um aluno.
- **MensalidadeService**: consulta mensalidades vencidas e não pagas.
- **PresencaServiceTest** e **MensalidadeServiceTest**: testes unitários dos serviços.

### Permission Set

- **AcademiaUser**: permissões de leitura e edição dos objetos e campos usados pela operação da academia.

## Tecnologias e Ferramentas

- Salesforce Platform
- Apex
- Lightning Web Components
- Salesforce CLI
- Visual Studio Code
- Git

## Estrutura Principal

```text
force-app/main/default/
	classes/
		MensalidadeService.cls
		MensalidadeServiceTest.cls
		PresencaService.cls
		PresencaServiceTest.cls
	lwc/painelAcademia/
		painelAcademia.html
		painelAcademia.js
		painelAcademia.css
	objects/
		Aluno__c/
		Mensalidade__c/
		Presenca__c/
	permissionsets/
		AcademiaUser.permissionset-meta.xml
```

## Como Configurar

1. Instale o Salesforce CLI e o Node.js.
2. Instale as dependências do projeto:

	```bash
	npm install
	```

3. Autentique-se em uma org Salesforce:

	```bash
	sf org login web -a academia
	```

4. Implante os metadados:

	```bash
	sf project deploy start --source-dir force-app/main/default --target-org academia
	```

5. Execute os testes Apex:

	```bash
	sf apex run test --target-org academia --test-level RunLocalTests --wait 10
	```

6. Execute as validações locais do LWC:

	```bash
	npm run lint
	npm test
	```

## Regras De Negócio Implementadas

Uma mensalidade está atrasada quando `Pago__c = false` e `Vencimento__c` é anterior à
data de referência. O histórico de presença retorna apenas os registros do aluno dentro
do período informado.

## Contato

- **Rafael Alexandre Oliveira Araújo**
- **LinkedIn:** https://www.linkedin.com/in/rafael-araujo-aa10a423/
- **Email:** Rafex113@gmail.com


