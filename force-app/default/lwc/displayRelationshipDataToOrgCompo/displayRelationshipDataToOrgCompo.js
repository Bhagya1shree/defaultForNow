import { LightningElement, wire, track } from 'lwc';
import fetchAccountConOppCaseDetails from '@salesforce/apex/AccConOppCaseWrapperClassController.fetchAccountConOppCaseDetails';
import Name from '@salesforce/schema/Account.Name';

const columns = [
    { label: 'Account Name', fieldName: 'Name', type: 'text' },
    { label: 'Industry', fieldName: 'Industry', type: 'text' },
    { label: 'Ownership', fieldName: 'Ownership', type: 'text' },
     { label: 'Type', fieldName: 'Type', type: 'text' },
    { label: 'Email', fieldName: 'Email', type: 'email' },
    { label: 'Stage', fieldName: 'Stage', type: 'text' },
    { label: 'Origin', fieldName: 'Origin', type: 'text' }
   
];

export default class DisplayRelationshipDataToOrgCompo extends LightningElement {
    @track data;
    @track error;
    @track columns = columns;

    @wire(fetchAccountConOppCaseDetails)
    wiredAccountData({ error, data }) {
        if (data) {
            this.data = data.map(row => {
                return {
                    ...row,
                    Name: row.acc.Name,
                    Type: row.Type,
                    Email: row.Email,
                    Stage: row.Stage,
                    Origin: row.Origin,
                    Industry: row.Industry,
                    Ownership: row.Ownership,

                };
            });
        }
        if (error) {
            this.error = error;
        }
    }
}
