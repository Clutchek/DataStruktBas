import java.util.PriorityQueue;

public class Lab2b {
  public static double[] simplifyShape(double[] poly, int k) {
    PriorityQueue<DLList.Node> queue = new PriorityQueue<>((poly.length/2));
    DLList<Point> doubleList = new DLList<>();
    for(int i = 0; i < poly.length; i=i+2){
      Point newPoint = new Point(poly[i], poly[i+1], getPointValue(i, poly));
      doubleList.addLast(newPoint);
      queue.add(doubleList.getLast());
    }

    while(doubleList.getSize() > k){
      DLList.Node lowestNode = queue.remove();
      DLList.Node prev = lowestNode.prev;
      DLList.Node next = lowestNode.next;
      if( prev != null && next != null ){
        doubleList.remove(lowestNode);
        updateNodeValue(prev);
        updateNodeValue(next);
      }
    }
    double[] result = new double[k*2];
    fillArrayWithNodes(result, 0, doubleList.getFirst());
    return result;
  }

  private static void fillArrayWithNodes(double[] list, int index, DLList.Node<Point> node){
    if(node != null){
      list[index] = node.elt.getX();
      list[index+1] = node.elt.getY();
      fillArrayWithNodes(list, index+2, node.next);
    }
  }

  private static void updateNodeValue(DLList.Node<Point> l){
    double pointValue = getPointValue((Point)l.prev.elt, l.elt, (Point)l.next.elt);
    l.elt.setValue(pointValue);
    
  }



  private static double getDistance(double x1,double y1,double x2,double y2){

    return Math.sqrt((Math.pow(x1-x2,2))+(Math.pow(y1-y2,2)));
  }

  private static double getPointValue(Point prev,Point point,Point next){
    double l1 = getDistance(point.getX(),point.getY(), prev.getX(), prev.getY());
    double l2 = getDistance(point.getX(), point.getY(),next.getX(),next.getY());
    double l3 = getDistance(prev.getX(),prev.getY(),next.getX(),next.getY());
    double val = l1+l2-l3;
    return val;
  }

  private static double getPointValue(int index,double[] simpleArray){

    double l1 = getDistance(simpleArray[index],simpleArray[index+1], simpleArray[index-2], simpleArray[index-1]);
    double l2 = getDistance(simpleArray[index],simpleArray[index+1], simpleArray[index+2], simpleArray[index+3]);
    double l3 = getDistance(simpleArray[index-2],simpleArray[index-1], simpleArray[index+2], simpleArray[index+3]);

    double val = l1+l2-l3;

    return val;
  }
}
