package semantic;

import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

public class ClassInfo {
    private String className;
    private String superName;
    private Map<String, String> fields = new HashMap<>();

    public ClassInfo(String className) {
        this.className = className;
    }

    public ClassInfo(String className, String superName) {
        this.superName = superName;
    }

    public String getClassName() {
        return className;
    }

    public void addField(String fieldName, String fieldType) {
        if (fields.containsKey(fieldName)) {
            throw new RuntimeException(String.format("Field %s has already been declared", fieldName));
        }
        fields.put(fieldName, fieldType);
    }

    public boolean hasField(String fieldName) {
        return fields.containsKey(fieldName);
    }
}
