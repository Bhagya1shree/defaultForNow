import { LightningElement, wire } from 'lwc';

import getAccountsByType from '@salesforce/apex/AccountControllerBhagyashree.getAccountsByType';
import getCasesByAccountId from '@salesforce/apex/CaseControllerBhagyashree.getCasesByAccountId';
export default class AccountCompoBhagyashree extends LightningElement {

   

    selectedAccountId;
   selectedAccountType;
    accountList;
    error;
    totalRecord;
    showDataTable;
    selectedRecord;
    caseList;

    draftValues=[];
    accColumns = [  
  { label: 'Account Name', fieldName: 'Name', editable: true },
  { label: 'Rating', fieldName: 'Rating', editable: true },
  { label: 'Type', fieldName: 'Type', editable: true }
  
];


    selectAccountTypeHandler(event){
    this.selectedAccountType= event.target.value; 
     console.log("Selected account type: " +this.selectedAccount);
     console.log('#### Event Occured');
    }

    @wire (getAccountsByType, {accountType: '$selectedAccountType'})
    accountsByType({error, data}){
        if (data) {
            this.accountList = data;
            this.totalRecord= data.length;
            if(data.length>0){
                this.showDataTable = true;
            } else{
                if(data.length=0)
                this.showDataTable = false;
            } 
            //console.log('Retrieved Account='+ JSON.stringify(data));
            this.error = undefined;
        } else if (error) {
            this.accountList = undefined;
            this.error = error;
            this.showDataTable = false;
        }
}

selectedRecordsHandler(event){

    
    const selectedRows = event.details.selectedRows;
   if(selectedRows.length === 1){
    const selectedRecord = selectedRows [0];
    const accountId =selectedRecord.Id;

    this.selectedAccountId = accountId;
   }

   
getCasesByAccountId ({accountIdForCase : this.selectedAccountId})
.then(result=> {
    this.caseList = result; 
    this.error = undefined;
    
const myEvent = new CustomEvent('myEvent',
{ data: caseList, bubbles:true, composed:true
 });       
this.dispatchEvent(myEvent);
})


.catch(error=> {
this.caseList = null;
this.error = error;
});

   
}

}

