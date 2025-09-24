import { LightningElement, api, track } from 'lwc';
import searchContactsForAccount from '@salesforce/apex/VoiceContactLookupController.searchContactsForAccount';

const COLUMNS = [
    { label: 'Name', fieldName: 'Name', type: 'text' },
    { label: 'Title', fieldName: 'Title', type: 'text' },
    { label: 'Email', fieldName: 'Email', type: 'email' },
    { label: 'Phone', fieldName: 'Phone', type: 'phone' }
];

export default class VoiceContactLookup extends LightningElement {
    @api recordId; // AccountId from record page
    @track prompt = '';
    @track rows = [];
    @track isLoading = false;
    recognizing = false;
    recognition;

    columns = COLUMNS;

    connectedCallback() {
        if ('webkitSpeechRecognition' in window || 'SpeechRecognition' in window) {
            const SpeechRecognition = window.SpeechRecognition || window.webkitSpeechRecognition;
            this.recognition = new SpeechRecognition();
            this.recognition.lang = 'en-US';
            this.recognition.interimResults = false;
            this.recognition.maxAlternatives = 1;

            this.recognition.onresult = (event) => {
                const transcript = event.results[0][0].transcript;
                this.prompt = transcript;
                this.search();
            };
            this.recognition.onend = () => {
                this.recognizing = false;
                this.isLoading = false;
            };
            this.recognition.onerror = () => {
                this.recognizing = false;
                this.isLoading = false;
            };
        }
    }

    get noResults() {
        return !this.isLoading && this.rows && this.rows.length === 0 && this.prompt;
    }

    get micIcon() {
        return this.recognizing ? 'utility:stop' : 'utility:mic';
    }

    get micLabel() {
        return this.recognizing ? 'Stop' : 'Speak';
    }

    get micVariant() {
        return this.recognizing ? 'destructive' : 'neutral';
    }

    handlePromptChange(event) {
        this.prompt = event.target.value;
    }

    toggleMic() {
        if (!this.recognition) {
            // eslint-disable-next-line no-alert
            alert('Speech recognition not supported in this browser.');
            return;
        }
        if (this.recognizing) {
            this.recognition.stop();
            this.recognizing = false;
            this.isLoading = false;
        } else {
            this.isLoading = true;
            this.recognizing = true;
            this.recognition.start();
        }
    }

    async search() {
        if (!this.recordId) {
            // eslint-disable-next-line no-console
            console.warn('No recordId provided. Place this component on an Account record page.');
            return;
        }
        this.isLoading = true;
        try {
            const data = await searchContactsForAccount({ prompt: this.prompt, accountId: this.recordId });
            this.rows = data;
        } catch (e) {
            // eslint-disable-next-line no-console
            console.error('Voice contact lookup failed', e);
            this.rows = [];
        } finally {
            this.isLoading = false;
        }
    }
}



