trigger ContactTrigger1 on Contact (before Delete,before insert,before update) {
    if(Trigger.isdelete){
        if(Trigger.isbefore){
            ContactTriggerHandler1.preventDeletion(Trigger.old);
        }
    }
    
    if(Trigger.isbefore){
        if(Trigger.isinsert || Trigger.isupdate){
            ContactTriggerHandler1.checkPhoneNumber(Trigger.new);
        }
    }

}