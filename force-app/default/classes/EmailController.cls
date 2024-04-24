public with sharing class EmailController {
    @AuraEnabled
    public static void sendEmailWithOTP(String email) {
        // Generate OTP
        String otp = generateOTP();
        
        // Send email
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        String[] toAddresses = new String[] { email };
        mail.setToAddresses(toAddresses);
        mail.setSubject('Verification Code');
        mail.setPlainTextBody('Your OTP is: ' + otp);
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
    }

    public static String generateOTP() {
        // Generate OTP logic
        return '123456'; // Dummy OTP for example
    }
}
