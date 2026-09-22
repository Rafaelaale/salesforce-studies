@IsTest
private class NomeAquiTest {
    @IsTest
    static void deveInstanciarSemErro() {
        Test.startTest();
        new NomeAqui();
        Test.stopTest();

        System.assert(true, 'O construtor deve executar sem lancar excecao.');
    }
}
