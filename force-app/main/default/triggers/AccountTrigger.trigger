trigger AccountTrigger on Account (before insert, before update) {
    for (Account accountRecord : Trigger.new) {
        if (String.isBlank(accountRecord.Phone)) {
            accountRecord.addError('por favor informar o telefone');
        } else if (accountRecord.Phone.length() < 11) {
            accountRecord.addError('por favor informar o telefone com o DDD');
        }
    }
}