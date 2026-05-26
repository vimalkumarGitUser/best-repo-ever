public with sharing class CaseModifiedDateUpdate {
   public static void ModifiedDateUpdate(List<Case>newList,Map<Id,Case>oldMap){
         for(case cs:newList)
        {
            Case oldCase=oldMap.get(cs.id);
            if(cs.Status!=oldCase.Status && cs.Status=='Escalated')
            {
                 cs.Modified_Date__c=System.Today();
            }
        }

   }
}