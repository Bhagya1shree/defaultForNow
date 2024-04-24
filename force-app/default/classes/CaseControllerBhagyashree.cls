public with sharing class CaseControllerBhagyashree {
     
            @AuraEnabled
            public static List<Case> getCasesByAccountId (String accountIdForCase){
                try {
                    return  [Select Id, CaseNumber, Subject, Status from Case where AccountId = : accountIdForCase];
                } catch (Exception e) {
                    return null;
                }
            }
        }

    
