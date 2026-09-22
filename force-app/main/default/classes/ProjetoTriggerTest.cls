@IsTest
private class ProjetoTriggerTest {
    @IsTest
    static void devePreencherDataDeInicioAoIniciarProjeto() {
        Projeto__c projeto = new Projeto__c(
            Name = 'Projeto Teste',
            Status__c = 'Não iniciado'
        );
        insert projeto;

        Test.startTest();
        projeto.Status__c = 'Em andamento';
        update projeto;
        Test.stopTest();

        Projeto__c atualizado = [
            SELECT Data_de_inicio__c
            FROM Projeto__c
            WHERE Id = :projeto.Id
        ];
        System.assertEquals(Date.today(), atualizado.Data_de_inicio__c);
    }

    @IsTest
    static void naoDeveAlterarDataQuandoJaPreenchida() {
        Date dataOriginal = Date.today().addDays(-5);
        Projeto__c projeto = new Projeto__c(
            Name = 'Projeto Teste 2',
            Status__c = 'Não iniciado',
            Data_de_inicio__c = dataOriginal
        );
        insert projeto;

        Test.startTest();
        projeto.Status__c = 'Em andamento';
        update projeto;
        Test.stopTest();

        Projeto__c atualizado = [
            SELECT Data_de_inicio__c
            FROM Projeto__c
            WHERE Id = :projeto.Id
        ];
        System.assertEquals(dataOriginal, atualizado.Data_de_inicio__c);
    }
}
