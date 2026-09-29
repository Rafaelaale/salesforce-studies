public with sharing class UraChackController {
    @InvocableMethod(label='Processar URA Chack' description='Executa a lógica de integração e atualização da oportunidade')
    public static void processar(List<Id> opportunityIds) {
        if (opportunityIds == null || opportunityIds.isEmpty()) {
            return;
        }

        List<Opportunity> oppsToUpdate = new List<Opportunity>();

        for (Opportunity opp : [SELECT Id, StageName FROM Opportunity WHERE Id IN :opportunityIds]) {
            opp.StageName = 'Prospecting';
            oppsToUpdate.add(opp);
        }

        if (!oppsToUpdate.isEmpty()) {
            update oppsToUpdate;
        }
    }
} 