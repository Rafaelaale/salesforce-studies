@IsTest
static void testBulkProcessar() {
    List<Opportunity> opps = new List<Opportunity>();
    for (Integer i = 0; i < 200; i++) {
        opps.add(new Opportunity(
            Name = 'Teste Bulk ' + i,
            StageName = 'Closed Won',
            CloseDate = Date.today().addDays(10)
        ));
    }
    insert opps;

    List<Id> oppIds = new List<Id>();
    for (Opportunity opp : opps) {
        oppIds.add(opp.Id);
    }

    Test.startTest();
    UraChackController.processar(oppIds);
    Test.stopTest();

    Integer count = [SELECT COUNT() FROM Opportunity WHERE Id IN :oppIds AND StageName = 'Prospecting'];
    System.assertEquals(200, count);
}