public with sharing class contactQueueable implements system.Queueable
{
    public Integer noOfContacts;
    public list<Account>accountList;
    public contactQueueable(Integer numberOfContacts,List<Account>accountList) 
    {
        this.noOfContacts=numberOfContacts;
        this.accountList=accountList;
    }
    public void execute(System.QueueableContext Context)
    {
        System.debug('contacts Queueable Executed...');
        Integer no=this.noOfContacts;
    }
}