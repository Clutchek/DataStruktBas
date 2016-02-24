package Lab3;

import java.util.Random;
import java.util.SortedSet;
import java.util.TreeSet;

public class TestSetCorrectness {

    public static void main(String[] args){
        int structureType  = Integer.parseInt(args[1]);
        int numberOfRestarts = Integer.parseInt(args[1]);
        int numberOfOperations = Integer.parseInt(args[2]);
        int numberOfIntegers = Integer.parseInt(args[3]);

        for(int i = 0; i<numberOfRestarts; i++){
            if(structureType == 1){
                testSimpleSet(new SortedLinkedListSet<Integer>(),numberOfIntegers, numberOfOperations);
            }else if(structureType == 2) {
                testSimpleSet(new SplayTreeSet<Integer>(),numberOfIntegers, numberOfOperations);
            }
        }

    }

    public static void testSimpleSet(SimpleSet<Integer> simpleSet, int numberOfIntegers, int numberOfOperations){
        Random randGenerator = new Random();
        TreeSet<Integer> referenceSet = new TreeSet<Integer>();
        Float randomFloat = randGenerator.nextFloat(); //Number between 0 and 1.0
        for(int i = 0; i < numberOfOperations; i++) {
            int randInteger = randGenerator.nextInt(numberOfIntegers);
            if (randomFloat < 0.25) {
                if(!(simpleSet.add(randInteger) == referenceSet.add(randInteger))){
                    System.out.println("Add operation failed");
                    System.exit(1);
                }

            } else if (randomFloat < 0.5) {
                if(!(simpleSet.contains(randInteger) == referenceSet.contains(randInteger))){
                    System.out.println("Contains operation failed");
                    System.exit(1);
                }
            } else if (randomFloat < 0.75) {
                if(!(simpleSet.remove(randInteger) == referenceSet.remove(randInteger))){
                    System.out.println("Remove operation failed");
                    System.exit(1);
                }
            } else {
                if(!(simpleSet.size() == referenceSet.size())){
                    System.out.println("Size operation failed");
                    System.exit(1);
                }
            }
        }
    }
}
