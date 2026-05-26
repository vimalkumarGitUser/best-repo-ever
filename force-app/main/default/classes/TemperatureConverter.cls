public with sharing class TemperatureConverter {
   
    public static decimal convertFahrenheitToCelsius(decimal fahrenheit) {

        Decimal cs=(fahrenheit-32)*5/9;
    
       return cs.setScale(2);

    }
}