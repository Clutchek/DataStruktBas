package Lab3;

import java.util.Random;
import java.util.TreeSet;


public class TestSetCorrectness {
    public static void main(String[] args) {
        int n1 = Integer.parseInt(args[0]);
        int n2 = Integer.parseInt(args[1]);
        int n3 = Integer.parseInt(args[2]);
        int n4 = Integer.parseInt(args[3]);

        if(n1 == 1){
            //TEST
        }else if(n1 == 2){
            testSplayTree(n2,n3,n4);
        }
    }

    private static void testSplayTree(int n2, int n3, int n4){
        Random randomGen = new Random();
        for(int i = 0; i < n2; i++){
            SplayTreeSet<Integer> splayTree = new SplayTreeSet<>();
            TreeSet<Integer> treeSet = new TreeSet<>();
            for(int j = 0; j < n3; j++){
                double random = Math.random();
                if(random < 0.25){
                    int randInt = randomGen.nextInt(n4);
                    if(!(splayTree.add(randInt) == treeSet.add(randInt))){
                        System.out.println("Error on add");
                        System.exit(1);
                    }
                }else if(random < 0.5){
                    int randInt = randomGen.nextInt(n4);
                    if(!(splayTree.remove(randInt) == treeSet.remove(randInt))){
                        System.out.println("Error on remove");
                        System.exit(2);
                    }
                }else if(random < 0.75){
                    int randInt = randomGen.nextInt(n4);
                    if(!(splayTree.contains(randInt) == treeSet.contains(randInt))){
                        System.out.println("Error on remove");
                        System.exit(3);
                    }
                }else{
                    if(!(splayTree.size() == treeSet.size())){
                        System.out.println("Error on size");
                        System.exit(4);
                    }
                }
            }
        }
    }
}
