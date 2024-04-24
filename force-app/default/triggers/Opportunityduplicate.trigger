trigger Opportunityduplicate on Opportunity (before insert, before update, after undelete){ 
    Set<Id> accIdSet = new Set<Id>();
    for(Opportunity objOpp : trigger.new){
        if(objOpp.AccountId != null){
            if(  (trigger.isBefore && trigger.isInsert) || (trigger.isAfter && trigger.isUndelete) ){
                accIdSet.add(objOpp.AccountId); 
            }   
            if(trigger.isBefore && trigger.isUpdate){
                if(objOpp.StageName != trigger.oldMap.get(objOpp.Id).StageName){
                    accIdSet.add(objOpp.AccountId);
                }
            }
        }
    }  
        
        Map<Id,Account> accountMap = new Map<Id,Account>();
        if(!accIdSet.isEmpty()){
            for(Account objAcc : [select Id,Name,(select Id, StageName from Opportunities) from Account where Id IN : accIdSet]){
                accountMap.put(objAcc.Id, objAcc);
            }    
        }
        
        if(!accountMap.isEmpty()){
            for(Opportunity objOpp : trigger.new){
                if(accountMap.containsKey(objOpp.AccountId)){
                   List<Opportunity> oppList =  accountMap.get(objOpp.AccountId).Opportunities;
                   
                    for(Opportunity objOppExisting : oppList){
                        if(objOpp.StageName == objOppExisting.StageName){
                            if(objOppExisting.StageName == 'Closed Lost'){
                            objOpp.addError('This Type of Opportunity of Same StageName  already exists for this Account');
                            }
                        }
                    }
                }
            }
        }
        
        
    }