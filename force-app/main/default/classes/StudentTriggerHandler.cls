public class StudentTriggerHandler {
    public static void updateAddr(List <Student__c> stuList){
        for(Student__c stu : stuList){
            stu.Address__c = 'Chennai,India';
        }
    }

}