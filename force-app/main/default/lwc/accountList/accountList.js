import { LightningElement, wire, track } from 'lwc';
import getAccounts from '@salesforce/apex/AccountController.getAccounts';

export default class AccountList extends LightningElement {
    @track accounts = [];
    @track visibleAccounts = [];
    @track page = 1;
    pageSize = 10;
    totalPages = 1;

    columns = [
        { label: 'Account Name', fieldName: 'Name' }
    ];

    @wire(getAccounts)
    wiredAccounts({ error, data }) {
        if (data) {
            this.accounts = data;
            this.totalPages = Math.ceil(this.accounts.length / this.pageSize);
            this.updateVisibleAccounts();
        } else if (error) {
            this.accounts = [];
        }
    }

    updateVisibleAccounts() {
        const start = (this.page - 1) * this.pageSize;
        const end = start + this.pageSize;
        this.visibleAccounts = this.accounts.slice(start, end);
    }

    handlePrevious() {
        if (this.page > 1) {
            this.page--;
            this.updateVisibleAccounts();
        }
    }

    handleNext() {
        if (this.page < this.totalPages) {
            this.page++;
            this.updateVisibleAccounts();
        }
    }

    get isFirstPage() {
        return this.page === 1;
    }
    get isLastPage() {
        return this.page === this.totalPages;
    }
}
