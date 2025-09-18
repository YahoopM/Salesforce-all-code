trigger Accounttrigger on Account (before insert , after insert,before update,after Update,before Delete) {
    if(trigger.isinsert){
        if(trigger.isBefore){
            AccountTriggerHandler.updateDesc(Trigger.New);
            AccountTriggerHandler.populatingRating(Trigger.New, null);
        }
        else if(trigger.isAfter){
            AccountTriggerHandler.createOpp(Trigger.New);
            
        }
        
    }
    
    
    if(trigger.isupdate){
        if(trigger.isbefore){
            AccountTriggerHandler.updatePhone(Trigger.New,Trigger.oldMap);
             AccountTriggerHandler.populatingRating(Trigger.New,Trigger.oldMap);
        }
        else if(trigger.isAfter){
            AccountTriggerHandler.updateRelatedContacts(Trigger.New,Trigger.oldMap);
        }
    }
    
     if(trigger.isdelete){
        if(trigger.isbefore){
            AccountTriggerHandler.preventDeletion(Trigger.old);
       		
        }
        else if(trigger.isAfter){
            
        }
    }
    
    
    
    
}