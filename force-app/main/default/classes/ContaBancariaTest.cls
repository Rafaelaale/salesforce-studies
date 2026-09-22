@IsTest
private class ContaBancariaTest {
    @IsTest
    static void deveDepositarEConsultarSaldo() {
        ContaBancaria conta = new ContaBancaria('Rafael', 1000);

        Test.startTest();
        conta.depositar(500);
        conta.consultarSaldo();
        Test.stopTest();

        System.assertEquals(1500, conta.saldo);
    }
}
