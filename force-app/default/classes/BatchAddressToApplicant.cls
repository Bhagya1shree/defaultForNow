global class BatchAddressToApplicant implements Database.Batchable<sObject>{

    global Database.QueryLocator start(Database.BatchableContext BC){
        return Database.getQueryLocator(' Select Id, Name, City__c, Pin_Code__c,Applicant__r.Id, Applicant__r.Police_Verification__c from Address__c where City__c = \'Nagpur\' and Pin_code__c like \'44%\' and Applicant__r.Police_Verification__c =true ');
    }
    
    global void execute(Database.BatchableContext BC, List<Address__c> adrList){
        
        Set<Id> appIDSet = new Set<Id>();
        if(!adrList.isEmpty()){
            for(Address__c objAdr : adrList){
                if(objAdr.Applicant__c !=null){
                    appIDSet.add(objAdr.Applicant__c);
                }
            }
        }
        
        Map<Id,Applicant__c> appMap = new Map<Id,Applicant__c>([select Id, List_of_Addresses__c from Applicant__c where Id IN :appIDSet]);
    
        if(!appMap.isEmpty()){
            for(Address__c objAdr : adrList){
                if(appMap.containsKey(objAdr.Applicant__c)){
                    if(String.isBlank(appMap.get(objAdr.Applicant__c).List_of_Addresses__c)){
                       appMap.get(objAdr.Applicant__c).List_of_Addresses__c =objAdr.City__c+' '+objAdr.Pin_Code__c; 
                    }
                    else{
                        appMap.get(objAdr.Applicant__c).List_of_Addresses__c = appMap.get(objAdr.Applicant__c).List_of_Addresses__c+'\n'+objAdr.City__c+' '+objAdr.Pin_Code__c;
                    }
                }
            }
            
            Database.update(appMap.values(),false);
        } 
    }
    
    global void finish(Database.BatchableContext BC){
        
    }
}