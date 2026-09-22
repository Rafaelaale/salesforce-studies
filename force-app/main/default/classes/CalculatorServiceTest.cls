@IsTest
private class CalculatorServiceTest {

    @IsTest
    static void deveExecutarAsOperacoesDoCalculator() {
        Test.setMock(HttpCalloutMock.class, new CalculatorMock());
        CalculatorService service = new CalculatorService('https://example.test/calculator');

        Test.startTest();
        Integer sum = service.add(8, 2);
        Integer difference = service.subtract(8, 2);
        Integer product = service.multiply(8, 2);
        Integer quotient = service.divide(8, 2);
        Test.stopTest();

        System.assertEquals(10, sum);
        System.assertEquals(6, difference);
        System.assertEquals(16, product);
        System.assertEquals(4, quotient);
    }

    @IsTest
    static void deveRejeitarValoresNulos() {
        CalculatorService service = new CalculatorService('https://example.test/calculator');

        try {
            service.add(null, 2);
            System.assert(false, 'Deveria rejeitar valor nulo.');
        } catch (CalculatorService.CalculatorException exceptionValue) {
            System.assert(exceptionValue.getMessage().contains('obrigatorios'));
        }
    }

    private class CalculatorMock implements HttpCalloutMock {
        public HttpResponse respond(HttpRequest request) {
            HttpResponse response = new HttpResponse();
            response.setStatusCode(200);
            response.setHeader('Content-Type', 'text/xml; charset=utf-8');

            String operation = request.getHeader('SOAPAction').replace('"http://tempuri.org/', '').replace('"', '');
            Integer result = operation == 'Add' ? 10
                : operation == 'Subtract' ? 6
                : operation == 'Multiply' ? 16
                : 4;
            String resultName = operation + 'Result';
            response.setBody(
                '<soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">'
                + '<soap:Body><' + operation + 'Response xmlns="http://tempuri.org/">'
                + '<' + resultName + '>' + result + '</' + resultName + '>'
                + '</' + operation + 'Response></soap:Body></soap:Envelope>'
            );
            return response;
        }
    }
}