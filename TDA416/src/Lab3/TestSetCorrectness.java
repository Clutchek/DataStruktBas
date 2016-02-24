package Lab3;

import java.util.*;

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
        List<String> listOfOperations = new ArrayList<String>();
        listOfOperations.add("Operations before error: ");
        for(int i = 0; i < numberOfOperations; i++) {
            int randInteger = randGenerator.nextInt(numberOfIntegers);
            if (randomFloat < 0.25) {
                if(!(simpleSet.add(randInteger) == referenceSet.add(randInteger))){
                    printList(listOfOperations);
                    System.out.println("Error: Add operation failed");
                    System.exit(1);
                }else{
                    listOfOperations.add("Added "+randInteger);
                }

            } else if (randomFloat < 0.5) {
                if(!(simpleSet.contains(randInteger) == referenceSet.contains(randInteger))){
                    printList(listOfOperations);
                    System.out.println("Error: Contains operation failed");
                    System.exit(1);
                }else{
                    listOfOperations.add("Checked if contains "+randInteger);
                }
            } else if (randomFloat < 0.75) {
                if(!(simpleSet.remove(randInteger) == referenceSet.remove(randInteger))){
                    printList(listOfOperations);
                    System.out.println("Error: Remove operation failed");
                    System.exit(1);
                }else{
                    listOfOperations.add("Removed "+randInteger);
                }
            } else {
                if(!(simpleSet.size() == referenceSet.size())){
                    printList(listOfOperations);
                    System.out.println("Error: Size operation failed");
                    System.exit(1);
                }else{
                    listOfOperations.add("Size was "+randInteger);
                }
            }
        }
    }

     private static void printList(List<String> list){
        for (String s: list) {
            System.out.println(s);
        }
    }
}
