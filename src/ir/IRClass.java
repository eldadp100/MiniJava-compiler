import java.util.List;
import java.util.LinkedList;

import ir.*;

public class IRClass {
    private String className;
    private List<IRMethod> irMethods = new LinkedList<>();

    public IRClass(String className)
    {
        this.className = className;
    }

    public String getClassName()
    {
        return this.className;
    }

    public String getClassIR()
    {
        StringBuilder classIR = new StringBuilder();
        for (var methodIR : irMethods)
        {
            classIR.append(methodIR.getMethodIR());
        }
        return classIR.toString();
    }

    public String getVTableIR()
    {
        var classDef = new StringBuilder();
        classDef.append(String.format("@.%s_vtable = global [%d x i8*] ", className, this.irMethods.size()));
        classDef.append('[');
        var iterator = this.irMethods.listIterator();
        while (iterator.hasNext())
        {
            classDef.append(String.format("i8* bitcast (%s to i8*)", iterator.next().getMethodType()));
            if (iterator.hasNext())
                classDef.append(", ");
        }
        classDef.append(']');
        classDef.append(System.lineSeparator());
        return classDef.toString();
    }

    public IRMethod generateMethod(String methodName)
    {
        var irMethod = new IRMethod(className, methodName);
        this.irMethods.add(irMethod);
        return irMethod;
    }
}
