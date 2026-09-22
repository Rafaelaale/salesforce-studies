# AGENTS.md

## Projeto

- Este e um projeto Salesforce DX para estudos e exemplos em Apex.
- O pacote principal esta em `force-app/main/default` conforme [sfdx-project.json](sfdx-project.json).
- O projeto cobre classes Apex, triggers, handlers, SOQL/DML e testes unitarios.
- Consulte [README.md](README.md) para o contexto geral; confirme caminhos no repositorio antes de confiar na estrutura descrita ali.

## Desenvolvimento Apex

- Preserve a separacao entre triggers e classes de negocio quando ela ja existir: o trigger deve delegar para um handler ou service.
- Prefira `with sharing` em classes que acessam dados, salvo motivo explicito para comportamento diferente.
- Use SOQL com campos explicitos, limites adequados e sem consultas ou DML dentro de loops.
- Para testes, use classes privadas com `@IsTest`, dados criados pelo proprio teste e `Test.startTest()`/`Test.stopTest()` ao validar a operacao principal.
- Cubra cenarios de sucesso e de erro, incluindo mensagens de `addError()` quando aplicavel.
- Ao alterar um trigger, verifique todos os contextos declarados (`before`/`after`, `insert`/`update`/`delete`) e mantenha o dispatch coerente com o metodo chamado.
- Nao invente campos customizados: confirme o nome e o tipo no codigo ou nos metadados antes de usa-los.

## Deploy e validacao

- Verifique o org autenticado antes de publicar: `sf org list`.
- Deploy focado: `sf project deploy start --target-org <alias> --source-dir force-app/main/default/<caminho> --wait 30`.
- Deploy do pacote: `sf project deploy start --target-org <alias> --source-dir force-app/main/default --wait 30`.
- Deploy via manifest (equivalente ao deploy do pacote): `sf project deploy start --target-org <alias> --manifest manifest/package.xml --wait 30`. Ao adicionar um novo tipo de metadado em `force-app/main/default`, atualize `manifest/package.xml` com o `<types>` correspondente.
- Para uma mudanca Apex, execute os testes relacionados com `sf apex run test --target-org <alias> --tests <ClasseTest> --result-format human --wait 30` ou inclua `--test-level RunSpecifiedTests` no deploy.
- Nao considere `sf project deploy preview` ou diff como publicacao; confirme `Status: Succeeded` no deploy.
- Se o CLI reclamar de arquivo ausente, confirme que o `.cls` e o `.cls-meta.xml` existem lado a lado no caminho informado.
- Evite incluir arquivos de exercicio fora de `force-app/main/default` em deploys de pacote sem verificar se sao metadados validos.

## Convencoes de edicao

- Mantenha mudancas pequenas e focadas; nao reescreva arquivos sem necessidade.
- Preserve a API publica e o estilo Apex existente.
- Nao altere arquivos fora do escopo da tarefa.
- Antes de editar, leia a implementacao e o teste ou trigger relacionado. Depois da primeira edicao, execute a validacao mais estreita disponivel.
