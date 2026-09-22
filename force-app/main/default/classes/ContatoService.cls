public with sharing class ContatoService implements Database.Batchable<SObject>, Database.RaisesPlatformEvents {

    public static Integer contarContatosComEmail(List<Contact> contatos) {
        Integer total = 0;

        for (Contact contato : contatos) {
            if (String.isNotBlank(contato.Email)) {
                total++;
            }
        }

        return total;
    }

    public Database.QueryLocator start(Database.BatchableContext context) {
        // TODO: add a WHERE clause to filter records
        return Database.getQueryLocator([SELECT Id FROM Contact]);
    }

    public void execute(Database.BatchableContext context, List<SObject> scope) {

    }

    public void finish(Database.BatchableContext context) {

    }
}