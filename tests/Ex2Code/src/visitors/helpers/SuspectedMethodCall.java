package visitors.helpers;

import ast.MethodCallExpr;
import symbol.Symbol;

public class SuspectedMethodCall {
    private MethodCallExpr methodCall;
    private Symbol symbol;

    public SuspectedMethodCall(MethodCallExpr methodCall, Symbol symbol)
    {
        this.methodCall = methodCall;
        this.symbol = symbol;
    }

    public void resolve()
    {
        // If the symbol name has been updated, update the method call expression
        if (!methodCall.methodId().equals(symbol.getName()))
            methodCall.setMethodId(symbol.getName());
    }    
}
