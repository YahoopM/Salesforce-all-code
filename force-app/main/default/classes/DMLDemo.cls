public class DMLDemo {
    public static void insertDemo(){
        /* List<Account> accList = new List <Account>();
List<Contact> conList = new List <Contact>();
Account acc =new Account();
acc.Name = 'Test 116';
acc.Active__c = 'Yes';
accList.add(acc);
//system.debug('Account Id' + Acc.Id);
Account acc2 =new Account();
acc2.Name = 'Test 117';
acc2.Active__c = 'Yes';
accList.add(acc2);


insert accList;

Contact con = new Contact();
con.FirstName = acc.Name;
con.LastName = acc.Name;
con.AccountId = acclist[0].Id;
conList.add(con);

Contact con2 = new Contact();
con2.FirstName = acc.Name;
con2.LastName = acc.Name;
con2.AccountId = acclist[1].Id;
conList.add(con2);

Insert conList; */
        
        
        //using Loop
        List<Account> accList = new List <Account>();
        for(Integer i =1;i<=200;i++){
            Account acc =new Account();
            acc.Name = 'Test DML '+ i;
            acc.Active__c = 'Yes';
            accList.add(acc);
        }
        insert accList;
    }
    
    public static void updateDemo(){
        List<Account> accList = new List <Account>();
        accList = [SELECT Id,Name,Rating,Industry FROM Account WHERE Rating = 'Hot'];
        
        if(!accList.isEmpty()){
            for(Account acc : accList){
                acc.Industry = 'Media';
                acc.Active__c = 'Yes';
            }
          Update accList;
        }
    }
    
    public static void upsertDemo(){
        List<Account> accList = new List <Account>();
        accList = [SELECT Id,Name,Rating,Industry FROM Account WHERE Rating = 'Hot'];
        
        if(!accList.isEmpty()){
            for(Account acc : accList){
                acc.Industry = 'Energy';
                acc.Active__c = 'Yes';
            }
        }
          
    	for(Integer i =1;i<=5;i++){
            Account acc =new Account();
            acc.Name = 'Test Upsert Demo '+ i;
            acc.Active__c = 'Yes';
            accList.add(acc);
    	}
        Upsert accList;
        
    }
    
    public static void deleteDemo(){
       List<Account> accList = new List <Account>(); 
       accList = [SELECT Id,Name,Rating,Industry FROM Account WHERE Name LIKE 'Test Upsert %'];
        
        if(!accList.isEmpty()){
            delete accList;
        }
    }
    
}