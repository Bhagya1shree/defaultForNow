import { LightningElement,api } from 'lwc';
import { CloseActionScreenEvent } from 'lightning/actions';
import getMobileVerify from '@salesforce/apex/MobileAPIClass.getMobileVerify';
export default class MobileCompo extends LightningElement {


    @api recordId;

   //Invoke on button click
     @api invoke(){
        console.log('Record Id ='+this.recordId);

        getMobileVerify({'applicantRecordId' : this.recordId})
        .then(success=>{
            console.log(success);
            this.dispatchEvent(new CloseActionScreenEvent()); //To Close the LWC Component Automatically
            window.location.reload();
        })
        .catch(error=>{
            console.log(error);
            this.dispatchEvent(new CloseActionScreenEvent()); ////To Close the LWC Component Automatically
            window.location.reload();
        })

    }
}