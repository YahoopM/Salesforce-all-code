public class Calculation {
    public static void add(){
        decimal var1 = 13 , var2 = 17 , sum ;
        sum = var1 + var2;
        system.debug('The Addition is ' + sum);
    }
    
    
    public static void Subtract(){
        decimal var1 = 17 , var2 = 13 , sub ;
        sub = var1 - var2;
        system.debug('The Subtraction is ' + sub);
    }
    
    
    public static void Mult(decimal Var1 , decimal Var2){
        decimal mul ;
        mul = var1 * var2;
        system.debug('The Multiplication is ' + mul);
    }

}