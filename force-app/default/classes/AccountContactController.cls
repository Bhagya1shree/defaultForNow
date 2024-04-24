public with sharing class AccountContactController {

    @AuraEnabled(cacheable=true)
    public static List<Account> getAccountDetails() {
        return [SELECT Id, Name, (SELECT Id, FirstName, LastName FROM Contacts) FROM Account];
    }
}
