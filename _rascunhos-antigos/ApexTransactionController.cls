ublic with sharing class ApexTransactionController {
    public static void saveAccount() {
        Account acc = new Account(
            Name = 'Test Apex Transaction Acc',
            Phone = '11111111111'
        );

        insert acc;

        Contact con = new Contact(
            AccountId = acc.Id,
            LastName = 'Test Apex Transaction Contact'
        );

        insert con;

        Case cs = new Case(
            AccountId = acc.Id,
            Subject = 'Test Apex Transaction Case'
        );
