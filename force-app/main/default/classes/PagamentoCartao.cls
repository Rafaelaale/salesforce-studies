public virtual class PagamentoCartao {


    public PagamentoCartao() {
    }


    public virtual Decimal cobrar(Decimal valorCompra, Decimal valorPago) {
        return valorPago - valorCompra;
    }
}