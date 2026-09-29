@IsTest
private class AccountListControllerTest {
    @IsTest
    static void navegaEAtualizaTamanhoDaPagina() {
        List<Account> accounts = new List<Account>();
        for (Integer index = 0; index < 12; index++) {
            accounts.add(new Account(Name = 'Conta ' + index, Phone = '(11) 99999-0100'));
        }
        insert accounts;

        ApexPages.StandardSetController standardController =
            new ApexPages.StandardSetController([
                SELECT Id, Name FROM Account ORDER BY Name
            ]);
        AccountListController controller = new AccountListController(standardController);

        System.assertEquals(5, controller.getPageSize());
        System.assertEquals(12, controller.getResultSize());
        System.assertEquals(3, controller.getTotalPages());
        System.assertEquals(true, controller.getIsFirstPage());
        System.assertEquals(false, controller.getIsLastPage());

        System.assertEquals(null, controller.next());
        System.assertEquals(2, controller.getPageNumber());
        System.assertEquals(null, controller.previous());
        System.assertEquals(1, controller.getPageNumber());
        System.assertEquals(null, controller.last());
        System.assertEquals(3, controller.getPageNumber());
        System.assertEquals(true, controller.getIsLastPage());
        System.assertEquals(null, controller.first());
        System.assertEquals(true, controller.getIsFirstPage());

        controller.setPageSize(null);
        controller.setPageSize(0);
        System.assertEquals(5, controller.getPageSize());
        controller.setPageSize(10);
        System.assertEquals(10, controller.getPageSize());
        System.assertEquals(2, controller.getTotalPages());
        System.assertEquals(1, controller.getPageNumber());
        System.assertEquals(null, controller.next());
        System.assertEquals(true, controller.getIsLastPage());
    }

    @IsTest
    static void listaVaziaTemUmaPagina() {
        ApexPages.StandardSetController standardController =
            new ApexPages.StandardSetController(new List<Account>());
        AccountListController controller = new AccountListController(standardController);

        System.assertEquals(0, controller.getResultSize());
        System.assertEquals(1, controller.getTotalPages());
        System.assertEquals(true, controller.getIsFirstPage());
        System.assertEquals(true, controller.getIsLastPage());
    }
}