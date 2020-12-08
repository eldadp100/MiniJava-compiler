package symbol;

import java.util.HashMap;
import java.util.Map;

import ast.AstNode;
import ast.AstType;
import ast.RefType;

public class AstSymbols {
    private Map<AstNode, SymbolTable> astSymbols = new HashMap<>();
    private Map<String, SymbolTable> classSymbols = new HashMap<>();
    private Map<AstType, String> refTypes = new HashMap<>();
    private Map<AstNode, SymbolTable> identiferScope = new HashMap<>();

    public void InsertMethod(AstNode node, SymbolTable symbolTable)
    {
        this.astSymbols.put(node, symbolTable);
    }

    public void InsertClass(AstNode node, SymbolTable symbolTable, String className)
    {
        this.astSymbols.put(node, symbolTable);
        this.classSymbols.put(className, symbolTable);
    }

    public void InsertNodeRedirection(AstNode node, SymbolTable symbolTable)
    {
        this.astSymbols.put(node, symbolTable);
    }

    public void InsertRefType(RefType node, String name)
    {
        this.refTypes.put(node, name);
    }

    public void SaveIdentiferScope(AstNode node)
    {
        this.identiferScope.put(node, GetSymbolTableByNode(node));
    }

    public SymbolTable GetSymbolTableByNode(AstNode node)
    {
        if (!this.astSymbols.containsKey(node))
            throw new RuntimeException("No symbol table found for node");

        return this.astSymbols.get(node);
    }

    public SymbolTable GetSymbolTableByClass(String className)
    {
        if (!classSymbols.containsKey(className))
            throw new RuntimeException("No symbol table found for class " + className);

        return this.classSymbols.get(className);
    }

    public Symbol GetSymbol(AstNode node, String name, SymbolType type)
    {
        SymbolTable symbolTable = astSymbols.get(node);
        if (!this.astSymbols.containsKey(node))
        {
            throw new RuntimeException("No symbol table found for node");
        }

        return symbolTable.GetSymbol(name, type);
    }

    public String GetRefTypeName(AstNode node)
    {
        // Return class name if exists, else null
        return this.refTypes.get(node);
    }

    public SymbolTable GetIdentifierScopeSymbolTable(AstNode astNode)
    {
        return this.identiferScope.get(astNode);
    }
}
