@IsTest
private class InformacoesDaOrgTest {
    @IsTest
    static void deveRetornarIdDaOrganizacao() {
        Test.startTest();
        String orgId = InformacoesDaOrg.obterIdDaOrganizacao();
        Test.stopTest();

        System.assertNotEquals(null, orgId);
    }
}
