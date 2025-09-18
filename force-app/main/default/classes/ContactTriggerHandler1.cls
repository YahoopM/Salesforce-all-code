//Prevent user to delete contact which is associated with any account. &  Throw an error if phone number is not 10 dight of length

public class ContactTriggerHandler1 {
    
    public static void preventDeletion(List<Contact> conList){
        //List<Account> accList = New List<Account>();
        //Set<Id> accIds = New Set<Id>();
        
        for(Contact con : conList){
            if(con.AccountId != Null){
                con.addError('Associated with Account Cannot Be Delete');
            }
           
            }
    }
    
    public static void checkPhoneNumber(List<Contact> conList){
        for(Contact con : conList){
            if(con.Phone.length() <10 ){
                con.addError('Phone Number cannot be lessthan 10');
            }
        }
        
    }

}