public class ApexToFlow {
    
    @InvocableMethod(label='Get Account Names' description='Returns a list of Account Names')
    public static List<InvocableAccountResult> accountToFlowHandler() {
        List<InvocableAccountResult> result = new List<InvocableAccountResult>();

        List<Account> accList = [SELECT Id, Name FROM Account];
        
        for (Account objAcc : accList) {
            InvocableAccountResult accResult = new InvocableAccountResult();
            accResult.AccountId = objAcc.Id;
            accResult.AccountName = objAcc.Name;
            result.add(accResult);
        }

        return result;
    }

    // Inner class to define the output structure
    public class InvocableAccountResult {
        @InvocableVariable(label='Account ID' description='ID of the Account')
        public Id AccountId;

        @InvocableVariable(label='Account Name' description='Name of the Account')
        public String AccountName;
    }
}