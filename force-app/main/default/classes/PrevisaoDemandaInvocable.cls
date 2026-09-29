public with sharing class PrevisaoDemandaInvocable {
    public class Request {
        @InvocableVariable(required=true)
        public Decimal Recursos_Marketing;

        @InvocableVariable(required=true)
        public Decimal Eventos_Promocionais;

        @InvocableVariable(required=true)
        public Decimal Historico_Vendas_Mes_Anterior;
    }

    public class Response {
        @InvocableVariable
        public Decimal previsao;
    }

    @InvocableMethod(label='Prever demanda' callout=true)
    public static List<Response> prever(List<Request> requests) {
        List<Response> responses = new List<Response>();
        if (requests == null || requests.isEmpty()) {
            return responses;
        }

        List<Map<String, Object>> payload = new List<Map<String, Object>>();

        for (Request request : requests) {
            if (request == null || request.Recursos_Marketing == null ||
                request.Eventos_Promocionais == null ||
                request.Historico_Vendas_Mes_Anterior == null) {
                throw new IllegalArgumentException('Todos os dados da previsão são obrigatórios.');
            }

            payload.add(new Map<String, Object>{
                'Recursos_Marketing' => request.Recursos_Marketing,
                'Eventos_Promocionais' => request.Eventos_Promocionais,
                'Historico_Vendas_Mes_Anterior' => request.Historico_Vendas_Mes_Anterior
            });
        }

        HttpRequest httpRequest = new HttpRequest();
        httpRequest.setEndpoint('callout:API_Previsao_Demanda_NC/prever');
        httpRequest.setMethod('POST');
        httpRequest.setHeader('Content-Type', 'application/json');
        httpRequest.setTimeout(30000);
        httpRequest.setBody(JSON.serialize(payload));

        HttpResponse httpResponse = new Http().send(httpRequest);
        if (httpResponse.getStatusCode() != 200) {
            throw new IllegalArgumentException(
                'A API de previsão retornou HTTP ' + httpResponse.getStatusCode() + '.'
            );
        }

        List<Object> predictions = (List<Object>) JSON.deserializeUntyped(httpResponse.getBody());
        if (predictions.size() != requests.size()) {
            throw new IllegalArgumentException('A API retornou uma quantidade inesperada de previsões.');
        }

        for (Object predictionValue : predictions) {
            Map<String, Object> prediction = (Map<String, Object>) predictionValue;
            Object value = prediction.get('previsao');
            if (value == null) {
                throw new IllegalArgumentException('A API não retornou o campo previsao.');
            }

            Response response = new Response();
            response.previsao = Decimal.valueOf(String.valueOf(value));
            responses.add(response);
        }

        return responses;
    }
}