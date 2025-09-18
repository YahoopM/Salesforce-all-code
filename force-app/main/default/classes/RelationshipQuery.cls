public class RelationshipQuery {
    public static void parentToChild(){
        List <Account> accList = new List <Account>();
        accList = [SELECT Id ,Name ,(SELECT Id ,FirstName ,LastName FROM contacts) FROM Account Where rating = 'Hot'];
        for(Account acc : accList){
            system.debug('Acccount Name' + acc.Name);
            for(Contact con : acc.contacts){
                system.debug(con.FirstName + ' ' + con.LastName);
            }
        }
    }
    

    
}