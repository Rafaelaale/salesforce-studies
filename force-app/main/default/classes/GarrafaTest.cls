@IsTest
private class GarrafaTest {
    @IsTest
    static void deveAbrirGarrafa() {
        Garrafa garrafa = new Garrafa();

        Test.startTest();
        garrafa.abrirGarrafa();
        Test.stopTest();

        System.assert(true, 'abrirGarrafa() deve executar sem lancar excecao.');
    }
}
