@isTest
private class ViaCEPFlowActionTest {
    @isTest
    static void testExecute() {
        Test.setMock(HttpCalloutMock.class, new ViaCEPMockHttpGenerator());
        Test.startTest();
        List<String> ceps = new List<String>{'01001-000'};
        List<ViaCEPResponse> results = ViaCEPFlowAction.execute(ceps);
        Test.stopTest();
        System.assertNotEquals(null, results, 'O resultado não deve ser nulo');
    }
}