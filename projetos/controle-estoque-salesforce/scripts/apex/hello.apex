// Use .apex files to store anonymous Apex.
// You can execute anonymous Apex in VS Code by selecting the
//     apex text and running the command:
//     SFDX: Execute Anonymous Apex with Currently Selected Text
// You can also execute the entire file by running the command:
//     SFDX: Execute Anonymous Apex with Editor Contents

List<Id> abaixoDoMinimo = EstoqueService.verificarEstoqueMinimo(
    new List<Id>{ /* Ids de Produto__c aqui */ }
);
System.debug('Produtos abaixo do minimo: ' + abaixoDoMinimo);
