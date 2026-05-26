// Resolve mixed DML Error
public with sharing class FutureMethodTest 
{
  
    public static void CreateAccount()
    {
        Account acc=new Account();
        acc.name='Raman';
        acc.Description='Account from the future method test';
        insert acc;
        createUser();
    }
    @future
   public static void createUser()
   {
      Profile p=[select id from profile where name='Minimum Access - Salesforce'];
      UserRole r=[select id from UserRole where name='Manager'];
       User u = new User(
            alias = 'WDocs', 
            email='vimal@hicglobalsolutions.com', 
            emailencodingkey='UTF-8',
            FirstName='William',
            lastname='Docs', 
            languagelocalekey='en_US', 
            localesidkey='en_US', profileid = p.Id, userroleid = r.Id,
            timezonesidkey='America/Los_Angeles', 
            username='WilliamDocs123@hicglobalsolutions.com');
        insert u;

   }
    
}