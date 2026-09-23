@IsTest
private class PresencaServiceTest {
    @IsTest
    static void deveBuscarHistoricoDoAlunoNoPeriodo() {
        Aluno__c aluno = new Aluno__c(Name = 'Aluno de presença');
        insert aluno;

        insert new List<Presenca__c>{
            new Presenca__c(
                Aluno__c = aluno.Id,
                Data__c = Date.today().addDays(-2)
            ),
            new Presenca__c(
                Aluno__c = aluno.Id,
                Data__c = Date.today().addDays(-20)
            )
        };

        Test.startTest();
        List<Presenca__c> historico = PresencaService.buscarHistorico(
            aluno.Id,
            Date.today().addDays(-7),
            Date.today()
        );
        Test.stopTest();

        System.assertEquals(1, historico.size());
        System.assertEquals(Date.today().addDays(-2), historico[0].Data__c);
    }
}
