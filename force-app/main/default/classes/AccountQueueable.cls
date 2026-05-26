public with sharing class AccountQueueable implements System.Queueable 
{
    public List<Account>accountList;
     public AccountQueueable(List<Account>accList)
     {
        this.accountList=accList;
     }

       

     public void execute(System.QueueableContext Context)
       {
        System.debug('Queueable executed...');
        System.debug('AccountList:'+accountList);
        FutureMethodsCreations.fMethod();
        FutureMethodsCreations.fMethod1();
        contactQueueable cn=new contactQueueable(10,accountList);
        Id cnJOb=System.enqueueJob(cn);
        System.debug('Contact Queable jobId:'+cnJOb);

       }

}