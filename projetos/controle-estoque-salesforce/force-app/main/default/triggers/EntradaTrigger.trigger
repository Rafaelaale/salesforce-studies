trigger EntradaTrigger on Entrada__c (after insert, after update, after delete, after undelete) {
    if (Trigger.isAfter) {
        if (Trigger.isInsert || Trigger.isUndelete) {
            EstoqueService.aumentarQuantidade(Trigger.new);
        } else if (Trigger.isUpdate) {
            List<Entrada__c> entradasParaProcessar = new List<Entrada__c>();
            for (Entrada__c novaEntrada : Trigger.new) {
                Entrada__c antigaEntrada = Trigger.oldMap.get(novaEntrada.Id);
                if (novaEntrada.Quantidade__c != antigaEntrada.Quantidade__c || novaEntrada.Produto__c != antigaEntrada.Produto__c) {
                    entradasParaProcessar.add(novaEntrada);
                }
            }
            if (!entradasParaProcessar.isEmpty()) {
                EstoqueService.aumentarQuantidade(entradasParaProcessar);
            }
        } else if (Trigger.isDelete) {
            EstoqueService.reverterEntrada(Trigger.old);
        }
    }
}
