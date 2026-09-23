public with sharing class MensagemConsultaInvocable {
    @InvocableMethod(label='Enviar mensagem de lembrete')
    public static void enviarMensagem(List<Id> consultaIds) {
        if (consultaIds == null || consultaIds.isEmpty()) {
            return;
        }

        Map<String, Object> binds = new Map<String, Object>{ 'consultaIds' => consultaIds };
        List<SObject> consultas = Database.queryWithBinds(
            'SELECT Id, DataHora__c, Paciente__r.Email__c, Paciente__r.Nome__c FROM Consulta__c WHERE Id IN :consultaIds',
            binds,
            AccessLevel.USER_MODE
        );

        for (SObject c : consultas) {
            SObject paciente = c.getSObject('Paciente__r');
            if (paciente == null) {
                continue;
            }

            Object emailValue = paciente.get('Email__c');
            Object nomeValue = paciente.get('Nome__c');
            if (emailValue == null) {
                continue;
            }

            String email = String.valueOf(emailValue);
            String nome = nomeValue == null ? 'Paciente' : String.valueOf(nomeValue);
            Object dataHoraValue = c.get('DataHora__c');

            Messaging.SingleEmailMessage emailMsg = new Messaging.SingleEmailMessage();
            emailMsg.setToAddresses(new String[] { email });
            emailMsg.setSubject('Lembrete da consulta');
            emailMsg.setPlainTextBody(
                'Olá ' + nome + ', sua consulta está agendada para ' +
                (dataHoraValue == null ? 'a data informada.' : String.valueOf(dataHoraValue) + '.')
            );

            Messaging.sendEmail(new Messaging.SingleEmailMessage[] { emailMsg });
        }
    }
}
