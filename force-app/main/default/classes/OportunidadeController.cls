public with sharing class OportunidadeController {
    @AuraEnabled(cacheable=true)
    public static List<Opportunity> getOportunidadesRecentes() {
        return [
            SELECT Id, Name, StageName, Amount, CloseDate 
            FROM Opportunity 
            ORDER BY CreatedDate DESC 
            LIMIT 10
        ];
    }
} 