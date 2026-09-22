public with sharing class ContatoServiceEstudo
    implements Database.Batchable<Contact> {

    public Iterable<Contact> start(Database.BatchableContext contexto) {
        return [
            SELECT Id, FirstName, LastName, Email
            FROM Contact
        ];
    }

    public void execute(
        Database.BatchableContext contexto,
        List<Contact> contatos
    ) {
        for (Contact contato : contatos) {
            System.debug('Contato: ' + contato.FirstName + ' ' + contato.LastName);
        }
    }

    public void finish(Database.BatchableContext contexto) {
        System.debug('Processamento concluído.');
    }
}