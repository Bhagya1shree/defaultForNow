public with sharing class ApplicationSearchController {
    @AuraEnabled(cacheable=true)
    public static List<Applicant__c> getApplicationsByDateRange (Date fromDate, Date toDate) {
        // Query for applications within the specified date range
       
       
       
        List<Applicant__c> applications = [SELECT Id, First_Name__c, Last_Name__c, DOB__c, CreatedDate
                                            FROM Applicant__c
                                            WHERE CreatedDate >= :fromDate
                                            AND CreatedDate <= :toDate];
        
        return applications;
    }
}