/**
 * Created by nalex on 21/01/2016.
 */
public class MySqrt {

    //konstant för felmarginal
    final static double EPSILON = Math.pow(10,-6);


    public static double mySqrtLoop(double x, double epsilon){
        //Max respektive min värde av vårt intervall
        double max = 0;
        double min = 0;

        //representerar mitten av intervallet
        double mitt = 0;

        //initiering av min,max i intervallet
        if(x < 0){
            return Double.NaN;
        }else if( x < 1){
            max = 1;
            min = x;
        }else if(x >= 1){
            max = x;
            min = 1;
        }
        //initiering av mitt
        mitt = (min + max)/2;


        while(Math.abs((Math.pow(mitt,2)-x)) > epsilon){
            //Testar om vi ska flytta intervallet uppåt eller neråt
            if(Math.pow(mitt,2) > x){
                max = mitt;
            }else{
                min = mitt;
            }
            mitt = (min+max)/2;
        }

        return mitt;
    }

    public static double mySqrtRecurse(double x, double epsilon){

        //Kollar först om x negativt, annars initieras rekursionens intervall utifrån om x är störra/mindre än 1.
        if(x < 0){
            return Double.NaN;
        }else if( x < 1){
            return sqrtRecursive(x, epsilon, x, 1);
        }else{
            return sqrtRecursive(x, epsilon, 1, x);
        }
    }

    public static double sqrtRecursive(double x, double epsilon, double min, double max){
        double mitt = (min+max)/2;

        //Kollar vårt basfall, om det approximerade talet är inom felmarginalen.
        if(Math.abs((Math.pow(mitt,2)-x)) < epsilon){
            return mitt;
        }
        //Annars flyttas intervallets gränser med binärt val.
        if(Math.pow(mitt, 2) > x){
            return sqrtRecursive(x, epsilon, min, mitt);
        }else{
            return sqrtRecursive(x, epsilon, mitt, max);
        }

    }

    public static void main(String args[]){

        System.out.println("---Test av mySqrtLoop---");
        System.out.println("Test with negative number, Expected result = NaN");
        System.out.println("Test result = " + mySqrtLoop(-1, EPSILON));
        System.out.println();

        System.out.println("Test with 1, Expected result = 1");
        System.out.println("Test result = " + mySqrtLoop(1, EPSILON));
        System.out.println();

        System.out.println("Test with 0, Expected result = 0");
        System.out.println("Test result = " + mySqrtLoop(0, EPSILON));
        System.out.println();

        System.out.println("Test with 4, Expected result = 2");
        System.out.println("Test result = " + mySqrtLoop(4, EPSILON));
        System.out.println();

        System.out.println("Test with 0.5, Expected result = 0.7");
        System.out.println("Test result = " + mySqrtLoop(0.5, EPSILON));
        System.out.println();

        System.out.println("---Test av mySqrtRecursive---");
        System.out.println("Test with negative number, Expected result = NaN");
        System.out.println("Test result = " + mySqrtRecurse(-1, EPSILON));
        System.out.println();

        System.out.println("Test with 1, Expected result = 1");
        System.out.println("Test result = " + mySqrtRecurse(1, EPSILON));
        System.out.println();

        System.out.println("Test with 0, Expected result = 0");
        System.out.println("Test result = " + mySqrtRecurse(0, EPSILON));
        System.out.println();

        System.out.println("Test with 4, Expected result = 2");
        System.out.println("Test result = " + mySqrtRecurse(4, EPSILON));
        System.out.println();

        System.out.println("Test with 0.5, Expected result = 0.7");
        System.out.println("Test result = " + mySqrtRecurse(0.5, EPSILON));
        System.out.println();

    }
}
