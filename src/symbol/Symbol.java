package symbol;

import ast.AstNode;
import ast.VarDecl;

public class Symbol {
    private String name;
    private SymbolType type;
    private AstNode node;

    public Symbol(String name, SymbolType type, AstNode node)
    {
        this.name = name;
        this.type = type;
        this.node = node;
    }

    public String getName()
    {
        return this.name;
    }

    public SymbolType getType()
    {
        return this.type;
    }

    public int getLine()
    {
        return this.node.lineNumber;
    }

    public void rename(String newName)
    {
        this.name = newName;
        
        switch(this.type)
        {
            case VAR:
                var varDecl = (VarDecl)this.node;
                varDecl.setName(newName);
                break;
        }
    }
}
