trigger Accounttrigger1 on Account (before insert) {

    for(Account A : trigger.new){
        if(A.SLA__c =='Gold'){
            A.Description ='Oo Lala';
        }
        else
        {
            if (A.SLA__c=='Silver'){
                A.Description='Yahoo';
            }
            else
            {
                A.Description='';
            }
            
            
            
            
            
        }
        
        
        
        
        
        
        
        
        
        
        
        
        
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}