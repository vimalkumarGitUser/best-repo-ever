public with sharing class UpdateAccountData 
{
    public static void upAccount(List<Contact>newList)
    {
        Set<Id>accid=new Set<Id>();
        for(Contact adt:newList)
        {
            if(adt.AccountId!=null)
            {
                accid.add(adt.AccountId);
            }
        }
         if(accid.isEmpty())
        return;

        
        Map<Id,Decimal>avgSalary18=new Map<Id,Decimal>();
        Map<Id,Decimal>avgSalary26=new Map<Id,Decimal>();
        Map<Id,Decimal>avgSalary36=new Map<Id,Decimal>();
        ///// calacualte average salary of age 18 to 25
        List<AggregateResult>avgList=[select accountid,avg(Salary__c)avgSal from Contact where accountid in:accid 
                                 And (Age__c>=18 And Age__c<=25) group by accountid];
        for(AggregateResult ar:avgList)
          {
             avgSalary18.put((Id)ar.get('accountid'),(Decimal) ar.get('avgSal'));
           }
           System.debug('Average salary of age 18:'+avgSalary18);

           ///// calacualte average salary of age 26 to 35
        List<AggregateResult>avgList1=[select accountid,avg(Salary__c)avgSal from Contact where accountid in:accid 
                                 And (Age__c>=26 And Age__c<=35) group by accountid];
        for(AggregateResult ar:avgList1)
          {
             avgSalary26.put((Id)ar.get('accountid'),(Decimal) ar.get('avgSal'));
           }
           System.debug('average salary of age 26 to 35:'+avgSalary26);

           List<AggregateResult>avgList2=[select accountid,avg(Salary__c)avgSal from Contact where accountid in:accid 
                                 And (Age__c>=36 And Age__c<=50) group by accountid];
        for(AggregateResult ar:avgList2)
          {
             avgSalary36.put((Id)ar.get('accountid'),(Decimal) ar.get('avgSal'));
           }
           System.debug('Average:'+avgSalary36);
 

           List<Account>accUpdate=new List<Account>();
          
           for(Contact adt:newList)
        { 
          
           
           // Decimal sal36=avgSalary36.get(adt.Account__c);
           Decimal Salary18;
           Decimal Salary26;
           Decimal Salary36;
            if(avgSalary18.containsKey(adt.AccountId))
            {
                 Decimal sal18=avgSalary18.get(adt.AccountId);
                 Salary18=sal18!=null?sal18:0;
            }
             if(avgSalary26.containsKey(adt.AccountId))
            {
                 Decimal sal26=avgSalary26.get(adt.AccountId);
                 Salary26=sal26!=null?sal26:0;
            }
             if(avgSalary36.containsKey(adt.AccountId))
            {
                 Decimal sal36=avgSalary36.get(adt.AccountId);
                 Salary36=sal36!=null?sal36:0;
            }

              Account acc=new Account(
                   id=adt.AccountId,
                    Average_Salary_for_Age_18_to_25_Years__c=Salary18,
                    Average_Salary_for_Age_26_to_35_Years__c=Salary26,
                    Average_Salary_for_Age_36_to_50_Years__c=Salary36
                 );
                 accUpdate.add(acc);
        }

        try
        {
            if(!accUpdate.isEmpty())
            update accUpdate;
        }
        catch(DmlException exp)
        {
            System.debug('Get Error'+exp.getMessage());
        }


    }   
    
    public static void sendMailMessage(List<Contact>newList)
    {
      Integer count=newList.size();
      for(Contact cn:newList)
      {
        String emailAddress = UserInfo.getUserEmail();
        String body=String.valueof(count)+'Contacts Created Successfully';
        EmailManager.sendMail(emailAddress,'New Contact Created',body);
      }
    }
    

}