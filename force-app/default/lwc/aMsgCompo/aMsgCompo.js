import { LightningElement } from 'lwc';

export default class AMsgCompo extends LightningElement {
    childHandler(){
        const myEvent = new CustomEvent ('myChildEvent',{
            Detail: {
              
            }

        });
    }
}