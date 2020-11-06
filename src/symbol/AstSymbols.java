package symbol;

import java.util.HashMap;
import java.util.Map;

import ast.AstNode;

public class AstSymbols {
    private Map<AstNode, SymbolTable> astSymbols = new HashMap<>();

    public void Insert(AstNode node, SymbolTable symbolTable)
    {
        astSymbols.put(node, symbolTable);
    }

    public SymbolTable GetSymbolTable(AstNode node)
    {
        return astSymbols.get(node);
    }

    public Symbol GetSymbol(AstNode node, String name, SymbolType type)
    {
        SymbolTable symbolTable = astSymbols.get(node);
        if (!astSymbols.containsKey(node))
        {
            throw new RuntimeException("No symbol table found for node");
        }

        return symbolTable.GetSymbol(name, type);
    }
}
