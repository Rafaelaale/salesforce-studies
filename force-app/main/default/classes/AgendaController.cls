public with sharing class AgendaController {
    @AuraEnabled(cacheable=true)
    public static List<SObject> getAgendaDoDia() {
        Date hoje = Date.today();

        Map<String, Object> binds = new Map<String, Object>{ 'hoje' => hoje };
        return Database.queryWithBinds(
            'SELECT Id, DataHora__c, Status__c, Paciente__r.Name FROM Consulta__c WHERE DAY_ONLY(convertTimezone(DataHora__c)) = :hoje ORDER BY DataHora__c ASC',
            binds,
            AccessLevel.USER_MODE
        );
    }
}

