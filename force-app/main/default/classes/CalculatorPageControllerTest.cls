@IsTest
private class CalculatorPageControllerTest {

    @IsTest
    static void deveCalcularPelaPagina() {
        Test.setMock(HttpCalloutMock.class, new CalculatorPageMock());
        CalculatorPageController controller = new CalculatorPageController();
        controller.intA = 8;
        controller.intB = 2;
        controller.operation = 'Multiply';

        Test.startTest();
        PageReference page = controller.calculate();
        Test.stopTest();

        System.assertEquals(null, page);
        System.assertEquals(16, controller.result);
        System.assertEquals(null, controller.errorMessage);
    }

    @IsTest
    static void deveExibirErroQuandoFaltaremValores() {
        CalculatorPageController controller = new CalculatorPageController();
        controller.operation = 'Add';

        controller.calculate();

        System.assert(controller.errorMessage.contains('obrigatorios'));
        System.assertEquals(null, controller.result);
    }

    private class CalculatorPageMock implements HttpCalloutMock {
        public HttpResponse respond(HttpRequest request) {
            HttpResponse response = new HttpResponse();
            response.setStatusCode(200);
            response.setBody(
                '<soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">'
                + '<soap:Body><MultiplyResponse xmlns="http://tempuri.org/">'
                + '<MultiplyResult>16</MultiplyResult>'
                + '</MultiplyResponse></soap:Body></soap:Envelope>'
            );
            return response;
        }
    }
}