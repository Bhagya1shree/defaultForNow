trigger TriggerApplicantBackup on Applicant__c (after delete) {
    List<Applicant_Backup__c> appBkList = new List<Applicant_Backup__c>();
     for(Applicant__c objApp :  trigger.old){
        if( objApp.Police_Verification__c== True && (objApp.DOB__c.month()== 6 ||objApp.DOB__c.month()== 11 ) && (objApp.Gender__c == 'Male' ||objApp.Gender__c == 'Female')){
            Applicant_Backup__c objAppBk = new Applicant_Backup__c ();
            objAppBk.First_Name__c = objApp.First_Name__c ;
            objAppBk.Last_Name__c =   objApp.Last_Name__c; 
                     appBkList.add(objAppBk);
        }
    }
    
    if(!appBkList.isEmpty()){
        Database.insert(appBkList,false);
    }
}