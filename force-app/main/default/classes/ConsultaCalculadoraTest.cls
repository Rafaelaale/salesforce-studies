@IsTest
private class ConsultaCalculadoraTest {
    @IsTest
    static void deveCalcularValorTotal() {
        Decimal valorBase = 50;
        Integer duracaoMinutos = 2;

        Test.startTest();
        Decimal resultado = ConsultaCalculadora.calcularValorTotal(valorBase, duracaoMinutos);
        Test.stopTest();

        System.assertEquals(100, resultado, 'O valor total deve ser 100.');
    }
}
