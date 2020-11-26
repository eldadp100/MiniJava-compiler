import java.util.List;
import java.util.LinkedList;
import symbol.AstSymbols;
import ir.*;

public class IRGenerator
{
    private List<IRClass> irClasses = new LinkedList<>();

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
        return irClass;
    }
}
