trigger HelloAudit on Audit__c (After insert ,After Update,After delete)
 {

    // if(trigger.isAfter && (trigger.isInsert || trigger.isUpdate || trigger.isUndelete))
    // {
    //     autoUpdatetoAccount.updateAcc(trigger.new);
    // }
    // else if(trigger.isAfter && trigger.isDelete)
    // {
    //     autoUpdatetoAccount.updateAcc(trigger.old);
    // }
}