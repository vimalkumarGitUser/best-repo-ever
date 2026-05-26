trigger HelloContact on Contact (After insert,After update,after delete ,after undelete)
 {
     if(trigger.isAfter && (trigger.isInsert || trigger.isUpdate || trigger.isUndelete))
    {
         UpdateAccountData.upAccount(trigger.new);
         UpdateAccountData.sendMailMessage(trigger.new);

    }
    else if(trigger.isAfter && trigger.isDelete)
    {
        UpdateAccountData.upAccount(trigger.old);
    }
}