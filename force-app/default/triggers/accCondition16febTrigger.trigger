trigger accCondition16febTrigger on Account (before insert) {
    //Whenever a new record is created into account object, before this new record is inserted into Account,
//delete all the contacts records with this account name also delete old Account Name.
   set <Id> AccIdSet = new set <Id>();
    for (Account objAcc : trigger.new){
    AccIdSet.add(objAcc.Id);
    
    List <Account >  accList = new  List <Account >();
    for (Account existAccount : [SELECT Id, Name, (SELECT Id, Name FROM Contacts) FROM Account WHERE Id IN (SELECT AccountId FROM Contact)]){
    accList.add(existAccount);
                        }
    database.delete(accList, false);
      
    }
 

}