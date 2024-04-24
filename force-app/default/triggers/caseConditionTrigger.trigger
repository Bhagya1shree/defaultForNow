trigger caseConditionTrigger on Case  (before update){///4] If any case of an Account is updated to "New", then "Escalate" all the existing cases of that account..........             

                set <Id> accIdSet = new set <Id>();
                for(Case objCase : trigger.new ){
                    if(objCase.Status == 'New'){
                            accIdSet.add(objCase.AccountId);
                        System.debug('# Acc Id '+objCase.AccountId);
                    }
                }
                                
                map <Id, Account> accMap= new map <Id, Account> ();
                for(Account objAcc : [Select Id, (Select id, Status from Cases where Status != 'Escalated') from Account where Id IN : accIdSet]){
                accMap.put(objAcc.Id, objAcc);
                   System.debug('# Acc  '+objAcc); 
                }
    
             System.debug('# MAP '+accMap); 
    
    List<Case> caseListUpdate = new List<Case>();
    
                for(Case objCase : trigger.new ){
                if(accMap.containskey(objCase.AccountId)){
                    System.debug('# Inside of containsKey '); 
                    for(Case objCaseExisting :  accMap.get(objCase.AccountId).Cases){
                        objCaseExisting.Status = 'Escalated';
                        System.debug('# Escalated'+objCaseExisting.Status); 
                        caseListUpdate.add(objCaseExisting);
                    }
                }
                }
    
    Database.update(caseListUpdate, false);
                
                
}