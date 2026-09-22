@IsTest
private class NomeDaClasseTest {
    @IsTest
    static void deveInstanciarSemErro() {
        Test.startTest();
        new NomeDaClasse();
        Test.stopTest();

        System.assert(true, 'O construtor deve executar sem lancar excecao.');
    }
}
