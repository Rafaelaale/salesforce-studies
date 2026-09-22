@IsTest
private class ClienteExercicio01Test {
    @IsTest
    static void deveMostrarClienteSemErro() {
        Test.startTest();
        ClienteExercicio01.mostrarCliente('Rafael', 'Sao Paulo', 'Premium', true);
        Test.stopTest();

        System.assert(true, 'mostrarCliente() deve executar sem lancar excecao.');
    }
}
