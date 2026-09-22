public class ContaBancaria {
    public String titular;
    public Decimal saldo;

    public ContaBancaria(String nomeTitular, Decimal saldoInicial) {
        titular = nomeTitular;
        saldo = saldoInicial;
    }

    public void depositar(Decimal valor) {
        saldo = saldo + valor;
    }

    public void consultarSaldo() {
        System.debug('Titular: ' + titular);
        System.debug('Saldo: ' + saldo);
    }
}