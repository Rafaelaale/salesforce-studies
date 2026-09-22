trigger Projeto on Projeto__c (before update) {

    for (Projeto__c novoProjeto : Trigger.new) {

        Projeto__c antigoProjeto = Trigger.oldMap.get(novoProjeto.Id);

        Boolean statusMudouParaEmAndamento =
            antigoProjeto.Status__c != 'Em andamento' &&
            novoProjeto.Status__c == 'Em andamento';

        Boolean dataDeInicioVazia =
            novoProjeto.Data_de_inicio__c == null;

        if (statusMudouParaEmAndamento && dataDeInicioVazia) {
            novoProjeto.Data_de_inicio__c = Date.today();
        }
    }
}