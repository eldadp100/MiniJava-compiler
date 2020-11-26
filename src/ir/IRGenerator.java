import java.util.List;
import symbol.AstSymbols;
import ir.*;

public class IRGenerator {
    private StringBuilder irStringBuilder = new StringBuilder();

    public IRGenerator()
    {
        initIRStringBuilder();
    }

    public String getString()
    {
        return irStringBuilder.toString();
    }

    private void initIRStringBuilder()
    {
        // TODO: Add fixed stuff, such as imported functions
    }

    public void openScope(String name, String retType, List<IRType> params)
    {
        irStringBuilder.append(String.format("define %s @%s", retType, name));
        irStringBuilder.append('(');
        var iterator = params.listIterator();
        while (iterator.hasNext())
        {
            var IRType = iterator.next();
            irStringBuilder.append(String.format("%s %s", IRType.getType(), IRType.getName()));
            if (iterator.hasNext())
                irStringBuilder.append(", ");
        }
        irStringBuilder.append(')');
        irStringBuilder.append(System.lineSeparator());
    }
}
