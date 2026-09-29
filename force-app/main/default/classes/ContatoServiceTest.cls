@isTest
private class ContatoServiceTest {
    @isTest
    static void deveTestarInsercaoContato() {
        Contact c = new Contact(FirstName = 'Teste', LastName = 'Email', Email = 'teste@email.com', Phone = '11999999999');
        Test.startTest();
        insert c;
        System.assertNotEquals(null, c.Id, 'O contato deve ser inserido com ID válido');
        Test.stopTest();
    }
}