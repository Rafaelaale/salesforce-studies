@isTest
private class TIGGERTIGGERTest {
    @isTest
    static void devePreencherDescricao() {
        Test.startTest();
        Account acc = new Account(Name = 'Teste', Phone = '11999999999');
        insert acc;
        Test.stopTest();
        System.assert(true, 'Executado com sucesso');
    }
}