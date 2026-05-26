@isTest
public with sharing class ContactTriggerTest
{
    @testSetup
    public static void setUpMethod()
    {
       Contact cn=new Contact();
       cn.LastName='test123';
       cn.AccountId='001f600000Il05RAAR';
       cn.Age__c=25;
       cn.Salary__c=24000;
       insert cn;  
    }
     
    @isTest
    public static void updateAn()
    {
      Contact cnn=[select id ,accountid,Age__c,Salary__c from contact where name='test123'];
      cnn.Age__C=29;
      cnn.Salary__c=30000;
      update cnn;
       Contact cnn1=[select id ,accountid,Age__c,Salary__c from contact where name='test123'];
        cnn1.Age__C=40;
        cnn1.Salary__c=34000;
      update cnn1;
      delete cnn1;

    }

//     @isTest
//   public static void updateAnNeg()
//     {
//       Account acc=[select id,name from account where name='Anderson'];
//       //acc.Name=' ';
//       update acc;
         

//     }


 
}