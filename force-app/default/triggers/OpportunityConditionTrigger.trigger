Trigger OpportunityConditionTrigger on Opportunity (after insert,  before update){
                set <Id> accIdSet = new set <Id>();
                for(Opportunity objOpp : trigger.new){
                    if(trigger.isAfter && trigger.isInsert){
                        if (objOpp.StageName == 'Prospecting'){
                            accIdSet.add(objOpp.AccountId);
                        }
                    }
                    if(trigger.isBefore && trigger.isUpdate){
                        if(objOpp.StageName == 'Closed Lost'  && trigger.oldMap.get(objOpp.Id).StageName == 'Qualification'){
                            objOpp.Amount = 0 ;
                        }
                    }
                }
                
                map <Id, Account> accMap = new map <Id, Account> ();
                for (Account objAcc : [Select Id, Description from Account where Id IN: accIdSet]){
                    accMap.put(objAcc.Id, objAcc);
                }
                
                if(!accMap.isEmpty()){
                    for(Opportunity objOpp : trigger.new){
                        
                        if(accMap.containsKey(objOpp.AccountId)){			
                            
                            accMap.get(objOpp.AccountId).Description = objOpp.Name+'\n'+objOpp.Amount;
                        }
                    }
                    
                    Database.update(accMap.values(), false);
                }
                
            }