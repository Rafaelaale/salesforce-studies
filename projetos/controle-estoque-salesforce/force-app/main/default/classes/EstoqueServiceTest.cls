@IsTest
private class EstoqueServiceTest {

    @IsTest
    static void deveAumentarQuantidadeAoInserirEntrada() {

        Produto__c produto = new Produto__c(
            Name = 'Produto Teste',
            Quantidade_Em_Estoque__c = 10,
            Quantidade_Minima__c = 5
        );
        insert produto;

        Entrada__c entrada = new Entrada__c(
            Produto__c = produto.Id,
            Quantidade__c = 4
        );

        Test.startTest();
        insert entrada;
        Test.stopTest();

        Produto__c resultado = [SELECT Quantidade_Em_Estoque__c FROM Produto__c WHERE Id = :produto.Id];
        System.assertEquals(
            14,
            resultado.Quantidade_Em_Estoque__c,
            'A quantidade em estoque deveria ter aumentado com a entrada.'
        );
    }

    @IsTest
    static void deveDiminuirQuantidadeAoInserirSaida() {

        Produto__c produto = new Produto__c(
            Name = 'Produto Teste',
            Quantidade_Em_Estoque__c = 10,
            Quantidade_Minima__c = 5
        );
        insert produto;

        Saida__c saida = new Saida__c(
            Produto__c = produto.Id,
            Quantidade__c = 3
        );

        Test.startTest();
        insert saida;
        Test.stopTest();

        Produto__c resultado = [SELECT Quantidade_Em_Estoque__c FROM Produto__c WHERE Id = :produto.Id];
        System.assertEquals(
            7,
            resultado.Quantidade_Em_Estoque__c,
            'A quantidade em estoque deveria ter diminuído com a saída.'
        );
    }

    @IsTest
    static void deveIdentificarProdutoAbaixoDoMinimo() {

        Produto__c produto = new Produto__c(
            Name = 'Produto Abaixo do Mínimo',
            Quantidade_Em_Estoque__c = 2,
            Quantidade_Minima__c = 5
        );
        insert produto;

        Test.startTest();
        List<Id> resultado = EstoqueService.verificarEstoqueMinimo(new List<Id>{ produto.Id });
        Test.stopTest();

        System.assertEquals(
            1,
            resultado.size(),
            'O produto abaixo do mínimo deveria ser retornado.'
        );
        System.assertEquals(produto.Id, resultado[0]);
    }

    @IsTest
    static void deveAtualizarQuantidadeAoEditarEntrada() {

        Produto__c produto = new Produto__c(
            Name = 'Produto Teste',
            Quantidade_Em_Estoque__c = 10,
            Quantidade_Minima__c = 5
        );
        insert produto;

        Entrada__c entrada = new Entrada__c(Produto__c = produto.Id, Quantidade__c = 4);
        insert entrada;

        entrada.Quantidade__c = 6;

        Test.startTest();
        update entrada;
        Test.stopTest();

        Produto__c resultado = [SELECT Quantidade_Em_Estoque__c FROM Produto__c WHERE Id = :produto.Id];
        System.assertEquals(
            20,
            resultado.Quantidade_Em_Estoque__c,
            'A quantidade deveria refletir a nova entrada aumentada.'
        );
    }

    @IsTest
    static void deveAtualizarQuantidadeAoEditarSaida() {

        Produto__c produto = new Produto__c(
            Name = 'Produto Teste',
            Quantidade_Em_Estoque__c = 10,
            Quantidade_Minima__c = 5
        );
        insert produto;

        Saida__c saida = new Saida__c(Produto__c = produto.Id, Quantidade__c = 3);
        insert saida;

        saida.Quantidade__c = 5;

        Test.startTest();
        update saida;
        Test.stopTest();

        Produto__c resultado = [SELECT Quantidade_Em_Estoque__c FROM Produto__c WHERE Id = :produto.Id];
        System.assertEquals(
            2,
            resultado.Quantidade_Em_Estoque__c,
            'A quantidade deveria refletir a nova saida diminuida.'
        );
    }

    @IsTest
    static void deveReverterQuandoDeletaEntrada() {

        Produto__c produto = new Produto__c(
            Name = 'Produto Teste',
            Quantidade_Em_Estoque__c = 10,
            Quantidade_Minima__c = 5
        );
        insert produto;

        Entrada__c entrada = new Entrada__c(Produto__c = produto.Id, Quantidade__c = 4);
        insert entrada;

        Test.startTest();
        delete entrada;
        Test.stopTest();

        Produto__c resultado = [SELECT Quantidade_Em_Estoque__c FROM Produto__c WHERE Id = :produto.Id];
        System.assertEquals(
            10,
            resultado.Quantidade_Em_Estoque__c,
            'A quantidade deveria voltar ao valor anterior a entrada excluida.'
        );
    }

    @IsTest
    static void deveReverterQuandoDeletaSaida() {

        Produto__c produto = new Produto__c(
            Name = 'Produto Teste',
            Quantidade_Em_Estoque__c = 10,
            Quantidade_Minima__c = 5
        );
        insert produto;

        Saida__c saida = new Saida__c(Produto__c = produto.Id, Quantidade__c = 3);
        insert saida;

        Test.startTest();
        delete saida;
        Test.stopTest();

        Produto__c resultado = [SELECT Quantidade_Em_Estoque__c FROM Produto__c WHERE Id = :produto.Id];
        System.assertEquals(
            10,
            resultado.Quantidade_Em_Estoque__c,
            'A quantidade deveria voltar ao valor anterior a saida excluida.'
        );
    }
}
