public with sharing class projectBatch implements Database.Batchable<SObject>,DataBase.stateful
{
        Integer sucessCases=0;
        Integer FailCases=0;

    public Database.QueryLocator start(Database.BatchableContext BC)
    {
        return Database.getQueryLocator('select id,Over_Time__c,Total_Hour_Logged__c from Project__C');
    }

    public void execute(Database.BatchableContext bc,List<Project__C>proList)
    {
        List<Project__C>pList=proList;
        for(Project__C pRecord:pList)
        {
            if(pRecord.Total_Hour_Logged__c>40)
            {
                pRecord.Over_Time__c=true;
            }
            else
            {
                pRecord.Over_Time__c=false;
            }
        }

       // update plist;
       List<DataBase.SaveResult>sResult=DataBase.Update(pList,false);
       for(DataBase.SaveResult saveResult:sResult)
       {
          if(saveResult.isSuccess())
          {
                sucessCases++;
          }
          else
          {
                FailCases++;
          }
       }
    }
    public void finish(Database.BatchableContext bc)
    {
           String emailAddress = UserInfo.getUserEmail();
        String body=String.valueof(sucessCases)+':Project Updated Successfully:'+String.valueOf(FailCases)+':Project Faild To Updated :';
        EmailManager.sendMail(emailAddress,'ProJect Update',body);
    }
}