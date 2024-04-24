public with sharing class MobileAPIClass {
    
    @AuraEnabled
    public static void getMobileVerify(Id applicantRecordId){
        system.debug(applicantRecordId);
 
        string mobileNumber =[select Id,Name,Mobile_Number__c from Applicant__c where ID=:applicantRecordId].Mobile_Number__c;

        Http http=new Http();
        HttpRequest request =new HttpRequest();
        request.setEndpoint('https://api.veriphone.io/v2/verify?phone='+mobileNumber+'&key=9493770FAD834D73ACC5D34A3CD51EA9');
        request.setMethod('GET');

        HttpResponse response =  http.send(request);

        system.debug('Response Code ='+response.getStatusCode());
        system.debug('Response Body ='+response.getBody());

        if(response.getStatusCode()==200){
            ApplicantWrapper objWrap=ApplicantWrapper.parse(response.getBody());

            Applicant__c objApp=new Applicant__c(Id=applicantRecordId);
            objApp.MobileOperator__c=objWrap.carrier;

            if(objWrap.phone_valid){
                objApp.MobileActive__c=true;
            }
            else{
                objApp.MobileActive__c=false;
            }
            try {
                database.update(objApp,false);
            } catch (Exception e) {
                system.debug(e);
            }

            
        }
    }
    
}