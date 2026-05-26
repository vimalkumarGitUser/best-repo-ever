public with sharing class AccountBatchClass implements Database.Batchable<sObject>
{
    public Database.QueryLocator start(Database.BatchableContext BC)
    {
        String rating='Hot';
        return Database.getQueryLocator('select id,phone,name from account');
    }
    public void execute(Database.BatchableContext BC,List<Account>accList)
    {
        List<Account>newList= accList;
        Integer n=1;
        for(Account acc:accList)
        {
            acc.Phone='009'+String.valueOf(n);
            n++;

        }
        update accList;
    }
    public void finish(Database.BatchableContext BC)
    {
         
    }
}