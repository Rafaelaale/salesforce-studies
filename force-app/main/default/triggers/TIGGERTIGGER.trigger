trigger TIGGERTIGGER on Contact (before insert) {
    for (Contact c : Trigger.new) {
        if (String.isBlank(c.Description)) {
            c.Description = 'Criado pelo trigger';
        }
    }
}