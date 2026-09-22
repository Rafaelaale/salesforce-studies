public class ConsultaContas {
    public static void listarContas() {
        List<Account> contas = [
            SELECT Id, Name, Industry
            FROM Account
            LIMIT 5
        ];

        for (Account conta : contas) {
            System.debug(
                'Nome: ' + conta.Name +
                ' | Setor: ' + conta.Industry
            );
        }
    }

    public static void listarContasPorSetor(String setor) {
        List<Account> contas = [
            SELECT Id, Name, Industry
            FROM Account
            WHERE Industry = :setor
            ORDER BY Name
            LIMIT 5
        ];

        for (Account conta : contas) {
            System.debug(
                'Nome: ' + conta.Name +
                ' | Setor: ' + conta.Industry
            );
        }
    }
}