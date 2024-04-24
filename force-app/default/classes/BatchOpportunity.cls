global class BatchOpportunity implements Database.Batchable<sObject> {
    
    global Database.QueryLocator start(Database.BatchableContext BC){
        String query =  'select Id, Amount, Close Date Month from Opportunity';
        return Database.getQueryLocator(query);
    }
    
    global void execute(Database.BatchableContext BC, List <Opportunity> oppList){
    if(!oppList.isEmpty()){
        for(Opportunity objOpp : oppList){
                    if(objOpp.Amount <=5000 && objOpp.CloseDate.month() == 8 ){
                objOpp.StageName = 'Closed Lost';
            }
            else{
                if((objOpp.Amount>= 5000 && objOpp.Amount<= 30000) && (objOpp.CloseDate.month() == 1 && objOpp.CloseDate.month() == 4 && objOpp.CloseDate.month() == 12)){
                  objOpp.StageName = 'Closed Won';   
                }
                
               objOpp.StageName ='';
            }   
        }
        Database.Update(oppList, False);
    }
    }
    
    global void finish(Database.BatchableContext BC){
        
    }
}