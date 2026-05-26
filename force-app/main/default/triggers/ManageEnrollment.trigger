trigger ManageEnrollment on Enrollment__c (before insert ,before update,after insert,after update,after delete) {

    EnrollmentDispatcher.dispatch(trigger.operationType);

}