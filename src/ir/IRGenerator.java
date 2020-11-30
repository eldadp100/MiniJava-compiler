import java.util.List;
import java.util.LinkedList;
import java.util.HashMap;
import java.util.Map;
import symbol.AstSymbols;
import ir.*;

public class IRGenerator
{
    private List<IRClass> irClasses = new LinkedList<>();
    private Map<String, IRClass> class_to_IRclass = new HashMap<>(); 

    public String getString()
    {
        StringBuilder generatedIR = new StringBuilder();

        // Classes' VTable
        for (var classIR : irClasses) {
            generatedIR.append(classIR.getVTableIR());
        }

        // Imported functions
        generatedIR.append(getImportsIR());

        // Classes' methods
        for (var classIR : irClasses) {
            generatedIR.append(classIR.getClassIR());
        }

        return generatedIR.toString();
    }

    private String getImportsIR()
    {
        // TODO: Add fixed stuff, such as imported functions
        return "";
    }

    public IRClass generateClass(String className)
    {
        var irClass = new IRClass(className);
        this.irClasses.add(irClass);
        this.class_to_IRclass.put(className, irClass);
        return irClass;
    }

    public IRClass generateClass(String className, IRClass superClass)
    {
        var irClass = new IRClass(className, superClass);
        this.irClasses.add(irClass);
        this.class_to_IRclass.put(className, irClass);
        return irClass;
    }

    public IRClass getClass(String className) {
        return this.class_to_IRclass.get(className);
    }
}
