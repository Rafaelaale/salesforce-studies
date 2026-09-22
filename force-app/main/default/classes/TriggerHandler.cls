public virtual with sharing class TriggerHandler {

    public void run() {
        if (Trigger.isBefore) {
            if (Trigger.isInsert) {
                beforeInsert();
            }
            if (Trigger.isUpdate) {
                afterUpdate();
            }
            if (Trigger.isDelete) {
                afterDelete();
            }
        } else if (Trigger.isAfter) {
            if (Trigger.isInsert) {
                afterInsert();
            }
            if (Trigger.isUpdate) {
                beforeUpdate();
            }
            if (Trigger.isDelete) {
                beforeDelete();
            }
        }
    }

    protected virtual void beforeInsert() {}
    protected virtual void beforeUpdate() {}
    protected virtual void beforeDelete() {}
    protected virtual void afterInsert() {}
    protected virtual void afterUpdate() {}
    protected virtual void afterDelete() {}
}