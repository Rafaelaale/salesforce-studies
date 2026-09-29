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
- Para um componente especifico, use `--metadata <Tipo>:<Nome>` (por exemplo, `--metadata ApexClass:NomeDaClasse`). Para um diretorio Salesforce DX, use `--source-dir <caminho>`. Esses seletores sao alternativas; nunca combine `--metadata`, `--source-dir` ou `--metadata-dir` no mesmo comando.
- Neste repositorio, prefira deploy focado ou via `manifest/package.xml`. Nunca use `force-app/main/default` inteiro como `--source-dir`: junto dos metadados ha scripts Python, CSV e modelos de dados. A pasta `flows` pode ser enviada como `--source-dir` porque `.forceignore` exclui scripts Python, CSV, modelos e `openapi_spec.json`; ainda prefira o manifest quando precisar de dependencias Apex ou objetos.
- Deploy via manifest: `sf project deploy start --target-org <alias> --manifest manifest/package.xml --wait 30`. O manifest deve listar somente componentes Salesforce que se deseja publicar; atualize-o ao adicionar componentes.
- Para org de estudo/sandbox, use `powershell -NoProfile -ExecutionPolicy Bypass -File scripts/validate-salesforce-deploy.ps1 -TargetOrg <alias> -Deploy`. O manifest usa wildcards para os tipos Salesforce mapeados; novos componentes desses tipos entram automaticamente. O preflight bloqueia pastas de metadados sem mapeamento, testa a API de previsao, e o wrapper roda `RunLocalTests`, faz dry-run e so publica apos a confirmacao literal `DEPLOY`. Sem `-Deploy`, ele apenas valida.
- Se a checagem local isolada for necessaria, rode `powershell -NoProfile -ExecutionPolicy Bypass -File scripts/validate-salesforce-metadata.ps1`.
- Antes de publicar, confirme os nomes e extensoes de metadados (por exemplo, classe `.cls` com `.cls-meta.xml`, Flow `.flow-meta.xml`), que cada referencia do Flow aponta para uma classe/metodo Apex existente e que os parametros e tipos de entrada/saida correspondem. XML bem-formado sozinho nao garante compatibilidade Salesforce.
- Em producao, use `sf project deploy validate --manifest manifest/package.xml --target-org <alias> --wait 30` e, se passar, `sf project deploy quick --job-id <id> --target-org <alias>`. Para sandbox/org de estudo, siga o wrapper de deploy acima.
- O wrapper de deploy executa `RunLocalTests`, cobrindo as classes de teste locais atuais e futuras; para uma mudanca Apex isolada, tambem e possivel executar `sf apex run test --target-org <alias> --tests <ClasseTest> --result-format human --wait 30`.
- Nao considere `sf project deploy preview` ou diff como publicacao; confirme `Status: Succeeded` no deploy.
- Se o CLI reclamar de arquivo ausente, confirme que o `.cls` e o `.cls-meta.xml` existem lado a lado no caminho informado.
- Evite incluir arquivos de exercicio fora de `force-app/main/default` em deploys de pacote sem verificar se sao metadados validos.

## Convencoes de edicao

- Mantenha mudancas pequenas e focadas; nao reescreva arquivos sem necessidade.
- Preserve a API publica e o estilo Apex existente.
- Nao altere arquivos fora do escopo da tarefa.
- Antes de editar, leia a implementacao e o teste ou trigger relacionado. Depois da primeira edicao, execute a validacao mais estreita disponivel.
