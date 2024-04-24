trigger nwCaseTrigger on Case (before insert, before update) {// If we create/Edit a Case having Priority as “High” or “Medium”, then Update its related Account Rating as “Hot”. Else nothing
    set <Id> acIdSet =  new set <Id> ();
    for(Case obCas : trigger.new){
        if(obCas.AccountId != null){
            if(trigger.isbefore && trigger.isInsert){
                 acIdSet.add(obCas.AccountId);
                
            }
            if(trigger.isbefore && trigger.isUpdate){
            if((obCas.Priority) != trigger.oldMap.get(obcas.Id).Priority){
               acIdSet.add(obCas.AccountId);  
            }
        }
        }
       
    }
    map <Id,Account > acmap = new  map <Id,Account >();
    for (Account obAcc : [SELECT   Id, Name, Rating FROM Account  WHERE Id IN : acIdSet]){
        acmap.put(obAcc.Id, obAcc);
    }
     for(Case obCas : trigger.new){
         
         if (acmap.containsKey(obCas.AccountId)){
             if(obCas.Priority == 'High' || obCas.Priority == 'Medium'){
               acmap.get(obCas.AccountId).Rating = 'Hot';
             }
             else{
                  acmap.get(obCas.AccountId).Rating = '  ';
             }
         }
       database.update (acmap.values(), false)  ;
    
}

}