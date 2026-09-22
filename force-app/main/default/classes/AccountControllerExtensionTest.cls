@IsTest
private class AccountControllerExtensionTest {

    @IsTest
    static void deveExporContaDoStandardController() {

        Account conta = new Account(
            Name = 'Conta de Teste',
            Phone = '71999999999'
        );

        insert conta;

        ApexPages.StandardController standardController =
            new ApexPages.StandardController(conta);

        Test.startTest();

        AccountControllerExtension extensao =
            new AccountControllerExtension(standardController);

        Test.stopTest();

        System.assertNotEquals(
            null,
            extensao.conta,
            'A extensão deveria expor a Account do controller.'
        );

        System.assertEquals(
            conta.Id,
            extensao.conta.Id
        );

        System.assertEquals(
            'Conta de Teste',
            extensao.conta.Name
        );
    }
}
