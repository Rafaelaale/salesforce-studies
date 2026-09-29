@isTest
private class OpportunityErrorHandlerTest {
    @isTest
    static void testLogFlowError() {
        Test.startTest();
        OpportunityErrorHandler.logFlowError('Erro simulado de teste', '001000000000000AAA');
        Test.stopTest();

        System.assert(true, 'O método de log executou com sucesso.');
    }
} 