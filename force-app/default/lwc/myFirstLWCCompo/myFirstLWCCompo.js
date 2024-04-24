import { LightningElement } from 'lwc';
export default class MyFirstLWCCompo extends LightningElement {
    name;
    firstName ='Lakhan';
    phone = 8788970637;
    salary = 70000.22
    flag = true
    todayDate = new Date();

    objAcc={ 'sObjectType' : 'Account'}
    applicantObject = {'sObjectType':'Applicant__c'}

    objContact ={
        'FirstName' : 'Munni',
        'LastName':'Modi',
        'Email':'munni@gmail.com'
    }
    objAddress ={
    'Country__c':'India',
    'State__c':'Maharashtra',
    'City__c':'Pune'
}
    empList =['Bunty', 'Babli', 'Samosa', 'Kachori'];
    display(){

    }
    myMethod(){
        
    }
}