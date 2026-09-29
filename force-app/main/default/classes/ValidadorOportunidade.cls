public class ValidadorOportunidade {
    public static void validar(List<Opportunity> listaOportunidades) {
        for (Opportunity opp : listaOportunidades) {
            if (opp.Amount != null && opp.Amount < 0) {
                opp.addError('O valor da oportunidade não pode ser negativo.');
            }
        }
    }
}