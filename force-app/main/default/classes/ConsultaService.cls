public with sharing class ConsultaService {
    public static Decimal calcularValorTotal(Decimal valorBase, Integer duracaoMinutos) {
        if (valorBase == null || valorBase < 0) {
            return 0;
        }

        if (duracaoMinutos == null || duracaoMinutos <= 0) {
            return valorBase;
        }

        return valorBase * duracaoMinutos;
    }

    public static List<Account> buscarContas() {
        return [
            SELECT Id, Name, Industry, Phone
            FROM Account
            ORDER BY Name
            LIMIT 10
        ];
    }

    public static Account buscarContaPorId(Id contaId) {
        return [
            SELECT Id, Name, Industry, Phone
            FROM Account
            WHERE Id = :contaId
            LIMIT 1
        ];
    }
}
