@IsTest
public class OportunidadeHandlerTest {
    @IsTest
    static void testHandler() {
        Opportunity opp = new Opportunity(Name='Test', StageName='Prospecting', CloseDate=Date.today());
        insert opp;
        System.assert(opp.Id != null);
    }
}