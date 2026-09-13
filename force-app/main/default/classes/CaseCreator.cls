public with sharing class CaseCreator {
    public static void createCase() {
        Case newCase = new Case();
        newCase.Subject = 'HI there';
        newCase.Status = 'New';
        newCase.Origin = 'Phone';

        insert newCase;
    }
}