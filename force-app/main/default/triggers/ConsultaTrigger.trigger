trigger ConsultaTrigger on Account (before insert, before update) {
    for (Account conta : Trigger.new) {
        if (String.isBlank(conta.Name)) {
            conta.addError('O nome da conta é obrigatório.');
        }

        if (String.isBlank(conta.Phone)) {
            conta.addError('Informe o telefone da conta.');
        }
    }
}
