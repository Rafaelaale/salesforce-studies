// force-app/main/default/classes/TicketsController.cls
public with sharing class TicketsController {

    @AuraEnabled(cacheable=true)
    public static List<Aeroporto__c> getAeroportos(String search) {
        search = ''; // Conforme visível nas imagens mais recentes

        return [SELECT Id, Name, Estado_r__c.Name, Sigla__c
                FROM Aeroporto__c
                WHERE Name LIKE :search OR
                      Estado_r__c.Name LIKE :search OR
                      Sigla__c LIKE :search
                WITH SECURITY_ENFORCED];
    }

    // 2020-12-15
    private static Date dateParse(String dateString) {
        List<String> dt = dateString.split('-');
        Date dtResult = Date.newInstance(Integer.valueOf(dt.get(0)), Integer.valueOf(dt.get(1)), Integer.valueOf(dt.get(2)));
        return dtResult;
    }

    @AuraEnabled
    public static String getVoos(String aeroportoOrigem, String aeroportoDestino, String dataPartida, String dataRetorno) {
        Date dtPartida = dateParse(dataPartida);
        Date dtRetorno = dateParse(dataRetorno);

        List<Voo__c> voosOrigem = [SELECT Id, Name, Aeroporto_Chegada__r.Sigla__c, Aeroporto_Partida__r.Sigla__c, Valor__c
                                   FROM Voo__c
                                   WHERE Data_Partida__c = :dtPartida AND Aeroporto_Partida__c = :aeroportoOrigem
                                   WITH SECURITY_ENFORCED];

        List<Voo__c> voosDestino = [SELECT Id, Name, Aeroporto_Chegada__r.Sigla__c, Aeroporto_Partida__r.Sigla__c, Valor__c
                                    FROM Voo__c
                                    WHERE Data_Partida__c = :dtRetorno AND Aeroporto_Chegada__c = :aeroportoDestino
                                    WITH SECURITY_ENFORCED];

        Map<Id, Voo__c> result = new Map<Id, Voo__c>();
        for(Voo__c vooOrigem : voosOrigem) {
            result.put(vooOrigem.Id, vooOrigem);
        }
        for(Voo__c vooDestino : voosDestino) {
            result.put(vooDestino.Id, vooDestino);
        }
        return JSON.serialize(result);
    }

    @AuraEnabled
    public static Ticket__c createTicket(String accountId, String vooIdId, String vooVoltaId) {
        if (Schema.SObjectType.Ticket__c.isCreateable()) {
            Ticket__c ticket = new Ticket__c();
            if (Schema.SObjectType.Ticket__c.fields.Account__c.isCreateable()) {
                ticket.Account__c = accountId;
            }
            if (Schema.SObjectType.Ticket__c.fields.Voo_Ida__c.isCreateable()) {
                ticket.Voo_Ida__c = vooIdId;
            }
            if (Schema.SObjectType.Ticket__c.fields.Voo_Volta__c.isCreateable()) {
                ticket.Voo_Volta__c = vooVoltaId;
            }
            insert ticket;
            return ticket;
        } else {
            throw new AuraHandledException('Você nao tem permissao para criar um ticket, contacte o Administrador');
        }
    }
}
