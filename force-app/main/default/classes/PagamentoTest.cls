@IsTest
public class PagamentoTest {

    @IsTest
    public static void pagamentoTest() {

        PagamentoCartao pc = new PagamentoCartao();

        Decimal troco = pc.cobrar(150, 150);

        System.assertEquals(0, troco);
    }
}