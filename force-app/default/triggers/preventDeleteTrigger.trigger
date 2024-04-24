trigger preventDeleteTrigger on Account (before delete){
            Map<Id,Account> accMap = new Map<Id,Account>();
            for(Account objAcc : trigger.old){
            accMap.put(objAcc.Id, objAcc);
        
            }
            
            list <Contact> conList = new list <Contact> ();
            for(Contact objCon : [Select Id, LastName , AccountId from Contact where AccountId IN: accmap.keySet()]){
            conList.add(objCon);
            }
            
            for(Contact objCon :conList){
            if(accMap.containskey(objCon.AccountId)){
        List <Contact> ConListCheck = accMap.get(objCon.AccountId).Contacts;
        }
         
            }
            if(!conList.isEmpty()){
            for (Account objAcc : trigger.old){
         objAcc.addError('This type of Account cannot be deleted');
         }
         }
            




}