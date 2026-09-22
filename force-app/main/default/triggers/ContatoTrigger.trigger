trigger ContatoTrigger on Contact (before insert, before update) {
    for (Contact contato : Trigger.new) {
        if (String.isBlank(contato.LastName)) {
            contato.addError('Sobrenome obrigatório.');
        }

        if (String.isBlank(contato.Email)) {
            contato.addError('Email obrigatório.');
        }
    }
}

