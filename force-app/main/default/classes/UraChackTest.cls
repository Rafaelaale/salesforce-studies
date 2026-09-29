@IsTest
private class UraChackTest {
    @IsTest
    static void testProcessar() {
        Opportunity opp = new Opportunity(
            Name = 'Teste URA',
            StageName = 'Closed Won',
            CloseDate = Date.today().addDays(30)
        );
        insert opp;

        Test.startTest();
        UraChackController2.processar(new List<Id>{ opp.Id });
        Test.stopTest();

        Opportunity result = [SELECT StageName FROM Opportunity WHERE Id = :opp.Id];
        System.assertEquals('Prospecting', result.StageName);
    }
}