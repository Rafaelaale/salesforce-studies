@isTest
public class ContactTriggerTest {
    @isTest
    static void testContactWithoutPhone() {
        Test.startTest();
        try {
            Contact con = new Contact(LastName = 'Test LastName');
            insert con;
            System.assert(false, 'Deveria ter lançado um erro por falta de telefone.');
        } catch (DmlException e) {
            System.assert(true);
        }
        Test.stopTest();
    }
}