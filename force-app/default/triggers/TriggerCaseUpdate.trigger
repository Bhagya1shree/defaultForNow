trigger TriggerCaseUpdate on Case (before insert) {
    for(Case objCas : Trigger.new){
        if(!string.isBlank(objCas.Priority)){
            if(objCas.Priority == 'High'){
                objCas.SLAViolation__c = 'Yes';
            }
        }
    }
  
}