@isTest
private class ViaCEPServiceTest {
    @isTest
    static void testGetCEPInfo() {
        Test.setMock(HttpCalloutMock.class, new ViaCEPMockHttpGenerator());
        Test.startTest();
        List<String> ceps = new List<String>{'01001-000'};
        List<ViaCEPResponse> results = ViaCEPService.getCEPInfo(ceps);
        Test.stopTest();
        System.assertNotEquals(null, results, 'O resultado não deve ser nulo');
    }
}