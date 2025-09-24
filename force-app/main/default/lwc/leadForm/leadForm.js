import { LightningElement } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class LeadForm extends LightningElement {
    handleSuccess(event) {
        const evt = new ShowToastEvent({
            title: 'Success',
            message: 'Lead created: ' + event.detail.id,
            variant: 'success'
        });
        this.dispatchEvent(evt);
    }
}


