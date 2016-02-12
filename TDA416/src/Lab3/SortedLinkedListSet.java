package Lab3;

/**
 * Created by Rasmus on 2016-02-12.
 */
public class SortedLinkedListSet<E extends Comparable<? super E>> implements SimpleSet{

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

    private int size;

    /** first and last nodes in list, null when list is empty */
    Node first, last;

    SortedLinkedListSet() {
        first = last = null;
        size = 0;
    }


    @Override
    public int size() {
        return size;
    }


    @Override
    public boolean add(E x) {

        return false;
    }

    @Override
    public boolean remove(E x) {
        return false;
    }

    @Override
    public boolean contains(E x) {
        Node node = first;
        while(node != null){
            if(node.elt.equals(x)){
                return true;
            }
            node = node.next;
        }
        return false;
    }
}
