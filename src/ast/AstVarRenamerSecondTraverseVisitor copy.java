package ast;

public class AstRenameVisitor implements Visitor {
    // Here add the data structures to perform renaming!!! 

    private void visitBinaryExpr(BinaryExpr e, String infixSymbol) {
    }


    @Override
    public void visit(Program program) {
    }

    @Override
    public void visit(ClassDecl classDecl) {
    }

    @Override
    public void visit(MainClass mainClass) {
    }

    @Override
    public void visit(MethodDecl methodDecl) {        
    }

    @Override
    public void visit(FormalArg formalArg) {
    }

    @Override
    public void visit(VarDecl varDecl) {
        appendWithIndent("");
        varDecl.type().accept(this);
        builder.append(" ");
        builder.append(varDecl.name());
        builder.append(";\n");
    }

    @Override
    public void visit(BlockStatement blockStatement) {
    }

    @Override
    public void visit(IfStatement ifStatement) {
    }

    @Override
    public void visit(WhileStatement whileStatement) {
    }

    @Override
    public void visit(SysoutStatement sysoutStatement) {
    }

    @Override
    public void visit(AssignStatement assignStatement) {
    }

    @Override
    public void visit(AssignArrayStatement assignArrayStatement) {
    }

    @Override
    public void visit(AndExpr e) {
    }

    @Override
    public void visit(LtExpr e) {
    }

    @Override
    public void visit(AddExpr e) {
    }

    @Override
    public void visit(SubtractExpr e) {
    }

    @Override
    public void visit(MultExpr e) {
    }

    @Override
    public void visit(ArrayAccessExpr e) {
    }

    @Override
    public void visit(ArrayLengthExpr e) {
    }

    @Override
    public void visit(MethodCallExpr e) {
        builder.append("(");
        e.ownerExpr().accept(this);
        builder.append(")");
        builder.append(".");
        builder.append(e.methodId());
        builder.append("(");

        String delim = "";
        for (Expr arg : e.actuals()) {
            builder.append(delim);
            arg.accept(this);
            delim = ", ";
        }
        builder.append(")");
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
        builder.append(e.id());
    }

    public void visit(ThisExpr e) {
        builder.append("this");
    }

    @Override
    public void visit(NewIntArrayExpr e) {
    }

    @Override
    public void visit(NewObjectExpr e) {
        builder.append("new ");
        builder.append(e.classId());
        builder.append("()");
    }

    @Override
    public void visit(NotExpr e) {
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
        builder.append(t.id());
    }
}
