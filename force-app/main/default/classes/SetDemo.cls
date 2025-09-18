public class SetDemo {
    public static Void sObjectSetDemo(){
        set<Id> accIds = new set <Id>();
        List <Account> accList = New List <Account>();
        accList =[SELECT Id,NAME FROM ACCOUNT LIMIT 5];
        for (Account acc : accList){
            accIds.add(acc.Id);
        }
        system.debug('Set Contains' +accIds);
        
    }
    
        public static Void customObjectSetDemo(){
        set<Id> stuIds = new set <Id>();
        List <Student__c> stuList = New List <Student__c>();
        stuList =[SELECT Id FROM Student__c LIMIT 5];
        for (Student__c stu : stuList){
            stuIds.add(stu.Id);
        }
        system.debug('Set Contains' +stuIds);
        
    }

}