@IsTest
private class CalculosTest {
    @IsTest
    static void deveInstanciarSemErro() {
        Test.startTest();
        new Calculos();
        Test.stopTest();

        System.assert(true, 'O construtor deve executar sem lancar excecao.');
    }
}
