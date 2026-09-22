public with sharing class CotacaoService {

    // URL do serviço da AwesomeAPI para obter a cotação diária de um par de moedas
    // O {origem} será substituído pela moeda de origem (ex: USD, EUR)
    // O '/1' no final indica que você quer a cotação do último dia.
    private static final String serviceUrl = 'https://economia.awesomeapi.com.br/json/daily/{origem}-BRL/1';

    // Timeout para a requisição HTTP em milissegundos (120 segundos)
    private static final Integer timeout = 120000; 

    /**
     * @description Obtém a cotação de uma moeda de origem em relação ao Real Brasileiro (BRL).
     * @param moedaOrigem O código da moeda de origem (ex: 'USD', 'EUR').
     * @return Uma lista de objetos Cotacao contendo os dados da cotação.
     * @throws CotacaoServiceException Se houver um erro na chamada da API ou na resposta.
     */
    public static List<Cotacao> getCotacao(String moedaOrigem) {
        // Constrói o endpoint completo substituindo o placeholder da moeda de origem
        String endpoint = serviceUrl.replace('{origem}', moedaOrigem);

        // Cria uma nova instância da classe Http para enviar requisições
        Http http = new Http();
        // Cria uma nova requisição HTTP
        HttpRequest request = new HttpRequest();

        // Define o endpoint (URL) para a requisição
        request.setEndpoint(endpoint);
        // Define o método HTTP como GET
        request.setMethod('GET');
        // Define o timeout para a requisição
        request.setTimeout(timeout); 
        // Define o cabeçalho Content-Type, informando que esperamos JSON
        request.setHeader('Content-Type', 'application/json'); 

        // Envia a requisição e recebe a resposta
        HttpResponse response = http.send(request);

        // Verifica se a requisição foi bem-sucedida (código de status HTTP 200 OK)
        if (response.getStatusCode() == 200) {
            // Obtém o corpo da resposta como uma string JSON
            String jsonResponse = response.getBody();

            // Cria uma instância da classe interna e chama o método de parse
            Cotacao cotacao = new Cotacao();
            return cotacao.parse(jsonResponse);
        } else {
            // Se a requisição não foi bem-sucedida, constrói um mapa de erro
            Map<String, String> error = new Map<String, String>();
            error.put('statusCode', String.valueOf(response.getStatusCode()));
            error.put('status', response.getStatus());
            error.put('body', response.getBody());

            // Lança uma exceção personalizada com os detalhes do erro
            throw new CotacaoServiceException(JSON.serialize(error));
        }
    }

    /**
     * @description Método utilitário para testar a funcionalidade de obtenção de cotações.
     *              Este não é um método de teste formal (@IsTest), mas para depuração rápida.
     */
    public void test() {
        // Chama o método getCotacao para obter a cotação do Dólar Americano
        List<Cotacao> result = CotacaoService.getCotacao('USD');
        // Imprime o resultado no log de depuração
        System.Debug(result);
    }

    /**
     * @description Classe de exceção personalizada para lidar com erros específicos do serviço de cotação.
     */
    public class CotacaoServiceException extends Exception {}

    /**
     * @description Classe interna (wrapper) para representar a estrutura de uma cotação de moeda
     *              retornada pela AwesomeAPI. As propriedades correspondem aos campos JSON.
     */
    public class Cotacao {
        public String code;         // Código da moeda de origem (ex: "USD")
        public String codein;       // Código da moeda de destino (ex: "BRL")
        public String name;         // Nome completo do par de moedas (ex: "Dólar Americano/Real Brasileiro")
        public String high;         // Maior preço do dia
        public String low;          // Menor preço do dia
        public String varBid;       // Variação monetária
        public String pctChange;    // Percentual da Variação
        public String bid;          // Valor de Compra
        public String ask;          // Valor de Venda
        public String timestamp;    // Data da Cotação em Timestamp (Unix timestamp)
        public String create_date;  // Data da Cotação (formato legível)

        // Método de instância para desserializar a string JSON
        public List<Cotacao> parse(String jsonString) {
            // A AwesomeAPI retorna um JSON para a cotação diária como uma lista de objetos.
            // Ex: [{"code":"USD","codein":"BRL",...}]
            // Portanto, desserializamos diretamente para List<Cotacao>.
            return (List<Cotacao>) JSON.deserialize(jsonString, List<Cotacao>.class);
        }
    }
}