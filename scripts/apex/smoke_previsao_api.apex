PrevisaoDemandaInvocable.Request request = new PrevisaoDemandaInvocable.Request();
request.Recursos_Marketing = 200;
request.Eventos_Promocionais = 2;
request.Historico_Vendas_Mes_Anterior = 700;

List<PrevisaoDemandaInvocable.Response> responses =
    PrevisaoDemandaInvocable.prever(new List<PrevisaoDemandaInvocable.Request>{ request });

System.assertEquals(1, responses.size(), 'A API deve retornar uma previsao para cada solicitacao.');
System.assertNotEquals(null, responses[0].previsao, 'A API deve retornar o valor da previsao.');
System.debug(LoggingLevel.ERROR, 'PREVISAO_API_RESULT=' + responses[0].previsao);