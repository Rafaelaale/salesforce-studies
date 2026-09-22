@IsTest
private class ContatoTriggerTest {
    @IsTest
    static void deveBloquearContatoSemSobrenome() {
        Contact contato = new Contact(
            FirstName = 'João',
            Email = 'joao@email.com'
        );

        Test.startTest();
        Database.SaveResult result = Database.insert(contato, false);
        Test.stopTest();

        System.assertEquals(false, result.isSuccess());
        System.assert(result.getErrors().size() > 0);
    }

    @IsTest
    static void deveBloquearContatoSemEmail() {
        Contact contato = new Contact(
            FirstName = 'Maria',
            LastName = 'Silva'
        );

        Test.startTest();
        Database.SaveResult result = Database.insert(contato, false);
        Test.stopTest();

        System.assertEquals(false, result.isSuccess());
        System.assert(result.getErrors().size() > 0);
    }

    @IsTest
    static void devePermitirContatoValido() {
        Contact contato = new Contact(
            FirstName = 'Ana',
            LastName = 'Souza',
            Email = 'ana@email.com'
        );

        Test.startTest();
        Database.SaveResult result = Database.insert(contato, false);
        Test.stopTest();

        System.assertEquals(true, result.isSuccess());
    }
}
