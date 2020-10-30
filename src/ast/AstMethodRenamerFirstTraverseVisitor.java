package ast;

import java.util.ArrayList;

public class AstMethodRenamerFirstTraverseVisitor implements Visitor {
    String originalName;
    int originalLine;

    public boolean declFound = false;
    public MethodDecl decl = null;
    public ClassDecl method_class = null;
    public ClassDecl declInClass = null;
    public ArrayList<MethodCallExpr> calls = new ArrayList<>();
    public ArrayList<ClassDecl> superclasses = new ArrayList<>();
    public ArrayList<ClassDecl> extendsclasees = new ArrayList<>();

    // public ? vars_static_types;

    public AstMethodRenamerFirstTraverseVisitor(String _originalName, int _originalLine) {
        originalName = _originalName;
        originalLine = _originalLine;
    }


    private void generalAtStart(AstNode node) {
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
        boolean tmp = declFound;
        boolean add_extenders = false;
        boolean add_supers = true;
        for (ClassDecl classdecl : program.classDecls()) {
            if (add_supers)
            {
                if ((superclasses.size() == 0) || (classdecl.superName() == superclasses.get(superclasses.size()-1).name()))
                {
                    superclasses.add(classdecl);
                } else {
                    superclasses.clear();
                    superclasses.add(classdecl);
                }
            }
            else if (add_extenders)
            {
                extendsclasees.add(classdecl);
            }
            
            classdecl.accept(this);
            if (!tmp && declFound)
            {
                method_class = classdecl;
                add_extenders = true;
                add_supers = false;
            }
        }
    }

    @Override
    public void visit(ClassDecl classDecl) {
        generalAtStart(classDecl);

        for (var fieldDecl : classDecl.fields()) {
            fieldDecl.accept(this);
        }
        for (var methodDecl : classDecl.methoddecls()) {
            boolean tmp = declFound;
            methodDecl.accept(this);
            if (!tmp && declFound){
                // we found the decliration! Lets find the classes
                declInClass = classDecl;
            }
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
        if (methodDecl.lineNumber == originalLine){
            decl = methodDecl;
            declFound = true;
        }
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
        if (e.methodId() == originalName) {
            calls.add(e);
        }

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
