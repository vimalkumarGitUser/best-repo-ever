public with sharing class CreateContact 
{
  public static void createCn(List<Account>newList)
  {
    
    List<Contact>con=new List<Contact>();
    for(Account acc:newList)
    {
        Contact con1=new Contact();
        con1.LastName=acc.Name;
        con1.AccountId=acc.Id;
        con.add(con1);
        
    }
    try
    {
        if(!con.isEmpty())
        insert con;
      
        
    }
    catch(DmlException exp)
    {
        System.debug('Get Erorr'+exp.getMessage());
    }
    
  }     
}