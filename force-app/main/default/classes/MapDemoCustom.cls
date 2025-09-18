public class MapDemoCustom {
    public static void mapCustom(){
         //Without Loop, Fetching Key as Id and Values as Account
        List<student__c> stuList = new List<student__c>();
        stuList = [SELECT Id,Name FROM student__c LIMIT 5];
        Map<Id,student__c> stuMap = new Map<Id,student__c>(stuList);
        System.debug('stuMap '+stuMap);
      //  System.debug('accMap '+accMap.keySet());
        //System.debug('accMap '+accMap.Values());
    }

}