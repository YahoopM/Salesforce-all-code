public class AccountTriggerHandler {
    
    public static void preventDeletion(List<Account> accList){
        for(Account acc : accList){
            if(acc.Active__c == 'Yes'){
                //acc.addError('Active Yes cannot be Deleted');
                acc.addError(label.Prevent_Account_Deletion);
            }
        }
        
    }
    
    public static void addressupdate(List<Account> accList){
        if(accList == null || acclist.isEmpty()){
            return;
        }
        for(Account acc : accList){
            if(acc.BillingCity != null){
                acc.ShippingCity = acc.BillingCity; 
            }
            if(acc.BillingStreet != null){
                acc.ShippingStreet = acc.BillingStreet;
            }
            if(acc.BillingState != null){
                acc.ShippingState = acc.BillingState;
            }
            if(acc.BillingCountry !=null){
                acc.ShippingCountry = acc.BillingCountry;
            }
            if(acc.BillingPostalCode != null){
                acc.ShippingPostalCode = acc.BillingPostalCode;
            }
        }
    }
    
    public static void updateRelatedContacts(List<Account> accList, Map<Id,Account> accOldMap){
        
        List<Contact> conList = new List<Contact>();
        Map<Id,Account> accMap = new Map<Id,Account>();
        
        for(Account acc : accList){
            //map will store only those accounts whose phone is updated
            if(acc.Phone != accOldMap.get(acc.Id).Phone){
                accMap.put(acc.Id,acc);
            }
        }
        
        for(Contact con :[SELECT Id,Homephone,AccountId FROM Contact WHERE AccountId IN :accMap.KeySet()]){
            if(accMap.containsKey(con.AccountId)){
                con.HomePhone = accMap.get(con.AccountId).Phone;
                conList.add(con);
            }
        }
        
    }
    
    
    
    public static void populatingRating(list <Account> accList,map<Id,Account> accOldMap){
        for(Account acc : accList){
            if((accOldMap == null && acc.Industry != NULL && acc.Industry == 'Media') || (accOldmap != Null && acc.Industry != accOldMap.get(acc.Id).Industry && acc.Industry == 'Media')){
                acc.Rating = 'Hot';
            }
        }
        
    }
    
    
    public static void updatePhone(list<Account> accList , Map<Id,Account> accOldMap){
        for(Account acc : accList){
            if(acc.Phone != accOldMap.get(acc.Id).Phone){
                acc.Description = 'Phone is Updated | old value =' +accOldMap.get(acc.Id).Phone + 'new Value = '+ acc.Phone;
            }
            
        }
    } 
    
    public static void relatedPhone(list<Account> accList , Map<Id,Account> accOldMap){
        Map<Id,String> updatedPhones = new Map<Id,String>();
        for(Account acc : accList){
            Account oldAcc = accOldMap.get(acc.Id);
            if(acc.Phone != oldAcc.Phone){
                updatedPhones.put(acc.Id,acc.Phone);
            }
        }
        
        List<Contact> conList = [SELECT Id,AccountId,Phone FROM Contact WHERE AccountId IN : accOldMap.keySet()];
        List<Contact> listToUpdateContacts = new List<Contact>();
        
        if(!conList.isEmpty()){
            for(Contact con : conList){
                con.Phone = updatedPhones.get(con.AccountId);
                listToUpdateContacts.add(con);
            }
            
        }
        if(!listToUpdateContacts.isEmpty()){
            update listToUpdateContacts;
        }
        
    }
    
    public static void createOpp(list <Account> accList){
        List <Opportunity> oppList = New List <Opportunity>();
        for(Account acc : accList){
            Opportunity opp = new Opportunity();
            opp.Name = acc.Name;
            opp.CloseDate = system.today();
            opp.StageName = 'Prospecting';
            opp.Accountid = acc.Id;
            oppList.add(opp);
            
        }
        
        if(!oppList.isEmpty()){
            insert OppList;
        }
    }
    
    
    
    
    
    public static void updateDesc(list <Account> accList){
        for(Account acc : accList){
            acc.Description = 'Account is Created';
        }
        
    }
    
    
}