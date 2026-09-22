@IsTest
private class ClienteServiceTest {
    @IsTest
    static void deveInstanciarSemErro() {
        Test.startTest();
        new ClienteService();
        Test.stopTest();

        System.assert(true, 'O construtor deve executar sem lancar excecao.');
    }
}