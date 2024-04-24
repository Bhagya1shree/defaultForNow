

public with sharing class WrapperConRelateAcc {
    
    // 3] Create Method
    @AuraEnabled(cacheable=true)
    public static List<AccountContactWrapperClass> fetchAccountandRelatedContactDetails() {
        List<AccountContactWrapperClass> accountContactWrappers = new List<AccountContactWrapperClass>();
        for(Account acc : [SELECT Id, Name, Type, BillingCity, BillingCountry, BillingStreet, (SELECT Id FROM Contacts) FROM Account WHERE Name != null LIMIT 20]) {
            accountContactWrappers.add(new AccountContactWrapperClass(acc, acc.Contacts.size()));
        }
        return accountContactWrappers;
    }
    
    // 1] Wrapper class
    public class AccountContactWrapperClass {
        
        @AuraEnabled
        public Account acc;
        @AuraEnabled
        public String AccountName;
        @AuraEnabled
        public String AccountLink;
        @AuraEnabled
        public String billingAddress;
        @AuraEnabled
        public String type;
        @AuraEnabled
        public Integer totalContacts;
        
        // 2] Parameterized constructor
        public AccountContactWrapperClass(Account acc, Integer totalContacts) {
            this.acc = acc;
            this.totalContacts = totalContacts;
            this.AccountLink = '/' + acc.Id;
            this.type = acc.Type; // Assign the Type here
            this.AccountName = acc.Name;
            this.billingAddress = acc.BillingStreet + ',' + acc.BillingCity + ',' + acc.BillingCountry;
        }
    }
}


