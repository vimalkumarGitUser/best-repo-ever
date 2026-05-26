@istest
public with sharing class TemConverter {

    @istest
   public static void testTemprature()
 {
    Decimal cel=TemTest.Tempraturetest(70);
    System.assertEquals(21.11,cel);
 }    
}