public with sharing class contactProvider {

    @AuraEnabled(cacheable=true)
    public static List<Contact> searchContact(String accountId) {
        try {
            // Find the Account by ID
            Account acc = [SELECT Id FROM Account WHERE Id = :accountId LIMIT 1];

            if (acc != null) {
                // If the Account exists, query the related Contacts
                return [SELECT Id, Name, Phone, Email
                        FROM Contact WHERE AccountId = :acc.Id];
            } else {
                // If the Account is not found, return an empty list or handle it as needed
                return new List<Contact>();
            }
        } catch (Exception e) {
            // Handle any exceptions and throw an AuraHandledException
            throw new AuraHandledException(e.getMessage());
        }
    }
}