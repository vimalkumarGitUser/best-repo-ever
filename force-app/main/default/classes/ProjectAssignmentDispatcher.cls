public with sharing class ProjectAssignmentDispatcher
 {
     public static void Dispatch(System.TriggerOperation OpType)
     {
        switch on OpType {
            when  AFTER_INSERT
            {
                
                 ProjectAssignmenHandler.CalculateHour(trigger.new);
            }
            when  AFTER_UPDATE
            {
                ProjectAssignmenHandler.CalculateHour(trigger.new);
            }
     }
    }
}