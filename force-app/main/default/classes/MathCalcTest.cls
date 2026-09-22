@IsTest
private class MathCalcTest {
    @IsTest
    static void deveExecutarOperacoesDaCalculadora() {
        Test.setMock(HttpCalloutMock.class, new MathCalcMock());

        Test.startTest();
        MathCalc calc = new MathCalc();
        Test.stopTest();

        System.assertNotEquals(null, calc);
    }

    private class MathCalcMock implements HttpCalloutMock {
        public HttpResponse respond(HttpRequest request) {
            HttpResponse response = new HttpResponse();
            response.setStatusCode(200);
            response.setHeader('Content-Type', 'text/xml; charset=utf-8');

            String action = request.getHeader('SOAPAction');
            String operation = action == null ? 'Add' : action.replace('"http://tempuri.org/', '').replace('"', '');

            Integer result = operation == 'Add' ? 20
                : operation == 'Divide' ? 2
                : operation == 'Subtract' ? 5
                : 100;

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
