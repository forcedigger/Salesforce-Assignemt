import { LightningElement, wire, track, api } from 'lwc';
import getAccountlist from '@salesforce/apex/AccountDataController.getAccounts'
import getAccountDetail from '@salesforce/apex/AccountDataController.getAccountDetail'

/*
* ASSUMPTIONS: Only Single account is allowed to select
               Only 5 accounts where shown per required.

*/

export default class LwcAccountView extends LightningElement {
    columns = [
        { label: 'Id', fieldName: 'Id' },
        { label: 'Name', fieldName: 'Name' }
    ];
    @track accountList; //all accounts returned from apex method
    @track selectedAccountId; // user selected account Id
    @track showlist = true; // if true,  show account list table
    @track showDetail = false; // if true, show account detail after account Id is selected
    @track isLoading = false; // if true, show spinning/loading icon
    account; //hold current account detail
    error; //hold any error received during apex call

    //Wire method to load accounts on load
    @wire (getAccountlist) wiredAccounts({data,error}){
         if (data) {
              this.accountList = data;
              this.error = undefined
              console.log('1:  '+data); 
         } else if (error) {
             this.error = error
            console.log(error);
         }
    }

    //handler for selecting single account from databale
    getSelectedAccountId(event) {
        const selectedRows = event.detail.selectedRows;
        // Display that fieldName of the selected rows
        for (let i = 0; i < selectedRows.length; i++) {
            console.log('You selected: ' + selectedRows[i].Id);
            this.selectedAccountId = selectedRows[i].Id;//always single account
        }
    }

    //Next button handler, calls apex method to get account detail
    handleNext(event) {
        
        this.isLoading = true;
        console.log(this.selectedAccountId + '' + this.showDetail);

        //call apex method with selected account Id 
        getAccountDetail({ accId: this.selectedAccountId  })
		.then(result => {
			this.account = result;
            this.error = undefined;
            //set UI booleans
            this.isLoading = false;
            this.showlist = false;
            this.showDetail = true;
		})
		.catch(error => {
			this.error = error;
            console.log(this.error );
			this.accounts = undefined;
            this.isLoading = false;
		})

        
    }

    handleBack(event) {
        this.showlist = true;
        this.showDetail = false;
        this.selectedAccountId = '';
        this.accounts = undefined;
    }
}