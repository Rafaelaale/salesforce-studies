trigger EntradaTrigger on Entrada__c (after insert) {
    EstoqueService.aumentarEstoque(Trigger.new);
}
