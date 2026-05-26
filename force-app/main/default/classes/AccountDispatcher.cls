public with sharing class AccountDispatcher 
{
    
public static void accDispatcher(System.TriggerOperation tOperation)
{ 
    switch on tOperation {
        when AFTER_INSERT
         {
            CreateContact.createCn(trigger.new);
        }
        
    }
}    
}