@IsTest
private class CaseCreatorTest {
    @IsTest
    static void deveCriarCase() {
        Test.startTest();
        CaseCreator.createCase();
        Test.stopTest();

        List<Case> casos = [SELECT Id, Subject, Status, Origin FROM Case];
        System.assertEquals(1, casos.size());
        System.assertEquals('HI there', casos[0].Subject);
    }
}
