trigger AccountTrigger on Account (After insert) 
{
       AccountDispatcher.accDispatcher(trigger.operationType);
}