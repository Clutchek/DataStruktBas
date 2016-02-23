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
            parent = left = right = null;

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

        Node<E> tempNode = currentNode;
        if(currentNode.left != null) {
            root = currentNode.left;

            findNode(currentNode.elt, false);

            if(root.right != null) {
                root.right = tempNode.right;
            }

        }else if(currentNode.right != null){
            root = currentNode.right;
        }


        size--;


        /*
        if(currentNode.left == null){
            replace(currentNode, currentNode.right);
        }else if(currentNode.right == null){
            replace(currentNode, currentNode.left);
        }else{




        }*/

        return true;
    }

    private Node<E> treeMinumum(Node<E> node){
        while(node.left != null){
            node = node.left;
        }
        return node;
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
            } else{

                currentNode = parent;
            }

            if(currentNode != root) {
                splay(currentNode);
            }


        return false;
    }



    public void rotateRight(Node node){
        Node left = node.left;
        if(left != null) {
            node.left = left.right;
            if (left.right != null) {
                left.right.parent = node;
            }
            left.parent = node.parent;
        }
        if(node.parent == null){
            root = left;
        }else if(node == node.parent.right){
            node.parent.right = left;
        }else{
            node.parent.left = left;
        }
        if(left != null){
            left.right = node;
        }
        node.parent = left;
    }

    public void rotateLeft(Node node){
        Node right = node.right;
        if(right != null) {
            node.right = right.left;
            if (right.left != null) {
                right.left.parent = node;
            }
            right.parent = node.parent;
        }
        if(node.parent == null){
            root = right;
        }else if(node == node.parent.right){
            node.parent.right = right;
        }else{
            node.parent.left = right;
        }
        if(right != null){
            right.left = node;
        }
        node.parent = right;

    }

    public void splay(Node node){
        while(node.parent != null){
            if(node.parent.parent == null) {
                //zig step
                if (node.parent.left == node) {
                    rotateRight(node.parent);
                } else { //node is right child
                    rotateLeft(node.parent);
                }
            }else if(node.parent.left == node && node.parent.parent.left == node.parent){ //zig-zig ver 1.
                rotateRight(node.parent.parent);
                rotateRight(node.parent);
            }else if(node.parent.right == node && node.parent.parent.right == node.parent){ //zig-zig ver 2.
                rotateLeft(node.parent.parent);
                rotateLeft(node.parent);
            }else if(node.parent.left == node && node.parent.parent.right == node.parent){ //zig-zag ver 1.
                rotateRight(node.parent);
                rotateLeft(node.parent);
            }else{ //zig-zag ver 2. (node right child and node.parent left child)
                rotateLeft(node.parent);
                rotateRight(node.parent);

            }
        }
    }

}
