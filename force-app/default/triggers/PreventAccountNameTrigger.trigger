trigger PreventAccountNameTrigger on Account (before insert, before update) {
    
    Set<String> accNameSet = new Set<String>();
    for(Account objAcc : trigger.new){//10       
            accNameSet.add(objAcc.Name);//10
    }
    
    List<Account> accList = [select Id, Name from Account Where Name IN : accNameSet];//02 Duplicate
    
    Map<String,Account> accMap = new Map<String,Account>();
    for(Account objAcc :accList){
        accMap.put(objAcc.Name,objAcc);
    }
    
    for(Account objAcc : trigger.new)
        if(accMap.containsKey(objAcc.Name)){
            objAcc.addError('Duplicate Account Name Found...!!');
        }
}