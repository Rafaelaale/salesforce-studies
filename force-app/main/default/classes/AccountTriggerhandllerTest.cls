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

    @IsTest
    static void deveChamarOnebeforeInsertQuandoRunForInsert() {
        List<Account> novasContas = new List<Account>{
            new Account(Name = 'Conta run insert', Phone = '11999998888')
        };

        Test.startTest();
        AccountTriggerhandller.run(true, false, false, novasContas, null);
        Test.stopTest();

        System.assertEquals(0, novasContas[0].getErrors().size(), 'Nao deveria ter erro com telefone valido.');
    }

    @IsTest
    static void deveChamarOnebeforeUpdateQuandoRunForUpdate() {
        Account conta = new Account(Name = 'Conta original', Phone = '11999998888');
        insert conta;

        List<Account> contasAtualizadas = new List<Account>{
            new Account(Id = conta.Id, Name = 'Conta run update', Phone = '11999998888')
        };
        Map<Id, Account> mapaAntigo = new Map<Id, Account>{ conta.Id => conta };

        Test.startTest();
        AccountTriggerhandller.run(true, false, true, contasAtualizadas, mapaAntigo);
        Test.stopTest();

        System.assertEquals(0, contasAtualizadas[0].getErrors().size(), 'Nao deveria ter erro com telefone valido.');
    }

    @IsTest
    static void validaTelefoneDiretamenteNoBeforeInsert() {
        List<Account> contas = new List<Account>{
            new Account(Name = 'Telefone vazio'),
            new Account(Name = 'Telefone curto', Phone = '12345')
        };

        AccountTriggerhandller.onebeforeInsert(contas, null);

        System.assertEquals(1, contas[0].getErrors().size());
        System.assertEquals(1, contas[1].getErrors().size());
        System.assert(contas[0].getErrors()[0].getMessage().contains('informar o telefone'));
        System.assert(contas[1].getErrors()[0].getMessage().contains('DDD'));
    }

    @IsTest
    static void validaTelefoneDiretamenteNoBeforeUpdate() {
        List<Account> contas = new List<Account>{
            new Account(Name = 'Telefone vazio'),
            new Account(Name = 'Telefone curto', Phone = '12345')
        };

        AccountTriggerhandller.onebeforeUpdate(contas, null);

        System.assertEquals(1, contas[0].getErrors().size());
        System.assertEquals(1, contas[1].getErrors().size());
        System.assert(contas[0].getErrors()[0].getMessage().contains('informar o telefone'));
        System.assert(contas[1].getErrors()[0].getMessage().contains('DDD'));
    }
}