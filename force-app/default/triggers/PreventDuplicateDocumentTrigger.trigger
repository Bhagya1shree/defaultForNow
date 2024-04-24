trigger PreventDuplicateDocumentTrigger on DocumentDetails__c (before insert,before Update ,after Undelete) {
    Set<Id> applicantIdSet = new Set<Id>();
    if((trigger.isBefore && trigger.isInsert)|| (trigger.isAfter && trigger.isUndelete)){
        for(DocumentDetails__c objDoc : trigger.new){
            applicantIdSet.add(objDoc.Applicant__c);
        }
    }
     for(DocumentDetails__c objDoc : trigger.new){
    if(trigger.isBefore && trigger.isUpdate){
        if((objDoc.IdentityProof__c != trigger.oldMap.get(objDoc.Id).IdentityProof__c) || (objDoc.Applicant__c != trigger.oldMap.get(objDoc.Id).Applicant__c)){
       
            applicantIdSet.add(objDoc.Applicant__c);
        }
    }
    }
    
    map <Id, Applicant__c>  appMap = new  map <Id, Applicant__c>  ();
    if(! applicantIdSet.isEmpty()){
        for(Applicant__c objApp : [Select Id, First_Name__c, (select id, IdentityProof__c from Document_Details__r) from Applicant__c where Id IN : applicantIdSet ]){
            appMap.put(objApp.Id,objApp);
        }
    }
    if(!appMap.isEmpty()){
        for(DocumentDetails__c objDoc : trigger.new){
            if( appMap.containsKey(objDoc.Applicant__c)){
                            
                list <DocumentDetails__c> docList = appMap.get(objDoc.Applicant__c).Document_Details__r;
                
                for(DocumentDetails__c objDocexisting : docList){
                    if(objDoc.IdentityProof__c == objDocexisting.IdentityProof__c){
                        objDoc.addError('This identity proof of same documents '+objDoc.IdentityProof__c+'is already exists for this Applicant');
                    }
                }
            }
        }
    }
}