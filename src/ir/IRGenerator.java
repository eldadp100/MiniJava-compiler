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
    private IRStatement irMainStatement = new IRStatement();;

    public String getString()
    {
        StringBuilder generatedIR = new StringBuilder();

        // Classes' VTable
        for (var classIR : irClasses) {
            generatedIR.append(classIR.getVTableIR());
        }

        // Imported functions
        generatedIR.append(getImportsIR());

        // Main function
        generatedIR.append(getMainIR());

        // Classes' methods
        for (var classIR : irClasses) {
            generatedIR.append(classIR.getClassIR());
        }

        return generatedIR.toString();
    }

    private String getImportsIR()
    {
        return "declare i8* @calloc(i32, i32)\n"
        + "declare i32 @printf(i8*, ...)\n"
        + "declare void @exit(i32)\n"
        + "\n"
        + "@_cint = constant [4 x i8] c\"%d\\0a\\00\"\n"
        + "@_cOOB = constant [15 x i8] c\"Out of bounds\\0a\\00\"\n"
        + "define void @print_int(i32 %i) {\n"
        +    "\t%_str = bitcast [4 x i8]* @_cint to i8*\n"
        +    "\tcall i32 (i8*, ...) @printf(i8* %_str, i32 %i)\n"
        +    "\tret void\n"
        + "}\n"
        + "\n"
        + "define void @throw_oob() {\n"
        +    "\t%_str = bitcast [15 x i8]* @_cOOB to i8*\n"
        +    "\tcall i32 (i8*, ...) @printf(i8* %_str)\n"
        +    "\tcall void @exit(i32 1)\n"
        +    "\tret void\n"
        + "}\n\n";
    }

    private String getMainIR()
    {
        StringBuilder ir = new StringBuilder();

        ir.append("define i32 @main() {");
        ir.append(this.irMainStatement.toString());
        ir.append("}\n\n");

        return ir.toString();
    }

    public void setMainStatement(IRStatement irMainStatement)
    {
        this.irMainStatement = irMainStatement;
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
