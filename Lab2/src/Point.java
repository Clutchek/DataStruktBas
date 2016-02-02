/**
 * Created by Rasmus on 2016-02-02.
 */
public class Point implements Comparable<Point>{

    private double x,y;

    private double value;

    public Point(double x,double y,double value){
        this.x = x;
        this.y = y;
        this.value = value;
    }

    public void setValue(double value) {
        this.value = value;
    }

    public double getValue() {
        return value;
    }

    public double getY() {
        return y;
    }

    public double getX() {
        return x;
    }

    @Override
    public int compareTo(Point o) {
        if (this.value < o.value) return -1;
        if (this.value > o.value) return 1;
        return 0;
    }
}
