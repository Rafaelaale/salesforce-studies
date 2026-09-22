public with sharing class AccountListController {

    private ApexPages.StandardSetController accountController;
    private Integer selectedPageSize = 5;

    public AccountListController(ApexPages.StandardSetController controller) {
        accountController = controller;
        accountController.setPageSize(selectedPageSize);
    }

    public Integer getPageSize() {
        return selectedPageSize;
    }

    public void setPageSize(Integer value) {
        if (value == null || value <= 0) {
            return;
        }

        selectedPageSize = value;
        accountController.setPageSize(selectedPageSize);
        accountController.first();
    }

    public Integer getPageNumber() {
        return accountController.getPageNumber();
    }

    public Integer getResultSize() {
        return accountController.getResultSize();
    }

    public Integer getTotalPages() {
        if (getResultSize() == 0) {
            return 1;
        }

        return (getResultSize() + selectedPageSize - 1) / selectedPageSize;
    }

    public Boolean getIsFirstPage() {
        return accountController.getPageNumber() == 1;
    }

    public Boolean getIsLastPage() {
        return accountController.getPageNumber() >= getTotalPages();
    }

    public PageReference first() {
        accountController.first();
        return null;
    }

    public PageReference previous() {
        accountController.previous();
        return null;
    }

    public PageReference next() {
        accountController.next();
        return null;
    }

    public PageReference last() {
        accountController.last();
        return null;
    }
}