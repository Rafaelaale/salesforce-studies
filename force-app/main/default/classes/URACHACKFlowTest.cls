@isTest
public class URACHACKFlowTest {
    @isTest
    static void testFlowExecution() {
        Opportunity opp = new Opportunity(
            Name = 'Oportunidade Teste Fluxo',
            StageName = 'Prospecting',
            CloseDate = Date.today().addDays(30),
            Amount = 10000.00
        );

        Test.startTest();
        insert opp;
        Test.stopTest();

        Opportunity insertedOpp = [SELECT Id, StageName FROM Opportunity WHERE Id = :opp.Id];
        System.assertNotEquals(null, insertedOpp.Id, 'A oportunidade deveria ter sido criada com sucesso.');
    }
} 