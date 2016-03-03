import java.util.Comparator;

public class CompKruskalEdge implements Comparator<Edge> {

    @Override
    public int compare(Edge b1, Edge b2) {
        if(b1.getWeight() > b2.getWeight()){
            return 1;
        }else if(b1.getWeight() < b2.getWeight()){
            return -1;
        }else{
            return 0;
        }
    }
}