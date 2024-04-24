trigger PreventDuplicateContactEmail on Contact (before insert, before update) {
    Map<String, List<Contact>> accountEmailMap = new Map<String, List<Contact>>();
    
    // Collect all contacts grouped by Account ID and email ID
    for (Contact contact : Trigger.new) {
        if (contact.AccountId != null && contact.Email != null) {
            String key = contact.AccountId + '_' + contact.Email.toLowerCase();
            if (!accountEmailMap.containsKey(key)) {
                accountEmailMap.put(key, new List<Contact>{contact});
            } else {
                accountEmailMap.get(key).add(contact);
            }
        }
    }
    
    // Check for duplicate email IDs within the same account
    for (List<Contact> contacts : accountEmailMap.values()) {
        if (contacts.size() > 1) {
            for (Contact contact : contacts) {
                contact.addError('Duplicate email ID found within the same account');
            }
        }
    }
}