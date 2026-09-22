@IsTest
private class OlaTest {
    @IsTest
    static void deveSaudarSemErro() {
        Ola obj = new Ola();

        Test.startTest();
        obj.saudacao();
        Test.stopTest();

        System.assert(true, 'saudacao() deve executar sem lancar excecao.');
    }
}
