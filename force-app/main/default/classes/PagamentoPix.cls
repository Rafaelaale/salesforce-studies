public class PagamentoPix extends PagamentoCartao {

    public override Decimal cobrar(Decimal valorCompra, Decimal valorPago) {

        Decimal troco = valorPago - valorCompra;

        return troco;
    }
}