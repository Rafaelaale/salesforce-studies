public class ClienteExercicio01 {
    public static void mostrarCliente(
        String nome,
        String cidade,
        String tipo,
        Boolean ativo
    ) {
        System.debug('Nome: ' + nome);
        System.debug('Cidade: ' + cidade);
        System.debug('Tipo: ' + tipo);
        System.debug('Ativo: ' + ativo);
    }
}