
        

        

        public with sharing class CreatedDateController {
            @AuraEnabled(cacheable=true)
            public static List<AccountWrapper> fetchAccountsWithCreatedDate() {
                List<Account> accounts = [SELECT Id, Name, CreatedDate FROM Account LIMIT 10];
                List<AccountWrapper> wrappers = new List<AccountWrapper>();
                
                for(Account acc : accounts) {
                    wrappers.add(new AccountWrapper(acc, acc.CreatedDate));
                }
                
                // Debugging the list of wrappers
                System.debug('Wrappers: ' + wrappers);
                
                return wrappers;
            }
            
            public class AccountWrapper {
                @AuraEnabled
                public Account accountRecord;
                @AuraEnabled
                public DateTime createdDate;
                
                public AccountWrapper(Account acc, DateTime createdDt) {
                   this.accountRecord = acc;
                    This.createdDate = createdDt;
                }
            }
        }
        