import { LightningElement} from 'lwc';

export default class SomeMsgCompo extends LightningElement {

 someMsg= 'Hello from child!';

    // Method to dispatch a custom event with the message
  sendMessage() {
        const messageEvent = new CustomEvent('messageevent', {
            detail: {
                message: 'Hello from child keep trying.........!'
            }
        });
        this.dispatchEvent(messageEvent);
    }

}