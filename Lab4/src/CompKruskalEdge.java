import java.util.Comparator;

public class CompKruskalEdge implements Comparator<BusEdge> {

    @Override
    public int compare(BusEdge b1, BusEdge b2) {
        if(b1.getWeight() > b2.getWeight()){
            return 1;
        }else if(b2.getWeight() > b1.getWeight()){
            return -1;
        }else{
            return 0;
        }
    }
}