public class MensalidadeHandler {

    public static void validar(List<Mensalidade__c> mensalidades) {

        for (Mensalidade__c mensalidade : mensalidades) {

            if (mensalidade.Valor__c == null ||
                mensalidade.Valor__c <= 0) {

                mensalidade.addError(
                    'Informe um valor de mensalidade maior que zero.'
                );
            }

            if (mensalidade.Pago__c &&
                mensalidade.Data_Pagamento__c == null) {

                mensalidade.Data_Pagamento__c = Date.today();
            }

            if (!mensalidade.Pago__c &&
                mensalidade.Data_Pagamento__c != null) {

                mensalidade.addError(
                    'Marque a mensalidade como paga ou remova a data do pagamento.'
                );
            }
        }
    }
}
