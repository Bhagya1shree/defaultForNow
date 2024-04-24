import { LightningElement } from 'lwc';

export default class BMsgCompo extends LightningElement {
    parentHandler(){
        const message = event.Detail;
    }
}