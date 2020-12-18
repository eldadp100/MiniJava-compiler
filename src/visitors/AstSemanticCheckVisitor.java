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

    private String extractArgType(Expr arg) {
        if ((arg instanceof IntegerLiteralExpr) ||
            (arg instanceof AddExpr) ||
            (arg instanceof SubtractExpr) ||
            (arg instanceof MultExpr) ||
            (arg instanceof ArrayAccessExpr) ||
            (arg instanceof ArrayLengthExpr)) {
            return "int";
        }
        else if ((arg instanceof TrueExpr) ||
                 (arg instanceof FalseExpr) ||
                 (arg instanceof AndExpr) ||
                 (arg instanceof NotExpr) ||
                 (arg instanceof LtExpr)) {
            return "bool";
        }
        else if (arg instanceof NewIntArrayExpr) {
            return "int[]";
        }
        else if (arg instanceof NewObjectExpr) {
            return ((NewObjectExpr)arg).classId();
        }
        else if (arg instanceof ThisExpr) {
            return currentClassName;
        }
        else if (arg instanceof IdentifierExpr) {
            var refId = ((IdentifierExpr)arg).id();
            return semanticDB.getRefIdType(
                currentClassName, currentMethodName, refId);
        }
        else if (arg instanceof MethodCallExpr) {
            var methodName = ((MethodCallExpr)arg).methodId();
            var className = extractMethodCallOwner(((MethodCallExpr)arg).ownerExpr());
            return semanticDB.getClassMethodInfo(className, methodName).getRetType();
        }
        
        throw new RuntimeException(String.format("arg of unknown type %s", arg.getClass()));
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
        System.out.println(String.format("ClassName: %s, MethodName: %s", currentClassName, currentMethodName));

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
        semanticDB.getRefIdType(currentClassName, currentMethodName, assignStatement.lv());
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

        if (e.arrayExpr() instanceof IdentifierExpr) {
            var refId = ((IdentifierExpr)e.arrayExpr()).id();
            semanticDB.validateArrayType(currentClassName, currentMethodName, refId);
        }
        else {
            throw new RuntimeException(String.format(
                "Length cannot be invoked on object of type %s", e.arrayExpr().getClass()));
        }
    }

    @Override
    public void visit(MethodCallExpr e) {
        e.ownerExpr().accept(this);

        String ownerClassType = extractMethodCallOwner(e.ownerExpr());
        semanticDB.validateClassType(ownerClassType);
        
        List<String> argTypes = new LinkedList<>();
        for (Expr arg : e.actuals()) {
            arg.accept(this);
            argTypes.add(extractArgType(arg));
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
