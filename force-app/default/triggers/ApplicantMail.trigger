trigger ApplicantMail on Applicant__c (after insert) {
  List <messaging.SingleEmailMessage> mailList = New List <messaging.SingleEmailMessage> ();
    for (Applicant__c objApp : Trigger.new){
         messaging.SingleEmailMessage Mail = new messaging.SingleEmailMessage ();
        Mail.setToAddresses( new string[] {'bhagya88058@gmail.com'});
        Mail.setSenderDisplayName('Bhagya Shree');
        Mail.setSubject('Creation of new applicant');
        Mail.setPlainTextBody('Hello new applicant is created \n\n Team Airtel');
        mailList.add(Mail);
    }
    if(!mailList.isEmpty()){
        Messaging.sendEmail(mailList,false);
    }
}