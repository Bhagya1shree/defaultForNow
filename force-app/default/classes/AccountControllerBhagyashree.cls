public with sharing class AccountControllerBhagyashree {

    @AuraEnabled(cacheable = true)
    public static List<Account> getAccountsByType (String accountType){
        try {
            List<Account> accList = [Select Id, Name, Type, Rating from Account where Type = : accountType];
            System.debug('#####Number of accounts retrieved: ' + accList.size());
            return accList;
         
        } catch (Exception e) {
           return null;
        }
    }
}