package visitors;

import ast.*;
import symbol.AstSymbols;
import symbol.Symbol;
import symbol.SymbolType;

public class AstRenameVisitor implements Visitor {
    private AstSymbols astSymbols;
    private String symbolToRename;
    private String newSymbolName;
    private int symbolLine;
    private boolean isMethod;

    public AstRenameVisitor(AstSymbols astSymbols, String originalName, String newName,
                                int line, boolean isMethod)
    {    
        this.astSymbols = astSymbols;
        this.symbolToRename = originalName;
        this.newSymbolName = newName;
        this.symbolLine = line;
        this.isMethod = isMethod;
    }

    private boolean IsRenameRequired(AstNode node, String name)
    {
        if (!name.equals(this.symbolToRename))
            return false;

        var symbolType = this.isMethod ? SymbolType.METHOD : SymbolType.VAR;
        Symbol symbol = this.astSymbols.GetSymbol(node, name, symbolType);
        return symbol.getLine() == this.symbolLine;
    }

    private void RenameSymbolIfNeeded(AstNode node, String name)
    {
        if (node.lineNumber == this.symbolLine)
        {
            var symbolType = this.isMethod ? SymbolType.METHOD : SymbolType.VAR;
            Symbol symbol = this.astSymbols.GetSymbol(node, name, symbolType);
            symbol.rename(this.newSymbolName);
        }
    }

    @Override
    public void visit(Program program) {
        program.mainClass().accept(this);

        for (ClassDecl classDecl : program.classDecls()) {
            classDecl.accept(this);
        }
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
        formalArg.type().accept(this);
    }

    @Override
    public void visit(VarDecl varDecl) {
        this.RenameSymbolIfNeeded(varDecl, varDecl.name());

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
        if (IsRenameRequired(assignStatement, assignStatement.lv()))
        {
            System.out.println(String.format("%s -> %s", assignStatement.lv(), this.newSymbolName));
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
        if (IsRenameRequired(e, e.id()))
        {
            System.out.println(String.format("%s -> %s", e.id(), this.newSymbolName));
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