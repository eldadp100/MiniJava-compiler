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

    public void addMethod(String MethodName) {
        if (!this.containsMethod(MethodName)) {
            this.Methods.add(MethodName);
        }
    }

    public int getClassObjectSize() {
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
        if (superClass != null) { 
            location = location + superClass.getClassObjectSize();
        }
        for (var Field : irClassFields) {
            if (Field.getName() == ObjectName) {
                return location;
            }
            location = location + Field.getSize();
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
        classDef.append(String.format("@.%s_vtable = global [%d x i8*] ", className, this.irMethods.size()));
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
}
