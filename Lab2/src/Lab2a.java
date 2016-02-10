public class Lab2a {
    public static double[] simplifyShape(double[] poly, int k) {
        double l1, l2, l3;
        double val;

        double[] simpleArray = poly.clone();

        double lowestVal;
        int index = 0;


        while ((simpleArray.length) / 2 > k) {

            //initialize lowestVal

            lowestVal = getPointValue(2, simpleArray);
            index = 2;

            for (int i = 4; i < simpleArray.length - 2; i = i + 2) {

                val = getPointValue(i, simpleArray);

                if (val <= lowestVal) {
                    lowestVal = val;
                    index = i;
                }
            }
            //remove
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
        for (double d : simpleArray) {
            System.out.println(d);
        }

        return simpleArray;

    }

    private static double getDistance(double x1, double y1, double x2, double y2) {
        //Pythagorean theorem to get distance between coordinates
        return Math.sqrt((Math.pow(x1 - x2, 2)) + (Math.pow(y1 - y2, 2)));
    }

    private static double getPointValue(int index, double[] simpleArray) {

        double l1 = getDistance(simpleArray[index], simpleArray[index + 1], simpleArray[index - 2], simpleArray[index - 1]);
        double l2 = getDistance(simpleArray[index], simpleArray[index + 1], simpleArray[index + 2], simpleArray[index + 3]);
        double l3 = getDistance(simpleArray[index - 2], simpleArray[index - 1], simpleArray[index + 2], simpleArray[index + 3]);

        double val = l1 + l2 - l3;

        return val;
    }


}
