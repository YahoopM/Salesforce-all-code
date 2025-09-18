public class MapDemo {
    public class MapCollcectionExample {
    
    //Map Methods
    //put(key,value);
    //putAll(fromMap);
    //putAll(Sobject);
    //remove(key);
    //size()
    //values()
    //clear()
    //clone()
    //containskey(key)
    //equals(map)
    //get(key)
    //isEmpty()
    //keySet()
    
    //Map<Integer,String> colorsMap = new Map<Integer,String>();
    //Map<String,String> colorsMap = new Map<String,String>();
    //Map<Id,Account> colorsMap = new Map<Id,Account>();
    //List<Account> accList = [SELECT Id,Name FROM Account];
    //Map<Id,Account> colorsMap = new Map<Id,Account>(accList);
    //Account account = [SELECT Id,Name FROM Account LIMIT 1];
    //List<Contact> conList = [SELECT Id,Name FROM Contact];
    //Map<Account,List<Contact>> colorsMap = new Map<Account,List<Contact>>(account,conList);
    }

    public static void mapMethod(){
        Map<Integer,String> colorsMap = new Map<Integer,String>();
        //put(key,value);
        colorsMap.put(1,'Red');
        colorsMap.put(2,'Black');
        colorsMap.put(3,'Green');
        colorsMap.put(4,'Blue');
        System.debug('colorsMap '+colorsMap);
        
       /* Map<Integer,String> colorsMap1 = new Map<Integer,String>{
            1 => 'Red',
                2 => 'Black'
        };*/
        
       // colorsMap.put(2,'Yellow');
      //  System.debug('colorsMap '+colorsMap);
        //colorsMap.put(5,'Yellow');
       // System.debug('colorsMap '+colorsMap);
       
       //putAll(fromMap);
        Map<Integer,String> moreColors = new Map<Integer,String>{
            10 => 'White',
                20 => 'Yellow'
              //  1 => 'Pink'
        };
            System.debug('moreColors '+moreColors);
        colorsMap.putAll(moreColors);
        System.debug('colorsMap '+colorsMap);
        
        //remove(key);
        colorsMap.remove(1);
        System.debug('colorsMap '+colorsMap);
        //size()
        System.debug('colorsMap '+colorsMap.size());
        
        //values()
        System.debug('colorsMap '+colorsMap.values());
        
        //clear()
        //colorsMap.clear();
        //System.debug('colorsMap '+colorsMap);
        
        //clone()
        Map<Integer,String> clonedMap = new Map<Integer,String>();
        clonedMap = colorsMap.clone();
        System.debug('clonedMap '+clonedMap);
        
        //containskey(key)
        //System.debug('clonedMap '+clonedMap.containskey(10));
        //System.debug('clonedMap '+clonedMap.containskey(50));
        
        //equals(map)
        // System.debug('clonedMap '+clonedMap.equals(colorsMap));
       // System.debug('clonedMap '+clonedMap.equals(moreColors));
      
     
        //get(key)
        System.debug('clonedMap '+clonedMap.get(10));
        
        //isEmpty()
       System.debug('clonedMap '+clonedMap.isEmpty());  
        
        //keySet()
        System.debug('clonedMap '+clonedMap.keySet());  
        
        Set<Integer> intSet = new Set<Integer>(); 
        List<String> strList = new List<String>(); 
        
        intSet = clonedMap.keySet(); //Stores keys into a set
        strList = clonedMap.Values(); //Stores values into a list
        System.debug('intSet '+intSet); 
        System.debug('strList '+strList); 
    }
    
    public static void sobjcetMAp(){
       /* List<Account> accList = new List<Account>();
        Map<Id,Account> accMap = new Map<Id,Account>();
        accList = [SELECT Id,Name,Phone FROM Account LIMIT 5];
        accMap.putAll(accList);
        System.debug('accMap '+accMap);*/
        
       // Map<Id,Account> accMap1 = new Map<Id,Account>([SELECT Id,Name,Phone FROM Account LIMIT 5]);
       
       //Without Loop, Fetching Key as Id and Values as Account
       /* List<Account> accList = new List<Account>();
        accList = [SELECT Id,Name,Phone FROM Account LIMIT 5];
        Map<Id,Account> accMap = new Map<Id,Account>(accList);
        System.debug('accMap '+accMap);
        System.debug('accMap '+accMap.keySet());
        System.debug('accMap '+accMap.Values());*/
        
        //With Loop
        List<Account> accList = new List<Account>();
        accList = [SELECT Id,Name,Phone FROM Account LIMIT 5];
        Map<Id,Account> accMap = new Map<Id,Account>();
        
        for(Account acc : accList){
            accMap.put(acc.Id, acc);
        }
        
        System.debug('accMap '+accMap);
        System.debug('accMap '+accMap.keySet());
        System.debug('accMap '+accMap.Values());
        
    }
}