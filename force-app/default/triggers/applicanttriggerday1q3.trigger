trigger applicanttriggerday1q3 on Applicant__c (before insert, before update) {
    for(Applicant__c objapp : trigger.new){
        if( String.isBlank(objapp.Pan_Card__c)){
            objapp.Pan_Card__c.addError('Pancard feild cannot be blank......');
        }
    }
    }