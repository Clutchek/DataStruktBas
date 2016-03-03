
import java.util.*;

public class DirectedGraph<E extends Edge> {
    List<E> edges = new ArrayList<E>();
    final int NUMBER_OF_NODES;

	public DirectedGraph(int noOfNodes) {
        NUMBER_OF_NODES = noOfNodes;
	}

    public class DijkstraElement{

        private final int node;
        private List<E> path;
        private final double distance;

        private DijkstraElement(int node, List<E> path, double distance){
            this.node = node;
            this.path = path;
            this.distance = distance;
        }

        public double getDistance() {
            return distance;
        }
    }

	public void addEdge(E e) {
		edges.add(e);
	}

    //Dayjsktsrats algoritm
	public Iterator<E> shortestPath(int from, int to) {

        //create list representing if nodes have been visited
        boolean[] nodeVisited = new boolean[NUMBER_OF_NODES];
        for(int i = 0; i < nodeVisited.length; i++){
            nodeVisited[i] = false;
        }
		PriorityQueue<DijkstraElement> priorityQueue = new PriorityQueue<DijkstraElement>(new CompDijkstraPath());
        //add startnode to pq
        priorityQueue.add(new DijkstraElement(from, new ArrayList<E>(), 0));
        DijkstraElement element;    

        while(!priorityQueue.isEmpty()){
            do {
                element = priorityQueue.poll();
            } while(!priorityQueue.isEmpty() && nodeVisited[element.node]);

            if(!priorityQueue.isEmpty() || !nodeVisited[element.node]){
                if(element.node == to){
                    return element.path.iterator();
                }
                nodeVisited[element.node] = true;
                for(E e: edges){
                    if(e.getSource() == element.node && (!nodeVisited[e.getDest()])){
                        //create the new path
                        List<E> newPath = new ArrayList<E>(element.path);
                        newPath.add(e);
                        DijkstraElement queueElement = new DijkstraElement(e.getDest(), newPath, element.distance + e.getWeight());
                        priorityQueue.add(queueElement);
                    }
                }
            }
        }
        //Should never happen unless the graph is not sammanhänging
        return null;
	}

	//Kruskals algoritm
	public Iterator<E> minimumSpanningTree() {
        //skapa array for alla noder

        ArrayList<E>[] nodes = new ArrayList[NUMBER_OF_NODES];
        for(int i = 0; i < nodes.length; i++){
            nodes[i] = new ArrayList<E>();
        }

        CompKruskalEdge compKruskalEdge = new CompKruskalEdge();
		PriorityQueue<E> priorityQueue = new PriorityQueue<E>(compKruskalEdge);
        //add all edges from graph
        for(int i = 0; i < edges.size(); i++){
            priorityQueue.add(edges.get(i));
        }

        boolean listNotEmpty = true;
        while(listNotEmpty){
            E edge;
            Boolean nodeCompare = true;
            do {
                listNotEmpty = (priorityQueue.size() > 0);
                edge = priorityQueue.poll();
                if(listNotEmpty){
                    nodeCompare = (nodes[edge.getSource()] == nodes[edge.getDest()]);
                }
            }while(listNotEmpty && nodeCompare);

            if(listNotEmpty) {
                ArrayList<E> lk;
                ArrayList<E> ll;
                if (nodes[edge.getSource()].size() > nodes[edge.getDest()].size()) {
                    lk = nodes[edge.getDest()];
                    ll = nodes[edge.getSource()];
                } else {
                    lk = nodes[edge.getSource()];
                    ll = nodes[edge.getDest()];
                }
                ll.add(edge);
                nodes[edge.getSource()] = ll;
                nodes[edge.getDest()] = ll;
                for (E e : lk) {
                    ll.add(e);
                    nodes[e.getSource()] = ll;
                    nodes[e.getDest()] = ll;
                }
            }
        }

        return nodes[0].iterator();
	}

}