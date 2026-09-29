trigger OportunidadeTrigger on Opportunity (before insert, before update) {
    if (Trigger.isBefore && (Trigger.isInsert || Trigger.isUpdate)) {
        ValidadorOportunidade.validar(Trigger.new);
    }
}