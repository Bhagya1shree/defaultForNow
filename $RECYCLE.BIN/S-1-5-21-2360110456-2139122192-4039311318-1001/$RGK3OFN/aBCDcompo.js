import { LightningElement, track } from 'lwc';
import sendMailWithOtp from '@salesforce/apex/userController.sendMailWithOtp';
import generateOTP from '@salesforce/apex/userController.generateOTP';
import sendEmailWithOtpTwice from '@salesforce/apex/userController.sendEmailWithOtpTwice'


export default class VerifyEmailForm extends LightningElement {
    @track fName;
    @track lName;
    @track email;
    @track otp;
    @track message;

    salutationsList = [
        { label: 'Mr.', value: 'Mr.' },
        { label: 'Ms.', value: 'Ms.' },
        { label: 'Mrs.', value: 'Mrs.' },
        { label: 'Dr.', value: 'Dr.' },
        { label: 'Prof.', value: 'Prof.' },
    ];

    get salutationOptions() {
        return this.salutationsList;
    }

    handleEmailChange(event) {
        this.email = event.target.value;
        console.log('Email:', this.email); // Log email value
    }

    handleNameChange(event) {
        // Retrieve the first and last name from the event
        this.fName = event.detail.firstName;
        this.lName = event.detail.lastName;
        console.log('First Name:', this.fName); // Log first name value
        console.log('Last Name:', this.lName); // Log last name value
    }

    handleVerifyEmail() {
        // Check if email is provided
        if (!this.email) {
            this.message = 'Please enter an email address';
            return;
        }
        console.log('Email:', this.email); // Log email value before calling Apex

        createNewAccount({ objAcc : this.fName})
        .then(result=>{
            console.log('New Account has been created...!!!!');
        })
        .catch(error=>{
            console.log('Locha, something went wrong..!!');
        });


        // Call Apex method to send email with OTP
        sendMailWithOtp({ email: this.email })
            .then(result => {
                this.otp = result.otp;
                this.message = result.message;
                console.log('Generated OTP:', this.otp); // Log generated OTP
                console.log('Message:', this.message); // Log message
            })
            .catch(error => {
                this.message = error.body.message;
                console.error('Error:', error); // Log error if any
            });
    }

   // handleOtpChange(event) {
        //this.otp = event.target.value;
        //console.log('OTP:', this.otp); // Log OTP value
    //}
}
