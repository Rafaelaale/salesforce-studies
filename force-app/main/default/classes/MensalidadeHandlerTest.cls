@IsTest
private class MensalidadeHandlerTest {

    @IsTest
    static void devePreencherDataQuandoMensalidadeForPaga() {
        Mensalidade__c mensalidade = new Mensalidade__c(
            Valor__c = 100,
            Pago__c = true
        );

        Test.startTest();
        insert mensalidade;
        Test.stopTest();

        Mensalidade__c mensalidadeSalva = [
            SELECT Data_Pagamento__c
            FROM Mensalidade__c
            WHERE Id = :mensalidade.Id
        ];

        System.assertEquals(
            Date.today(),
            mensalidadeSalva.Data_Pagamento__c,
            'A data de pagamento deveria ser preenchida automaticamente.'
        );
    }

    @IsTest
    static void deveRecusarValorInvalido() {
        Mensalidade__c mensalidade = new Mensalidade__c(
            Valor__c = 0,
            Pago__c = false
        );

        Test.startTest();
        Database.SaveResult resultado = Database.insert(mensalidade, false);
        Test.stopTest();

        System.assertEquals(false, resultado.isSuccess());
        System.assert(
            resultado.getErrors()[0].getMessage().contains('maior que zero'),
            'Deveria informar que o valor precisa ser maior que zero.'
        );
    }

    @IsTest
    static void deveRecusarDataDePagamentoQuandoNaoEstiverPago() {
        Mensalidade__c mensalidade = new Mensalidade__c(
            Valor__c = 100,
            Pago__c = false,
            Data_Pagamento__c = Date.today()
        );

        Test.startTest();
        Database.SaveResult resultado = Database.insert(mensalidade, false);
        Test.stopTest();

        System.assertEquals(false, resultado.isSuccess());
        System.assert(
            resultado.getErrors()[0].getMessage().contains('Marque a mensalidade como paga'),
            'Deveria pedir para marcar a mensalidade como paga ou remover a data.'
        );
    }
}