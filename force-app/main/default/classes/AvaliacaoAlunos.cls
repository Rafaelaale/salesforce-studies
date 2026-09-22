public class AvaliacaoAlunos {
    public static void verificarAvaliacao(String nome, Decimal nota) {
        if (nota >= 7) {
            System.debug(nome + ' foi aprovado com nota ' + nota);
        } else if (nota >= 5) {
            System.debug(nome + ' ficou de recuperação com nota ' + nota);
        } else {
            System.debug(nome + ' foi reprovado com nota ' + nota);
        }
    }
}