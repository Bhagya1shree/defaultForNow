trigger PreventAccountDeletion on Account (before delete) {

 Set<Id> accountIdsWithContacts = new Set<Id>();

    for (Contact contact : [SELECT AccountId FROM Contact WHERE AccountId IN :Trigger.old]) {
        accountIdsWithContacts.add(contact.AccountId);
    }

    for (Account acc : Trigger.old) {
        if (accountIdsWithContacts.contains(acc.Id)) {
            acc.addError('Cannot delete Account with associated Contacts.');
        }
    }
}