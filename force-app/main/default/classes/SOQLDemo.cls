public class SOQLDemo {
    public static void queryDemo(){
        List<Account> accList =[SELECT Id ,Name, Industry,Type,Rating FROM Account WHERE Industry = 'Media' OR Rating = 'Hot'];
        for(Account acc : accList){
            system.debug(acc);
        }
    }

}