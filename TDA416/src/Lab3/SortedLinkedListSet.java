package Lab3;

/**
 * Created by Rasmus on 2016-02-12.
 */
public class SortedLinkedListSet<E extends Comparable<? super E>> implements SimpleSet<E>{

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
        if(contains(x)){
            return false;
        }
        Node node = first;



        while ((node.next != null) && (node.elt.compareTo(x)>= 0)){
            node = node.next;
        }

        Node newNode = new Node(x);
        newNode.next = node.next;
        newNode.prev = node;
        node.next = newNode;

        if(node == last){
            last = newNode;
        }
        if(node == first){
            first = newNode;
        }

        size++;

        return true;

    }

    @Override
    public boolean remove(E x) {

        if(contains(x)){
            return false;
        }

        Node node = first;

        while(node != null){
            if(node.elt.equals(x)){
                if(node == last){

                    last = node.prev;
                }
                if(node == first){
                    
                    first = node.next;
                }
                Node prev = node.prev;
                Node next = node.next;
                prev.next = next;
                next.prev = prev;
                node = null;
                return true;
            }
            node = node.next;
        }
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
