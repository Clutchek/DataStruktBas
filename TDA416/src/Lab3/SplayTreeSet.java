package Lab3;

/**
 * Created by Rasmus on 2016-02-12.
 */
public class SplayTreeSet <E extends Comparable<? super E>>  implements SimpleSet<E> {

    public class Node<E>{
        /** The contents of the node is public */
        public E elt;

        protected Node parent, left, right;

        Node() {
            this(null);
        }
        Node(E elt) {
            this.elt = elt;
            left = right = null;
        }

        public Node(E elt, Node<E> p) {
            this.elt = elt;
            parent = p;
            left = null;
            right = null;
        }


        public Node getRight() {
            return this.right;
        }

        public Node getLeft() {
            return this.left;
        }
    }

    private Node<E> root = null;
    private int size = 0;
    private Node<E> currentNode = null;

    @Override
    public int size() {
        return this.size;
    }

    @Override
    public boolean add(E x) {
            return findNode(x,true);
    }

    @Override
    public boolean remove(E x) {
        return false;
    }

    @Override
    public boolean contains(E x) {

        return findNode(x,false);

    }


    private boolean findNode(E x, boolean insertNode){

        if(x != null){
            Node<E> current = root;
            Node<E> parent = null;
            boolean leftChild = false;

            while (current != null){

                if(current.elt.equals(x)){
                    return  true;
                }
                if(current.elt.compareTo(x)>0){
                    parent = current;
                    current = current.left;
                    leftChild = true;
                }else{
                    parent = current;
                    current = current.right;
                    leftChild = false;
                }
            }

            if(insertNode){
                Node<E> newNode = new Node<E>(x,parent);
                if(parent == null) {
                    root = newNode;
                }else if(leftChild){
                    parent.left = newNode;
                }else{
                    parent.right = newNode;
                }

                size++;
                currentNode = newNode;
            } else {
                currentNode = parent;
            }


        }

        return false;
    }
    
    private void splay(){

    }

    private Node rotateRight(Node node){

        Node childNode = node.left;
        node.left = childNode.right;
        childNode.right = node;

        return childNode;

    }

    private Node rotateLeft(Node node){

        Node childNode = node.right;
        node.right= childNode.left;
        childNode.left = node;

        return childNode;
    }


}
