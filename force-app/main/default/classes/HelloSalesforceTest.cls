@IsTest
private class HelloSalesforceTest {

    @IsTest
    static void deveRetornarMensagem() {

        String resultado = HelloSalesforce.mensagem();

        System.assertEquals(
            'Ola! Meu primeiro codigo Apex esta funcionando!',
            resultado
        );
    }
}