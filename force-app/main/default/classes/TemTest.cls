public with sharing class TemTest {
    public static decimal Tempraturetest(Decimal fh) 
    {
        Decimal cel=(fh-32)*5/9;
        return cel.setScale(2);
    }
   
}