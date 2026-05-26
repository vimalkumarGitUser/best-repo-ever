@isTest
public with sharing class AccountTriggerTest 
{
     @isTest
    public static void testAccount()  
    {
        Account acc=new Account();
        acc.name='Danny';
        acc.Description='Account created by test class';
           
         test.startTest();
         insert acc;
         test.stopTest();
          
        // List<Account>accLen=[select id,name from account limit 1];
        // Integer len=accLen.size();

        // List<Contact>cnCreate=[select id,name from contact limit 1];

        // Assert.areEqual(len,cnCreate.size(),'contact is not created....');
    
    }
}