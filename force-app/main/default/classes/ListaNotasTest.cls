@IsTest
private class ListaNotasTest {
    @IsTest
    static void deveVerificarNotasNasTresFaixas() {
        Test.startTest();
        ListaNotas.verificarNotas(new List<Decimal>{ 8, 6, 3 });
        Test.stopTest();

        System.assert(true, 'verificarNotas() deve executar sem lancar excecao.');
    }
}
