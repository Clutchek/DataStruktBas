/** Doubly-linked list with user access to nodes
 */
public class DLList<E extends Comparable<E>> {
  public static class Node<E extends Comparable<E>> implements Comparable<Node<E>>{
    /** The contents of the node is public */
    public E elt;

    protected Node prev, next;

    Node() {
      this(null);
    }
    Node(E elt) {
      this.elt = elt;
      prev = next = null;
    }

    public Node getNext() {
      return this.next;
    }

    public Node getPrev() {
      return this.prev;
    }
      public int compareTo(Node<E> node){
        return this.elt.compareTo(node.elt);
      }


  }

  /** first and last nodes in list, null when list is empty */
  Node first, last;

  private int size;

  DLList() {
    first = last = null;
  }

  /** inserts an element at the beginning of the list
   * @param e   the new element value
   * @return    the node holding the added element
   */
  public Node addFirst(E e) {
      Node firstNode = new Node(e);
      firstNode.next = first;
      if(first != null){
        first.prev = firstNode;
      }
      first = firstNode;
      size++;
      return firstNode;
  }

  /** inserts an element at then end of the list
   * @param e   the new element
   * @return    the node holding the added element
   */
  public Node addLast(E e) {
      Node lastNode = new Node(e);
      if(last != null){
        last.next = lastNode;
      }
      lastNode.prev = last;
      last = lastNode;
      size++;
      return lastNode;
  }

  /**
   * @return    the node of the list's first element, null if list is empty
   */
  public Node getFirst() {
      return first;
  }

  /**
   * @return    the node of the list's last element, null if list is empty
   */
  public Node getLast() {
      return last;
  }
  
  /** inserts a new element after a specified node
    * @param e   the new element
    * @param l   the node after which to insert the element, must be non-null and a node belonging to this list
    * @return    the node holding the inserted element
    */
  public Node insertAfter(E e, Node l) {
      if(l.next == null){
        return addLast(e);
      }else{
        Node nextNode = new Node(e);
        nextNode.next = l.next;
        nextNode.prev = l;
        l.next = nextNode;
        size++;
        return nextNode;
      }
  }

  /** inserts a new element before a specified node
    * @param e   the new element
    * @param l   the node before which to insert the element, must be non-null and a node belonging to this list
    * @return    the node holding the inserted element
    */
  public Node insertBefore(E e, Node l) {
      if(l.prev == null){
        return addFirst(e);
      }else{
        Node prevNode = new Node(e);
        prevNode.next = l;
        prevNode.prev = l.prev;
        l.prev = prevNode;
        size++;
        return prevNode;
      }
  }

  /** removes an element
    * @param l   then node containing the element that will be removed, must be non-null and a node belonging to this list
    */
  public void remove(Node l) {
      if(l == null){
        throw new IllegalArgumentException();
      }
      Node prev = l.prev;
      Node next = l.next;
      prev.next = next;
      next.prev = prev;
      size--;
      //java's gc should take care of the rest
      l = null;
  }
}
