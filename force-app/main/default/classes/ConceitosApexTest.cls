@IsTest
private class ConceitosApexTest {
    @IsTest
    static void deveCriarComConceitoPadrao() {
        ConceitosApex obj = new ConceitosApex();
        System.assertEquals('Novo', obj.conceito);
    }

    @IsTest
    static void deveAtualizarConceitoEExibir() {
        ConceitosApex obj = new ConceitosApex('Inicial');

        Test.startTest();
        obj.showConceito();
        Test.stopTest();

        System.assertEquals('y', obj.Visivel);
    }

    @IsTest
    static void deveFazerPizzaComInstanciaValida() {
        ConceitosApex obj = new ConceitosApex();
        Pizza pizza = new Portuguesa();

        Test.startTest();
        obj.fazerPizza(pizza);
        Test.stopTest();

        System.assert(true, 'Deve preparar a pizza sem erro.');
    }

    @IsTest
    static void deveLancarExcecaoQuandoNaoForPizza() {
        ConceitosApex obj = new ConceitosApex();
        Boolean lancouExcecao = false;

        Test.startTest();
        try {
            obj.testandoMetodo();
        } catch (ConceitosApex.PizzaException e) {
            lancouExcecao = true;
        }
        Test.stopTest();

        System.assert(lancouExcecao, 'Deve lancar PizzaException para um objeto que nao e Pizza.');
    }
}
