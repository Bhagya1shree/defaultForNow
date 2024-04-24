/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 09-13-2023
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
public with sharing class AccountProvider {


    
    @AuraEnabled
    public static void createNewAccount(String accountName){ //Cinemax
        if(String.isNotBlank(accountName)){
                Account objAcc = new Account(Name=accountName);
                insert objAcc;
        }
    }


            
        
        
        @AuraEnabled(cacheable=true)
        public static String getAccountName(String accountId) {
            try {
                Account acc = [SELECT Name FROM Account WHERE Id = :accountId LIMIT 1];
                return acc.Name;
            } catch (QueryException e) {
                return null;
            }
        }
    }