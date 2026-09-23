public with sharing class MensalidadeService {
    @AuraEnabled(cacheable=true)
    public static List<Mensalidade__c> buscarAtrasadas(Date dataReferencia) {
        return [
            SELECT Id, Name, Aluno__c, Valor__c, Vencimento__c, Pago__c, Data_Pagamento__c
            FROM Mensalidade__c
            WHERE Pago__c = false
            AND Vencimento__c < :dataReferencia
            ORDER BY Vencimento__c ASC
        ];
    }
}
