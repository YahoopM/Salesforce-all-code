@isTest
public class ContactTriggerHandlerTest {
    @isTest
    static void testDeleteContactWithAccount() {
        
        Account acc = new Account(Name = 'Test Account');
        insert acc;
        
        Contact con = new Contact(FirstName = 'Test', LastName = '555', Phone = '1234567890', AccountId = Null);
        insert con;
        
        Test.startTest();
        delete con; 
        Test.stopTest();
    }
    
    @isTest
    static void testInsertValidPhone() {
        Contact con = new Contact(FirstName = 'Test', LastName = '55', Phone = '1234567890');
        
        Test.startTest();
        insert con;
        Test.stopTest();

        System.assertNotEquals(null, con.Id, 'Contact should be inserted successfully');
    }


    
}