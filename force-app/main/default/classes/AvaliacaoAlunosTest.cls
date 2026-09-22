@IsTest
private class AvaliacaoAlunosTest {
    @IsTest
    static void deveVerificarAvaliacaoNasTresFaixas() {
        Test.startTest();
        AvaliacaoAlunos.verificarAvaliacao('Ana', 8);
        AvaliacaoAlunos.verificarAvaliacao('Bruno', 6);
        AvaliacaoAlunos.verificarAvaliacao('Carla', 3);
        Test.stopTest();

        System.assert(true, 'verificarAvaliacao() deve executar sem lancar excecao.');
    }
}
