import { LightningElement,api} from 'lwc';
import searchApplicantDateRecords from '@salesforce/apex/ApplicantProvider.searchApplicantDateRecords';
const columns = [
    { label: 'Applicant Id', fieldName: 'Name', editable: true },
    { label: 'First Name', fieldName: 'First_Name__c', editable: true },
    { label: 'Last Name', fieldName: 'Last_Name__c', editable: true },
    { label: 'Created Date', fieldName: 'createdDate', editable: true },
    { label: 'Mobile Number', fieldName: 'Mobile_Number__c', editable: true },
    { label: 'Email Id', fieldName: 'Email_Id__c', editable: true },
  ];
  

export default class ApplicantDataTableCompo extends LightningElement {
     @api fromDate;
    @api toDate;
    @api popupList;
    columns = columns;

 
    
        
        closePopModalHandler(event){
        
            const myEvent = new CustomEvent("popupevent", {
                detail : false
                });
                this.dispatchEvent(myEvent);
             
                        }
    
  
}