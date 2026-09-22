@IsTest
private class AccountTriggerhandllerTest {
    @IsTest
    static void deveAdicionarErroQuandoTelefoneEmBranco() {
        Account conta = new Account(Name = 'Sem telefone');

        Test.startTest();
        try {
            insert conta;
            System.assert(false, 'Deveria ter lancado erro por telefone em branco.');
        } catch (DmlException e) {
            System.assert(e.getMessage().contains('informar o telefone'));
        }
        Test.stopTest();
    }

    @IsTest
    static void deveAdicionarErroQuandoTelefoneSemDdd() {
        Account conta = new Account(Name = 'Telefone curto', Phone = '12345');

        Test.startTest();
        try {
            insert conta;
            System.assert(false, 'Deveria ter lancado erro por telefone sem DDD.');
        } catch (DmlException e) {
            System.assert(e.getMessage().contains('DDD'));
        }
        Test.stopTest();
    }

    @IsTest
    static void devePermitirAtualizacaoComTelefoneValido() {
        Account conta = new Account(Name = 'Conta valida', Phone = '11999998888');
        insert conta;

        Test.startTest();
        conta.Name = 'Conta valida atualizada';
        update conta;
        Test.stopTest();

        Account atualizado = [SELECT Name FROM Account WHERE Id = :conta.Id];
        System.assertEquals('Conta valida atualizada', atualizado.Name);
    }
}
