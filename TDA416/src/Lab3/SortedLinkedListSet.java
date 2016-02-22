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

        if(first == null){
            Node newNode = new Node(x);
            first = newNode;
            last = newNode;
            size++;
            return true;
        }

        Node node = first;

        boolean compareOK= true;

        while ((node.next != null) && compareOK){ //kan vara compareOk fel iteration
            if(node.elt.compareTo(x) >= 0){
                compareOK = false;
            }else{
                node = node.next;
            }
        }
        Node newNode = new Node(x);
        if(compareOK){ //compareOK
            if(node.elt.compareTo(x) >= 0){
                newNode.next = node;
                newNode.prev = node.prev;
                if(node.prev != null){
                    node.prev.next = newNode;
                }
                node.prev = newNode;
                if(node == first){
                    first = newNode;
                }
            }else {
                node.next = newNode;
                newNode.prev = node;
                //newNode.next = null
                last = newNode;
            }
        }else{
            newNode.next = node;
            newNode.prev = node.prev;
            if(node.prev != null){
                node.prev.next = newNode;
            }
            node.prev = newNode;
            if(node == first){
                first = newNode;
            }
        }

        size++;

        if(first != null){
            Node noder = first;
            while(noder != null){
                System.out.print("" + noder.elt + " ");
                noder = noder.next;
            }
            System.out.print("\n");

        }
        return true;

    }

    @Override
    public boolean remove(E x) {
        if(!contains(x)){
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
                if(prev != null){
                    prev.next = next;
                }
                if(next != null){
                    next.prev = prev;
                }
                node = null;
                size--;
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
