trigger ContactTrigger on Contact (After insert,After Delete,After Undelete) {
    
    if(Trigger.isInsert){
        if(Trigger.isAfter){
            ContactTriggerHandler.totalContactCount(Trigger.New);
        }
    }
    
    if(Trigger.isDelete){
        if(Trigger.isAfter){
            ContactTriggerHandler.totalContactCount(Trigger.old);  
        }
    }
    
    if(Trigger.isUndelete){
        if(Trigger.isAfter){
            ContactTriggerHandler.totalContactCount(Trigger.New);
        }
    }
    
}