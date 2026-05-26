public with sharing class CaseDateUpdate {
    
    public static void cDateUpdate(List<Case>newList,Map<Id,Case>oldList)
    {
        for(case cs:newList)
        {
            System.debug('before batch update');
            Case oldCase=oldList.get(cs.id);
            if(cs.Status!=oldCase.Status && cs.Status=='Escalated')
            {
                cs.Modified_Date__c=System.Today();
                cs.Auto_Closed__c=false;
                System.debug('condition not match');
            }
    }
}
}