@IsTest
private class ConsultaContasTest {
    @TestSetup
    static void setup() {
        insert new Account(Name = 'Conta Teste', Industry = 'Technology', Phone = '11999998888');
    }

    @IsTest
    static void deveListarContas() {
        Test.startTest();
        ConsultaContas.listarContas();
        Test.stopTest();

        System.assert(true, 'listarContas() deve executar sem lancar excecao.');
    }

    @IsTest
    static void deveListarContasPorSetor() {
        Test.startTest();
        ConsultaContas.listarContasPorSetor('Technology');
        Test.stopTest();

        System.assert(true, 'listarContasPorSetor() deve executar sem lancar excecao.');
    }
}
