package Lab3;

public class SplayTreeSet <E extends Comparable<? super E>>  implements SimpleSet<E> {

    public class Node{
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

        public Node(E elt, Node p) {
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

    protected Node root = null;
    private int size = 0;


    @Override
    public int size() {
        return this.size;
    }

    @Override
    public boolean add(E x) {
        //if value already exist findNode will return true and not inserted
        return !findNode(x,true);
    }

    @Override
    public boolean remove(E x) {
        //set desired value in root
        boolean valueExists = findNode(x, false);
        if(!valueExists){
            return false;
        }
        Node originalRoot = root;
        if(originalRoot.left != null){
            //set left side of tree as root
            root = originalRoot.left;
            root.parent = null;

            //set highest value in left tree as root, should have no right child as it is the highest value on left side
            findNode(originalRoot.elt, false);

            if(originalRoot.right != null){
                root.right = originalRoot.right;
                root.right.parent = root;
            }

        }else if(originalRoot.right != null){
            //set right side of tree as root
            root = originalRoot.right;
            root.parent = null;
        }else{
            root = null;
        }
        originalRoot = null;

        size--;
        return true;
    }

    
    @Override
    public boolean contains(E x) {
        return findNode(x,false);

    }


    private boolean findNode(E x, boolean insertNode){

            Node currentNode = root;
            Node parent = null;
            boolean leftChild = false;


            while (currentNode != null){//Search through the tree until find existing node or hitting the an end node

                if(currentNode.elt.equals(x)){//if matching node is found splay the node
                    splay(currentNode);
                    return  true;
                }
                if(currentNode.elt.compareTo(x)<0){//if target value is larger than current node go to right child
                    parent = currentNode;
                    currentNode = currentNode.right;
                    leftChild = false;
                }else{//else go to left child
                    parent = currentNode;
                    currentNode = currentNode.left;
                    leftChild = true;
                }
            }
            //if parameter insertNode is true a new node with value x will be inserted
            if(insertNode){
                Node newNode = new Node(x,parent);
                if(parent == null) {//if the tree is empty insert at root
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
        if(left == null) throw new IllegalArgumentException();
        node.left = left.right;
        if (left.right != null) {
            left.right.parent = node;
        }
        left.parent = node.parent;

        if(node.parent == null){
            root = left;
        }else if(node == node.parent.right){
            node.parent.right = left;
        }else{
            node.parent.left = left;
        }
        left.right = node;
        node.parent = left;
    }

    public void rotateLeft(Node node){
        Node right = node.right;
        if(right == null) throw new IllegalArgumentException();
        node.right = right.left;
        if (right.left != null) {
            right.left.parent = node;
        }
        right.parent = node.parent;

        if(node.parent == null){
            root = right;
        }else if(node == node.parent.right){
            node.parent.right = right;
        }else{
            node.parent.left = right;
        }
        right.left = node;
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
