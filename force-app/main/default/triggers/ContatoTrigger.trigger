trigger ContatoTrigger on Contact (before insert, before update, after insert) {
    if (Trigger.isBefore) {
        for (Contact contato : Trigger.new) {
            if (String.isBlank(contato.LastName)) {
                contato.addError('Sobrenome obrigatório.');
            }
            if (String.isBlank(contato.Email)) {
                contato.addError('Email obrigatório.');
            }
            if (String.isBlank(contato.Phone)) {
                contato.addError('Telefone obrigatório.');
            }
        }
    }

    if (Trigger.isAfter && Trigger.isInsert) {
        for (Contact contato : Trigger.new) {
            AnomalyDetectionService.checkAnomaly(contato.Id);
        }
    }
}