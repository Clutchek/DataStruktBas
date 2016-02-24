package Lab3;

/**
 * Created by clutchek on 2/24/16.
 */
public class TestClass {
    public static void main(String[] args){
        SplayTreeSet<Integer> splayTree = new SplayTreeSet<>();

        splayTree.add(1);
        splayTree.add(2);
        splayTree.add(3);
        splayTree.add(4);

        splayTree.contains(2);
        splayTree.add(5);

        splayTree.contains(3);

        SplayTreeSet.Node node = splayTree.root;
        System.out.println("Root: " +(node.elt));
        if(node.left != null){
            System.out.println("Left Child: " + node.left.elt);

            if(node.left.left != null) {
                System.out.println("Left.left Child: " + node.left.left.elt);
            }

            if(node.left.right != null) {
                System.out.println("Left.right Child: " + node.left.right.elt);
            }
        }

        if(node.right != null){
            System.out.println("Right Child: " + node.right.elt);
        }

    }


}
