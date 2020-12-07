import java.util.List;
import java.util.LinkedList;

import ir.*;

public class IRMethod
{
    private String className;
    private String methodName;
    private String retType;
    private List<IRVar> params = new LinkedList<>();
    private List<IRStatement> stmts = new LinkedList<>();

    public IRMethod(String className, String methodName)
    {
        this.className = className;
        this.methodName = methodName;
        // this.params.add(new IRVar("%this", "i8*"));
    }
    
    public String getName() {
        return methodName;
    }

    public void setRetType(String retType)
    {
        this.retType = retType;
    }

    public void addParam(IRVar param)
    {
        this.params.add(param);
    }

    public void addStatement(IRStatement stmt)
    {
        this.stmts.add(stmt);
    }

    public String getMethodType()
    {
        StringBuilder methodType = new StringBuilder();
        methodType.append(retType);
        methodType.append(" (");
        var iterator = params.listIterator();
        while (iterator.hasNext())
        {
            var irVar = iterator.next();
            methodType.append(irVar.getType());
            if (iterator.hasNext())
                methodType.append(", ");
        }
        methodType.append(String.format(")* @%s.%s", className, methodName));
        return methodType.toString();
    }

    public String getMethodIR()
    {
        StringBuilder methodIR = new StringBuilder();
        methodIR.append(openScope());
        methodIR.append(declareFormalArguments());
        for (var stmt: this.stmts) {
            methodIR.append(stmt.toString());
        }
        methodIR.append(closeScope());
        return methodIR.toString();
    }

    private String openScope()
    {
        var methodDef = new StringBuilder();
        methodDef.append(String.format("define %s @%s.%s", retType, className, methodName));
        methodDef.append('(');
        var iterator = params.listIterator();
        var thisVar = iterator.next();
        methodDef.append(String.format("%s %%_%d", thisVar.getType(), thisVar.getNumber()));

        while (iterator.hasNext())
        {
            methodDef.append(", ");
            var irVar = iterator.next();
            methodDef.append(String.format("%s %%.%d", irVar.getType(), irVar.getNumber()));
        }
        methodDef.append(") {");
        methodDef.append(System.lineSeparator());
        return methodDef.toString();
    }

    private String declareFormalArguments()
    {
        IRStatement formalArgsDec = new IRStatement();
        var iterator = params.listIterator();
        iterator.next();
        while (iterator.hasNext())
        {
            var irVar = iterator.next();
            formalArgsDec.varDecl(irVar.getNumber(), irVar.getType());
            formalArgsDec.addStoreFormalArg(irVar.getType(), String.format(".%d", irVar.getNumber()), String.format("%s*", irVar.getType()), irVar.getNumber());
        }
        return formalArgsDec.toString();
    }

    private String closeScope()
    {
        return "}" + System.lineSeparator();
    }
}
