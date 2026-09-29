@IsTest
public class OportunidadeTriggerTest {
    @IsTest
    static void testOportunidadeInsert() {
        Test.startTest();
        Opportunity opp = new Opportunity(
            Name = 'Oportunidade de Teste',
            StageName = 'Prospec��o',
            CloseDate = Date.today().addDays(30)
        );
        insert opp;
        Test.stopTest();
        System.assertNotEquals(null, opp.Id, 'O ID da oportunidade deve ser gerado.');
    }
}