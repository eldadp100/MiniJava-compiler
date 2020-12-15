package visitors;

import java.util.Stack;

import ast.*;
import symbol.AstSymbols;
import symbol.SymbolTable;
import symbol.SymbolType;
import symbol.UnresolvedSymbol;

public class AstSymbolsVisitor implements Visitor {
    private AstSymbols astSymbols = new AstSymbols();
    private Stack<UnresolvedSymbol> unresolvedSymbols = new Stack<>();

    private void CreateSymbolTable(AstNode node)
    {
        CreateSymbolTable(node, null, null);
    }

    private void CreateSymbolTable(AstNode node, String className)
    {
        CreateSymbolTable(node, null, className);
    }

    private void CreateSymbolTable(AstNode node, AstNode parentNode)
    {
        CreateSymbolTable(node, astSymbols.GetSymbolTableByNode(parentNode), null);
    }

    private void CreateSymbolTable(AstNode node, SymbolTable parentSymbolTable, String className)
    {        
        SymbolTable symbolTable;
        if (parentSymbolTable == null)
            symbolTable = new SymbolTable();
        else
            symbolTable = new SymbolTable(parentSymbolTable);

        if (className == null)
            astSymbols.InsertMethod(node, symbolTable);
        else
            astSymbols.InsertClass(node, symbolTable, className);
    }

    private void RedirectSymbolTable(AstNode node, AstNode parentNode)
    {
        astSymbols.InsertNodeRedirection(node, astSymbols.GetSymbolTableByNode(parentNode));
    }

    private void InsertSymbol(AstNode parent, String name, SymbolType type, AstNode node)
    {
        var scopeSymbolTable = astSymbols.GetSymbolTableByNode(parent);
        scopeSymbolTable.InsertSymbol(name, type, node);
    }

    public AstSymbols GetAstSymbolTable()
    {
        return astSymbols;
    }

    @Override
    public void visit(Program program) {
        // Initialize a new AstSymbols object
        this.astSymbols = new AstSymbols();

        program.mainClass().accept(this);

        for (ClassDecl classDecl : program.classDecls()) {
            classDecl.accept(this);
        }

        // Handle unresolved symbols
        while (!unresolvedSymbols.empty())
            unresolvedSymbols.pop().resolve(this.astSymbols);
    }

    @Override
    public void visit(ClassDecl classDecl) {
        if (classDecl.superName() != null)
        {
            var parentClassSymbolTable = this.astSymbols.GetSymbolTableByClass(classDecl.superName());
            CreateSymbolTable(classDecl, parentClassSymbolTable, classDecl.name());
        }
        else
        {
            CreateSymbolTable(classDecl, classDecl.name());
        }
        
        for (var fieldDecl : classDecl.fields()) {
            InsertSymbol(classDecl, fieldDecl.name(), SymbolType.VAR, fieldDecl);
            RedirectSymbolTable(fieldDecl, classDecl);
            fieldDecl.accept(this);
        }
        for (var methodDecl : classDecl.methoddecls()) {
            InsertSymbol(classDecl, methodDecl.name(), SymbolType.METHOD, methodDecl);
            CreateSymbolTable(methodDecl, classDecl);
            methodDecl.accept(this);
        }
    }

    @Override
    public void visit(MainClass mainClass) {
        CreateSymbolTable(mainClass.mainStatement());
        mainClass.mainStatement().accept(this);
    }

    @Override
    public void visit(MethodDecl methodDecl) {
        RedirectSymbolTable(methodDecl.returnType(), methodDecl);
        methodDecl.returnType().accept(this);
        
        for (var formal : methodDecl.formals()) {
            InsertSymbol(methodDecl, formal.name(), SymbolType.VAR, formal);
            RedirectSymbolTable(formal, methodDecl);
            formal.accept(this);
        }
        for (var varDecl : methodDecl.vardecls()) {
            InsertSymbol(methodDecl, varDecl.name(), SymbolType.VAR, varDecl);
            RedirectSymbolTable(varDecl, methodDecl);
            varDecl.accept(this);
        }
        for (var stmt : methodDecl.body()) {
            RedirectSymbolTable(stmt, methodDecl);
            stmt.accept(this);
        }

        RedirectSymbolTable(methodDecl.ret(), methodDecl);
        methodDecl.ret().accept(this);
    }

    @Override
    public void visit(FormalArg formalArg) {
        RedirectSymbolTable(formalArg.type(), formalArg);
        formalArg.type().accept(this);
    }

    @Override
    public void visit(VarDecl varDecl) {
        RedirectSymbolTable(varDecl.type(), varDecl);
        varDecl.type().accept(this);
    }

    @Override
    public void visit(BlockStatement blockStatement) {
        for (var s : blockStatement.statements()) {
            RedirectSymbolTable(s, blockStatement);
            s.accept(this);
        }
    }

    @Override
    public void visit(IfStatement ifStatement) {
        RedirectSymbolTable(ifStatement.cond(), ifStatement);
        ifStatement.cond().accept(this);

        RedirectSymbolTable(ifStatement.thencase(), ifStatement);
        ifStatement.thencase().accept(this);

        RedirectSymbolTable(ifStatement.elsecase(), ifStatement);
        ifStatement.elsecase().accept(this);
    }

    @Override
    public void visit(WhileStatement whileStatement) {
        RedirectSymbolTable(whileStatement.cond(), whileStatement);
        whileStatement.cond().accept(this);

        RedirectSymbolTable(whileStatement.body(), whileStatement);
        whileStatement.body().accept(this);
    }

    @Override
    public void visit(SysoutStatement sysoutStatement) {
        RedirectSymbolTable(sysoutStatement.arg(), sysoutStatement);
        sysoutStatement.arg().accept(this);
    }

    @Override
    public void visit(AssignStatement assignStatement) {
        RedirectSymbolTable(assignStatement.rv(), assignStatement);
        assignStatement.rv().accept(this);
    }

    @Override
    public void visit(AssignArrayStatement assignArrayStatement) {
        RedirectSymbolTable(assignArrayStatement.index(), assignArrayStatement);
        assignArrayStatement.index().accept(this);

        RedirectSymbolTable(assignArrayStatement.rv(), assignArrayStatement);
        assignArrayStatement.rv().accept(this);
    }

    @Override
    public void visit(AndExpr e) {
        RedirectSymbolTable(e.e1(), e);
        e.e1().accept(this);

        RedirectSymbolTable(e.e2(), e);
        e.e2().accept(this);
    }

    @Override
    public void visit(LtExpr e) {
        RedirectSymbolTable(e.e1(), e);
        e.e1().accept(this);

        RedirectSymbolTable(e.e2(), e);
        e.e2().accept(this);
    }

    @Override
    public void visit(AddExpr e) {
        RedirectSymbolTable(e.e1(), e);
        e.e1().accept(this);

        RedirectSymbolTable(e.e2(), e);
        e.e2().accept(this);
    }

    @Override
    public void visit(SubtractExpr e) {
        RedirectSymbolTable(e.e1(), e);
        e.e1().accept(this);

        RedirectSymbolTable(e.e2(), e);
        e.e2().accept(this);
    }

    @Override
    public void visit(MultExpr e) {
        RedirectSymbolTable(e.e1(), e);
        e.e1().accept(this);

        RedirectSymbolTable(e.e2(), e);
        e.e2().accept(this);
    }

    @Override
    public void visit(ArrayAccessExpr e) {
        RedirectSymbolTable(e.arrayExpr(), e);
        e.arrayExpr().accept(this);
        
        RedirectSymbolTable(e.indexExpr(), e);
        e.indexExpr().accept(this);
    }

    @Override
    public void visit(ArrayLengthExpr e) {
        RedirectSymbolTable(e.arrayExpr(), e);
        e.arrayExpr().accept(this);
    }

    @Override
    public void visit(MethodCallExpr e) { 
        RedirectSymbolTable(e.ownerExpr(), e);
        e.ownerExpr().accept(this);

        for (Expr arg : e.actuals()) {
            RedirectSymbolTable(arg, e);
            arg.accept(this);
        }
    }

    @Override
    public void visit(IntegerLiteralExpr e) {
    }

    @Override
    public void visit(TrueExpr e) {
    }

    @Override
    public void visit(FalseExpr e) {
    }

    @Override
    public void visit(IdentifierExpr e) {
        var symbol = this.astSymbols.GetSymbol(e, e.id(), SymbolType.VAR);
        String className = this.astSymbols.GetRefTypeName(symbol.getStaticType());
        if (className != null)
        {
            // We would like to update the symbol table of this node later,
            // when all classes have been resolved.
            unresolvedSymbols.push(new UnresolvedSymbol(e, className));
        }
    }

    public void visit(ThisExpr e) {
    }

    @Override
    public void visit(NewIntArrayExpr e) {
        RedirectSymbolTable(e.lengthExpr(), e);
        e.lengthExpr().accept(this);
    }

    @Override
    public void visit(NewObjectExpr e) {
        // We would like to update the symbol table of this node later,
        // when all classes have been resolved.
        unresolvedSymbols.push(new UnresolvedSymbol(e, e.classId()));
    }

    @Override
    public void visit(NotExpr e) {
        RedirectSymbolTable(e.e(), e);
        e.e().accept(this);
    }

    @Override
    public void visit(IntAstType t) {
    }

    @Override
    public void visit(BoolAstType t) {
    }

    @Override
    public void visit(IntArrayAstType t) {
    }

    @Override
    public void visit(RefType t) {
        this.astSymbols.InsertRefType(t, t.id());
    }
}