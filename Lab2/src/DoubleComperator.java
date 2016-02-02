import java.util.Comparator;

/**
 * Created by Rasmus on 2016-02-02.
 */
public class DoubleComperator implements Comparator<Double>{
    @Override
    public int compare(Double a, Double b) {
        if (a < b) return -1;
        if (a > b) return 1;
        return 0;
    }
}
