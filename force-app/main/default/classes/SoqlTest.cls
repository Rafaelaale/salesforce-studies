@IsTest
private class SoqlTest {
    @IsTest
    static void deveInstanciarSemErro() {
        Test.startTest();
        new Soql();
        Test.stopTest();

        System.assert(true, 'O construtor deve executar a consulta sem lancar excecao.');
    }
}
