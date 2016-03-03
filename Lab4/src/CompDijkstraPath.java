import java.util.Comparator;

/**
 * Created by clutchek on 3/3/16.
 */
public class CompDijkstraPath implements Comparator<DirectedGraph.DijkstraElement> {

    @Override
    public int compare(DirectedGraph.DijkstraElement d1, DirectedGraph.DijkstraElement d2) {
        if(d1.getDistance() > d2.getDistance()){
            return 1;
        }else if(d2.getDistance() > d1.getDistance()){
            return -1;
        }else{
            return 0;
        }
    }
}
