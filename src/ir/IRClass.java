import java.util.List;
import java.util.LinkedList;
import java.util.HashMap;
import java.util.Map;


import ir.*;

public class IRClass {
    private String className;
    private IRClass superClass;
    private Map<String, IRMethod> irMethods = new HashMap<>(); 
    private List<IRClassField> irClassFields = new LinkedList<>();
    private List<String> Methods = new LinkedList<>();
    private Map<String, List<String>> methods_to_formal_args_types = new HashMap<>(); 
    private Map<String, String> methods_to_return_type = new HashMap<>(); 

    public IRClass(String className)
    {
        this.className = className;
    }

    public IRClass(String className, IRClass superClass)
    {
        this.className = className;
        this.superClass = superClass;
    }

    public void addField(String fieldName, String fieldType, int fieldSize) {
        this.irClassFields.add(new IRClassField(fieldName,fieldType,fieldSize));
    }

    public void addMethod(String MethodName, List<String> formalTypes, String ret_type) {
        if (!this.containsMethod(MethodName)) {
            this.Methods.add(MethodName);
            this.methods_to_formal_args_types.put(MethodName, formalTypes);
            this.methods_to_return_type.put(MethodName, ret_type);
        }
    }

    public int getClassObjectSize() {
        return this.getClassFieldsSize() + 8;
    }

    public int getClassFieldsSize() {
        int size = 0;
        if (superClass != null) { 
            size = superClass.getClassObjectSize();
        }
        for (var Field : irClassFields) {
            size = size + Field.getSize();
        }
        return size;
    }


    public int getObjectLocation(String ObjectName) {
        int location = 8;
        int s = 0;
        for (var Field : irClassFields) {
            if (Field.getName().equals(ObjectName)) {
                if (superClass != null) {
                    s = superClass.getClassObjectSize();
                }
                return location + s;
            }
            location = location + Field.getSize();
        }

        if (superClass != null) { 
            return superClass.getObjectLocation(ObjectName);
        }
        throw new RuntimeException("Field is not part of the class!");
    }

    public String getFieldType(String ObjectName) {
        for (var Field : irClassFields) {
            if (Field.getName().equals(ObjectName)) {
                return Field.getType();
            }
        }
        if (superClass != null) { 
            return superClass.getFieldType(ObjectName);
        }
        throw new RuntimeException("Field is not part of the class!");
    }



    public int getMethodVtableIndex(String MethodName) {
        if (this.Methods.contains(MethodName)) {
            int ex = 0;
            if (superClass != null) {
                ex = superClass.numberOfMethods();
            }
            return Methods.indexOf(MethodName) + ex;
        }
        if (superClass == null) {
            throw new RuntimeException("Method not in class!");
        }
        return superClass.getMethodVtableIndex(MethodName);
    }

    public String getClassName()
    {
        return this.className;
    }

    public String getClassIR()
    {
        StringBuilder classIR = new StringBuilder();
        for (var methodIR : irMethods.values())
        {
            classIR.append(methodIR.getMethodIR());
        }
        return classIR.toString();
    }

    public String getVTableIR() // FIX
    {
        var classDef = new StringBuilder();
        classDef.append(String.format("%s = global %s ", this.getVtableName(), this.getVtableType()));
        classDef.append('[');
        classDef.append(System.lineSeparator());
        int numMethods = this.numberOfMethods();

        for (int i = 0; i < numMethods; i++) {
            var methodName = this.getMethodInIndex(i);
            var irMethod = this.getIRMethod(methodName);
            classDef.append(String.format("   i8* bitcast (%s to i8*)", irMethod.getMethodType()));
            if (i < numMethods - 1) {
                classDef.append(", ");
                classDef.append(System.lineSeparator());
            }
        }

        classDef.append(']');
        classDef.append(System.lineSeparator());
        classDef.append(System.lineSeparator());
        return classDef.toString();
    }

    public IRMethod generateMethod(String methodName)
    {
        var irMethod = new IRMethod(className, methodName);
        this.irMethods.put(methodName, irMethod);
        return irMethod;
    }

    public IRMethod getIRMethod(String methodName) {
        if (this.irMethods.containsKey(methodName)) {
            return this.irMethods.get(methodName);
        }
        if (superClass == null) {
            throw new RuntimeException("Method not in class!");
        }
        return superClass.getIRMethod(methodName);
    }

    public List<String> getMethodFormalTypes(String methodName) {
        if (this.methods_to_formal_args_types.containsKey(methodName)) {
            return this.methods_to_formal_args_types.get(methodName);
        }
        if (superClass == null) {
            throw new RuntimeException("Method not in class!");
        }
        return superClass.getMethodFormalTypes(methodName);
    }

    public boolean containsMethod(String methodName) {
        boolean sup = false;
        if (superClass != null) {
            sup = superClass.containsMethod(methodName);
        }
        return (this.Methods.contains(methodName) || sup);
    }

    public int numberOfMethods() {
        if (superClass == null) {
            return this.Methods.size();
        }
        return superClass.numberOfMethods() + this.Methods.size();
    }

    public String getMethodInIndex(int i) {
        if (superClass == null) {
            return Methods.get(i);
        }
        int j = i - superClass.numberOfMethods();
        if (j < 0) {
            return superClass.getMethodInIndex(i);
        } else {
            return Methods.get(j);
        }
    }

    public String getVtableName() {
        return String.format("@.%s_vtable", className);
    }

    public String getVtableType() {
        return String.format("[%d x i8*]", this.Methods.size());
    }

    public String getMethodPtrType(String methodName) {
        StringBuilder methodPtrType = new StringBuilder();

        methodPtrType.append(this.getMethodRetType(methodName));

        var formalTypes = this.getMethodFormalTypes(methodName);
        var iterator = formalTypes.listIterator();
        methodPtrType.append(" (");
        while (iterator.hasNext())
        {
            var irVar = iterator.next();
            methodPtrType.append(irVar);
            if (iterator.hasNext()) {
                methodPtrType.append(", ");
            }
        }
        methodPtrType.append(")*");
        
        return methodPtrType.toString();

    }

    public String getMethodRetType(String methodName) {
        if (this.methods_to_return_type.containsKey(methodName)) {
            return this.methods_to_return_type.get(methodName);
        }
        if (superClass == null) {
            throw new RuntimeException("Method not in class!");
        }
        return superClass.getMethodRetType(methodName);
    }
}
