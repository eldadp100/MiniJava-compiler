package visitors;

import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import ast.*;
import ir.*;
import semantic.*;

public class AstSemanticCheckVisitor implements Visitor {
    private SemanticDB semanticDB = new SemanticDB();
    private String currentClassName;
    private String currentMethodName;
    private String currentVarType;

    @Override
    public void visit(Program program) {
        // First, create a mapping of the classes hierarchy
        for (ClassDecl classDecl : program.classDecls()) {
            semanticDB.addClass(classDecl.name(), classDecl.superName(), false);
        }

        // Add the main class
        semanticDB.addClass(program.mainClass().name(), null, true);
        program.mainClass().accept(this);

        for (ClassDecl classDecl : program.classDecls()) {
            classDecl.accept(this);
        }
    }

    @Override
    public void visit(ClassDecl classDecl) {
        currentClassName = classDecl.name();

        for (var fieldDecl : classDecl.fields()) {
            fieldDecl.accept(this);
            semanticDB.addClassField(classDecl.name(), fieldDecl.name(), currentVarType);
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
        var methodInfo = new MethodInfo(methodDecl.name());
        currentMethodName = methodDecl.name();

        methodDecl.returnType().accept(this);
        methodInfo.setRetType(currentVarType);

        for (var formal : methodDecl.formals()) {
            formal.accept(this);
            methodInfo.addArgType(currentVarType);
        }

        for (var varDecl : methodDecl.vardecls()) {
            varDecl.accept(this);
        }

        for (var stmt : methodDecl.body()) {
            stmt.accept(this);
        }

        methodDecl.ret().accept(this);
        semanticDB.addClassMethod(currentClassName, methodInfo);
    }

    @Override
    public void visit(FormalArg formalArg) {
        formalArg.type().accept(this);
    }

    @Override
    public void visit(VarDecl varDecl) {
        varDecl.type().accept(this);
        semanticDB.validateType(currentVarType);
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
    }

    public void visit(ThisExpr e) {
    }

    @Override
    public void visit(NewIntArrayExpr e) {
        e.lengthExpr().accept(this);
    }

    @Override
    public void visit(NewObjectExpr e) {
        semanticDB.validateClassType(e.classId());
    }

    @Override
    public void visit(NotExpr e) {
        e.e().accept(this);
    }

    @Override
    public void visit(IntAstType t) {
        currentVarType = "int";
    }

    @Override
    public void visit(BoolAstType t) {
        currentVarType = "bool";
    }

    @Override
    public void visit(IntArrayAstType t) {
        currentVarType = "int[]";
    }

    @Override
    public void visit(RefType t) {
        currentVarType = t.id();
    }
}
