public with sharing class AccConOppCaseWrapperClassController {  
    
    //3} Create a method to bind in js
    @AuraEnabled(cacheable=true)
    public static List<AccConOppCaseWrapperClass> fetchAccountConOppCaseDetails() {
        List<AccConOppCaseWrapperClass> wrappers = new List<AccConOppCaseWrapperClass>();
        
        // Query data from Salesforce
        List<Account> accounts = [SELECT Id, Name, Type, Industry, Ownership, (SELECT Id, Email FROM Contacts), 
                                  (SELECT Id, StageName FROM Opportunities),
                                  (SELECT Id, Origin FROM Cases) 
                                  FROM Account WHERE Name != null LIMIT 20];
        for (Account acc : accounts) { 
            AccConOppCaseWrapperClass wrapper = new AccConOppCaseWrapperClass(acc, acc.Type, acc.Ownership, acc.Industry,'', '', '');
       wrappers.add(wrapper);
        }
        return wrappers;
    }
    //1}Create a Wrapper Class
    public class AccConOppCaseWrapperClass {
        @AuraEnabled
        public Account acc;
    
        @AuraEnabled
        public String Type;

        @AuraEnabled
        public String Industry;

        @AuraEnabled
        public String Ownership;
    
        @AuraEnabled
        public String Email;
    
        @AuraEnabled
        public String Stage;
    
        @AuraEnabled
        public String Origin;
    
        // 3} Create a Parameterized constructor
        public AccConOppCaseWrapperClass(Account acc, String Type, String Industry, String Ownership, String Email, String Stage, String Origin) {
            this.acc = acc;
            this.Type = Type;
            this.Industry = Industry;
            this.Ownership = Ownership;
            this.Email = Email;
            this.Stage = Stage;
            this.Origin = Origin;
        }
    }
    
}
