public class userController {
   
    @AuraEnabled
    public static Map<String, String> sendMailWithOtp(){
        Map<String, String> result = new Map<String, String>();
        try {
            Integer otpLength = 6; // Define the length of OTP
            String generatedOtpValue = generateOTP(otpLength);
            sendEmailWithOtpTwice(generatedOtpValue);
            result.put('message', 'OTP sent successfully');
            result.put('otp', generatedOtpValue);
        } catch (Exception e) {
            result.put('message', e.getMessage());
        }
        return result;
    }

   @AuraEnabled
  
   
    public static String generateOTP(Integer length) {
        String otp = '';
        for (Integer i = 0; i < length; i++) {
            otp += String.valueOf(Math.mod(Math.abs(Crypto.getRandomInteger()), 10));
        }
        return otp;
    }

    // Method to send email with OTP
    @AuraEnabled
   
    public static void sendEmailWithOtpTwice(String otpValue) {
        try {
            List<Messaging.SingleEmailMessage> mailList = new List<Messaging.SingleEmailMessage>();
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
            mail.setToAddresses(new String[] {'bhagya88058@gmail.com'});
            mail.setSenderDisplayName('Bhagyashree');
            mail.setSubject('OTP Verification');
            mail.setPlainTextBody('Your OTP: ' + otpValue);
            mailList.add(mail);
            if (!mailList.isEmpty()) {
                Messaging.sendEmail(mailList);
            }
        } catch (Exception e) {
            throw e;
        }
    }
}
