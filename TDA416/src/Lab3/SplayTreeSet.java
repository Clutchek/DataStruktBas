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
            return !findNode(x,true);
    }

    @Override
    public boolean remove(E x) {
        boolean nodeExist = findNode(x,false);
        if(!nodeExist){
            return false;
        }

        if(currentNode.left == null){
            replace(currentNode, currentNode.right);
        }else if(currentNode.right == null){
            replace(currentNode, currentNode.left);
        }else{

        }

        return true;
    }

    private void replace(Node<E> current, Node replacement ) {

        if( current.parent == null){

            root = replacement;

        }else if( current == current.parent.left ) {

            current.parent.left = replacement;

        }else {

            current.parent.right = replacement;

        }

        if( replacement != null ) {

            replacement.parent = current.parent;

        }
    }


    @Override
    public boolean contains(E x) {

        return findNode(x,false);

    }


    private boolean findNode(E x, boolean insertNode){

            currentNode = root;
            Node<E> parent = null;
            boolean leftChild = false;

            while (currentNode != null){

                if(currentNode.elt.equals(x)){
                    return  true;
                }
                if(currentNode.elt.compareTo(x)>0){
                    parent = currentNode;
                    currentNode = currentNode.left;
                    leftChild = true;
                }else{
                    parent = currentNode;
                    currentNode = currentNode.right;
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

            splay(currentNode);


        return false;
    }
    
    private void splay(Node node){

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
