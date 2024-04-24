trigger PreventDuplicateAccounts on Account (before insert) {
    List<String> accountNames = new List<String>();
    List<String> websiteAddresses = new List<String>();
    List<String> phoneNumbers = new List<String>();
    
    // Collect all account names, website addresses, and phone numbers from the new Account records
    for (Account acc : Trigger.new) {
        accountNames.add(acc.Name);
        websiteAddresses.add(acc.Website);
        phoneNumbers.add(acc.Phone);
    }
    
    // Query for existing accounts with the same account names, website addresses, or phone numbers
    Set<Id> existingAccountIds = new Set<Id>();
    for (Account existingAcc : [SELECT Id, Name, Website, Phone FROM Account WHERE Name IN :accountNames OR Website IN :websiteAddresses OR Phone IN :phoneNumbers]) {
        existingAccountIds.add(existingAcc.Id);
    }
    
    // Check for duplicates and prevent the insertion
    for (Account acc : Trigger.new) {
        if (existingAccountIds.contains(acc.Id)) {
            acc.addError('Duplicate account with the same account name, website address, or phone number found.');
        }
    }
}