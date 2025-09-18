public class ListDemo {
    public static void listMethod(){
        List<String> colors = new List <string>();
        colors.add('Red');
        colors.add('Blue');
        colors.add('Pink');
        colors.add('Black');
        system.debug('The Colors Are'+ colors);
        
        //add(index,listElement);
        colors.add(1,'Black');
        System.debug('colors List '+colors);
        
         //addAll(fromList);
         List<String> colorsTwo = new List<String>();
         colorsTwo.add('White');
         colorsTwo.add('Purple');
         System.debug('colorsTwo '+colorsTwo);
         colors.addAll(colorsTwo);
         System.debug('colors '+colors);
        
        //clear
        colorsTwo.clear();
        system.debug('the colors' + colorsTwo);
        

	} //CustomObject
    public static void customObjectListDemo(){
        List <Student__c> stuList = new List <Student__c>();
        Student__c stu1 = new Student__c(Name__c = 'Testprav');
        stuList.add(stu1);
        
        Student__c stu2 = new Student__c();
        stu2.Name__c = 'praveen';
        stuList.add(stu2);
        
        insert stuList;
    }
    //Sobject
        public static void sObjectListDemo(){
        List <Account> accList = new List <Account>();
        Account acc1 = new Account(Name = 'Test111' , active__c = 'Yes');
        accList.add(acc1);
        
        Account acc2 = new Account();
        acc2.Name = 'Test123';
        acc2.Active__c = 'Yes';
        accList.add(acc2);
        
        insert accList;
    }

}