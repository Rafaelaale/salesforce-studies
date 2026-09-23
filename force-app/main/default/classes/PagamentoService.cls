public with sharing class PagamentoService {
    public static Decimal calcularValorComDesconto(Decimal valor, Decimal percentualDesconto) {
        if (valor == null || valor < 0) {
            return 0;
        }

        if (percentualDesconto == null || percentualDesconto < 0) {
            return valor;
        }

        Decimal desconto = valor * (percentualDesconto / 100);
        return valor - desconto;
    }

    public static Decimal calcularTotalComJuros(Decimal valor, Decimal juros) {
        if (valor == null || valor < 0) {
            return 0;
        }

        if (juros == null || juros < 0) {
            return valor;
        }

        return valor + (valor * (juros / 100));
    }
}
