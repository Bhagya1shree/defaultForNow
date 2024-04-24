trigger ContactTrigger47 on Contact (before insert, before update) {
    set<Id> accIdSet = new set<Id>();
    for(Contact objCon : trigger.new){
        if(objCon.AccountId != null){
            if(trigger.isInsert && trigger.isBefore){
             accIdSet.add(objCon.AccountId);
        }
        if(trigger.isUpdate && trigger.isBefore){
            if(objCon.AccountId !=trigger.oldMap.get(objCon.Id).AccountId){
                accIdSet.add(objCon.AccountId);
            }
        }
         }
   }
    Map<Id,Account> accMap = New Map<Id,Account>();
    if(!accIdSet.isEmpty()){
        for(Account objAcc: [Select Id,Rating from Account where Id IN: accIdSet]){
            accMap.put(objAcc.Id, objAcc);
        }
    }
        
    if(!accMap.isEmpty()){
 for(Contact objCon : trigger.new){
        if(accMap.containsKey(objCon.AccountId)){
            if(accMap.get(objCon.AccountId).Rating == 'Hot' ){
                objCon.Level__c = 'Primary';
            }
            else{
                 objCon.Level__c = '';
            }
        }
            }
        }
            
    }