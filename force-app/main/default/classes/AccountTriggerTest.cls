@isTest
public class AccountTriggerTest {
    @isTest
    static void testInsertAccountWithValidName() {
        Account acc = new Account(Name = 'Conta Teste', Phone = '11999999999');
        Test.startTest();
        insert acc;
        Test.stopTest();

        System.assertNotEquals(null, acc.Id, 'A conta deveria ter sido inserida com sucesso.');
    }
}