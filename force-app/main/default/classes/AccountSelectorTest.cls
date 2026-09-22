@IsTest
private class AccountSelectorTest {

    @IsTest
    static void deveBuscarContas() {

        Account conta1 = new Account(
            Name = 'Conta Selector A',
            Phone = '71999999999'
        );

        Account conta2 = new Account(
            Name = 'Conta Selector B',
            Phone = '71888888888'
        );

        insert new List<Account>{ conta1, conta2 };

        Test.startTest();

        List<Account> resultado = AccountSelector.buscarContas();

        Test.stopTest();

        System.assert(
            resultado.size() > 0,
            'O Selector deveria retornar Accounts.'
        );
    }

    @IsTest
    static void deveBuscarContaPorId() {

        Account conta = new Account(
            Name = 'Conta Selector por ID',
            Phone = '71777777777'
        );

        insert conta;

        Test.startTest();

        Account resultado = AccountSelector.buscarPorId(conta.Id);

        Test.stopTest();

        System.assertNotEquals(
            null,
            resultado,
            'O Selector deveria retornar a Account.'
        );

        System.assertEquals(
            conta.Id,
            resultado.Id
        );

        System.assertEquals(
            'Conta Selector por ID',
            resultado.Name
        );
    }
}