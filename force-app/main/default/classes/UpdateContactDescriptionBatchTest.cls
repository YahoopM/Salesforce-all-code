@isTest
public class UpdateContactDescriptionBatchTest { 
    @isTest
    static void batchMethod(){
        List<Contact> conList = new List<Contact>();
        Contact con = new Contact();
        con.LastName = 'Test25 ';
        con.Phone = '8596478575';
        conList.add(con);
        insert conList;
        
        Test.startTest();
        UpdateContactDescriptionBatch batch = new UpdateContactDescriptionBatch();
        Database.executeBatch(batch, 50);
        Test.stopTest();
        
        Contact updatedCon = [SELECT Description FROM Contact WHERE Id = :con.Id];
        System.assertEquals('Updated by Batch', updatedCon.Description, 'Description should be updated by batch');
    }
    
}