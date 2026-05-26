trigger HelloOpportunity on Opportunity (before update)
{
   OppDateUpdate.updateDate(trigger.new,trigger.oldMap);
}