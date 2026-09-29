public with sharing class UraChackController2 {
    @InvocableMethod(label='Processar URA Chack v2' description='Processa o fluxo alternativo para oportunidades')
    public static void processar(List<Id> opportunityIds) {
        if (opportunityIds == null || opportunityIds.isEmpty()) {
            return;
        }

        List<Opportunity> opps = [SELECT Id, StageName FROM Opportunity WHERE Id IN :opportunityIds];
        for (Opportunity opp : opps) {
            opp.StageName = 'Prospecting';
        }

        if (!opps.isEmpty()) {
            update opps;
        }
    }
}  