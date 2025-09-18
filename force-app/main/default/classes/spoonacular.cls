public class spoonacular {
    private static final string SPOONACULAR_API ='https://api.spoonacular.com';
   // private static final string API_KEY = 'dac13889343142db93c27311d10b29a5';
    public static void getRandomrecipe(){
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint(SPOONACULAR_API+'/recipes/random?apiKey=dac13889343142db93c27311d10b29a5');
        request.setMethod('GET');
        HttpResponse response = http.send(request);
        
        system.debug(response.getStatusCode());
        // If the request is successful, parse the JSON response.
        if(response.getStatusCode() == 200) {
            system.debug('response' +response.getbody());
        }
        
    }
    
}