@IsTest
private class AccountServiceTest {

    @IsTest
    static void deveBuscarContas() {

        Account conta = new Account(
            Name = 'Conta Teste SOQL'
        );

        insert conta;

        Test.startTest();

        List<Account> resultado = AccountService.buscarContas();

        Test.stopTest();

        System.assert(
            resultado.size() > 0,
            'A consulta deveria retornar pelo menos uma Account.'
        );
    }

    @IsTest
    static void deveCriarConta() {

        Test.startTest();

        Account resultado = AccountService.criarConta(
            'Conta Criada pelo Teste',
            'Technology',
            '71999999999'
        );

        Test.stopTest();

        System.assertNotEquals(
            null,
            resultado.Id,
            'A Account deveria ter sido criada.'
        );

        System.assertEquals(
            'Conta Criada pelo Teste',
            resultado.Name
        );

        System.assertEquals(
            'Technology',
            resultado.Industry
        );

        System.assertEquals(
            '71999999999',
            resultado.Phone
        );
    }

    @IsTest
    static void deveAtualizarConta() {

        Account conta = new Account(
            Name = 'Conta para Atualizar'
        );

        insert conta;

        Test.startTest();

        Account resultado = AccountService.atualizarConta(
            conta.Id,
            'Finance',
            '71888888888'
        );

        Test.stopTest();

        System.assertEquals(
            conta.Id,
            resultado.Id
        );

        System.assertEquals(
            'Finance',
            resultado.Industry
        );

        System.assertEquals(
            '71888888888',
            resultado.Phone
        );
    }

    @IsTest
    static void deveExcluirConta() {

        Account conta = new Account(
            Name = 'Conta para Excluir'
        );

        insert conta;

        Test.startTest();

        AccountService.excluirConta(conta.Id);

        Test.stopTest();

        List<Account> resultado = [
            SELECT Id
            FROM Account
            WHERE Id = :conta.Id
        ];

        System.assertEquals(
            0,
            resultado.size(),
            'A Account deveria ter sido excluída.'
        );
    }
}