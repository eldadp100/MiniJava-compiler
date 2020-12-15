package semantic;

public class SemanticDB {
    private Map<String, List<ClassInfo>> classes = new HashMap<>();

    public void AddClass(String className, String superName, boolean isMain) {
        if (classes.containsKey(className)) {
            throw RuntimeError(String.format("Class %s has already been declared", className));
        }

        if (isMain) {
            // null indicates that its the main class
            classes.put(className, null);
            return;
        }

        var hierarchy = null;
        var classInfo = new ClassInfo(className);

        if (superName != null) {
            if (!classes.containsKey(superName)) {
                throw RuntimeError(String.format("Super Class %d hasn't been declared", superName));
            }
            // Get the existing hierarchy
            hierarchy = classes.get(superName);
            if (hierarchy == null) {
                // null indicates its the main class
                throw RuntimeError(String.format("The main class %s cannot be extended", superName));
            }
        }
        else {
            // Create a new hierarchy
            hierarchy = new ArrayList<ClassInfo>();
        }

        hierarchy.add(classInfo);
        classes.put(className, hierarchy);
    }
}
