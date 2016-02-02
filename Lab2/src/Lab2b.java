import java.util.PriorityQueue;


public class Lab2b {
  public static double[] simplifyShape(double[] poly, int k)
  {
      // TODO


  }



  private static double getDistance(double x1,double y1,double x2,double y2){

    return Math.sqrt((Math.pow(x1-x2,2))+(Math.pow(y1-y2,2)));
  }

  private static double getPointValue(int index,double[] simpleArray){

    double l1 = getDistance(simpleArray[index],simpleArray[index+1], simpleArray[index-2], simpleArray[index-1]);
    double l2 = getDistance(simpleArray[index],simpleArray[index+1], simpleArray[index+2], simpleArray[index+3]);
    double l3 = getDistance(simpleArray[index-2],simpleArray[index-1], simpleArray[index+2], simpleArray[index+3]);

    double val = l1+l2-l3;

    return val;
  }
}
