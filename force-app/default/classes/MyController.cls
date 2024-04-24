public with sharing class MyController {
    @AuraEnabled(cacheable=true)
    public static List<Applicant__c> getRecords() {
        List<Applicant__c> appList =   [select Id,Name, First_Name__c, CreatedDate from Applicant__c where CreatedDate >= 2022-04-01T00:00:00Z and CreatedDate <= TODAY];
      return appList;
    }
    
    }