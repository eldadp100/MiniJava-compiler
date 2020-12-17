package semantic;

import java.util.HashMap;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

public class SemanticDB {
    private Map<String, ClassInfo> classes = new HashMap<>();

    public ClassInfo getClassInfo(String className) {
        if (!classes.containsKey(className)) {
            throw new RuntimeException(String.format("Class %s hasn't been declared", className));
        }
        return classes.get(className);
    }

    public ClassInfo getSuperClass(ClassInfo classInfo) {
        var superName = classInfo.getSuperName();
        if (superName == null) {
            return null;
        }
        return getClassInfo(superName);
    }

    public boolean isNativeType(String type) {
        return (type.equals("int")) || (type.equals("bool")) || (type.equals("int[]"));
    }

    public boolean isClassType(String type) {
        return classes.containsKey(type);
    }

    public boolean isSubtype(String type, String subType) {
        if (isNativeType(type) || isNativeType(subType)) {
            return false;
        }

        var subClassInfo = getClassInfo(subType);
        while (subClassInfo != null) {
            if (subClassInfo.getClassName().equals(type)) {
                return true;
            }
            subClassInfo = getSuperClass(subClassInfo);
        }

        return false;
    }

    public void validateClassType(String type) {
        if (!isClassType(type)) {
            throw new RuntimeException(String.format("Type %s is not a valid class type", type));
        }
    }

    public void validateType(String type) {
        if ((!isNativeType(type)) &&
            (!isClassType(type))) {
            throw new RuntimeException(String.format("Unknown type %s", type));
        }
    }

    public void addClass(String className, String superName, boolean isMain) {
        if (classes.containsKey(className)) {
            throw new RuntimeException(String.format("Class %s has already been declared", className));
        }

        if (isMain) {
            // null indicates that its the main class
            classes.put(className, null);
            return;
        }

        ClassInfo classInfo = null;
        if (superName != null) {
            if (!classes.containsKey(superName)) {
                throw new RuntimeException(String.format("Super Class %s hasn't been declared", superName));
            }

            classInfo = new ClassInfo(className, superName);

            // Get super class info
            if (classes.get(superName) == null) {
                // null indicates its the main class
                throw new RuntimeException(String.format("The main class %s cannot be extended", superName));
            }
        }
        else {
            classInfo = new ClassInfo(className);
        }

        classes.put(className, classInfo);
    }

    public boolean hasField(String className, String fieldName) {
        var classInfo = getClassInfo(className);

        while (classInfo != null) {
            if (classInfo.hasField(fieldName)) {
                return true;
            }
            classInfo = getSuperClass(classInfo);
        }

        return false;
    }

    public void addClassField(String className, String fieldName, String fieldType) {
        if (hasField(className, fieldName)) {
            throw new RuntimeException(String.format("Field %s has already been declared", fieldName));
        }

        getClassInfo(className).addField(fieldName, fieldType);
    }

    public String getClassFieldType(String className, String fieldName) {
        var classInfo = getClassInfo(className);

        while (classInfo != null) {
            if (classInfo.hasField(fieldName)) {
                return classInfo.getFieldType(fieldName);
            }
            classInfo = getSuperClass(classInfo);
        }

        throw new RuntimeException(String.format("Field %s could not be found", fieldName));
    }

    public void addClassMethod(String className, MethodInfo methodInfo) {
        var classInfo = getClassInfo(className);

        // In the same class duplication / overloading is not allowed
        if (classInfo.hasMethod(methodInfo.getName())) {
            throw new RuntimeException(String.format("Method %s cannot be overloaded", methodInfo.getName()));
        }
        classInfo = getSuperClass(classInfo);

        while (classInfo != null) {
            if (classInfo.hasMethod(methodInfo.getName())) {
                var currentMethodInfo = classInfo.getMethodInfo(methodInfo.getName());

                // Overloading is not allowed
                if (!currentMethodInfo.equals(methodInfo)) {
                    throw new RuntimeException(String.format("Method %s cannot be overloaded", methodInfo.getName()));
                }
            }

            classInfo = getSuperClass(classInfo);
        }

        getClassInfo(className).addMethod(methodInfo.getName(), methodInfo);
    }

    public MethodInfo getClassMethodInfo(String className, String methodName) {
        var classInfo = getClassInfo(className);

        while (classInfo != null) {
            if (classInfo.hasMethod(methodName)) {
                return classInfo.getMethodInfo(methodName);
            }
            classInfo = getSuperClass(classInfo);
        }

        throw new RuntimeException(String.format("Method %s could not be found", methodName));
    }

    public String getRefIdType(String className, String methodName, String refId) {
        var methodInfo = getClassInfo(className).getMethodInfo(methodName);

        if (methodInfo.hasLocalVar(refId)) {
            return methodInfo.getLocalVarType(refId);
        }
        else if (methodInfo.hasArg(refId)) {
            return methodInfo.getArgType(refId);
        }
        else if (hasField(className, refId)) {
            return getClassFieldType(className, refId);
        }

        throw new RuntimeException(String.format("RefId %s could not be found", refId));
    }

    public void validateMethodCallArgs(String className, String methodName, List<String> callerArgTypes) {
        var methodInfo = getClassMethodInfo(className, methodName);
        List<String> methodArgTypes = methodInfo.getArgTypes();
        
        var callIter = callerArgTypes.iterator();
        var methodIter = methodArgTypes.iterator();

        while (callIter.hasNext() && methodIter.hasNext()) {
            var callerArgType = callIter.next();
            var methodArgType = methodIter.next();

            // If either one is a native type, they should be equal
            if ((isNativeType(callerArgType) || isNativeType(methodArgType)) &&
                (callerArgType.equals(methodArgType))) {
                continue;
            }
            
            // Otherwise both are class types and the caller passed type should be 
            // subtype of the method arg type
            if (isSubtype(methodArgType, callerArgType)) {
                continue;
            }

            throw new RuntimeException(String.format(
                "Method call arguments types for %s do not match the method signature", methodName));
        }

        if (callIter.hasNext() != methodIter.hasNext()) {
            throw new RuntimeException(String.format(
                "Method call arguments count for %s is not as expected", methodName));
        }
    }
}
