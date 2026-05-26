public with sharing class OppDateUpdate 
{
    public static void updateDate(List<Opportunity>newList,Map<Id,Opportunity>oldMap)
    {
        set<Id>oppId=new set<Id>();
        for(Opportunity Opp:newList)
        {
            Opportunity newOP=oldMap.get(Opp.Id);
            if(Opp.StageName!=newOP.StageName && Opp.StageName=='Closed Won')
            {
                Opp.Activation_Date__c=System.Today();
                oppId.add(Opp.Id);
            }
        }
        if(oppId.isEmpty())
        return;

         
        List<OpportunityLineItem> addOitem=new List<OpportunityLineItem>();
       for(OpportunityLineItem oItem:[select id,OpportunityId,Tenure__c,Due_Date__c from OpportunityLineItem
                                      where OpportunityId in:oppId])
        {
            Date D;
            if(oItem.Tenure__c=='3 Months(90 Days)')
                {
                     D=System.Today()+90;
                }
            else if(oItem.Tenure__c=='6 Months(180 Days)')
            {
                D=System.Today()+180;
            }
             else if(oItem.Tenure__c=='12 Months(365 Days)')
            {
                D=System.Today()+365;
            }
            OpportunityLineItem op=new OpportunityLineItem(
              id=oItem.Id,
              Due_Date__c=D

            );
            addOitem.add(op);

        }   
        
        
         try
            {
            if(!addOitem.isEmpty())
             update  addOitem;
             }
            catch (DmlException exp)
            {
            System.debug('Exception:'+exp.getMessage());
             }
    }     
}