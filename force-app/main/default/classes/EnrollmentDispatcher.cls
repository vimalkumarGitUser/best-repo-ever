public with sharing class EnrollmentDispatcher {
    public static void dispatch(System.TriggerOperation tOperation)
    {
         switch on tOperation {
        when BEFORE_INSERT
         {
             StudentEnrollment.beforeInsertRecord(trigger.new);
              
         }
         when BEFORE_UPDATE
         {
             StudentEnrollment.beforeUpdateRecord((List<Enrollment__c>)trigger.new,(map<id,Enrollment__c>)trigger.oldMap);
         }
         when AFTER_INSERT
         {
            StudentEnrollment.afterInsertRecord(trigger.new);
         }
         when AFTER_UPDATE
         {
             StudentEnrollment.afterUpdateRecord((List<Enrollment__c>)trigger.new,(map<id,Enrollment__c>)trigger.oldMap);
         }
        when AFTER_DELETE
        {
             StudentEnrollment.afterInsertRecord(trigger.old);
        }
    }
    }
}