package symbol;

import java.util.HashMap;
import java.util.Map;

import ast.AstNode;

public class SymbolTable {
    private Map<String, Symbol> entries = new HashMap<>();
    private SymbolTable parentSymbolTable;

    public SymbolTable() {}
    public SymbolTable(SymbolTable parentSymbolTable)
    {
        this.parentSymbolTable = parentSymbolTable;
    }

    public void InsertSymbol(String name, SymbolType type, AstNode node)
    {
        entries.put(name, new Symbol(name, type, node));
    }

    public Symbol GetSymbol(String name, SymbolType type)
    {
        if ((entries.containsKey(name)) &&
            (entries.get(name).getType() == type))
        {
            return entries.get(name);
        }

        if (this.parentSymbolTable != null)
        {
            return this.parentSymbolTable.GetSymbol(name, type);
        }

        throw new RuntimeException(String.format("Symbol \"%s\" cannot be found", name));
    }

    public void RenameMethodInHierarchy(String name, String newName)
    {
         if ((this.entries.containsKey(name)) &&
             (this.entries.get(name).getType() == SymbolType.METHOD))
        {
            this.entries.get(name).rename(newName);
        }

        if (this.parentSymbolTable != null)
            this.parentSymbolTable.RenameMethodInHierarchy(name, newName);
    }

    public void RenameMethodInHierarchy(String name, String newName, int line)
    {
        // First, check if a method with that name was declared in the given line
        // in the hierarchy        
        var symbolTable = this;
        boolean shouldRename = false;

        while (symbolTable != null)
        {
            if ((symbolTable.entries.containsKey(name)) &&
                (symbolTable.entries.get(name).getType() == SymbolType.METHOD) &&
                (symbolTable.entries.get(name).getLine() == line))
            {
                // Found target method in hierarchy
                shouldRename = true;
                break;
            }

            symbolTable = symbolTable.parentSymbolTable;
        }  
        
        if (shouldRename)
        {
            this.RenameMethodInHierarchy(name, newName);
        }
    }
}
