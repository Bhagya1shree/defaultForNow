public class AccountRequestAPI {

    public static void getAccFromColgate(){
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('callout:ColgateNamedCred/services/apexrest/getAccountdetails');
        request.setMethod('GET');
        
        HttpResponse response = http.send(request);
        
        System.debug('#Status Code = '+response.getStatusCode()+ ' #Body '+response.getBody());
    }
}
///// To run => AccountRequestAPI.getAccFromColgate();