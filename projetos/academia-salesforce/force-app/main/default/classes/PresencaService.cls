public with sharing class PresencaService {
    @AuraEnabled(cacheable=true)
    public static List<Presenca__c> buscarHistorico(Id alunoId, Date inicio, Date fim) {
        return [
            SELECT Id, Name, Aluno__c, Data__c
            FROM Presenca__c
            WHERE Aluno__c = :alunoId
            AND Data__c >= :inicio
            AND Data__c <= :fim
            ORDER BY Data__c DESC
        ];
    }
}
