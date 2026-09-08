public with sharing class AccountSelector {

    public static List<Account> buscarContas() {
        return [
            SELECT Id, Name, Industry, Phone
            FROM Account
            ORDER BY Name
            LIMIT 10
        ];
    }

    public static Account buscarPorId(Id accountId) {
        return [
            SELECT Id, Name, Industry, Phone
            FROM Account
            WHERE Id = :accountId
            LIMIT 1
        ];
    }
}