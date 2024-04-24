import { LightningElement } from 'lwc';
import searchApplicantRecord from '@salesforce/apex/ApplicantProvider.searchApplicantRecord';

export default class SearchApplicantCompo extends LightningElement {

    applicantObject = {'sObjectType' : 'Applicant__c'};

    handleSearchButton(){
        debugger;
        console.log('Inside of search button js method');
        this.applicantObject.Name = this.template.querySelector('lightning-input[data-formfield="applicantName"]').value; //APID-0062
    
        console.log('Received in JS = '+this.applicantObject.Name);

        searchApplicantRecord({"objApp" : this.applicantObject})
        .then(result=>{
                console.log("Result = "+ JSON.stringify(result) );
                this.applicantObject = result;
                this.showSuccessToast();               
            })
            .catch(error=>{
                    console.log("Error "+JSON.stringify(error));
            });
    
        }
    
        showSuccessToast() {
            const evt = new ShowToastEvent({
                title: 'Message',
                message: 'Record Found...!!!',
                variant: 'success',
                mode: 'dismissable'
            });
            this.dispatchEvent(evt);
        }
    
    }