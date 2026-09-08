public with sharing class Soql {

    public Soql() {

        List<Account> contas = [
            SELECT Id, Name, Type, BillingState
            FROM Account
            WHERE Type IN ('Customer - Channel', 'Customer - Direct')
            ORDER BY Name ASC
        ];

    }
}