import { LightningElement, track, api, wire } from 'lwc';
import getAccountName from '@salesforce/apex/AccountProvider.getAccountName';

export default class SearchAccbyIdCompo extends LightningElement {
    
        @track accountId = '';
        @track accountName;
    
        handleInputChange(event) {
            this.accountId = event.target.value;
        }
    
        searchAccount() {
            getAccountName({ accountId: this.accountId })
                .then(result => {
                    this.accountName = result;
                })
                .catch(error => {
                    console.error('Error retrieving account name', error);
                });
        }
    }