trigger Contacttrigger46 on Contact (before insert, before update) {
    set<Id> accIdSet = new set<Id>();
    for(Contact objCon : Trigger.new){
        accIdSet.add(objCon.AccountId);
    }
        Map<Id,Account> accMap =  New Map<Id,Account>();
    for(Account objAcc : [Select Id,Description from Account where Id IN : accIdSet  ]){
                accMap.put(objAcc.Id, objAcc);
    }
     for (Contact objCon : Trigger.new){
         If (accMap.containsKey(objCon.AccountId)){
              accMap.get(objCon.AccountId).Description= objCon.FirstName+' '+objCon.LastName;
                        }
     }
         If (!accMap.isEmpty()){
             Database.insert(accMap.values(), False);
         }
}