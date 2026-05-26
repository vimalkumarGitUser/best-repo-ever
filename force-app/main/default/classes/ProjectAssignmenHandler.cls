public with sharing class ProjectAssignmenHandler
 {
     public static void CalculateHour(List<Project_Assignment__c>newList)
     {
        Set<Id>proId=new set<Id>();
        for(Project_Assignment__c pA:newList)
        {
            if(pA.Project__C!=null)
            {
                proId.add(pA.Project__C);
            }
        }
        if(proId.isEmpty())
        return;
         Map<id,Decimal>totalHour=new Map<Id,Decimal>();
         List<Project__c>updateProject = new List<Project__C>();
         for(AggregateResult ar:[select Project__C,sum(Hour_Logged__c)HourLog from Project_Assignment__c where Project__C in:proId
                                    group by Project__C])
            {
                totalHour.put((Id)ar.get('Project__C'),(Decimal)ar.get('HourLog'));
                        
            }  
            
            for(Project_Assignment__c proAssign:newList)
            {

                 Decimal tHour=totalHour.get(proAssign.Project__C);
                //  Boolean overTime=false;
                if(totalHour.containsKey(proAssign.Project__C))
                {
                    
                     Decimal totalH=tHour!=null?tHour:0;
                    // if(totalH>40)
                    // {
                    //     overTime=true;
                    // }

                    Project__C pro=new Project__C(
                        id=proAssign.Project__C,
                        Total_Hour_Logged__c=totalH
                       // Over_Time__c=overTime
                    );

                    updateProject.add(pro);
                }
            }

            try
            {
                if(!updateProject.isEmpty())
                {
                    update updateProject;
                }

            }
            catch(DmlException exp)
            {
                System.debug('Get Error:'+exp.getMessage());
            }
         
     }
}