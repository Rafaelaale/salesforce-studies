@IsTest
public class PagamentoPixTest {

    @IsTest
    static void testarPagamentoPix() {

        PagamentoCartao pagamento = new PagamentoPix();

        Decimal troco = pagamento.cobrar(100, 150);

        System.assertEquals(50, troco);
    }
}