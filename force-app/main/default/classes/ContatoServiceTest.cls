@IsTest
private class ContatoServiceTest {
    @IsTest
    static void deveContarContatosComEmail() {
        List<Contact> contatos = new List<Contact>{
            new Contact(
                LastName = 'Silva',
                Email = 'silva@example.com'
            ),
            new Contact(
                LastName = 'Souza'
            ),
            new Contact(
                LastName = 'Oliveira',
                Email = 'oliveira@example.com'
            )
        };

        Test.startTest();
        Integer resultado =
            ContatoService.contarContatosComEmail(contatos);
        Test.stopTest();

        System.assertEquals(
            2,
            resultado,
            'Somente contatos com email devem ser contados.'
        );
    }

    @IsTest
    static void deveExecutarBatchSemErro() {
        insert new Contact(LastName = 'Batch', Email = 'batch@example.com');

        Test.startTest();
        Database.executeBatch(new ContatoService());
        Test.stopTest();

        System.assert(true, 'O batch deve executar start/execute/finish sem lancar excecao.');
    }
}