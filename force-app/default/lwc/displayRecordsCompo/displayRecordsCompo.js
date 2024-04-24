import { LightningElement} from 'lwc';
import searchApplicantDateRecords from '@salesforce/apex/ApplicantProvider.searchApplicantDateRecords';

export default class ApplicantTableDateRangeComp extends LightningElement {
    agentName;
     fromDate;
     toDate;
 appList;
showPopupModalFlag = false;
showTableFlag = false;

     searchApplicantHandler(event){ 
       this.showTableFlag = false;
        this.showPopupModalFlag = false;
        this.showPopupModalFlag = event.detail;    
        this.fromDate = this.template.querySelector('lightning-input[data-formfield="fromDate"]').value;
        this.toDate = this.template.querySelector('lightning-input[data-formfield="toDate"]').value;
        console.log('Yes, calling on Blur');
        console.log("From Date = "+this.fromDate + ', To Date = '+this.toDate);
       

        searchApplicantDateRecords({fromDateParam : this.fromDate  , toDateParam : this.toDate})
        .then(result=>{
                console.log('Result = '+JSON.stringify(result));
                this.appList = result;
                console.table('appList' +this.appList);
           
                this.showPopupModalFlag = true;
                this.showTableFlag = true;
        })
        .catch(error=>{
            console.log("Error "+JSON.stringify(error));
            this.showPopupModalFlag = false;
           this.showTableFlag = false;
        })
    }
}