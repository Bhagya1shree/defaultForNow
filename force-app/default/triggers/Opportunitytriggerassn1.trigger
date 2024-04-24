trigger Opportunitytriggerassn1 on Opportunity(after insert) {
    
    if(trigger.isAfter && trigger.isInsert){
          set<Id> accIDSet = New  set<Id>();
    for(Opportunity objOpp : trigger.new){
        accIDSet.add(objOpp.AccountId);
    }
      
    map<Id,Account> accMap = New map<Id,Account>();
    for(Account objAcc : [select Id,SLA__c from Account where ID IN : accIDSet]){
           accMap.put(objAcc.Id,objAcc);
    }
    for(Opportunity objOpp : trigger.new) {
        if( accMap.containskey(objOpp.AccountId)){
            if(objOPP.Amount<=10000 && objOpp.StageName=='Closed Lost'){
             accMap.get(objOpp.AccountId).SLA__C='Silver';   
            }
        }
        Database.update(accMap.values(),false);    
    }        
    }
    }