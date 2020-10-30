package ast;

import java.util.ArrayList;

public class AstMethodRenamerFirstTraverseVisitor implements Visitor {
    String originalName;
    int originalLine;
    String newName;

    ArrayList<AstNode> nodes = new ArrayList<>();

    public AstMethodRenamerFirstTraverseVisitor(String _originalName, int _originalLine, String _newName) {
        originalName = _originalName;
        originalLine = _originalLine;
        newName = _newName;
    }

    public ArrayList<AstNode> getVisitorOrignalLines() {
        return nodes;
    }

    public void isTheLine(AstNode node) {
        if (node.lineNumber == originalLine) {
            nodes.add(node);
        }
    }

    public void generalAtStart(AstNode node) {
        isTheLine(node);
    }

    private void visitBinaryExpr(BinaryExpr e, String infixSymbol) {
        generalAtStart(e);
        e.e1().accept(this);
        e.e2().accept(this);
    }

    @Override
    public void visit(Program program) {
        generalAtStart(program);
        program.mainClass().accept(this);
        for (ClassDecl classdecl : program.classDecls()) {
            classdecl.accept(this);
        }
    }

    @Override
    public void visit(ClassDecl classDecl) {
        generalAtStart(classDecl);

        for (var fieldDecl : classDecl.fields()) {
            fieldDecl.accept(this);
        }
        for (var methodDecl : classDecl.methoddecls()) {
            methodDecl.accept(this);
        }
    }

    @Override
    public void visit(MainClass mainClass) {
        generalAtStart(mainClass);

        generalAtStart(mainClass);
        mainClass.mainStatement().accept(this);

    }

    @Override
    public void visit(MethodDecl methodDecl) {
        generalAtStart(methodDecl);
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
        generalAtStart(formalArg);
        formalArg.type().accept(this);

    }

    @Override
    public void visit(VarDecl varDecl) {
        generalAtStart(varDecl);

        varDecl.type().accept(this);

    }

    @Override
    public void visit(BlockStatement blockStatement) {
        generalAtStart(blockStatement);

        for (var s : blockStatement.statements()) {

            s.accept(this);
        }

    }

    @Override
    public void visit(IfStatement ifStatement) {
        generalAtStart(ifStatement);

        ifStatement.cond().accept(this);

        ifStatement.thencase().accept(this);

        ifStatement.elsecase().accept(this);

    }

    @Override
    public void visit(WhileStatement whileStatement) {
        generalAtStart(whileStatement);
        whileStatement.cond().accept(this);

        whileStatement.body().accept(this);

    }

    @Override
    public void visit(SysoutStatement sysoutStatement) {
        generalAtStart(sysoutStatement);
        sysoutStatement.arg().accept(this);

    }

    @Override
    public void visit(AssignStatement assignStatement) {
        generalAtStart(assignStatement);
        assignStatement.rv().accept(this);

    }

    @Override
    public void visit(AssignArrayStatement assignArrayStatement) {
        generalAtStart(assignArrayStatement);
        assignArrayStatement.index().accept(this);

        assignArrayStatement.rv().accept(this);

    }

    @Override
    public void visit(AndExpr e) {
        generalAtStart(e);
        visitBinaryExpr(e, "&&");
    }

    @Override
    public void visit(LtExpr e) {
        generalAtStart(e);
        visitBinaryExpr(e, "<");
    }

    @Override
    public void visit(AddExpr e) {
        generalAtStart(e);
        visitBinaryExpr(e, "+");
    }

    @Override
    public void visit(SubtractExpr e) {
        generalAtStart(e);
        visitBinaryExpr(e, "-");
    }

    @Override
    public void visit(MultExpr e) {
        generalAtStart(e);
        visitBinaryExpr(e, "*");
    }

    @Override
    public void visit(ArrayAccessExpr e) {
        generalAtStart(e);

        e.arrayExpr().accept(this);

        e.indexExpr().accept(this);

    }

    @Override
    public void visit(ArrayLengthExpr e) {
        generalAtStart(e);

        e.arrayExpr().accept(this);

    }

    @Override
    public void visit(MethodCallExpr e) {
        generalAtStart(e);
        e.ownerExpr().accept(this);
        for (Expr arg : e.actuals()) {
            arg.accept(this);
        }
    }

    @Override
    public void visit(IntegerLiteralExpr e) {
        generalAtStart(e);
    }

    @Override
    public void visit(TrueExpr e) {
        generalAtStart(e);
    }

    @Override
    public void visit(FalseExpr e) {
        generalAtStart(e);
    }

    @Override
    public void visit(IdentifierExpr e) {
        generalAtStart(e);
    }

    public void visit(ThisExpr e) {
        generalAtStart(e);
    }

    @Override
    public void visit(NewIntArrayExpr e) {
        generalAtStart(e);
        e.lengthExpr().accept(this);
    }

    @Override
    public void visit(NewObjectExpr e) {
        generalAtStart(e);
    }

    @Override
    public void visit(NotExpr e) {
        generalAtStart(e);
        e.e().accept(this);
    }

    @Override
    public void visit(IntAstType t) {
        generalAtStart(t);
    }

    @Override
    public void visit(BoolAstType t) {
        generalAtStart(t);
    }

    @Override
    public void visit(IntArrayAstType t) {
        generalAtStart(t);
    }

    @Override
    public void visit(RefType t) {
        generalAtStart(t);
    }
}
