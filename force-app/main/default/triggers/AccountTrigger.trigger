trigger AccountTrigger on Account (before insert, before update) {
    for (Account acc : Trigger.new) {
        if (String.isBlank(acc.Phone)) {
            acc.addError('Telefone obrigatório.');
        } else if (acc.Phone.replaceAll('\\D', '').length() < 11) {
            acc.addError('Telefone deve ter DDD e 9 dígitos.');
        }
    }
}
