#!/bin/bash
VALIDASTDIR=valid_ast
PRINTEDJAVAFROMVALIDASTDIR=produced_java_from_valid_ast
OURASTDIR=our_ast_from_java
PRINTEDJAVAFROMOURASTDIR=produced_java_from_our_ast
MJAVAC=../mjavac.jar
function run() {
  VALIDAST=$VALIDASTDIR/$1.xml
  PRINTEDJAVAFROMVALIDAST=$PRINTEDJAVAFROMVALIDASTDIR/$1.java
  OURAST=$OURASTDIR/$1.xml
  PRINTEDJAVAFROMOURAST=$PRINTEDJAVAFROMOURASTDIR/$1.java
  echo  "$1: "
  echo "---------------------------------------------------------------------------------------------------------------"
  echo "1) Test that the input .xml $1.xml is a valid AST according to the scheme."
  xmllint --schema ast.xsd $OURAST --noout

  echo "2) Create a .java file from the input .xml file $1.xml."
  java -jar $MJAVAC unmarshal print $VALIDAST $PRINTEDJAVAFROMVALIDAST

  echo "3) Parse $1.java to a .xml file using mjavac.jar."
  java -jar $MJAVAC parse marshal $PRINTEDJAVAFROMVALIDAST $OURAST

  echo "4) Test that the new .xml $1.xml is a valid AST according to the scheme."
  xmllint --schema ast.xsd $OURAST --noout

  #echo "Create Java file from your new AST of $1."
  #java -jar $MJAVAC unmarshal print $OURAST $PRINTEDJAVAFROMOURAST
  echo "Difference between ATTs is:"
  diff -w -y --suppress-common-lines <(sed 's/<lineNumber>.*<\/lineNumber>/<lineNumber><\/lineNumber>/g' $VALIDAST | cat -n) <(sed 's/<lineNumber>.*<\/lineNumber>/<lineNumber><\/lineNumber>/g' $OURAST | cat -n)
  echo "---------------------------------------------------------------------------------------------------------------"
  echo
  #ASTDIFF=$(diff -w -y --suppress-common-lines <(sed 's/<lineNumber>.*<\/lineNumber>/<lineNumber><\/lineNumber>/g' $VALIDAST | cat -n) <(sed 's/<lineNumber>.*<\/lineNumber>/<lineNumber><\/lineNumber>/g' $OURAST | cat -n))
  #if [[ $ASTDIFF != "" ]]; then
   # echo "Found difference in ASTs. The difference is:"
    #echo "Original AST                      Your AST"
    #echo $ASTDIFF
  #else
   # echo "Both ASTs are the same."
    #echo
  #fi
}
run $1
