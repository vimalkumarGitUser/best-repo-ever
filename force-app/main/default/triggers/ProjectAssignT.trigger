trigger ProjectAssignT on Project_Assignment__c (After insert,After update)
 {
        ProjectAssignmentDispatcher.Dispatch(Trigger.OperationType);
}