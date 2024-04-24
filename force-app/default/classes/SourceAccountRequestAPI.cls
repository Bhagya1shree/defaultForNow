public  class SourceAccountRequestAPI {
   public static void getAccountFromColgate(){
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('callout:ColgateNamedCred/services/apexrest/getAccountDetails?type=Prospect&sla=Gold');
        request.setMethod('GET');

        HttpResponse response = http.send(request);

        System.debug('Status Code = '+response.getStatusCode()); //OK 200

        if(response.getStatusCode() == 200){
                System.debug('Received Body in Source '+response.getBody()); //JSON Format
        
                List<object> objList = (List<Object>) JSON.deserializeUntyped(response.getBody());
                List<Account> accListInsert = new List<Account>();
                
                for(object obj : objList){
                    Map<String,Object> accMap = (Map<String,Object>) obj;
                    
                    System.debug('Id = '+accMap.get('Id'));
                    System.debug('Name = '+accMap.get('Name'));
                    System.debug('Type = '+accMap.get('Type'));
                    System.debug('SLA = '+accMap.get('SLA__c'));
                    System.debug('Rating = '+accMap.get('Rating'));
                    System.debug('Created Date = '+accMap.get('CreatedDate'));

                }
            }
    }

}