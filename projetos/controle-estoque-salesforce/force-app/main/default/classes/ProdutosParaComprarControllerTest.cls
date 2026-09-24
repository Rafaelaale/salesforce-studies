@IsTest
private class ProdutosParaComprarControllerTest {

    @IsTest
    static void deveRetornarApenasProdutosAbaixoDoMinimo() {

        Produto__c produtoAbaixo = new Produto__c(
            Name = 'Produto Abaixo do Mínimo',
            Quantidade_Em_Estoque__c = 2,
            Quantidade_Minima__c = 5
        );

        Produto__c produtoOk = new Produto__c(
            Name = 'Produto Estoque Ok',
            Quantidade_Em_Estoque__c = 20,
            Quantidade_Minima__c = 5
        );

        insert new List<Produto__c>{ produtoAbaixo, produtoOk };

        Test.startTest();
        List<Produto__c> resultado = ProdutosParaComprarController.getProdutosAbaixoDoMinimo();
        Test.stopTest();

        System.assertEquals(
            1,
            resultado.size(),
            'Apenas o produto abaixo do mínimo deveria ser retornado.'
        );
        System.assertEquals(produtoAbaixo.Id, resultado[0].Id);
    }

    @IsTest
    static void deveRetornarListaVaziaQuandoNenhumProdutoAbaixoDoMinimo() {

        Produto__c produtoOk = new Produto__c(
            Name = 'Produto Estoque Ok',
            Quantidade_Em_Estoque__c = 20,
            Quantidade_Minima__c = 5
        );
        insert produtoOk;

        Test.startTest();
        List<Produto__c> resultado = ProdutosParaComprarController.getProdutosAbaixoDoMinimo();
        Test.stopTest();

        System.assertEquals(
            0,
            resultado.size(),
            'Nenhum produto deveria ser retornado.'
        );
    }
}
