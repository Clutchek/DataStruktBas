package Lab2;

public class Lab2a {
    public static double[] simplifyShape(double[] poly, int k) {
        double l1, l2, l3;
        double val;

        double[] simpleArray = poly.clone();

        //represents the lowestValue of a point in the array
        double lowestVal;
        //the index with lowestValue
        int index = 0;


        while ((simpleArray.length) / 2 > k) {

            //initialize lowestVal and index, end points should not be included in our calculations
            lowestVal = getPointValue(2, simpleArray);
            index = 2;

            //already used second node to initialize lowestVal so starting from third point. Excludes last point as well.
            for (int i = 4; i < simpleArray.length - 2; i = i + 2) {

                val = getPointValue(i, simpleArray);

                if (val <= lowestVal) {
                    lowestVal = val;
                    index = i;
                }
            }
            //remove the point with lowest value from the array
            double[] tempArray = new double[simpleArray.length - 2];
            for (int i = 0; i < tempArray.length; i++) {
                if (i >= index) {
                    tempArray[i] = simpleArray[i + 2];
                } else {
                    tempArray[i] = simpleArray[i];
                }
            }
            simpleArray = tempArray;

        }

        return simpleArray;

    }

    private static double getDistance(double x1, double y1, double x2, double y2) {
        //Pythagorean theorem to get distance between coordinates
        return Math.sqrt((Math.pow(x1 - x2, 2)) + (Math.pow(y1 - y2, 2)));
    }

    private static double getPointValue(int index, double[] simpleArray) {
        //using the given formula to calculate a points comparative value
        double l1 = getDistance(simpleArray[index], simpleArray[index + 1], simpleArray[index - 2], simpleArray[index - 1]);
        double l2 = getDistance(simpleArray[index], simpleArray[index + 1], simpleArray[index + 2], simpleArray[index + 3]);
        double l3 = getDistance(simpleArray[index - 2], simpleArray[index - 1], simpleArray[index + 2], simpleArray[index + 3]);

        double val = l1 + l2 - l3;

        return val;
    }


}
