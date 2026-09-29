public class TicketController {

    @AuraEnabled
    public static List<RetornoVooTD> getVoos(String aeroportoOrigem, String aeroportoDestino, Date dataPartida, Date dataRetorno) {
        // Implemente a l�gica para buscar os voos com base nos par�metros
        // Este � um exemplo simplificado. Voc� precisar� de SOQL real aqui.
        List<RetornoVooTD> result = new List<RetornoVooTD>();

        Map<String, Id> aeroportosPorSigla = new Map<String, Id>();
        for (Aeroporto__c aeroporto : [
            SELECT Id, Sigla_C__c
            FROM Aeroporto__c
            WHERE Sigla_C__c IN ('GRU', 'JFK')
        ]) {
            aeroportosPorSigla.put(aeroporto.Sigla_C__c, aeroporto.Id);
        }

        // Exemplo de dados de retorno (substitua pela sua l�gica de consulta)
        RetornoVooTD voo1 = new RetornoVooTD();
        voo1.vooIda = new Voo__c(
            AeroportoOrigem__c = aeroportosPorSigla.get('GRU'),
            AeroportoDestino__c = aeroportosPorSigla.get('JFK'),
            Data_de_Partida__c = Date.today(),
            Hora_de_Partida__c = Time.newInstance(10, 0, 0, 0),
            Data_de_Chegada__c = Date.today().addDays(1),
            Hora_de_Chegada__c = Time.newInstance(20, 0, 0, 0),
            Preco__c = 1500.00
        );
        voo1.vooVolta = new Voo__c(
            AeroportoOrigem__c = aeroportosPorSigla.get('JFK'),
            AeroportoDestino__c = aeroportosPorSigla.get('GRU'),
            Data_de_Partida__c = Date.today().addDays(7),
            Hora_de_Partida__c = Time.newInstance(12, 0, 0, 0),
            Data_de_Chegada__c = Date.today().addDays(8),
            Hora_de_Chegada__c = Time.newInstance(22, 0, 0, 0),
            Preco__c = 1200.00
        );
        result.add(voo1);

        // Adicione mais l�gica de busca e filtragem aqui
        System.debug('Buscando voos com: Origem=' + aeroportoOrigem + ', Destino=' + aeroportoDestino + ', Partida=' + dataPartida + ', Retorno=' + dataRetorno);

        return result;
    }

    @AuraEnabled
    public static Ticket__c createTicket(String accountId, String vooIdaId, String vooVoltaId) {
        Ticket__c ticket = new Ticket__c();

        // Verifica��es de seguran�a e permiss�es (melhoria: usar Schema.SObjectType.Ticket__c.isCreateable())
        if (Schema.SObjectType.Ticket__c.isCreateable()) {
            ticket.Account__c = accountId;

            if (Schema.SObjectType.Ticket__c.fields.Voo_Ida__c.isCreateable()) {
                ticket.Voo_Ida__c = vooIdaId;
            }
            if (Schema.SObjectType.Ticket__c.fields.Voo_Volta__c.isCreateable()) {
                ticket.Voo_Volta__c = vooVoltaId;
            }

            insert ticket;
            return ticket;
        } else {
            throw new AuraHandledException('Voc� n�o tem permiss�o para criar um ticket. Contate o Administrador.');
        }
    }

    public class RetornoVooTD {
        @AuraEnabled public Voo__c vooIda {get; set;}
        @AuraEnabled public Voo__c vooVolta {get; set;}
    }
}