import { LightningElement, api, wire, track } from 'lwc';
import getContactsByAccount from '@salesforce/apex/ContactController.getContactsByAccount';

export default class AccountContacts extends LightningElement {
    @api recordId;
    @track rows = [];
    isLoading = false;

    columns = [
        { label: 'Name', fieldName: 'Name' },
        { label: 'Title', fieldName: 'Title' },
        { label: 'Email', fieldName: 'Email', type: 'email' },
        { label: 'Phone', fieldName: 'Phone', type: 'phone' }
    ];

    @wire(getContactsByAccount, { accountId: '$recordId' })
    wiredContacts({ data, error }) {
        this.isLoading = false;
        if (data) {
            this.rows = data;
        } else if (error) {
            // eslint-disable-next-line no-console
            console.error('Failed to load contacts', error);
            this.rows = [];
        }
    }

    connectedCallback() {
        this.isLoading = true;
    }

    get hasNoData() {
        return !this.isLoading && (!this.rows || this.rows.length === 0);
    }
}








