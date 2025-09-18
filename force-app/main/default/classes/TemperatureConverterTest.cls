@isTest
public class TemperatureConverterTest {
    @isTest
    static void testWarmTemp(){
        Decimal celcius = TemperatureConverter.fahrenheitToCelcius(70);
        system.assertEquals(21.11,celcius);
    }
    
    @isTest
    static void testFreezingPoint(){
        Decimal celcius = TemperatureConverter.fahrenheitToCelcius(32);
        system.assertEquals(0,celcius);
    }
    
    @isTest
    static void testBoilingPoint(){
        Decimal celcius = TemperatureConverter.fahrenheitToCelcius(212);
        system.assertEquals(100,celcius,'boiling point temperature is not expected');
    }
    
    @isTest
    static void testNegativeTemp(){
        Decimal celcius = TemperatureConverter.fahrenheitToCelcius(-10);
        system.assertEquals(-23.33,celcius);
    }

}