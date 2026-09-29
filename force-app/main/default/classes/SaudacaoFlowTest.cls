@IsTest
private class SaudacaoFlowTest {
    @IsTest
    static void geraUmaSaudacaoPorNome() {
        Test.startTest();
        List<String> mensagens = SaudacaoFlow.gerarSaudacao(new List<String>{ 'Ana', 'Rafael' });
        Test.stopTest();

        System.assertEquals(2, mensagens.size());
        System.assertEquals('Olá, Ana!', mensagens[0]);
        System.assertEquals('Olá, Rafael!', mensagens[1]);
    }

    @IsTest
    static void retornaListaVaziaParaEntradaVazia() {
        System.assertEquals(0, SaudacaoFlow.gerarSaudacao(new List<String>()).size());
    }
}