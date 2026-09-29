public class OportunidadeFlowHandler {

    @InvocableMethod(label='Validar Oportunidade pelo Flow' description='Valida campos e regras de negócio para Oportunidades no Flow Builder.')
    public static void validarOportunidades(List<Opportunity> oportunidades) {
        for (Opportunity opp : oportunidades) {
            if (opp.Amount == null || opp.Amount <= 0) {
                opp.addError('O valor da oportunidade deve ser preenchido e maior que zero.');
            }
            if (opp.StageName == 'Closed Won' && String.isBlank(opp.Description)) {
                opp.addError('Insira uma descrição para fechar a oportunidade com sucesso.');
            }
        }
    }
} 