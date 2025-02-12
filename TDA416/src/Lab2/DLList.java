package Lab2;

/** Doubly-linked list with user access to nodes
 */
public class DLList<E> {
    public class Node {
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
    }

    /** first and last nodes in list, null when list is empty */
    Node first, last;

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
        if(last == null){
            last = first;
        }
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
        if(first == null){
            first = last;
        }
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
            return prevNode;
        }
    }

    /** removes an element
     * @param l   then node containing the element that will be removed, must be non-null and a node belonging to this list
     */
    public void remove(Node l) {
        if(l == last){
            last = l.prev;
        }
        if(l == first){
            first = l.next;
        }
        //remove references
        Node prev = l.prev;
        Node next = l.next;
        prev.next = next;
        next.prev = prev;
        //java's gc should take care of the rest
        l = null;
    }
}
