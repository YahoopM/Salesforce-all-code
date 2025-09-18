import { LightningElement, track } from 'lwc';
import searchAccounts from '@salesforce/apex/AccountSearchController.searchAccounts';

const COLUMNS = [
    { label: 'Name', fieldName: 'Name', type: 'text' },
    { label: 'Phone', fieldName: 'Phone', type: 'phone' },
    { label: 'Industry', fieldName: 'Industry', type: 'text' },
    { label: 'Type', fieldName: 'Type', type: 'text' },
    { label: 'Billing City', fieldName: 'BillingCity', type: 'text' },
    { label: 'Website', fieldName: 'Website', type: 'url' }
];

export default class AccountSearch extends LightningElement {
    @track keyword = '';
    @track accounts = [];
    @track isLoading = false;

    columns = COLUMNS;

    get hasNoResults() {
        return !this.isLoading && this.keyword && this.accounts && this.accounts.length === 0;
    }

    handleChange(event) {
        this.keyword = event.target.value;
        this.search();
    }

    async search() {
        this.isLoading = true;
        try {
            const results = await searchAccounts({ keyword: this.keyword });
            this.accounts = results;
        } catch (e) {
            // optionally surface error state
            this.accounts = [];
            // eslint-disable-next-line no-console
            console.error('Account search failed', e);
        } finally {
            this.isLoading = false;
        }
    }
}


