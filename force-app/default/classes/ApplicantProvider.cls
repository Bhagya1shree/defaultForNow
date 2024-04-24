/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 09-13-2023
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
public without Sharing class ApplicantProvider {


  

    public static List<Applicant__c> getApplicantRecords(){
      List<Applicant__c> appList =   [select Id,Name, First_Name__c, CreatedDate from Applicant__c where CreatedDate >= 2022-04-01T00:00:00Z and CreatedDate <= TODAY];
      return appList;
    }
  

    @AuraEnabled
    public static Applicant__c searchApplicantRecord(Applicant__c objApp){
      try {
          Applicant__c objAppRetrieved =  [select Id, First_Name__c, Last_Name__c, Gender__c from Applicant__c where Name =: objApp.Name];
          return objAppRetrieved;
      } catch (Exception e) {
        throw new AuraHandledException(e.getMessage());
      }
    }

    @AuraEnabled(cacheable=true)
    public static List<Applicant__c> searchApplicantDateRecords(Date fromDateParam , Date toDateParam){
      try {
        System.debug('From Date = '+fromDateParam);
        System.debug('To Date = '+toDateParam);

        return [select Id, Name, First_Name__c, Last_Name__c,Mobile_Number__c,Email_Id__c, CreatedDate,CreatedBy.FirstName, CreatedBy.LastName, CreatedBy.Name from Applicant__c where CreatedDate >=: fromDateParam and CreatedDate <=: toDateParam];
      
      
      
      } catch (Exception e) {
        throw new AuraHandledException(e.getMessage());
      }
    }

    @AuraEnabled
    public static List<Applicant__c> searchApplicantFirstNameWise(Applicant__c objApp){
      try {
        if(String.isNotBlank(objApp.First_Name__c)){
        return [select Id, Name, First_Name__c, Last_Name__c,CreatedDate from Applicant__c where First_Name__c like : objApp.First_Name__c+'%'];
        }
        else{
          return null;
        }
      } catch (Exception e) {
        throw new AuraHandledException(e.getMessage());
      }
    }

      @AuraEnabled
      public static List<Applicant__c> deleteSelectedApplicantRecords(List<Id> appIDList, Applicant__c objApp){
        try {
         Database.delete([select id from Applicant__c where Id IN : appIDList] ,false);
         return [select Id, Name, First_Name__c, Last_Name__c,CreatedDate from Applicant__c where First_Name__c like : objApp.First_Name__c+'%'];
        } catch (Exception e) {
          throw new AuraHandledException(e.getMessage());
        }
      }
      @AuraEnabled
      public static void methodNameCreateApplicant(String objAppNew, String objAppNewGender){ //Cinemax
          if(String.isNotBlank(objAppNew)){
                  Applicant__c objAcc = new Applicant__c (First_Name__c=objAppNew, Gender__c = objAppNewGender );
                  insert objAcc;
          }
      }
  
      
}