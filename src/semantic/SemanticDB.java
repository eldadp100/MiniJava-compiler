package semantic;

import java.util.HashMap;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

public class SemanticDB {
    private Map<String, ClassInfo> classes = new HashMap<>();

    public void addClass(String className, String superName, boolean isMain) {
        if (classes.containsKey(className)) {
            throw new RuntimeException(String.format("Class %s has already been declared", className));
        }

        if (isMain) {
            // null indicates that its the main class
            classes.put(className, null);
            return;
        }

        if (superName != null) {
            if (!classes.containsKey(superName)) {
                throw new RuntimeException(String.format("Super Class %d hasn't been declared", superName));
            }

            var classInfo = new ClassInfo(className, superName);

            // Get super class info
            superClassInfo = classes.get(superName);
            if (superClassInfo == null) {
                // null indicates its the main class
                throw new RuntimeException(String.format("The main class %s cannot be extended", superName));
            }
        }
        else {
            var classInfo = new ClassInfo(className);
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

    public ClassInfo getClassInfo(String className) {
        if (!classes.containsKey(className)) {
            throw new RuntimeException(String.format("Class %d hasn't been declared", className));
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
}
