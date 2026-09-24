public with sharing class ProdutosParaComprarController {
    @AuraEnabled(cacheable=true)
    public static List<Produto__c> getProdutosAbaixoDoMinimo() {
        List<Produto__c> produtos = [
            SELECT Id, Name, Quantidade_Em_Estoque__c, Quantidade_Minima__c, Fornecedor__c, Fornecedor__r.Name
            FROM Produto__c
            WHERE Quantidade_Minima__c != null
            ORDER BY Name
        ];

        List<Produto__c> produtosAbaixoDoMinimo = new List<Produto__c>();
        for (Produto__c produto : produtos) {
            if (produto.Quantidade_Em_Estoque__c != null &&
                produto.Quantidade_Em_Estoque__c < produto.Quantidade_Minima__c) {
                produtosAbaixoDoMinimo.add(produto);
            }
        }
        return produtosAbaixoDoMinimo;
    }
}
