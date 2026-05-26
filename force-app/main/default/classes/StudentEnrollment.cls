public with sharing class StudentEnrollment {
    
    
    
    public static void beforeInsertRecord(List<Enrollment__c>newList)
    {
        
        
        Set<Id> studentIds = new Set<Id>();
        Set<Id> courseIds = new Set<Id>();
        for(Enrollment__c enList : newList){
            if(enList.Course__c != null && enList.Student__c!=null){
                studentIds.add(enList.Student__c);
                courseIds.add(enList.Course__c);
            }
        }
        Map<String, Enrollment__c> enrollMap = new Map<String, Enrollment__c>();
        for(Enrollment__c Enroll : [select Id, Course__c, Student__c from Enrollment__c where Student__c in:studentIds and Course__c in:courseIds]){
            String temp = Enroll.Student__c + '_' + Enroll.Course__c;
            enrollMap.put(temp, Enroll);
        }
        
        for(Enrollment__C enList:newList)
        {
            Integer EnDuration=Integer.valueOf(enList.Enrollment_Duration__c)!=null?Integer.valueOf(enList.Enrollment_Duration__c):0;
            if(EnDuration>0)
            {
                Date calculateEndDate=enList.Enrollment_Date__c!=null?enList.Enrollment_Date__c.addMonths(EnDuration):null;
                enList.Enrollment_End_Date__c=calculateEndDate;
            }
            
            
            
            String temp = enList.Student__c + '_' + enList.Course__c;
            if(enrollMap.containsKey(temp)){
                enList.addError('"This student is already enrolled in this course."');
            }
        }
    }
    
    public static void beforeUpdateRecord(List<Enrollment__c>newList,Map<Id,Enrollment__c>oldMap)
    {
       
        Set<Id> studentIds = new Set<Id>();
        Set<Id> courseIds = new Set<Id>();
        for(Enrollment__c enList : newList){
            Enrollment__c oldList=oldMap.get(enList.Id);
            if(enList.Course__c != null && enList.Student__c!=null && enList.Student__c !=oldList.Student__c || enList.Course__c !=oldList.Course__c ){
                studentIds.add(enList.Student__c);
                courseIds.add(enList.Course__c);
            }
        }
        Map<String, Enrollment__c> enrollMap = new Map<String, Enrollment__c>();
        for(Enrollment__c Enroll : [select Id, Course__c, Student__c from Enrollment__c where Student__c in:studentIds and Course__c in:courseIds]){
            String temp = Enroll.Student__c + '_' + Enroll.Course__c;
            enrollMap.put(temp, Enroll);
        }
        
        for(Enrollment__C enList:newList)
        {
            Integer EnDuration=Integer.valueOf(enList.Enrollment_Duration__c)!=null?Integer.valueOf(enList.Enrollment_Duration__c):0;
            if(EnDuration>0)
            {
                Date calculateEndDate=enList.Enrollment_Date__c!=null?enList.Enrollment_Date__c.addMonths(EnDuration):null;
                enList.Enrollment_End_Date__c=calculateEndDate;
            }
            
            
            
            String temp = enList.Student__c + '_' + enList.Course__c;
            if(enrollMap.containsKey(temp)){
                enList.addError('"This student is already enrolled in this course."');
            }
        }
    }
    
    public static void afterInsertRecord(List<Enrollment__c>newList)
    {
        set<Id>courseId=new set<Id>();
        for(Enrollment__C enList:newList)
        {
            if(enList.Course__c!=null)
                courseId.add(enList.Course__c);
        }
        
        if(courseId.isEmpty())
            return;
        
        Map<Id,Integer>countStudent=new Map<Id,Integer>();
        for(AggregateResult ar:[select Course__c, count(Id)tStudent from Enrollment__c where Course__c in:courseId group by Course__c])
        {
            countStudent.put((Id)ar.get('Course__c'),(Integer)ar.get('tStudent'));
        }
        
        List<Course__c>updateCourse=new List<Course__c>();
       
        for(Id cId : courseId){
            Course__c newCourse = new Course__c(
                Id = cId,
                Number_of_Student__c = countStudent.get(cId)
            );
            updateCourse.add(newCourse);
        
        }
        
        try{
            if(!updateCourse.isEmpty())
            {
                update updateCourse;
            }
        }catch(DmlException exp){
            System.debug('Error Message:'+exp.getMessage());
        }
    }
     public static void afterUpdateRecord(List<Enrollment__c>newList,Map<Id,Enrollment__c>oldMap)
    {
        set<Id>courseId=new set<Id>();
        for(Enrollment__C enList:newList)
        {
               Enrollment__c oldList=oldMap.get(enList.Id);
            if(enList.Course__c!=null && enList.Course__c!=oldList.Course__c )
                courseId.add(enList.Course__c);
                courseId.add(oldList.Course__c);
        }
        
        if(courseId.isEmpty())
            return;
        
        Map<Id,Integer>countStudent=new Map<Id,Integer>();
        for(AggregateResult ar:[select Course__c, count(Id)tStudent from Enrollment__c where Course__c in:courseId group by Course__c])
        {
            countStudent.put((Id)ar.get('Course__c'),(Integer)ar.get('tStudent'));
        }
        
        List<Course__c>updateCourse=new List<Course__c>();

        for(Id cId : courseId){
            Course__c newCourse = new Course__c(
                Id = cId,
                Number_of_Student__c = countStudent.get(cId)
            );
            updateCourse.add(newCourse);
        }
           
        
        try{
            if(!updateCourse.isEmpty())
            {
                update updateCourse;
            }
        }catch(DmlException exp){
            System.debug('Error Message:'+exp.getMessage());
        }
    }

    
}