import { LightningElement } from 'lwc';

export default class DateRangeSearch extends LightningElement {
    fromDate = '';
    toDate = '';

    handleFromDateChange(event) {
        this.fromDate = event.target.value;
    }

    handleToDateChange(event) {
        this.toDate = event.target.value;
    }

    handleSearchClick() {
        // Display the modal (Component B)
        this.dispatchEvent(new CustomEvent('showmodal', { bubbles: true }));
    }
}