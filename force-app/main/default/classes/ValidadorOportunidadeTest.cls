@isTest
public class ValidadorOportunidadeTest {
    @isTest
    static void testarValidacaoPositiva() {
        Opportunity opp = new Opportunity(Name = 'Teste', Amount = 100, StageName = 'Prospecting', CloseDate = Date.today().addDays(5));
        insert opp;
        System.assert(opp.Id != null);
    }
}