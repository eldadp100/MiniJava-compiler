package visitors;

import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.HashSet;

import ast.*;
import ir.*;
import semantic.*;

public class AstSemanticCheckVisitor implements Visitor {
    private SemanticDB semanticDB;
    private String currentClassName;
    private String currentMethodName;
    private Set<String> currentUninitVars;

    public AstSemanticCheckVisitor(SemanticDB semanticDB) {
        this.semanticDB = semanticDB;
    }

    private String extractMethodCallOwner(Expr ownerExpr) {
        if (ownerExpr instanceof IdentifierExpr) {
            var refId = ((IdentifierExpr)ownerExpr).id();
            return semanticDB.getRefIdType(
                currentClassName, currentMethodName, refId);
        }
        else if (ownerExpr instanceof ThisExpr) {
            return currentClassName;
        }
        else if (ownerExpr instanceof NewObjectExpr) {
            return ((NewObjectExpr)ownerExpr).classId();
        }
        
        throw new RuntimeException(String.format("Invalid owner type %s", ownerExpr.getClass()));
    }

    private String extractExprType(Expr expr) {
        if ((expr instanceof IntegerLiteralExpr) ||
            (expr instanceof AddExpr) ||
            (expr instanceof SubtractExpr) ||
            (expr instanceof MultExpr) ||
            (expr instanceof ArrayAccessExpr) ||
            (expr instanceof ArrayLengthExpr)) {
            return "int";
        }
        else if ((expr instanceof TrueExpr) ||
                 (expr instanceof FalseExpr) ||
                 (expr instanceof AndExpr) ||
                 (expr instanceof NotExpr) ||
                 (expr instanceof LtExpr)) {
            return "bool";
        }
        else if (expr instanceof NewIntArrayExpr) {
            return "int[]";
        }
        else if (expr instanceof NewObjectExpr) {
            return ((NewObjectExpr)expr).classId();
        }
        else if (expr instanceof ThisExpr) {
            return currentClassName;
        }
        else if (expr instanceof IdentifierExpr) {
            var refId = ((IdentifierExpr)expr).id();
            return semanticDB.getRefIdType(
                currentClassName, currentMethodName, refId);
        }
        else if (expr instanceof MethodCallExpr) {
            var methodName = ((MethodCallExpr)expr).methodId();
            var className = extractMethodCallOwner(((MethodCallExpr)expr).ownerExpr());
            return semanticDB.getClassMethodInfo(className, methodName).getRetType();
        }
        
        throw new RuntimeException(String.format("expr of unknown type %s", expr.getClass()));
    }

    private void validateMethodRetType(Expr ret) {
        var retType = extractExprType(ret);
        semanticDB.validateMethodRetType(currentClassName, currentMethodName, retType);
    }

    private void validateType(Expr expr, String correctType) {
        var type = extractExprType(expr);
        if (!type.equals(correctType)) {
            throw new RuntimeException(String.format("Expr is not of type %s", correctType));
        }
    }

    private void validateInitialized(String refId) {
        var methodInfo = semanticDB.getClassMethodInfo(currentClassName, currentMethodName);
        if (!methodInfo.hasLocalVar(refId)) {
            return;
        }

        if (currentUninitVars.contains(refId)) {
            throw new RuntimeException(String.format("Accessing uninitialized var %s", refId));
        }
    }

    private void setInitialized(String refId) {
        if (currentUninitVars.contains(refId)) {
            currentUninitVars.remove(refId);
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
        currentClassName = classDecl.name();

        for (var fieldDecl : classDecl.fields()) {
            fieldDecl.accept(this);
        }

        for (var methodDecl : classDecl.methoddecls()) {
            methodDecl.accept(this);
        }
    }

    @Override
    public void visit(MainClass mainClass) {
        currentClassName = mainClass.name();

        currentUninitVars = new HashSet<String>();
        mainClass.mainStatement().accept(this);
    }

    @Override
    public void visit(MethodDecl methodDecl) {
        currentMethodName = methodDecl.name();

        methodDecl.returnType().accept(this);

        for (var formal : methodDecl.formals()) {
            formal.accept(this);
        }

        currentUninitVars = new HashSet<String>();
        for (var varDecl : methodDecl.vardecls()) {
            varDecl.accept(this);
            currentUninitVars.add(varDecl.name());
        }

        for (var stmt : methodDecl.body()) {
            stmt.accept(this);
        }

        validateMethodRetType(methodDecl.ret());
        methodDecl.ret().accept(this);
    }

    @Override
    public void visit(FormalArg formalArg) {
        formalArg.type().accept(this);
    }

    @Override
    public void visit(VarDecl varDecl) {
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
        validateType(ifStatement.cond(), "bool");
        ifStatement.cond().accept(this);

        var orgUninitVars = currentUninitVars;

        currentUninitVars = new HashSet<String>(orgUninitVars);
        ifStatement.thencase().accept(this);
        var thenUninitVars = currentUninitVars;

        currentUninitVars = new HashSet<String>(orgUninitVars);
        ifStatement.elsecase().accept(this);
        var elseUninitVars = currentUninitVars;

        // Join the two sets
        thenUninitVars.addAll(elseUninitVars);
        currentUninitVars = thenUninitVars; 
    }

    @Override
    public void visit(WhileStatement whileStatement) {
        validateType(whileStatement.cond(), "bool");
        whileStatement.cond().accept(this);

        var orgUninitVars = currentUninitVars;
        currentUninitVars = new HashSet<String>(orgUninitVars);
        whileStatement.body().accept(this);
        currentUninitVars = orgUninitVars;
    }

    @Override
    public void visit(SysoutStatement sysoutStatement) {
        validateType(sysoutStatement.arg(), "int");
        sysoutStatement.arg().accept(this);
    }

    @Override
    public void visit(AssignStatement assignStatement) {
        var lvType = semanticDB.getRefIdType(currentClassName, currentMethodName, assignStatement.lv());
        var rvType = extractExprType(assignStatement.rv());
        semanticDB.validateSubType(lvType, rvType);
        
        assignStatement.rv().accept(this);

        setInitialized(assignStatement.lv());
    }

    @Override
    public void visit(AssignArrayStatement assignArrayStatement) {
        semanticDB.validateRefIdType(currentClassName, currentMethodName, assignArrayStatement.lv(), "int[]");
        validateType(assignArrayStatement.index(), "int");
        validateType(assignArrayStatement.rv(), "int");

        assignArrayStatement.index().accept(this);
        assignArrayStatement.rv().accept(this);

        setInitialized(assignArrayStatement.lv());
    }

    @Override
    public void visit(AndExpr e) {
        validateType(e.e1(), "bool");
        validateType(e.e2(), "bool");

        e.e1().accept(this);
        e.e2().accept(this);
    }

    @Override
    public void visit(LtExpr e) {
        validateType(e.e1(), "int");
        validateType(e.e2(), "int");

        e.e1().accept(this);
        e.e2().accept(this);
    }

    @Override
    public void visit(AddExpr e) {
        validateType(e.e1(), "int");
        validateType(e.e2(), "int");

        e.e1().accept(this);
        e.e2().accept(this);
    }

    @Override
    public void visit(SubtractExpr e) {
        validateType(e.e1(), "int");
        validateType(e.e2(), "int");

        e.e1().accept(this);
        e.e2().accept(this);
    }

    @Override
    public void visit(MultExpr e) {
        validateType(e.e1(), "int");
        validateType(e.e2(), "int");

        e.e1().accept(this);
        e.e2().accept(this);
    }

    @Override
    public void visit(ArrayAccessExpr e) {
        validateType(e.arrayExpr(), "int[]");
        validateType(e.indexExpr(), "int");

        e.arrayExpr().accept(this);
        e.indexExpr().accept(this);
    }

    @Override
    public void visit(ArrayLengthExpr e) {
        validateType(e.arrayExpr(), "int[]");
        
        e.arrayExpr().accept(this);
    }

    @Override
    public void visit(MethodCallExpr e) {
        e.ownerExpr().accept(this);

        String ownerClassType = extractMethodCallOwner(e.ownerExpr());
        semanticDB.validateClassType(ownerClassType);
        
        List<String> argTypes = new LinkedList<>();
        for (Expr arg : e.actuals()) {
            arg.accept(this);
            argTypes.add(extractExprType(arg));
        }
        semanticDB.validateMethodCallArgs(ownerClassType, e.methodId(), argTypes);
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
        semanticDB.getRefIdType(currentClassName, currentMethodName, e.id());
        validateInitialized(e.id());
    }

    public void visit(ThisExpr e) {
    }

    @Override
    public void visit(NewIntArrayExpr e) {
        validateType(e.lengthExpr(), "int");
        e.lengthExpr().accept(this);
    }

    @Override
    public void visit(NewObjectExpr e) {
        semanticDB.validateClassType(e.classId());
    }

    @Override
    public void visit(NotExpr e) {
        validateType(e.e(), "bool");
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
