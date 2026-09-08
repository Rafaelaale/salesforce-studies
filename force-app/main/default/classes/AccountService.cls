public with sharing class AccountService {

    public static List<Account> buscarContas() {
        return [
            SELECT Id, Name, Industry, Phone
            FROM Account
            ORDER BY Name
            LIMIT 10
        ];
    }

    public static Account criarConta(String nome, String industria, String telefone) {
        Account conta = new Account(
            Name = nome,
            Industry = industria,
            Phone = telefone
        );

        insert conta;

        return conta;
    }

    public static Account atualizarConta(
        Id accountId,
        String industria,
        String telefone
    ) {
        Account conta = [
            SELECT Id, Name, Industry, Phone
            FROM Account
            WHERE Id = :accountId
            LIMIT 1
        ];

        conta.Industry = industria;
        conta.Phone = telefone;

        update conta;

        return conta;
    }

    public static void excluirConta(Id accountId) {
        Account conta = [
            SELECT Id
            FROM Account
            WHERE Id = :accountId
            LIMIT 1
        ];

        delete conta;
    }
}