package visitors;

import ast.*;
import symbol.AstSymbols;
import symbol.SymbolTable;
import symbol.SymbolType;

public class AstSymbolsVisitor implements Visitor {
    private AstSymbols astSymbols = new AstSymbols();

    private void CreateSymbolTable(AstNode node)
    {
        CreateSymbolTable(node, null);
    }

    private void CreateSymbolTable(AstNode node, AstNode parentNode)
    {
        System.out.println("Creating a new symbol table");
        if (parentNode == null)
        {
            astSymbols.Insert(node, new SymbolTable());
        }
        else
        {
            SymbolTable parentSymbolTable = astSymbols.GetSymbolTable(parentNode);
            astSymbols.Insert(node, new SymbolTable(parentSymbolTable));
        }
    }

    private void SkipSymbolTable(AstNode node, AstNode parentNode)
    {
        astSymbols.Insert(node, astSymbols.GetSymbolTable(parentNode));
    }

    private void InsertSymbol(AstNode parent, String name, SymbolType type, AstNode node)
    {
        System.out.println(String.format("Symbol: %s,\tType: %s", name, type.name()));
        var scopeSymbolTable = astSymbols.GetSymbolTable(parent);
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
    }

    @Override
    public void visit(ClassDecl classDecl) {
            CreateSymbolTable(classDecl);
        for (var fieldDecl : classDecl.fields()) {
            InsertSymbol(classDecl, fieldDecl.name(), SymbolType.VAR, fieldDecl);
            SkipSymbolTable(fieldDecl, classDecl);
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
        mainClass.mainStatement().accept(this);
    }

    @Override
    public void visit(MethodDecl methodDecl) {
        SkipSymbolTable(methodDecl.returnType(), methodDecl);
        methodDecl.returnType().accept(this);
        
        for (var formal : methodDecl.formals()) {
            InsertSymbol(methodDecl, formal.name(), SymbolType.VAR, formal);
            SkipSymbolTable(formal, methodDecl);
            formal.accept(this);
        }
        for (var varDecl : methodDecl.vardecls()) {
            InsertSymbol(methodDecl, varDecl.name(), SymbolType.VAR, varDecl);
            SkipSymbolTable(varDecl, methodDecl);
            varDecl.accept(this);
        }
        for (var stmt : methodDecl.body()) {
            SkipSymbolTable(stmt, methodDecl);
            stmt.accept(this);
        }

        SkipSymbolTable(methodDecl.ret(), methodDecl);
        methodDecl.ret().accept(this);
    }

    @Override
    public void visit(FormalArg formalArg) {
        SkipSymbolTable(formalArg.type(), formalArg);
        formalArg.type().accept(this);
    }

    @Override
    public void visit(VarDecl varDecl) {
        SkipSymbolTable(varDecl.type(), varDecl);
        varDecl.type().accept(this);
    }

    @Override
    public void visit(BlockStatement blockStatement) {
        for (var s : blockStatement.statements()) {
            SkipSymbolTable(s, blockStatement);
            s.accept(this);
        }
    }

    @Override
    public void visit(IfStatement ifStatement) {
        SkipSymbolTable(ifStatement.cond(), ifStatement);
        ifStatement.cond().accept(this);

        SkipSymbolTable(ifStatement.thencase(), ifStatement);
        ifStatement.thencase().accept(this);

        SkipSymbolTable(ifStatement.elsecase(), ifStatement);
        ifStatement.elsecase().accept(this);
    }

    @Override
    public void visit(WhileStatement whileStatement) {
        SkipSymbolTable(whileStatement.cond(), whileStatement);
        whileStatement.cond().accept(this);

        SkipSymbolTable(whileStatement.body(), whileStatement);
        whileStatement.body().accept(this);
    }

    @Override
    public void visit(SysoutStatement sysoutStatement) {
        SkipSymbolTable(sysoutStatement.arg(), sysoutStatement);
        sysoutStatement.arg().accept(this);
    }

    @Override
    public void visit(AssignStatement assignStatement) {
        SkipSymbolTable(assignStatement.rv(), assignStatement);
        assignStatement.rv().accept(this);
    }

    @Override
    public void visit(AssignArrayStatement assignArrayStatement) {
        SkipSymbolTable(assignArrayStatement.index(), assignArrayStatement);
        assignArrayStatement.index().accept(this);

        SkipSymbolTable(assignArrayStatement.rv(), assignArrayStatement);
        assignArrayStatement.rv().accept(this);
    }

    @Override
    public void visit(AndExpr e) {
        SkipSymbolTable(e.e1(), e);
        e.e1().accept(this);

        SkipSymbolTable(e.e2(), e);
        e.e2().accept(this);
    }

    @Override
    public void visit(LtExpr e) {
        SkipSymbolTable(e.e1(), e);
        e.e1().accept(this);

        SkipSymbolTable(e.e2(), e);
        e.e2().accept(this);
    }

    @Override
    public void visit(AddExpr e) {
        SkipSymbolTable(e.e1(), e);
        e.e1().accept(this);

        SkipSymbolTable(e.e2(), e);
        e.e2().accept(this);
    }

    @Override
    public void visit(SubtractExpr e) {
        SkipSymbolTable(e.e1(), e);
        e.e1().accept(this);

        SkipSymbolTable(e.e2(), e);
        e.e2().accept(this);
    }

    @Override
    public void visit(MultExpr e) {
        SkipSymbolTable(e.e1(), e);
        e.e1().accept(this);

        SkipSymbolTable(e.e2(), e);
        e.e2().accept(this);
    }

    @Override
    public void visit(ArrayAccessExpr e) {
        SkipSymbolTable(e.arrayExpr(), e);
        e.arrayExpr().accept(this);
        
        SkipSymbolTable(e.indexExpr(), e);
        e.indexExpr().accept(this);
    }

    @Override
    public void visit(ArrayLengthExpr e) {
        SkipSymbolTable(e.arrayExpr(), e);
        e.arrayExpr().accept(this);
    }

    @Override
    public void visit(MethodCallExpr e) { 
        SkipSymbolTable(e.ownerExpr(), e);
        e.ownerExpr().accept(this);

        for (Expr arg : e.actuals()) {
            SkipSymbolTable(arg, e);
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
    }

    public void visit(ThisExpr e) {
    }

    @Override
    public void visit(NewIntArrayExpr e) {
        SkipSymbolTable(e.lengthExpr(), e);
        e.lengthExpr().accept(this);
    }

    @Override
    public void visit(NewObjectExpr e) {
    }

    @Override
    public void visit(NotExpr e) {
        SkipSymbolTable(e.e(), e);
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
    }
}