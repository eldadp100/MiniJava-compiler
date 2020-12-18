echo --- Running semantic check on ast examples...
mkdir tests/temp_out
java -jar mjavac.jar unmarshal semantic examples/ast/BinarySearch.java.xml out.txt
java -jar mjavac.jar unmarshal semantic examples/ast/BinaryTree.java.xml out.txt
java -jar mjavac.jar unmarshal semantic examples/ast/BubbleSort.java.xml out.txt
java -jar mjavac.jar unmarshal semantic examples/ast/Classes.xml out.txt
java -jar mjavac.jar unmarshal semantic examples/ast/Factorial.java.xml out.txt
java -jar mjavac.jar unmarshal semantic examples/ast/LinearSearch.java.xml out.txt
java -jar mjavac.jar unmarshal semantic examples/ast/LinkedList.java.xml out.txt
java -jar mjavac.jar unmarshal semantic examples/ast/QuickSort.java.xml out.txt
java -jar mjavac.jar unmarshal semantic examples/ast/TreeVisitor.java.xml out.txt
echo --- Finished