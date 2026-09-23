 

trigger PagamentoTrigger on Pagamento__c (before insert, before update) { 
    if (Trigger.isBefore && (Trigger.isInsert || Trigger.isUpdate)) { 
        PagamentoService.atualizarStatusPagamento(Trigger.new); 
    } 
