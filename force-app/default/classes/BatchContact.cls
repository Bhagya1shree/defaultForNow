global class BatchContact implements Database.Batchable<sObject> {
    
    global Database.QueryLocator start(Database.BatchableContext BC){
        String query =  'select Id, LeadSource, Level__c from Contact';
        return Database.getQueryLocator(query);
    }
    
    global void execute(Database.BatchableContext BC, List <Contact> conList){
    if(!conList.isEmpty()){
        for(Contact objCon : conList){
            if(objCon.LeadSource == 'web'){
                objCon.Level__c ='Primary';
            }
                else{
                    if(objCon.LeadSource == 'Phone Enquiry' || objCon.LeadSource =='Partner Referral' ){
                        objCon.Level__c ='Tertiary';
                    }
                else{
                    objCon.Level__c ='';
                }   
            }
        }
        Database.Update(ConList, False);
    }
    }
    
    global void finish(Database.BatchableContext BC){
        
    }
}