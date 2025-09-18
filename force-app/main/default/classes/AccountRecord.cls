public class AccountRecord {
    public static ID createRecord(String name , string rating , string active){
        Account acc = new Account();
        acc.Name = name;
        acc.Rating = rating;
        acc.Active__c = active;
        insert acc ;
        
        return acc.Id; // after creation of account accid will be there
    }
    
    public static void createContact(){
        Id accId;
        accId = createRecord('zaid','Warm','Yes');
        Contact con = new Contact(FirstName = 'Al', LastName = 'Amaira');
        con.accountId = accId;
        Insert con ;
    }
}