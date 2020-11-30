import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import ast.*;
import ir.*;
import symbol.AstSymbols;
import symbol.SymbolTable;

public class AstIRClassGeneratorVisitor implements Visitor {
    private IRGenerator irGenerator;
    private IRClass currentIRClass;
    private String currentIRType;
    private String current_variable_type;
    private int current_variable_size;
    private List<String> FormalArgsTypes;


    public AstIRClassGeneratorVisitor()
    {
        this.irGenerator = new IRGenerator();
    }

    public String getString()
    {
        return irGenerator.getString();
    }

    public IRGenerator getIRGenerator()
    {
        return irGenerator;
    }


    @Override
    public void visit(Program program) {
        program.mainClass().accept(this);

        for (ClassDecl classDecl : program.classDecls()) {
            String superName = classDecl.superName();
            if (superName != null) {
                this.currentIRClass = irGenerator.generateClass(classDecl.name(), irGenerator.getClass(superName));
            } else {
                this.currentIRClass = irGenerator.generateClass(classDecl.name());
            }
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

        FormalArgsTypes = new LinkedList<>();

        for (var formal : methodDecl.formals()) { 
            formal.accept(this);
            FormalArgsTypes.add(this.currentIRType);
        }

        this.currentIRClass.addMethod(methodDecl.name(), FormalArgsTypes);
    }

    @Override
    public void visit(FormalArg formalArg) {
    }
    
    @Override
    public void visit(VarDecl varDecl) {
        varDecl.type().accept(this);
        this.currentIRClass.addField(varDecl.name(), this.currentIRType, this.current_variable_size);
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
    }

    @Override
    public void visit(NewObjectExpr e) {
    }

    @Override
    public void visit(NotExpr e) {
    }

    @Override
    public void visit(IntAstType t) {
        this.current_variable_size = 4;
        this.currentIRType = "i32";
    }

    @Override
    public void visit(BoolAstType t) {
        this.current_variable_size = 1;
        this.currentIRType = "i1";
    }

    @Override
    public void visit(IntArrayAstType t) {
        this.current_variable_size = 8; // [TODO:] Validate!
        this.currentIRType = "i32*";
    }

    @Override
    public void visit(RefType t) {
        this.current_variable_size = 8;
        this.currentIRType = "i8*";
    }
}
