trigger updateDescTrigger on Account (after update) {
                
                Map<Id,Account> accMap = new Map<Id,Account>();
            for(Account objAcc : trigger.new ){
            if(objAcc.Sic != trigger.oldMap.get(objAcc.Id).Sic){
            
            accMap.put(objAcc.Id, objAcc);
        }
            }
                List <Opportunity> oppList = new List <Opportunity> ();
                for(Opportunity objOpp : [Select Id, Description, AccountId from Opportunity where AccountId IN: accMap.keyset()]){
                oppList.add(objOpp);
                }
                
                for(Opportunity objOpp : oppList){
                    if(accMap.containsKey(objOpp.AccountId)){
                        if(string.isBlank(objOpp.Description)){
                                objOpp.Description = 'The Sic of Account has been changed';
                        }
                        else  {
                            objOpp.Description = objOpp.Description = 'The Sic of Account has been changed' +'\n' + 'The Sic of Account has been changed';
                        } 
                        
                
                    }
            
                }
                
                 Database.update(oppList,false);
                
                 }