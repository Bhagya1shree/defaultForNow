trigger UpdateOpportunityAmount5Feb on Account (after insert, after update) {
    List<Opportunity> opportunitiesToUpdate = new List<Opportunity>();
    Map<Id, String> originalIndustryValues = new Map<Id, String>();

    for (Account newAccount : Trigger.new) {
        if (Trigger.isUpdate) {
            Account oldAccount = Trigger.oldMap.get(newAccount.Id);
            if (oldAccount.Industry == newAccount.Industry) {
                continue;
            }
            originalIndustryValues.put(newAccount.Id, oldAccount.Industry);
        }

        List<Opportunity> relatedOpportunities = [SELECT Id, Amount FROM Opportunity
                                                  WHERE AccountId = :newAccount.Id
                                                  AND StageName = 'Closed Won'];

        for (Opportunity opp : relatedOpportunities) {
            opp.Amount = opp.Amount * 1.1;
            opportunitiesToUpdate.add(opp);
        }
    }

    if (!opportunitiesToUpdate.isEmpty()) {
        Database.update(opportunitiesToUpdate, false) ;
    }
}