trigger MensalidadeTrigger on Mensalidade__c (
    before insert,
    before update
) {
    MensalidadeHandler.validar(Trigger.new);
}

