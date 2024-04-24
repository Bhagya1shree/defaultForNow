import { LightningElement,api,wire } from 'lwc';
//import{getRecord, getFieldValue} from 'lightning/uiRecordApi';
//import STATUS_FIELD from '@salesforce/schema/Case.Status';

//const fields = [STATUS_FIELD]

export default class CommunityCaseDemoCompo extends LightningElement {
   // @api recordId;

   // @wire (getRecord, { recordId: '$recordId', fields})
    //caseObject ={'sObjectType': 'Case'}
 

//picklist me options
get statusoptions() {
    return [
        { label: 'New', value: 'new' },
        { label: 'In Progress', value: 'inProgress' },
        { label: 'Escalated', value: 'escalated' },
    ];
}

// handle for changing the picklist
handleChange(event) {
    //this.caseObject.Status = event.detail.value;
    this.value = event.detail.value;
    console.log(this.value);
}
}