package visitors;

import java.util.Stack;

import ast.*;
import symbol.AstSymbols;
import symbol.Symbol;
import symbol.SymbolType;
import visitors.helpers.SuspectedMethodCall;

public class AstRenamerVisitor implements Visitor {
    private AstSymbols astSymbols;
    private String symbolToRename;
    private String newSymbolName;
    private int symbolLine;
    private SymbolType symbolType;
    private Stack<SuspectedMethodCall> suspectedMethodCalls = new Stack<>();

    public AstRenamerVisitor(AstSymbols astSymbols, String originalName, String newName,
                                int line, boolean isMethod)
    {    
        this.astSymbols = astSymbols;
        this.symbolToRename = originalName;
        this.newSymbolName = newName;
        this.symbolLine = line;
        this.symbolType = isMethod ? SymbolType.METHOD : SymbolType.VAR;
    }

    private boolean ShouldRenameStatement(AstNode node, String name)
    {
        if (!name.equals(this.symbolToRename))
            return false;

        if (this.symbolType != SymbolType.VAR)
            return false;

        Symbol symbol = this.astSymbols.GetSymbol(node, name, SymbolType.VAR);
        return symbol.getLine() == this.symbolLine;
    }

    private void ShouldRenameMethodCall(MethodCallExpr methodCall)
    {
        if (!methodCall.methodId().equals(this.symbolToRename))
            return;

        if (this.symbolType != SymbolType.METHOD)
            return;

        // Notice that we pass the owner expression when looking for symbols here
        Symbol symbol = this.astSymbols.GetSymbol(
            methodCall.ownerExpr(), methodCall.methodId(), SymbolType.METHOD);

        // Save the method call expression to be resolved later
        this.suspectedMethodCalls.push(new SuspectedMethodCall(methodCall, symbol));
    }

    private void RenameMethodSymbolIfNeeded(AstNode node, String name)
    {
        if (!name.equals(this.symbolToRename))
            return;

        if (this.symbolType != SymbolType.METHOD)
            return;

        var symbolTable = this.astSymbols.GetSymbolTableByNode(node);
        symbolTable.RenameMethodInHierarchy(name, this.newSymbolName, this.symbolLine);
    }

    private void RenameVarSymbolIfNeeded(AstNode node, String name)
    {
        if (node.lineNumber != this.symbolLine)
            return;

        if (!name.equals(this.symbolToRename))
            return;

        if (this.symbolType != SymbolType.VAR)
            return;

        Symbol symbol = this.astSymbols.GetSymbol(node, name, symbolType);
        symbol.rename(this.newSymbolName);
    }

    @Override
    public void visit(Program program) {
        program.mainClass().accept(this);

        for (ClassDecl classDecl : program.classDecls()) {
            classDecl.accept(this);
        }

        // Resolve suspected method calls
        while (!suspectedMethodCalls.empty())
            suspectedMethodCalls.pop().resolve();
    }

    @Override
    public void visit(ClassDecl classDecl) {
        for (var fieldDecl : classDecl.fields()) {
            fieldDecl.accept(this);
        }
        for (var methodDecl : classDecl.methoddecls()) {
            methodDecl.accept(this);
        }
    }

    @Override
    public void visit(MainClass mainClass) {
        mainClass.mainStatement().accept(this);
    }

    @Override
    public void visit(MethodDecl methodDecl) {
        this.RenameMethodSymbolIfNeeded(methodDecl, methodDecl.name());

        methodDecl.returnType().accept(this);
        
        for (var formal : methodDecl.formals()) {
            formal.accept(this);
        }
        for (var varDecl : methodDecl.vardecls()) {
            varDecl.accept(this);
        }
        for (var stmt : methodDecl.body()) {
            stmt.accept(this);
        }

        methodDecl.ret().accept(this);
    }

    @Override
    public void visit(FormalArg formalArg) {
        this.RenameVarSymbolIfNeeded(formalArg, formalArg.name());

        formalArg.type().accept(this);
    }

    @Override
    public void visit(VarDecl varDecl) {
        this.RenameVarSymbolIfNeeded(varDecl, varDecl.name());

        varDecl.type().accept(this);
    }

    @Override
    public void visit(BlockStatement blockStatement) {
        for (var s : blockStatement.statements()) {
            s.accept(this);
        }
    }

    @Override
    public void visit(IfStatement ifStatement) {
        ifStatement.cond().accept(this);
        ifStatement.thencase().accept(this);
        ifStatement.elsecase().accept(this);
    }

    @Override
    public void visit(WhileStatement whileStatement) {
        whileStatement.cond().accept(this);
        whileStatement.body().accept(this);
    }

    @Override
    public void visit(SysoutStatement sysoutStatement) {
        sysoutStatement.arg().accept(this);
    }

    @Override
    public void visit(AssignStatement assignStatement) {
        if (this.ShouldRenameStatement(assignStatement, assignStatement.lv()))
        {
            assignStatement.setLv(this.newSymbolName);
        }

        assignStatement.rv().accept(this);
    }

    @Override
    public void visit(AssignArrayStatement assignArrayStatement) {
        assignArrayStatement.index().accept(this);
        assignArrayStatement.rv().accept(this);
    }

    @Override
    public void visit(AndExpr e) {
        e.e1().accept(this);
        e.e2().accept(this);
    }

    @Override
    public void visit(LtExpr e) {
        e.e1().accept(this);
        e.e2().accept(this);
    }

    @Override
    public void visit(AddExpr e) {
        e.e1().accept(this);
        e.e2().accept(this);
    }

    @Override
    public void visit(SubtractExpr e) {
        e.e1().accept(this);
        e.e2().accept(this);
    }

    @Override
    public void visit(MultExpr e) {
        e.e1().accept(this);
        e.e2().accept(this);
    }

    @Override
    public void visit(ArrayAccessExpr e) {
        e.arrayExpr().accept(this);
        e.indexExpr().accept(this);
    }

    @Override
    public void visit(ArrayLengthExpr e) {
        e.arrayExpr().accept(this);
    }

    @Override
    public void visit(MethodCallExpr e) {  
        this.ShouldRenameMethodCall(e);
        
        e.ownerExpr().accept(this);

        for (Expr arg : e.actuals()) {
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
        if (this.ShouldRenameStatement(e, e.id()))
        {
            e.setId(this.newSymbolName);
        }
    }

    public void visit(ThisExpr e) {
    }

    @Override
    public void visit(NewIntArrayExpr e) {
        e.lengthExpr().accept(this);
    }

    @Override
    public void visit(NewObjectExpr e) {
    }

    @Override
    public void visit(NotExpr e) {
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