trigger Casetriggerday1q2 on Case (before insert) {
    for(Case objcase : trigger.new){
        if( objcase.Status=='New'&& objcase.Origin=='Phone'){
            objcase.Product__c ='GC1020';
             }
                else
                    if( objcase.Status=='Working'&& objcase.Origin=='Web'){
            objcase.Product__c ='GC1060';
             }
                else
                    if( objcase.Status=='Escalated'&& objcase.Origin=='Email'){
            objcase.Product__c.addError('This Case cannot be escalated');
             }
        
    }
        
        
  
}