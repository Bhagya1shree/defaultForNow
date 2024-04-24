import { LightningElement } from 'lwc';

import createNewAccount from '@salesforce/apex/AccountProvider.createNewAccount';
export default class accountRegistrationForm extends LightningElement {

    accName;

    handleSubmitButton(){
        this.accName = this.template.querySelector('lightning-input[data-formfield="accountName"]').value; //Cinemax

       console.log('Inside of JS METHOD');
       createNewAccount({ accountName : this.accName})
        .then(result=>{
            console.log('New Account has been created...!!!!');
        })
        .catch(error=>{
            console.log('Locha, something went wrong..!!');
        });

    }
}