package symbol;

import ast.AstNode;

public class UnresolvedSymbol {
    private AstNode node;
    private String className;

    public UnresolvedSymbol(AstNode node, String className)
    {
        this.node = node;
        this.className = className;
    }

    public void resolve(AstSymbols astSymbols)
    {
        var classSymbolTable = astSymbols.GetSymbolTableByClass(this.className);
        astSymbols.SaveIdentiferScope(node);
        astSymbols.InsertNodeRedirection(node, classSymbolTable);
    }    
}
