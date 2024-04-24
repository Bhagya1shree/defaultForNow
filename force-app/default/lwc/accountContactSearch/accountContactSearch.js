import { LightningElement, track } from 'lwc';
import searchContact from '@salesforce/apex/contactProvider.searchContact';

export default class AccountContactSearch extends LightningElement {
    @track accountId = '';
    @track contacts = [];
    @track columns = [
        { label: 'Name', fieldName: 'Name' },
        { label: 'Phone', fieldName: 'Phone' },
        { label: 'Email', fieldName: 'Email' },
    ];

    handleInputChange(event) {
        this.accountId = event.target.value;
    }

    searchContacts() {
        searchContact({ accountId: this.accountId })
            .then(result => {
                this.contacts = result;
            })
            .catch(error => {
                console.error('Error: ' + JSON.stringify(error));
            });
    }
}