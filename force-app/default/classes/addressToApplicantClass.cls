global class addressToApplicantClass implements Database.Batchable <sObject>, Database.Stateful{
            Set<Id> successRecordsSet = new Set<Id>();
    		Set<Id> failedRecordsSet = new Set<Id>();
     
			global Database.QueryLocator start (Database.BatchableContext BC){
			return Database.getQueryLocator('Select Id, City__c, State__c, Country__c , Applicant__r.Id, Applicant__r.Name, Applicant__r.Police_Verification__c from Address__c where City__c = \'Nagpur\' and Applicant__r.Police_Verification__c != true ')  ;
			}
   
   
			global void execute(Database.BatchableContext BC, List <Address__c> adrList){
     

			Set <Id> appIdSet = new Set <Id> ();
			if(!adrList.isEmpty()){
			for(Address__c objAdr : adrList){
			if(objAdr.Applicant__c != Null){
			appIdSet.add(objAdr.Applicant__c);
			}
			
			}
            }
			map <Id, Applicant__c> appMap = new map <Id, Applicant__c>();
                for ( Applicant__c objApp : [Select Id, First_Name__c, Last_Name__c, Police_Verification__c from Applicant__c where Id IN : appIdSet]){
                    appMap.put(objApp.Id, objApp );
                }
					
			if(!appMap.isEmpty()){
			for(Address__c objAdr : adrList){
			if(appMap.containsKey(objAdr.Applicant__c)){
			appMap.get(objAdr.Applicant__c).Police_Verification__c = true;
                         
			}
			}
			
			Database.SaveResult [] result = Database.Update(appMap.values(),false);
                
            List<Applicant__c> appList = appMap.values();    
			
            Integer index=0;
            
            for(Database.SaveResult sr : result){
                if(sr.isSuccess()){
                    System.debug('Success = '+appList[index].Id);
                    successRecordsSet.add(appList[index].Id);
                    index++;
                }
                else{
                    System.debug('Failed = '+appList[index].Id);
                    failedRecordsSet.add(appList[index].Id);
                    index++;
                }
            }
                        
        }

			}
			    
			    global void finish(Database.BatchableContext BC){
        List<Messaging.SingleEmailMessage> mailList = new List<Messaging.SingleEmailMessage>();
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        mail.setToAddresses(new String[] {'bhagya88058@gmail.com'});
        mail.setSenderDisplayName('Bhagyashree');
        mail.setSubject('Success and Failed Record');
        mail.setPlainTextBody('Success = '+successRecordsSet+' Failed '+failedRecordsSet); 
        mailList.add(mail);            
        if(!mailList.isEmpty()){
            Messaging.sendEmail(mailList,false);  
        }
        
    }
 }