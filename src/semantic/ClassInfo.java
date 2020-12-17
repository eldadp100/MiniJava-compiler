package semantic;

import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

public class ClassInfo {
    private String className;
    private String superName;
    private Map<String, String> fields = new HashMap<>();
    private Map<String, MethodInfo> methods = new HashMap<>();

    public ClassInfo(String className) {
        this.className = className;
    }

    public ClassInfo(String className, String superName) {
        this.superName = superName;
    }

    public String getClassName() {
        return className;
    }

    public String getSuperName() {
        return superName;
    }
    
    public boolean hasField(String fieldName) {
        return fields.containsKey(fieldName);
    }

    public String getFieldType(String fieldName) {
        if (!fields.containsKey(fieldName)) {
            throw new RuntimeException(String.format("Field %s hasn't been declared", fieldName));
        }
        return fields.get(fieldName);
    }

    public boolean hasMethod(String methodName) {
        return methods.containsKey(methodName);
    }

    public MethodInfo getMethodInfo(String methodName) {
        if (!methods.containsKey(methodName)) {
            throw new RuntimeException(String.format("Method %s hasn't been declared", methodName));
        }
        return methods.get(methodName);
    }

    public void addField(String fieldName, String fieldType) {
        if (fields.containsKey(fieldName)) {
            throw new RuntimeException(String.format("Field %s has already been declared", fieldName));
        }
        fields.put(fieldName, fieldType);
    }

    public void addMethod(String methodName, MethodInfo methodInfo) {
        if (methods.containsKey(methodName)) {
            throw new RuntimeException(String.format("Method %s has already been declared", methodName));
        }
        methods.put(methodName, methodInfo);
    }
}
