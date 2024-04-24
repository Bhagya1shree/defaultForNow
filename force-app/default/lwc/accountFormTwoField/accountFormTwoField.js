import { LightningElement } from 'lwc';
import createNewAccount from '@salesforce/apex/AccountProvider.createNewAccount';
export default class accountFormTwoField extends LightningElement {
  
   accountObject = {'sObjectType' : 'Account'}

    handleSubmitButton(){
        debugger;
        
        this.accountObject.Name = this.template.querySelector('lightning-input[data-formfield="accountName"]').value; //Cinemax
        this.accountObject.Type = this.template.querySelector('lightning-input[data-formfield="accountType"]').value; 
        
        console.log('Inside of JS Method '+ this.accName);

        createNewAccount({objAcc : this.accountObject})
        .then(result=>{
            console.log('New Account has been created...!!!!');
            alert('New Account Created.....');
        })
        .catch(error=>{
            console.log('Locha, something went wrong..!!');
        });

    }
}