//Write a Batch class to add "Updated by Batch" in the Description field of all Contacts where the field is currently null.

public class  UpdateContactDescriptionBatch implements Database.Batchable<sobject>{
    public Database.QueryLocator start(Database.BatchableContext bc){
        return Database.getQueryLocator([SELECT Id, Description FROM Contact]);
    }
    
    public void execute(Database.BatchableContext bc, List<Contact> conList){
        for(Contact con : conList){
            con.Description = 'Updated by Batch';
        }
    update conList;
}
public void finish(Database.BatchableContext bc){
    system.debug('Batch Job Completed : Description is updated using Batch');
   
}

}