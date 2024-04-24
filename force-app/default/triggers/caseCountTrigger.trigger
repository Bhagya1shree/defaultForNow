trigger caseCountTrigger on Case (after insert, after update, after delete, after undelete){
                    set <Id > accIdSet = new set <Id > ();
                    for (Case objCase : trigger.new){
                        if(trigger.isInsert || trigger.isUpdate || trigger.isDelete){
                            accIdSet.add(objCase.AccountId);
                        }
                    }
                    if(trigger.isDelete){
                        for (Case objCase : trigger.old){
                            
                            if(objCase.AccountId != trigger.oldMap.get(objCase.Id).AccountId){
                                accIdSet.add(objCase.AccountId);
                            }
                        }
                    }
                    
                    
                    map <Id, Account> accMap = new map <Id, Account> ();
                    for (Account objAcc : [Select Id, countCase__c , (SELECT Id, CaseNumber, AccountId  FROM Cases) from Account where Id IN: accIdSet]){
                        objAcc.countCase__c = objAcc.Cases.size();
                        accMap.put(objAcc.Id, objAcc);
                    }
                    
                    
                    
                    
                    database.Update(accMap.values(), false);
                    
                    
                }