package visitors;

import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import ast.*;
import ir.*;
import semantic.*;

public class AstSemanticCheckVisitor implements Visitor {
    private SemanticDB semanticDB;
    private String currentClassName;
    private String currentMethodName;
    private String currentVarType;

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

    private void validateArrayType(Expr expr) {
        if (expr instanceof IdentifierExpr) {
            var refId = ((IdentifierExpr)expr).id();
            semanticDB.validateArrayType(currentClassName, currentMethodName, refId);
        }
        else {
            throw new RuntimeException("Expr is not of type int[]");
        }
    }

    private void validateBoolType(Expr expr) {
        var type = extractExprType(expr);
        if (!type.equals("bool")) {
            throw new RuntimeException("Expr is not of type bool");
        }
    }

    private void validateIntType(Expr expr) {
        var retType = extractExprType(expr);
        if (!retType.equals("int")) {
            throw new RuntimeException("Expr is not of type int");
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
        mainClass.mainStatement().accept(this);
    }

    @Override
    public void visit(MethodDecl methodDecl) {
        // TODO: Remove
        // System.out.println(String.format("ClassName: %s, MethodName: %s", currentClassName, currentMethodName));

        currentMethodName = methodDecl.name();

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
        validateBoolType(ifStatement.cond());

        ifStatement.cond().accept(this);
        ifStatement.thencase().accept(this);
        ifStatement.elsecase().accept(this);
    }

    @Override
    public void visit(WhileStatement whileStatement) {
        validateBoolType(whileStatement.cond());

        whileStatement.cond().accept(this);
        whileStatement.body().accept(this);
    }

    @Override
    public void visit(SysoutStatement sysoutStatement) {
        validateIntType(sysoutStatement.arg());

        sysoutStatement.arg().accept(this);
    }

    @Override
    public void visit(AssignStatement assignStatement) {
        var lvType = semanticDB.getRefIdType(currentClassName, currentMethodName, assignStatement.lv());
        var rvType = extractExprType(assignStatement.rv());
        semanticDB.validateSubType(lvType, rvType);

        assignStatement.rv().accept(this);
    }

    @Override
    public void visit(AssignArrayStatement assignArrayStatement) {
        semanticDB.validateArrayType(currentClassName, currentMethodName, assignArrayStatement.lv());
        validateIntType(assignArrayStatement.index());
        validateIntType(assignArrayStatement.rv());

        assignArrayStatement.index().accept(this);
        assignArrayStatement.rv().accept(this);
    }

    @Override
    public void visit(AndExpr e) {
        validateBoolType(e.e1());
        validateBoolType(e.e2());

        e.e1().accept(this);
        e.e2().accept(this);
    }

    @Override
    public void visit(LtExpr e) {
        validateIntType(e.e1());
        validateIntType(e.e2());

        e.e1().accept(this);
        e.e2().accept(this);
    }

    @Override
    public void visit(AddExpr e) {
        validateIntType(e.e1());
        validateIntType(e.e2());

        e.e1().accept(this);
        e.e2().accept(this);
    }

    @Override
    public void visit(SubtractExpr e) {
        validateIntType(e.e1());
        validateIntType(e.e2());

        e.e1().accept(this);
        e.e2().accept(this);
    }

    @Override
    public void visit(MultExpr e) {
        validateIntType(e.e1());
        validateIntType(e.e2());

        e.e1().accept(this);
        e.e2().accept(this);
    }

    @Override
    public void visit(ArrayAccessExpr e) {
        validateArrayType(e.arrayExpr());
        validateIntType(e.indexExpr());

        e.arrayExpr().accept(this);
        e.indexExpr().accept(this);
    }

    @Override
    public void visit(ArrayLengthExpr e) {
        validateArrayType(e.arrayExpr());

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
    }

    public void visit(ThisExpr e) {
    }

    @Override
    public void visit(NewIntArrayExpr e) {
        validateIntType(e.lengthExpr());

        e.lengthExpr().accept(this);
    }

    @Override
    public void visit(NewObjectExpr e) {
        semanticDB.validateClassType(e.classId());
    }

    @Override
    public void visit(NotExpr e) {
        validateBoolType(e.e());

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
