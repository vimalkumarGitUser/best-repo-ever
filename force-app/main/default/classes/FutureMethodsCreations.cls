public with sharing class FutureMethodsCreations 
{
    @future
     public static void fMethod()
     {
        System.debug('This is from future method');
     } 
     @future
     public static void fMethod1()
     {
        System.debug('this is from another future method...');
     }  
}