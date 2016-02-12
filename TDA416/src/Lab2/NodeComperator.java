package Lab2;

import java.util.Comparator;

/**
 * Created by Rasmus on 2016-02-02.
 */
public class NodeComperator implements Comparator<DLList.Node>{

    @Override
    public int compare(DLList.Node a, DLList.Node b) {

        if ((double)a.elt < (double)b.elt) return -1;
        if ((double)a.elt > (double)b.elt) return 1;
        return 0;
    }
}
