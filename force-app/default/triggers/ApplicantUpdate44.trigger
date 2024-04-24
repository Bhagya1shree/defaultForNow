trigger ApplicantUpdate44 on Applicant__c (before insert) {
     List <Applicant__c> appList = New  List <Applicant__c> ();
    for(Applicant__c objApp : Trigger.new){
        if (objApp.Gender__c == 'Male'){
            objApp.Police_Verification__c = True;
        }
    }

}