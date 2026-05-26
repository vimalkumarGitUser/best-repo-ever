public with sharing class autoUpdatetoAccount
 {
    
    public static void updateAcc(List<Audit__c>newList)
    {

        Set<Id>accid=new Set<Id>();
        for(Audit__c adt:newList)
        {
            if(adt.Account__c!=null && adt.Contact__c!=null)
            {
                accid.add(adt.Account__c);
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
           System.debug('Average:'+avgSalary18);

          
            
      ///// calacualte average salary of age 26 to 35
        List<AggregateResult>avgList1=[select accountid,avg(Salary__c)avgSal from Contact where accountid in:accid 
                                 And (Age__c>=26 And Age__c<=35) group by accountid];
        for(AggregateResult ar:avgList1)
          {
             avgSalary26.put((Id)ar.get('accountid'),(Decimal) ar.get('avgSal'));
           }
           System.debug('average salary of age 26 to 35:'+avgSalary26);

           
      ///// calacualte average salary of age 36 to 50

       List<AggregateResult>avgList2=[select accountid,avg(Salary__c)avgSal from Contact where accountid in:accid 
                                 And (Age__c>=36 And Age__c<=50) group by accountid];
        for(AggregateResult ar:avgList2)
          {
             avgSalary36.put((Id)ar.get('accountid'),(Decimal) ar.get('avgSal'));
           }
           System.debug('Average:'+avgSalary36);
 

           List<Account>accUpdate=new List<Account>();

           for(Audit__c adt:newList)
        { 
          
           
           // Decimal sal36=avgSalary36.get(adt.Account__c);
           Decimal Salary18;
           Decimal Salary26;
           Decimal Salary36;
            if(avgSalary18.containsKey(adt.Account__c))
            {
                 Decimal sal18=avgSalary18.get(adt.Account__c);
                 Salary18=sal18!=null?sal18:0;
            }
             if(avgSalary26.containsKey(adt.Account__c))
            {
                 Decimal sal26=avgSalary26.get(adt.Account__c);
                 Salary26=sal26!=null?sal26:0;
            }
             if(avgSalary36.containsKey(adt.Account__c))
            {
                 Decimal sal36=avgSalary36.get(adt.Account__c);
                 Salary36=sal36!=null?sal36:0;
            }

              Account acc=new Account(
                    id=adt.Account__c,
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
}