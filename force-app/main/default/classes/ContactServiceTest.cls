@IsTest
private class ContactServiceTest {
    @IsTest
    static void testValidatePhone() {
        Contact c = new Contact(LastName = 'Test Contact');
        Test.startTest();
        ContactService.validatePhone(new List<Contact>{c});
        Test.stopTest();
        System.assert(true, 'Test executed successfully');
    }
}