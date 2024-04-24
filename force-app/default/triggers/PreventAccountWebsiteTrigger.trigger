trigger PreventAccountWebsiteTrigger on Account  (before insert, before update) { 
    set<string> newNameSet = new set<string>();
    set<string> newWebsiteSet = new set<string>();
    set<string> newPhoneSet = new set<string>();
    
    set<string> dbNameSet = new set<string>();
    set<string> dbWebsiteSet = new set<string>();
    set<string> dbPhoneSet = new set<string>();
    
    for(Account objAcc: trigger.new){
        newNameSet.add(objAcc.Name);
        newWebsiteSet.add(objAcc.Website);
        newPhoneSet.add(objAcc.Phone);
    }
    for(Account acc : [select Id,Name,Website, Phone from Account where Website IN: newWebsiteSet OR Name IN: newNameSet OR Phone IN: newPhoneSet]){
        dbNameSet.add(acc.Name);
        dbWebsiteSet.add(acc.Website);
        dbPhoneSet.add(acc.Phone);
    }
    for(Account objAcc : trigger.new){
        if(dbNameSet.contains(objAcc.Name) && dbWebsiteSet.Contains(objAcc.Website) && dbPhoneSet.contains(objAcc.Phone))
            objAcc.addError('You are inserting Duplicate Account with same Website nd Phone feilds.....');
    }
    }