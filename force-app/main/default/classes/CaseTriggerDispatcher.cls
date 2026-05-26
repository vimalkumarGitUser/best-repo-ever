public class CaseTriggerDispatcher {
     public static void Dispatch(System.TriggerOperation OperationType)
    {
        switch on OperationType{
            when BEFORE_UPDATE
            {   
                System.debug('Hello');
                CaseDateUpdate.cDateUpdate((List<Case>)Trigger.New,(Map<Id,Case>)Trigger.oldMap);
            }
            when else
            {
                
            }
        }
        
         
}

}