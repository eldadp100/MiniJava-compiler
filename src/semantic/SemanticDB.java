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

    public void addClassField(String className, String fieldName, String fieldType) {
        var classInfo = getClassInfo(className);

        while (classInfo != null) {
            if (classInfo.hasField(fieldName)) {
                throw new RuntimeException(String.format("Field %s has already been declared", fieldName));
            }
            classInfo = getSuperClass(classInfo);
        }

        getClassInfo(className).addField(fieldName, fieldType);
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

                // Only overloading is not allowed
                if (!(currentMethodInfo.getRetType().equals(methodInfo.getRetType())) ||
                    !(currentMethodInfo.getArgsType().equals(methodInfo.getArgsType()))) {
                    throw new RuntimeException(String.format("Method %s cannot be overloaded", methodInfo.getName()));
                }
            }

            classInfo = getSuperClass(classInfo);
        }

        getClassInfo(className).addMethod(methodInfo.getName(), methodInfo);
    }
}
