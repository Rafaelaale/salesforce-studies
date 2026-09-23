@IsTest
private class MvcAccountViewControllerTest {
    @IsTest
    static void deveCarregarContaNaExtensao() {
        Account conta = new Account(Name = 'Conta MVC');
        insert conta;

        ApexPages.StandardController standardController =
            new ApexPages.StandardController(conta);

        Test.startTest();
        MvcAccountViewController controller =
            new MvcAccountViewController(standardController);
        Test.stopTest();

        System.assertEquals(conta.Id, controller.conta.Id);
        System.assertEquals('Conta MVC', controller.conta.Name);
    }
}
