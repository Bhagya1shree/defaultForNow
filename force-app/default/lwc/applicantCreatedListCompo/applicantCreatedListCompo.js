import { LightningElement } from 'lwc';
import searchApplicantDateRecords from
'@salesforce/apex/ApplicantProvider.searchApplicantDateRecords';
export default class applicantCreatedListCompo extends LightningElement {
    selectedRecordCount = 0;

applicantObject = {'sObjectType':'Applicant__c'}
    

    deleteButtonHandler(){
        console.log('Inside  deleteButton.......');

    }

    showRecords(){
        console.log('AWESOMEEEEEEEE.......');
        this.applicantObject.applicantName=this.template.querySelector('lightning-input[data-formfeild="appLicantname"]').value;
        console.log('AWESOMEEEEEEEE.......=' +this.applicantObject.applicantName);

    }
}