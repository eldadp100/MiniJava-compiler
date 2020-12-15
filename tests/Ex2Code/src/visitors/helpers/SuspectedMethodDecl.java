package visitors.helpers;

import symbol.SymbolTable;

public class SuspectedMethodDecl {
    private SymbolTable symbolTable;
    private String name;
    private String newName;

    public SuspectedMethodDecl(SymbolTable symbolTable, String name, String newName)
    {
        this.symbolTable = symbolTable;
        this.name = name;
        this.newName = newName;
    }

    public void resolve()
    {
        this.symbolTable.RenameMethodIfRenamedInHierarchy(this.name, this.newName);
    }    
}
