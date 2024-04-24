import { LightningElement, wire, track  } from 'lwc';
import fetchAccountandRelatedContactDetails from '@salesforce/apex/WrapperConRelateAcc.fetchAccountandRelatedContactDetails';
const columns = [
    { label: 'Account Name', fieldName: 'AccountLink', type: 'url', typeAttributes: { label: { fieldName: 'AccountName' } }, target: '_blank' },
    { label: 'Type', fieldName: 'type', type: 'text' }, // Changed type to text as it's not a URL
    { label: 'Total Contacts', fieldName: 'totalContacts', type: 'number' }, // Changed type to number for better display
    { label: 'Address', fieldName: 'billingAddress', type: 'text' } // Changed type to text as it's not a URL
];


export default class ConAccWrapperCompo extends LightningElement {

        @track data;
        @track error;
        @track columns = columns;
    
        @wire(fetchAccountandRelatedContactDetails)
        wiredAccountData({ error, data }) {
            if (data) {
                this.data = data.map(row => {
                    return { ...row, AccountLink: '/' + row.acc.Id }; // Add AccountLink dynamically
                });
            }
            if (error) {
                this.error = error;
            }
        }
    }
    







