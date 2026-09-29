@IsTest
static void testBulkProcessarComErro() {
    List<Opportunity> opps = new List<Opportunity>();
    for (Integer i = 0; i < 50; i++) {
        opps.add(new Opportunity(
            Name = 'Erro Bulk ' + i,
            StageName = null,
            CloseDate = Date.today().addDays(5)
        ));
    }

    Test.startTest();
    try {
        insert opps;
    } catch (DmlException e) {
        System.assert(e.getMessage().contains('Required fields are missing'));
    }
    Test.stopTest();
}