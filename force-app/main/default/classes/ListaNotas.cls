public class ListaNotas {
    public static void verificarNotas(List<Decimal> notas) {
        for (Decimal nota : notas) {
            if (nota >= 7) {
                System.debug('Nota ' + nota + ': Aprovado');
            } else if (nota >= 5) {
                System.debug('Nota ' + nota + ': Recuperação');
            } else {
                System.debug('Nota ' + nota + ': Reprovado');
            }
        }
    }
}