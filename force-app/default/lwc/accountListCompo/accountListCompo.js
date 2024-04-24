// displayMultipleAccounts.js
import { LightningElement, wire } from 'lwc';
import { getListUi } from 'lightning/uiListApi';
import ACCOUNT_OBJECT from '@salesforce/schema/Account';
import NAME_FIELD from '@salesforce/schema/Account.Name';
import CREATED_DATE_FIELD from '@salesforce/schema/Account.CreatedDate';

export default class accountListCompo extends LightningElement {
    accounts = [];
    error;

    columns = [
        { label: 'Account Name', fieldName: 'Name', type: 'text' },
        { label: 'Created Date', fieldName: 'CreatedDate', type: 'date' }
    ];

    @wire(getListUi, {
        objectApiName: ACCOUNT_OBJECT,
        listViewApiName: 'AllAccounts', // Assuming you have a list view named AllAccounts
        pageSize: 10
    })
    wiredAccounts({ error, data }) {
        if (data) {
            this.accounts = data.records.records.map(record => {
                let account = {};
                account.Id = record.id;
                account.Name = record.fields[NAME_FIELD.fieldApiName].value;
                account.CreatedDate = record.fields[CREATED_DATE_FIELD.fieldApiName].value;
                return account;
            });
            this.error = undefined;
        } else if (error) {
            this.error = error;
            this.accounts = [];
        }
    }
}

duplicate value found: <unknown> duplicates value on record with id: <unknown>
Cannot find Lightning Component Bundle AccountListCompo. 