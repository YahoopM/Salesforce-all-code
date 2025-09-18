@isTest
public class AccountTriggerHandlerTest {
    
    @testSetup
    static void setUp(){
        List <Account> accList = New List <Account>();
        for(Integer i = 1 ; i<=10 ; i++){
            Account acc = new Account();
            acc.Name = 'Test ' + i;
            acc.Active__c = 'Yes';
            accList.add(acc);
        }
        
        Test.StartTest();
        insert accList;
        Test.StopTest();
        
    }
    
    
    @isTest
    static void createOppTest(){
        List <Account> accList = New List <Account>();
        List<Opportunity> oppList = [SELECT Id From Opportunity WHERE Accountid =:accList[0].Id];
        System.assert(oppList!=Null,'Opportunity not Created');
        
    }
    
    @isTest
    static void populateRatingInsert(){
        /*List <Account> accList = New List <Account>();
        for(Integer i = 1 ; i<=10 ; i++){
            Account acc = new Account();
            acc.Name = 'Test ' + i;
            acc.Active__c = 'Yes';
            acc.Industry = 'Media';
            accList.add(acc);
        }
        
        Test.StartTest();
        insert accList;
        Test.StopTest();*/
        List <Account> accList = New List <Account>();
        List<Account> updatedAccList = [SELECT Rating FROM Account WHERE Id =: accList[0].Id ];
        System.AssertEquals('Hot',updatedAccList[0].Rating);
    }
    
    
    @isTest
    static void populateRatingUpdate(){
       /* List <Account> accList = New List <Account>();
        for(Integer i = 1 ; i<=10 ; i++){
            Account acc = new Account();
            acc.Name = 'Test ' + i;
            acc.Active__c = 'Yes';
            acc.Industry = 'Chemicals';
            accList.add(acc);
        }
        
        Test.StartTest();
        insert accList;*/
        List <Account> accList = New List <Account>();
        accList = [SELECT Id,Name,Industry FROM Account];
        for(Account acc : accList){
            acc.Industry = 'Media';
        }
        update accList;
        Test.StopTest();
        
        List<Account> updateAccList = [SELECT Rating FROM Account WHERE Id =: accList[0].Id ];
        System.AssertEquals('Hot',updateAccList[0].Rating);
        
        
        
    }
    
}