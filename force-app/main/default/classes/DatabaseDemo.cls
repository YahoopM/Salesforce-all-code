public class DatabaseDemo {
    
    public static void dbDemo(){
        
        List<Contact> conList = new List<Contact>{
            new Contact(FirstName = 'Joe',LastName = 'bravo' , Department = 'Finance'),
                new Contact(FirstName = 'Will',LastName = 'Smith' , Department = 'Technology'),
                new Contact(FirstName = 'Hardik',LastName = 'Pandya' , Department = 'Finance'),
                new Contact()
                };
                    
                    Database.SaveResult[] srList = Database.insert(conList,false);
        
        //iterate through each returning result
        for (Database.SaveResult sr :srList){
            if(sr.isSuccess()){
                //operation was successful , so get the id of the record that was processed
                system.debug('Successfully inserted contact. ContactID : '+sr.getId());
            }else{
                //operation fails means get all errors
                for(Database.Error err : sr.getErrors()){
                    system.debug('the following error has occured');
                    system.debug(err.getStatusCode() + ':' + err.getMessage());
                    system.debug('contact fields that affected this error' + err.getFields());
                }
            }
            
        }
    }
}