import { LightningElement,api } from 'lwc';

export default class Demolwc extends LightningElement 
{

    @api recordId;
    @api objectApiName;
    fields = ['AccountId', 'Name','Phone', 'Email'];
}