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
        if (entries.containsKey(name) && entries.get(name).getType() == type)
        {
            return entries.get(name);
        }

        if (this.parentSymbolTable != null)
        {
            return this.parentSymbolTable.GetSymbol(name, type);
        }

        throw new RuntimeException(String.format("Symbol \"%s\" cannot be found", name));
    }
}
