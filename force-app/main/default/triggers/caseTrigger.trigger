trigger caseTrigger on Case (before insert,before Update)
{
    CaseTriggerDispatcher.Dispatch(Trigger.OperationType);  
}