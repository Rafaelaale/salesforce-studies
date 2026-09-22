@IsTest
private class ContatoServiceEstudoTest {
    @TestSetup
    static void setup() {
        insert new Contact(FirstName = 'Joao', LastName = 'Silva', Email = 'joao@example.com');
    }

    @IsTest
    static void deveExecutarBatchSemErro() {
        Test.startTest();
        Database.executeBatch(new ContatoServiceEstudo());
        Test.stopTest();

        System.assert(true, 'O batch deve executar start/execute/finish sem lancar excecao.');
    }
}
