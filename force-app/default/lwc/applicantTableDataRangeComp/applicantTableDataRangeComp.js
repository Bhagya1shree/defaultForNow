import { LightningElement } from 'lwc';
import searchApplicantDateRecords from
'@salesforce/apex/ApplicantProvider.searchApplicantDateRecords';
export default class ApplicantTableDateRangeComp extends LightningElement {
fromDate;
toDate;
appList;
showPopupFlag;
showDataTableWithPopup(){
    this.showPopupFlag = true;
this.fromDate = this.template.querySelector('lightning-input[dataformfield="fromDate"]').value;
this.toDate = this.template.querySelector('lightning-input[dataformfield="toDate"]').value;
console.log('Yes, calling on Blur');
console.log("From Date = "+this.fromDate + ', To Date = '+this.toDate);

searchApplicantDateRecords({fromDateParam : this.fromDate , toDateParam :
this.toDate})
.then(result=>{
console.log('Result = '+JSON.stringify(result));
this.appList = result;
this.showPopupFlag = true;
})
.catch(error=>{
    this.showPopupFlag = false;
console.log("Error "+JSON.stringify(error));
})
}
}