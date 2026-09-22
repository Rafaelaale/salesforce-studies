@IsTest
private class ResultadoAlunoTest {
    @IsTest
    static void deveVerificarResultadoNasDuasFaixas() {
        Test.startTest();
        ResultadoAluno.verificarResultado('Ana', 8);
        ResultadoAluno.verificarResultado('Bruno', 4);
        Test.stopTest();

        System.assert(true, 'verificarResultado() deve executar sem lancar excecao.');
    }
}
