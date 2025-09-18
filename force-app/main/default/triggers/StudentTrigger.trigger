trigger StudentTrigger on Student__c (before insert) {
    if(trigger.isinsert){
        if(trigger.isBefore){
            StudentTriggerHandler.updateAddr(trigger.New);
        }
        
    }
}