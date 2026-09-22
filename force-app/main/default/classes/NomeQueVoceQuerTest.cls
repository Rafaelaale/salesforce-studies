@IsTest
private class NomeQueVoceQuerTest {
    @IsTest
    static void deveInstanciarSemErro() {
        Test.startTest();
        new NomeQueVoceQuer();
        Test.stopTest();

        System.assert(true, 'O construtor deve executar sem lancar excecao.');
    }
}
