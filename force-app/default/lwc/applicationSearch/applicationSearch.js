import { LightningElement, track, wire } from 'lwc';
import searchApplicantDateRecords from '@salesforce/apex/ApplicantProvider.searchApplicantDateRecords';
import getApplicationsByDateRange from '@salesforce/apex/ApplicationSearchController.getApplicationsByDateRange';

export default class ApplicationSearch extends LightningElement {
    @track showPopupModalFlag = false;
    @track data;
    @track fromDate;
    @track toDate;
    
    handleFromDateChange(event){
        this.fromDate = event.target.value;
    }
    
    handleToDateChange(event){
        this.toDate = event.target.value;
    }
    
    popUpHandler(){
        searchApplicantDateRecords({ fromDate: this.fromDate, toDate: this.toDate })
            .then(result => {
                this.data = result;
                this.showPopupModalFlag = true;
            })
            .catch(error => {
                this.data = undefined;
                this.showPopupModalFlag = false;
                console.error('Error fetching data: ', error);
            });
    }
    
    receivedPopupModalDataHandler(event){
        console.log('Inside of Popup');
        this.showPopupModalFlag = event.detail;
    }
}
