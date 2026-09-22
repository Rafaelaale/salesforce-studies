@IsTest
private class bemsimplesTest {
    @IsTest
    static void deveSaudarVisitanteQuandoNomeVazio() {
        System.assertEquals('Olá, visitante', bemsimples.ola(''));
    }

    @IsTest
    static void deveSaudarPeloNome() {
        System.assertEquals('Olá, Rafael', bemsimples.ola('Rafael'));
    }
}
