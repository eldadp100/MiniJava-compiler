package symbol;

import java.util.HashMap;
import java.util.Map;

import ast.AstNode;

public class SymbolTable {
    private Map<String, Symbol> methods = new HashMap<>();
    private Map<String, Symbol> vars = new HashMap<>();
    private SymbolTable parentSymbolTable;

    public SymbolTable() {}
    public SymbolTable(SymbolTable parentSymbolTable)
    {
        this.parentSymbolTable = parentSymbolTable;
    }

    public void InsertSymbol(String name, SymbolType type, AstNode node)
    {
        if (type == SymbolType.METHOD)
            methods.put(name, new Symbol(name, type, node));
        else
            vars.put(name, new Symbol(name, type, node));
    }

    public Symbol GetSymbol(String name, SymbolType type)
    {
        Map<String, Symbol> entries;
        if (type == SymbolType.METHOD)
            entries = this.methods;
        else
            entries = this.vars;

        if (entries.containsKey(name))
        {
            return entries.get(name);
        }

        if (this.parentSymbolTable != null)
        {
            return this.parentSymbolTable.GetSymbol(name, type);
        }

        throw new RuntimeException(String.format("Symbol \"%s\" cannot be found", name));
    }

    public void RenameSymbol(String name, String newName, SymbolType type)
    {
        Map<String, Symbol> entries;
        if (type == SymbolType.METHOD)
            entries = this.methods;
        else
            entries = this.vars;

        if (!entries.containsKey(name))
        {
            throw new RuntimeException(String.format("Symbol \"%s\" cannot be found", name));
        }

        Symbol symbol = entries.remove(name);
        symbol.rename(newName);
        entries.put(newName, symbol);
    }

    public void RenameMethodInHierarchy(String name, String newName)
    {
        if (methods.containsKey(name))
        {
            this.RenameSymbol(name, newName, SymbolType.METHOD);
        }

        if (this.parentSymbolTable != null)
            this.parentSymbolTable.RenameMethodInHierarchy(name, newName);
    }

    public void RenameMethodIfRenamedInHierarchy(String name, String newName)
    {     
        var symbolTable = this;
        while (symbolTable != null)
        {
            if ((symbolTable.methods.containsKey(newName)) &&
                (symbolTable.methods.get(newName).wasRenamed()))
            {
                this.RenameMethodInHierarchy(name, newName);
                return;
            }

            symbolTable = symbolTable.parentSymbolTable;
        }
    }
}
