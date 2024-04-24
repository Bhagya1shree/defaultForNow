trigger ContacTtrigger2710 on Contact (before insert) {
set<Id> accIdSet = new set<Id> ();
for(Contact objCon : trigger.New) {
accIdSet.add(objCon.AccountId);
}
Map <Id,Account> accMap = new Map <Id,Account>();
for(Account objAcc : [Select Id, Description from Account where Id IN : accIdSet]){
accMap.put(objAcc.Id, objAcc);
}
for(Contact objCon : trigger.New) {
if(accMap.containsKey(objCon.AccountId)){
    

        if(string.isblank(accMap.get(objCon.AccountId).Description)){
accMap.get(objCon.AccountId).Description = objCon.FirstName+''+objCon.LastName;
}
else{
}
accMap.get(objCon.AccountId).Description = accMap.get(objCon.AccountId).Description+'\n'+objCon.FirstName+''+objCon.LastName;
    if(!accMap.isEmpty()){
        Database.insert(accMap.Values(),False);
    }
    }
    

}

}