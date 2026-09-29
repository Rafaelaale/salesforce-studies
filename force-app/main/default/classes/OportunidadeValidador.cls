public class OportunidadeValidador {
    public static void validarCamposObrigatorios(List<Opportunity> oportunidades) {
        for (Opportunity opp : oportunidades) {
            if (opp.Amount == null || opp.Amount <= 0) {
                opp.addError('O valor da oportunidade deve ser maior que zero.');
            }
        }
    }
} 