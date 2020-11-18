package symbol;

import ast.AstNode;
import ast.AstType;
import ast.MethodDecl;
import ast.VariableIntroduction;

public class Symbol {
    private String name;
    private SymbolType type;
    private AstNode node;
    private boolean renamed = false;

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

    public AstType getStaticType()
    {
        if (this.type == SymbolType.VAR)
        {
            var varDecl = (VariableIntroduction)this.node;
            return varDecl.type();
        }
        else
        {
            throw new RuntimeException("Cannot get static type of a method");
        }
    }

    public boolean wasRenamed()
    {
        return this.renamed;
    }

    public void rename(String newName)
    {
        this.name = newName;
        
        switch(this.type)
        {
            case VAR:
                var varDecl = (VariableIntroduction)this.node;
                varDecl.setName(newName);
                break;

            case METHOD:
                var methodDecl = (MethodDecl)this.node;
                methodDecl.setName(newName);
                break;
        }

        this.renamed = true;
    }
}
