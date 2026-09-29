@isTest
public class OportunidadeServiceTest {
    @isTest
    static void testarAplicacaoRegrasNegocio() {
        Opportunity op = new Opportunity(
            Name = 'Oportunidade Grande',
            StageName = 'Prospecting',
            CloseDate = Date.today().addDays(5),
            Amount = 150000.00
        );

        Test.startTest();
        OportunidadeService.aplicarRegrasNegocio(new List<Opportunity>{op});
        Test.stopTest();

        System.assertEquals('Existing Customer - Upgrade', op.Type, 'O tipo da oportunidade deveria ter sido preenchido automaticamente.');
    }
}