@IsTest
private class PrevisaoDemandaInvocableTest {
    @IsTest
    static void deveRetornarPrevisoesDaApiParaTodasAsSolicitacoes() {
        Test.setMock(HttpCalloutMock.class, new PredictionMock(200, '[{"previsao":900},{"previsao":1100}]'));

        PrevisaoDemandaInvocable.Request firstRequest = criarSolicitacao(200, 2, 700);
        PrevisaoDemandaInvocable.Request secondRequest = criarSolicitacao(300, 1, 800);

        Test.startTest();
        List<PrevisaoDemandaInvocable.Response> responses =
            PrevisaoDemandaInvocable.prever(
                new List<PrevisaoDemandaInvocable.Request>{ firstRequest, secondRequest }
            );
        Test.stopTest();

        System.assertEquals(2, responses.size());
        System.assertEquals(900, responses[0].previsao);
        System.assertEquals(1100, responses[1].previsao);
    }

    @IsTest
    static void rejeitaHistoricoAusente() {
        PrevisaoDemandaInvocable.Request request = criarSolicitacao(200, 2, null);

        try {
            PrevisaoDemandaInvocable.prever(new List<PrevisaoDemandaInvocable.Request>{ request });
            System.assert(false, 'Deveria rejeitar o histórico ausente.');
        } catch (IllegalArgumentException exceptionRaised) {
            System.assertEquals(
                'Todos os dados da previsão são obrigatórios.',
                exceptionRaised.getMessage()
            );
        }
    }

    @IsTest
    static void retornaListaVaziaSemChamarApi() {
        System.assertEquals(0, PrevisaoDemandaInvocable.prever(new List<PrevisaoDemandaInvocable.Request>()).size());
        System.assertEquals(0, PrevisaoDemandaInvocable.prever(null).size());
    }

    @IsTest
    static void rejeitaRespostaHttpDeErro() {
        Test.setMock(HttpCalloutMock.class, new PredictionMock(503, '{"error":"indisponivel"}'));

        try {
            PrevisaoDemandaInvocable.prever(
                new List<PrevisaoDemandaInvocable.Request>{ criarSolicitacao(200, 2, 700) }
            );
            System.assert(false, 'Deveria rejeitar uma resposta HTTP de erro.');
        } catch (IllegalArgumentException exceptionRaised) {
            System.assertEquals('A API de previsão retornou HTTP 503.', exceptionRaised.getMessage());
        }
    }

    private static PrevisaoDemandaInvocable.Request criarSolicitacao(
        Decimal recursos, Decimal eventos, Decimal historico
    ) {
        PrevisaoDemandaInvocable.Request request = new PrevisaoDemandaInvocable.Request();
        request.Recursos_Marketing = recursos;
        request.Eventos_Promocionais = eventos;
        request.Historico_Vendas_Mes_Anterior = historico;
        return request;
    }

    private class PredictionMock implements HttpCalloutMock {
        private Integer statusCode;
        private String body;

        PredictionMock(Integer statusCode, String body) {
            this.statusCode = statusCode;
            this.body = body;
        }

        public HttpResponse respond(HttpRequest request) {
            System.assertEquals('POST', request.getMethod());
            System.assertEquals('callout:API_Previsao_Demanda_NC/prever', request.getEndpoint());

            HttpResponse response = new HttpResponse();
            response.setStatusCode(statusCode);
            response.setBody(body);
            return response;
        }
    }
}