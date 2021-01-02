echo --- Running semantic check on ex3 examples...
mkdir tests/temp_out
java -jar mjavac.jar unmarshal semantic examples/ex3/AssignmentInvalid.java.xml tests/temp_out/AssignmentInvalid.res
java -jar mjavac.jar unmarshal semantic examples/ex3/AssignmentValid.java.xml tests/temp_out/AssignmentValid.res
java -jar mjavac.jar unmarshal semantic examples/ex3/InitVarInvalid.java.xml tests/temp_out/InitVarInvalid.res
java -jar mjavac.jar unmarshal semantic examples/ex3/InitVarValid.java.xml tests/temp_out/InitVarValid.res
java -jar mjavac.jar unmarshal semantic examples/ex3/OwnerExprInvalid.java.xml tests/temp_out/OwnerExprInvalid.res
java -jar mjavac.jar unmarshal semantic examples/ex3/OwnerExprValid.java.xml tests/temp_out/OwnerExprValid.res
echo --- Finished