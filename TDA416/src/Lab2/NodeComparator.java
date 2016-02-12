package Lab2;

import java.util.Comparator;

/**
 * Created by nalex on 09/02/2016.
 */
public class NodeComparator implements Comparator<DLList<Point>.Node> {


    @Override
    public int compare(DLList<Point>.Node o1, DLList<Point>.Node o2) {
        return o1.elt.compareTo(o2.elt);
    }
}
