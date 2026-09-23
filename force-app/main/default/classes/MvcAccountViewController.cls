public with sharing class MvcAccountViewController {
    public Account conta { get; private set; }

    public MvcAccountViewController(ApexPages.StandardController standardController) {
        conta = (Account) standardController.getRecord();
    }
}
