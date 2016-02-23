package Lab3;

/**
 * Created by Rasmus on 2016-02-12.
 */
public class SplayTreeSet <E extends Comparable<? super E>>  implements SimpleSet<E> {

    public class Node {
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


        public Node getRight() {
            return this.right;
        }

        public Node getLeft() {
            return this.left;
        }
    }

    private int size;
    private Node root;

    @Override
    public int size() {
        return this.size;
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

    

}
