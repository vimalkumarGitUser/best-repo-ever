public with sharing class CaseAutoCloseBatch implements Database.Batchable<sObject>  {
    public Database.QueryLocator start(Database.BatchableContext BC)
    {  
         String str='Escalated';
         // Date firstM=System.today().addDays(-15);
        Date firstM=System.Today();
        return DataBase.getQueryLocator('select id,Status,Modified_Date__c,Auto_Closed__c from case where status=:str AND Modified_Date__c=:firstM');
    }
    public void execute(Database.BatchableContext BC,List<Case>caseList)
    {
      
          Date firstM=System.today();
      
          List<Case>caseUpdate=new List<Case>();  
         List<FeedItem>FeedUpdate=new List<FeedItem>();
          for(Case cs:caseList)  
          {
              System.debug('underfor loop');
           
              if(cs.Status=='Escalated' && cs.Modified_Date__c==firstM )   
              {
                  case newCase=new case();
                  newCase.Status='Closed';
                  newCase.Auto_Closed__c=true;
                  newCase.Id=cs.id;
                 
                caseUpdate.add(newCase);
               
                  FeedItem FItem=new FeedItem();
                  FItem.ParentId=cs.Id;
                  FItem.Body='"Case auto-closed due to inactivity..."';
                
                FeedUpdate.add(FItem);  
              }
          }
            
          if(!caseUpdate.isEmpty())
          {
          update caseUpdate;
         
          }
        if(!FeedUpdate.isEmpty())
          {
          Insert FeedUpdate;
            
          } 

    }    
    public void finish(Database.BatchableContext BC)
    {
        String address='vimalkumar997788@gmail.com';
        String Body='3 days to rimaing to close Case:';
         EmailManager.sendMail(address,'Alert Case Close',Body);      
    }

}