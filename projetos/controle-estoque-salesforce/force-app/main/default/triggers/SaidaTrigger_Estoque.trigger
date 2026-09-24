trigger SaidaTrigger_Estoque on Saida__c (after insert, after update, after delete, after undelete) {
    if (Trigger.isAfter) {
        if (Trigger.isInsert || Trigger.isUndelete) {
            EstoqueService.diminuirQuantidade(Trigger.new);
        } else if (Trigger.isUpdate) {
            List<Saida__c> saidasParaProcessar = new List<Saida__c>();
            for (Saida__c novaSaida : Trigger.new) {
                Saida__c antigaSaida = Trigger.oldMap.get(novaSaida.Id);
                if (novaSaida.Quantidade__c != antigaSaida.Quantidade__c || novaSaida.Produto__c != antigaSaida.Produto__c) {
                    saidasParaProcessar.add(novaSaida);
                }
            }
            if (!saidasParaProcessar.isEmpty()) {
                EstoqueService.diminuirQuantidade(saidasParaProcessar);
            }
        } else if (Trigger.isDelete) {
            EstoqueService.reverterSaida(Trigger.old);
        }
    }
}