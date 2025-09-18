public class CustomSobjectDemo {
    public static void custom(){
        Student__c stu = new Student__c();
        stu.Name__c = 'Amaira';
        stu.Phone_no__c = '7200994848';
        insert stu;
    }

}