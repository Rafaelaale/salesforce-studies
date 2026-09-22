public class ResultadoAluno {
    public static void verificarResultado(String nome, Decimal nota) {
        if (nota >= 7) {
            System.debug(nome + ' foi aprovado com nota ' + nota);
        } else {
            System.debug(nome + ' foi reprovado com nota ' + nota);
        }
    }
}