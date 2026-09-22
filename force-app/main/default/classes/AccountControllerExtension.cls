public with sharing class AccountControllerExtension {

    public Account conta { get; private set; }

    public AccountControllerExtension(
        ApexPages.StandardController standardController
    ) {
        conta = (Account) standardController.getRecord();
    }

}
