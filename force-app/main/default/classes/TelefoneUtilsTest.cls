@IsTest
private class TelefoneUtilsTest {
    @IsTest
    static void deveRetornarVazioQuandoTelefoneEmBranco() {
        System.assertEquals('', TelefoneUtils.somenteDigitos(''));
    }

    @IsTest
    static void deveRemoverCaracteresNaoNumericos() {
        System.assertEquals('11999998888', TelefoneUtils.somenteDigitos('(11) 99999-8888'));
    }
}
