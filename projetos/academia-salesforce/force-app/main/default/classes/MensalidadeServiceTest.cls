@IsTest
private class MensalidadeServiceTest {
    @IsTest
    static void deveBuscarSomenteMensalidadesAtrasadas() {
        Aluno__c aluno = new Aluno__c(Name = 'Aluno de teste');
        insert aluno;

        insert new List<Mensalidade__c>{
            new Mensalidade__c(
                Aluno__c = aluno.Id,
                Valor__c = 150,
                Vencimento__c = Date.today().addDays(-10),
                Pago__c = false
            ),
            new Mensalidade__c(
                Aluno__c = aluno.Id,
                Valor__c = 150,
                Vencimento__c = Date.today().addDays(-10),
                Pago__c = true,
                Data_Pagamento__c = Date.today().addDays(-2)
            ),
            new Mensalidade__c(
                Aluno__c = aluno.Id,
                Valor__c = 150,
                Vencimento__c = Date.today().addDays(10),
                Pago__c = false
            )
        };

        Test.startTest();
        List<Mensalidade__c> atrasadas = MensalidadeService.buscarAtrasadas(Date.today());
        Test.stopTest();

        System.assertEquals(1, atrasadas.size());
        System.assertEquals(false, atrasadas[0].Pago__c);
        System.assert(atrasadas[0].Vencimento__c < Date.today());
    }
}