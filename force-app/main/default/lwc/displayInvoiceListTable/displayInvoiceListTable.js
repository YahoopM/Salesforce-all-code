import { LightningElement, track, wire } from 'lwc';
import getInvoiceList from '@salesforce/apex/DisplayInvoiceListTable.getInvoiceList';
import getInvoiceLineById from '@salesforce/apex/DisplayInvoiceListTable.getInvoiceLineById';
import getAllProducts from '@salesforce/apex/DisplayInvoiceListTable.getAllProducts';
import saveInvoiceLine from '@salesforce/apex/DisplayInvoiceListTable.saveInvoiceLine';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { NavigationMixin } from 'lightning/navigation';

const columns = [
    { label: 'Invoice Number', fieldName: 'NameUrl',  sortable: "true" , type: 'url', typeAttributes: {
        label: { fieldName: 'Name' },
        target: '_blank', tooltip: { fieldName: 'Name' } 
    }},
    { label: 'Invoice Date', fieldName: 'Invoice_Date__c', type: 'date' , sortable: "true"},
    {
        label: 'Buyer Name', fieldName: 'BuyerNameUrl', sortable: "true" , type: 'url', typeAttributes: {
            label: { fieldName: 'Buyer_Name__c' },
            target: 'blank', tooltip: { fieldName: 'Buyer_Name_c' }
        }
    },
    { label: 'Invoice Status', fieldName: 'Invoice_Status__c', type: 'Picklist' , sortable: "true" },
    {
        label: 'Open', type: 'button', typeAttributes: {
            label: 'View',
            name: 'view',
            title: 'Click to view Invoice',
            variant: 'brand',
            iconPosition: 'left'
        }
    }
];

const invoiceLineColumns = [
    { label: 'Product Name', fieldName: 'ProductNameUrl', sortable: "true" , type: 'url', typeAttributes: {
        label: { fieldName: 'Product_Name__c' },
        target: 'Blank', tooltip: { fieldName: 'Product_Name__c' }
    }},
    { label: 'Quantity', fieldName: 'Quantity__c', type: 'number' , sortable: "true" },
    { label: 'Price', fieldName: 'Price__c', type: 'currency', sortable: "true" },
    { label: 'Product Total', fieldName: 'Product_Total__c', type: 'currency', sortable: "true" },
    { label: 'Taxes', fieldName: 'Taxes__c', type: 'currency', sortable: "true" },
    { label: 'Grand Total', fieldName: 'Grand_Total__c', type: 'currency', sortable: "true" }
];

export default class DisplayInvoiceListTable extends NavigationMixin(LightningElement) {
    // Invoice table properties
    @track data;
    @track columns = columns;
    @track page = 1;
    @track pageSize = 10;
    @track totalPages;
    @track visibleInvoices = [];

    // Invoice line table properties
    @track invoiceLineColumns = invoiceLineColumns;
    @track invoiceLineData = [];
    @track invoiceLinePage = 1;
    @track invoiceLinePageSize = 10;
    @track invoiceLineTotalPages = 1;
    @track paginatedInvoiceLineData = [];

    // UI state
    @track selectedInvoice;
    @track showInvoice = true;
    @track showInvoiceLine = false;
    @track showAddProduct = false;

    // Modal properties
    @track productOptions;
    @track productName;
    @track quantity;
    @track price;
    @track taxes;

    // Sorting properties
    @track sortBy;
    @track sortDirection;
    @track invoiceLineSortBy;
    @track invoiceLineSortDirection;

    // Get invoice list data
    @wire(getInvoiceList)
    wiredInvoices({ error, data }) {
        if (data) {
            const parseddata = JSON.parse(JSON.stringify(data));
            this.data = parseddata.map((res, index) => ({
                SNo: index + 1,
                Id: res.Id,
                NameUrl: res.Id ? '/' + res.Id : '',
                Name: res.Name,
                Invoice_Date__c: res.Invoice_Date__c,
                Invoice_Status__c: res.Invoice_Status__c,
                BuyerNameUrl: res.Buyer_Name__c ? '/' + res.Buyer_Name__c : '',
                Buyer_Name__c: res.Buyer_Name__r.Name,
                BuyerId: res.Buyer_Name__r.Id,
                Seller_Name__c: res.Seller_Name__r?.Name,
                SellerNameUrl: res.Seller_Name__c ? '/' + res.Seller_Name__c : '',
                SellerId: res.Seller_Name__r.Id,
                Pending_Amount__c: res.Pending_Amount__c
            }));
            this.page = 1;
            this.paginatedData();
        } else if (error) {
            console.error('Error fetching invoices', error);
        }
    }

    // Pagination for Invoice table
    paginatedData() {
        const startIndex = (this.page - 1) * this.pageSize;
        const endIndex = startIndex + this.pageSize;
        this.visibleInvoices = this.data ? this.data.slice(startIndex, endIndex) : [];
        this.totalPages = this.data ? Math.ceil(this.data.length / this.pageSize) || 1 : 1;
    }
    get isFirstPage() { return this.page === 1; }
    get isLastPage() { return this.page === this.totalPages; }
    goToFirstPage() { if (!this.isFirstPage) { this.page = 1; this.paginatedData(); } }
    goToPreviousPage() { if (this.page > 1) { this.page--; this.paginatedData(); } }
    goToNextPage() { if (this.page < this.totalPages) { this.page++; this.paginatedData(); } }
    goToLastPage() { if (!this.isLastPage) { this.page = this.totalPages; this.paginatedData(); } }

    // Invoice line data
    handleRowAction(event) {
        const actionName = event.detail.action.name;
        const row = event.detail.row;
        if (actionName === 'view') {
            this.selectedInvoice = row;
            this.showInvoice = false;
            this.showInvoiceLine = true;
            this.getInvoiceLine();
        }
    }

    // Back to invoice list
    handleClickBack() {
        this.showInvoice = true;
        this.showInvoiceLine = false;
    }

    // Selected Invoice
    getInvoiceLine() {
        getInvoiceLineById({ invoiceId: this.selectedInvoice.Id })
            .then(result => {
                this.invoiceLineData = result.map((res, index) => ({
                    SNo: index + 1,
                    Id: res.Id,
                    ProductNameUrl: res.Product_Name__c ? '/' + res.Product_Name__c : '',
                    Product_Name__c: res.Product_Name__r ? res.Product_Name__r.Name : '',
                    Quantity__c: res.Quantity__c,
                    Price__c: res.Price__c,
                    Product_Total__c: res.Product_Total__c,
                    Taxes__c: res.Taxes__c,
                    Grand_Total__c: res.Grand_Total__c
                }));
                this.invoiceLinePage = 1;
                this.updatePaginatedInvoiceLineData();
            })
            .catch(error => {
                console.error('Error fetching invoice lines', error);
                this.invoiceLineData = [];
                this.updatePaginatedInvoiceLineData();
            });
    }

    // Pagination for Invoice Line table
    updatePaginatedInvoiceLineData() {
        if (!this.invoiceLineData || this.invoiceLineData.length === 0) {
            this.paginatedInvoiceLineData = [];
            this.invoiceLineTotalPages = 1;
            return;
        }
        const startIndex = (this.invoiceLinePage - 1) * this.invoiceLinePageSize;
        const endIndex = startIndex + this.invoiceLinePageSize;
        this.paginatedInvoiceLineData = this.invoiceLineData.slice(startIndex, endIndex);
        this.invoiceLineTotalPages = Math.ceil(this.invoiceLineData.length / this.invoiceLinePageSize) || 1;
    }
    get isInvoiceLineFirstPage() { return this.invoiceLinePage === 1; }
    get isInvoiceLineLastPage() { return this.invoiceLinePage === this.invoiceLineTotalPages; }
    goToInvoiceLineFirstPage() { if (!this.isInvoiceLineFirstPage) { this.invoiceLinePage = 1; this.updatePaginatedInvoiceLineData(); } }
    goToInvoiceLinePreviousPage() { if (this.invoiceLinePage > 1) { this.invoiceLinePage--; this.updatePaginatedInvoiceLineData(); } }
    goToInvoiceLineNextPage() { if (this.invoiceLinePage < this.invoiceLineTotalPages) { this.invoiceLinePage++; this.updatePaginatedInvoiceLineData(); } }
    goToInvoiceLineLastPage() { if (!this.isInvoiceLineLastPage) { this.invoiceLinePage = this.invoiceLineTotalPages; this.updatePaginatedInvoiceLineData(); } }

    // Add Product Modal
    connectedCallback() {
        this.loadProduct();
    }

    loadProduct() {
        getAllProducts()
            .then(result => {
                this.productOptions = result.map(res => ({
                    label: res.Name,
                    value: res.Id
                }));
            })
            .catch(error => {
                console.error('Error fetching products', error);
            });
    }

    handleInputChange(event) {
        const field = event.target.name;
        this[field] = event.target.value;
    }

    @track invoiceLineList = [];
    handleSave() {
        if (!this.productName || !this.quantity || !this.price || !this.taxes) {
            this.showToast('Missing Information', 'Please enter all required fields', 'error', 'dismissable');
            return;
        }
        const invoiceLine = {
            SobjectType: 'Invoice_Line__c',
            Invoice__c: this.selectedInvoice.Id,
            Product_Name__c: this.productName,
            Quantity__c: this.quantity,
            Price__c: this.price,
            Taxes__c: this.taxes
        };
        this.invoiceLineList.push(invoiceLine);

        saveInvoiceLine({ invoiceLineList: this.invoiceLineList })
            .then(() => {
                this.showToast('Success', 'Invoice Line Added Successfully', 'success', 'dismissable');
                this.showAddProduct = false;
                this.loadProduct();
                this.getInvoiceLine();
                this.productName = '';
                this.quantity = '';
                this.price = '';
                this.taxes = '';
            })
            .catch(error => {
                this.showToast('Error', error.body.message, 'error', 'dismissable');
                console.error('Error saving invoice line', error);
            });
    }

    handleClick() {
        this.showAddProduct = true;
        this.loadProduct();
    }

    handleCancel() {
        this.showAddProduct = false;
    }

    showToast(title, message, variant, mode) {
        const toastEvent = new ShowToastEvent({
            title: title,
            message: message,
            variant: variant,
            mode: mode
        });
        this.dispatchEvent(toastEvent);
    }

    handleRecordClick(event) {
        const recordId = event.target.dataset.id;
        this[NavigationMixin.Navigate]({
            type: 'standard__recordPage',
            attributes: {
                recordId: recordId,
                actionName: 'view'
            }
        });
    }

    // General sort function
    sortData(dataArray, fieldname, direction) {
        let parseData = JSON.parse(JSON.stringify(dataArray));
        let keyValue = (a) => (a[fieldname] ? a[fieldname] : '');
        let isReverse = direction === 'asc' ? 1 : -1;
        parseData.sort((x, y) => {
            x = keyValue(x);
            y = keyValue(y);
            return isReverse * ((x > y) - (y > x));
        });
        return parseData;
    }

    // Invoice table sort handler
    handleSort(event) {
        this.sortBy = event.detail.fieldName;
        this.sortDirection = event.detail.sortDirection;
        this.data = this.sortData(this.data, this.sortBy, this.sortDirection);
        this.paginatedData();
    }

    // Invoice line table sort handler
    handleInvoiceLineSort(event) {
        this.invoiceLineSortBy = event.detail.fieldName;
        this.invoiceLineSortDirection = event.detail.sortDirection;
        this.invoiceLineData = this.sortData(this.invoiceLineData, this.invoiceLineSortBy, this.invoiceLineSortDirection);
        this.updatePaginatedInvoiceLineData();
    }
}