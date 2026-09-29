@IsTest
private class MensagemConsultaInvocableTest {
    @IsTest
    static void ignoraEntradaNula() {
        Test.startTest();
        MensagemConsultaInvocable.enviarMensagem(null);
        Test.stopTest();
        System.assertEquals(0, Limits.getEmailInvocations());
    }

    @IsTest
    static void ignoraListaVazia() {
        Test.startTest();
        MensagemConsultaInvocable.enviarMensagem(new List<Id>());
        Test.stopTest();
        System.assertEquals(0, Limits.getEmailInvocations());
    }
}