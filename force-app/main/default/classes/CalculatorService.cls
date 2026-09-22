public with sharing class CalculatorService {

    private static final String DEFAULT_ENDPOINT =
        'http://www.dneonline.com/calculator.asmx';
    private static final String SOAP_NAMESPACE = 'http://tempuri.org/';

    private final String endpoint;

    public CalculatorService() {
        this(DEFAULT_ENDPOINT);
    }

    public CalculatorService(String endpointUrl) {
        if (String.isBlank(endpointUrl)) {
            throw new CalculatorException('O endpoint do calculator nao pode ser vazio.');
        }

        endpoint = endpointUrl;
    }

    public Integer add(Integer intA, Integer intB) {
        return execute('Add', 'AddResult', intA, intB);
    }

    public Integer subtract(Integer intA, Integer intB) {
        return execute('Subtract', 'SubtractResult', intA, intB);
    }

    public Integer multiply(Integer intA, Integer intB) {
        return execute('Multiply', 'MultiplyResult', intA, intB);
    }

    public Integer divide(Integer intA, Integer intB) {
        return execute('Divide', 'DivideResult', intA, intB);
    }

    private Integer execute(
        String operation,
        String resultName,
        Integer intA,
        Integer intB
    ) {
        if (intA == null || intB == null) {
            throw new CalculatorException('Os dois valores da operacao sao obrigatorios.');
        }

        HttpRequest request = new HttpRequest();
        request.setEndpoint(endpoint);
        request.setMethod('POST');
        request.setHeader('Content-Type', 'text/xml; charset=utf-8');
        request.setHeader('SOAPAction', '"' + SOAP_NAMESPACE + operation + '"');
        request.setTimeout(120000);
        request.setBody(buildEnvelope(operation, intA, intB));

        HttpResponse response = new Http().send(request);
        if (response.getStatusCode() < 200 || response.getStatusCode() >= 300) {
            throw new CalculatorException(
                'O calculator retornou HTTP ' + response.getStatusCode() + '.'
            );
        }

        return readResult(response.getBody(), resultName);
    }

    private static String buildEnvelope(String operation, Integer intA, Integer intB) {
        return '<?xml version="1.0" encoding="utf-8"?>'
            + '<soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">'
            + '<soap:Body><' + operation + ' xmlns="' + SOAP_NAMESPACE + '">'
            + '<intA>' + intA + '</intA><intB>' + intB + '</intB>'
            + '</' + operation + '></soap:Body></soap:Envelope>';
    }

    private static Integer readResult(String responseBody, String resultName) {
        Dom.Document document = new Dom.Document();
        document.load(responseBody);

        Dom.XmlNode resultNode = findNode(document.getRootElement(), resultName);
        if (resultNode == null || String.isBlank(resultNode.getText())) {
            throw new CalculatorException(
                'A resposta SOAP nao contem o resultado ' + resultName + '.'
            );
        }

        return Integer.valueOf(resultNode.getText());
    }

    private static Dom.XmlNode findNode(Dom.XmlNode node, String nodeName) {
        if (node.getName() == nodeName) {
            return node;
        }

        for (Dom.XmlNode child : node.getChildElements()) {
            Dom.XmlNode result = findNode(child, nodeName);
            if (result != null) {
                return result;
            }
        }

        return null;
    }

    public class CalculatorException extends Exception {
    }
}