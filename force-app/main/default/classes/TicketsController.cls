public with sharing class TicketsController {

    @AuraEnabled
    public static String getToday() {
        return System.today().format();
    }

    @AuraEnabled
    public static List<Voo__c> loadVoos(String aeroportoOrigemId, String aeroportoDestinoId, Date dataPartida, Date dataRetorno) {
        // Implementar l�gica de busca de voos
        // Exemplo simples:
        List<Voo__c> voos = [SELECT Id, Name, AeroportoOrigem__r.Name, AeroportoDestino__r.Name, Data_de_Partida__c, Hora_de_Partida__c, Preco__c FROM Voo__c LIMIT 10];
        return voos;
    }

    @AuraEnabled
    public static Id createTicket(Id accountId, Id idVooIda, Id idVooVolta) {
        Ticket__c newTicket = new Ticket__c(
            Account__c = accountId,
            Voo_Ida__c = idVooIda,
            Voo_Volta__c = idVooVolta
        );
        insert newTicket;
        return newTicket.Id;
    }
}