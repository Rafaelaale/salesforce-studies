trigger Accountriggertrigger on Account (before insert) {

    if (Trigger.operationType == System.TriggerOperation.BEFORE_INSERT) {

        AccountTriggerhandller.onebeforeInsert(
            Trigger.new,
            Trigger.newMap
        );
    }
}