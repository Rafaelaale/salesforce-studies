@IsTest
private class TicketControllerTest {
    @IsTest
    static void retornaVoosDeExemplo() {
        Date partida = Date.today().addDays(3);
        Date retorno = Date.today().addDays(10);
        Aeroporto__c gru = new Aeroporto__c(Name = 'Guarulhos', Sigla_C__c = 'GRU');
        Aeroporto__c jfk = new Aeroporto__c(Name = 'John F. Kennedy', Sigla_C__c = 'JFK');
        insert new List<Aeroporto__c>{ gru, jfk };

        List<TicketController.RetornoVooTD> voos = TicketController.getVoos(
            'GRU', 'JFK', partida, retorno
        );

        System.assertEquals(1, voos.size());
        System.assertEquals(gru.Id, voos[0].vooIda.AeroportoOrigem__c);
        System.assertEquals(jfk.Id, voos[0].vooIda.AeroportoDestino__c);
        System.assertEquals(jfk.Id, voos[0].vooVolta.AeroportoOrigem__c);
        System.assertEquals(gru.Id, voos[0].vooVolta.AeroportoDestino__c);
        System.assertEquals(null, voos[0].vooIda.Id);
        System.assertEquals(null, voos[0].vooVolta.Id);
    }

    @IsTest
    static void criaTicketComConta() {
        Account account = new Account(Name = 'Conta de teste', Phone = '(11) 99999-0101');
        insert account;

        Test.startTest();
        Ticket__c ticket = TicketController.createTicket(
            String.valueOf(account.Id), null, null
        );
        Test.stopTest();

        System.assertNotEquals(null, ticket.Id);
        System.assertEquals(account.Id, ticket.Account__c);
        System.assertEquals(account.Id, [SELECT Account__c FROM Ticket__c WHERE Id = :ticket.Id].Account__c);
    }
}