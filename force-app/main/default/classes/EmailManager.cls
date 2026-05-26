public with sharing class EmailManager 
{

    public static void sendMail(String address,String subject, String body)
    {
        List<Messaging.Email>EmailList=new List<Messaging.Email>();
        Messaging.SingleEmailMessage mail=new Messaging.SingleEmailMessage();
        String[] toAddress=new String[]{address};
        mail.setToAddresses(toAddress);
        //mail.setToAddress(String[]{address})++

        
        mail.setSubject(subject);
        mail.setHtmlBody(body);
        EmailList.add(mail);

        System.debug('User Email:-'+toAddress+'Subject:'+subject+' body:'+body);
        System.debug('Email List:'+EmailList);
        try
        {
           Messaging.sendEmail(EmailList);
        }
        catch (EmailException exp)
        {
            System.debug('Error Message:'+exp.getMessage());
        }
    }
}