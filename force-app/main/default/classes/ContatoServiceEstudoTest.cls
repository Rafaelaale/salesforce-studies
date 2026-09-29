@IsTest
private class ContatoServiceEstudoTest {
    @TestSetup
    static void setup() {
        Contact c = new Contact(
            FirstName = 'Teste',
            LastName = 'Silva',
            Email = 'teste@email.com',
            Phone = '11999999999'
        );
        insert c;
    }

    @IsTest
    static void deveExecutarSemErro() {
        Test.startTest();
        Contact contato = [SELECT Id, LastName, Email, Phone FROM Contact LIMIT 1];
        System.assertNotEquals(null, contato.Id, 'O contato deveria existir.');
        Test.stopTest();
    }
}