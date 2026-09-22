@IsTest
private class TiposDeDadosTest {
    @IsTest
    static void deveInstanciarSemErro() {
        Test.startTest();
        new TiposDeDados();
        Test.stopTest();

        System.assert(true, 'O construtor deve executar sem lancar excecao.');
    }
}
