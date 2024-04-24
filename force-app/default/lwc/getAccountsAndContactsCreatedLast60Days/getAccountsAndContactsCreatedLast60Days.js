

import { LightningElement, track, wire } from 'lwc';
import getAccountDetails from '@salesforce/apex/AccountContactController.getAccountDetails';

export default class getAccountsAndContactsCreatedLast60Days extends LightningElement {

    @track gridColumn = [
        { label: 'Account Name', fieldName: 'Name', type: 'text' },
        { label: 'First Name', fieldName: 'FirstName', type: 'text'},
        { label: 'Last Name', fieldName: 'LastName', type: 'text'} 
    ];

    @track gridData;

    connectedCallback() {
        getAccountDetails()
            .then(result => {
                this.gridData = result.map(account => ({
                    Id: account.Id,
                    Name: account.Name,
                    _children: account.Contacts ? account.Contacts.map(contact => ({
                        Id: contact.Id,0
                        FirstName: contact.FirstName,
                        LastName: contact.LastName
                    })) : []
                }));
            })
            .catch(error => {
                console.error(error);
            });
    }
}
