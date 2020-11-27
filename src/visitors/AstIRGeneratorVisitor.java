import java.util.HashMap;
import java.util.LinkedList;
import java.util.Map;

import ast.*;
import ir.*;
import symbol.AstSymbols;
import symbol.SymbolTable;

public class AstIRGeneratorVisitor implements Visitor {
    private AstSymbols astSymbols;
    private IRGenerator irGenerator;
    private IRClass currentIRClass;
    private IRMethod currentIRMethod;
    private IRStatement currentIRStatement = new IRStatement();
    private String currentIRType;
    private int currentRegNum = 0; // [TODO] change to last used reg num
    private int currentSymVarNum = 0; // [TODO] change to free sym var num
    private int currentLabel = 0; // [TODO] change to free label
    private Map<String, Integer> var_name_to_sym_var = new HashMap<>(); 
    private Map<Integer, String> sym_var_to_type = new HashMap<>(); 
    // private Map<Integer, String> reg_to_type = new HashMap<>(); // [TODO] fill and use it

    public AstIRGeneratorVisitor(AstSymbols astSymbols)
    {
        this.astSymbols = astSymbols;
        this.irGenerator = new IRGenerator();
    }

    public String getString()
    {
        return irGenerator.getString();
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
        this.currentIRClass = this.irGenerator.generateClass(classDecl.name());

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
        this.currentIRMethod = this.currentIRClass.generateMethod(methodDecl.name());

        methodDecl.returnType().accept(this);
        this.currentIRMethod.setRetType(this.currentIRType);
        
        for (var formal : methodDecl.formals()) { // should add them to start method (declare and stuff)
            formal.accept(this);
        }
        for (var varDecl : methodDecl.vardecls()) {
            this.currentIRStatement = new IRStatement();
            varDecl.accept(this);
            this.currentIRMethod.addStatement(this.currentIRStatement);
        }
        for (var stmt : methodDecl.body()) {
            this.currentIRStatement = new IRStatement();
            stmt.accept(this);
            this.currentIRMethod.addStatement(this.currentIRStatement);
        }
        methodDecl.ret().accept(this);
    }

    @Override
    public void visit(FormalArg formalArg) {
        formalArg.type().accept(this);
        this.currentIRMethod.addParam(new IRVar("%."+formalArg.name(), this.currentIRType));
        
    }

    @Override
    public void visit(VarDecl varDecl) {
        varDecl.type().accept(this);
        this.var_name_to_sym_var.put(varDecl.name(), this.currentSymVarNum);
        this.sym_var_to_type.put(this.currentSymVarNum, this.currentIRType);
        currentIRStatement.varDecl(this.currentSymVarNum, this.currentIRType);
        this.currentSymVarNum++;
    }

    @Override
    public void visit(BlockStatement blockStatement) {
        // currentIRStatement.startBlock(); [TODO]
        for (var s : blockStatement.statements()) {
            s.accept(this);
        }
        // currentIRStatement.endBlock(); [TODO]
    }

    @Override
    public void visit(IfStatement ifStatement) {
        ifStatement.cond().accept(this);
        int cond_reg = this.currentRegNum;
        int if_label = this.currentLabel++;
        int else_label = this.currentLabel++;
        int continueLabel = this.currentLabel++;
        currentIRStatement.addBranch(cond_reg, if_label, else_label);
        currentIRStatement.addLabel(if_label);
        ifStatement.thencase().accept(this);
        currentIRStatement.addJump(continueLabel);
        currentIRStatement.addLabel(else_label);
        ifStatement.elsecase().accept(this);
        currentIRStatement.addJump(continueLabel);
        currentIRStatement.addLabel(continueLabel);

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
        int rv_reg = this.currentRegNum;
        int lv_sym_var = this.var_name_to_sym_var.get(assignStatement.lv());
        String lv_type = this.sym_var_to_type.get(lv_sym_var);
        this.currentIRStatement.addAssignment(lv_sym_var, lv_type, rv_reg);        
    }

    @Override
    public void visit(AssignArrayStatement assignArrayStatement) {
        assignArrayStatement.index().accept(this);
        assignArrayStatement.rv().accept(this);
    }

    @Override
    public void visit(AndExpr e) {
        int e1_label = this.currentLabel++;
        int e2_label = this.currentLabel++;
        int exist_false_label = this.currentLabel++;
        int final_label = this.currentLabel++;
        
        // short circuit
        this.currentIRStatement.addLabel(e1_label);
        e.e1().accept(this);
        // result in curr register
        this.currentIRStatement.addBranch(this.currentRegNum, exist_false_label, e2_label);
        this.currentIRStatement.addLabel(e2_label);
        e.e2().accept(this);
        this.currentIRStatement.addBranch(this.currentRegNum, exist_false_label, final_label);
        this.currentIRStatement.addLabel(exist_false_label);
        this.currentIRStatement.addJump(final_label);
        this.currentIRStatement.addLabel(final_label);
        this.currentIRStatement.addPhi(this.currentRegNum++,exist_false_label, e2_label);
        
    }

    @Override
    public void visit(LtExpr e) {
        e.e1().accept(this);
        int e1_reg = this.currentRegNum;
        e.e2().accept(this);
        int e2_reg = this.currentRegNum;
        int to_reg = ++this.currentRegNum;
        this.currentIRStatement.addLt(e1_reg, e2_reg, to_reg);
    }

    @Override
    public void visit(AddExpr e) {
        // TODO: x+42: 42 is not in register - fixed!
        e.e1().accept(this);
        int e1_reg = this.currentRegNum;
        e.e2().accept(this);
        int e2_reg = this.currentRegNum;
        int to_reg = ++this.currentRegNum;
        String type = "i32"; // [TODO: change it to other than i32 if needed]
        currentIRStatement.addAddition(to_reg, type,  e1_reg, e2_reg);
        // " %_this.currentRegNum = e1_reg_num add e2_reg_num"
    }

    @Override
    public void visit(SubtractExpr e) {
        // same as add
        e.e1().accept(this);
        int e1_reg = this.currentRegNum;
        e.e2().accept(this);
        int e2_reg = this.currentRegNum;
        int to_reg = ++this.currentRegNum;
        String type = "i32"; // [TODO: change it to other than i32 if needed]
        currentIRStatement.addSubstuction(to_reg, type,  e1_reg, e2_reg);
    }

    @Override
    public void visit(MultExpr e) {
        // same as add
        e.e1().accept(this);
        int e1_reg = this.currentRegNum;
        e.e2().accept(this);
        int e2_reg = this.currentRegNum;
        int to_reg = ++this.currentRegNum;
        String type = "i32"; // [TODO: change it to other than i32 if needed]
        currentIRStatement.addMult(to_reg, type,  e1_reg, e2_reg);
    }

    @Override
    public void visit(ArrayAccessExpr e) {
        // laod array address
        // check not negative index
        // check not out of bounds (the length is first index)
        // load the array size    then icmp sle
        // add exception (there's example in instructions) 
        // getelemntptr
        e.arrayExpr().accept(this);
        int arr_ptr_reg = this.currentRegNum;
        e.indexExpr().accept(this);
        int index_reg = this.currentRegNum;
        
        // define zero register
        int minus_one_reg = ++this.currentRegNum;
        this.currentIRStatement.addConstantRegAssignment(minus_one_reg, 0);

        // check out of bounds exception:
        int arr_length_reg = ++this.currentRegNum;
        this.currentIRStatement.addLoadPtr(arr_ptr_reg, arr_length_reg); //getlempter- get array length that stored at first index 
        int positive_OOB_reg = ++this.currentRegNum; // index > len
        int negative_OOB_reg = ++this.currentRegNum; // index < 0
        int OOB_label = this.currentLabel++;
        int continue_label = this.currentLabel++;
        this.currentIRStatement.addLt(index_reg, arr_length_reg, positive_OOB_reg); // index < len
        this.currentIRStatement.addLt(minus_one_reg, index_reg, negative_OOB_reg); // -1 < index 
        int OOB_reg = ++this.currentRegNum;
        this.currentIRStatement.addAnd(positive_OOB_reg, negative_OOB_reg, OOB_reg);
        this.currentIRStatement.addBranch(OOB_reg, continue_label, OOB_label);
        this.currentIRStatement.addOutOfBoundException(OOB_label);
        
        // continue:
        this.currentIRStatement.addLabel(continue_label);
        int shifted_by_one_index_reg = ++this.currentRegNum;
        this.currentIRStatement.addAdditionByConstant(shifted_by_one_index_reg, "i32", index_reg, 1);
        int output_reg = ++this.currentRegNum;
        this.currentIRStatement.addLoadPtrAtIndex(arr_ptr_reg, shifted_by_one_index_reg, output_reg);
        // [TODO] - check if done (implement addLoadPtrAtIndex with getlempter)
    }

    @Override
    public void visit(ArrayLengthExpr e) {
        e.arrayExpr().accept(this);
    }

    @Override
    public void visit(MethodCallExpr e) {       
        e.ownerExpr().accept(this);
        
        // registers to each argument
        int[] args_registers = new int[e.actuals().size()];
        int i = 0;
        for (Expr arg : e.actuals()) {
            arg.accept(this);
            args_registers[i++] = this.currentRegNum;
        }
        // TODO - need args type also, fix it - not done...
        int to_reg = ++this.currentRegNum;
        this.currentIRStatement.addFunctionCall(e.methodId(), args_registers, "unkown_type_fix_it_later", to_reg);
    }

    @Override
    public void visit(IntegerLiteralExpr e) {
        int put_to_reg = ++this.currentRegNum;
        int int_value = e.num();
        currentIRStatement.addConstantRegAssignment(put_to_reg, int_value);
    }

    @Override
    public void visit(TrueExpr e) {
        int to_reg = ++this.currentRegNum;
        currentIRStatement.addBool(to_reg, 1);
    }

    @Override
    public void visit(FalseExpr e) {
        int to_reg = ++this.currentRegNum;
        currentIRStatement.addBool(to_reg, 0);
    }

    @Override
    public void visit(IdentifierExpr e) {
        if (this.var_name_to_sym_var.containsKey(e.id())) {
            int to_reg = ++this.currentRegNum;
            int symVar = this.var_name_to_sym_var.get(e.id());
            String symVarType = this.sym_var_to_type.get(symVar);
            this.currentIRStatement.addLoadSymVar(symVar, symVarType, to_reg);
        }
    }

    public void visit(ThisExpr e) {
    }

    @Override
    public void visit(NewIntArrayExpr e) {
        // check not negative lentgh
        // %_%d = calloc with 4 bytes element size
        // save at the first element the size
        // already declared... this is expr!!!
        // int array_sym_var = this.currentSymVarNum++;
        // this.sym_var_to_type.put(array_sym_var, "i32*");
        // this.var_name_to_sym_var.put()
        // this.currentIRStatement.varDecl(array_sym_var, "i32*");
        e.lengthExpr().accept(this);
        int output_before_cast_reg = ++this.currentRegNum;
        int expr_output_reg = ++this.currentRegNum; // Q: why I put it here? (and not before accept)

        int length_reg = this.currentRegNum;

        // positivity handling:
        int length_positivity_reg = ++this.currentRegNum;
        this.currentIRStatement.addLt(0, length_reg, length_positivity_reg); // positive length (TODO: 0 is ok?)
        int not_positive_exception_label = this.currentLabel++; 
        int continue_label = this.currentLabel++;
        this.currentIRStatement.addBranch(length_positivity_reg, continue_label, not_positive_exception_label);
        this.currentIRStatement.addNotPositiveSizeException(not_positive_exception_label);
        this.currentIRStatement.addJump(continue_label);
        
        // continue:
        this.currentIRStatement.addLabel(continue_label);
        this.currentIRStatement.addCaloc(output_before_cast_reg, length_reg, 4);
        this.currentIRStatement.addCast(output_before_cast_reg, "i8*", expr_output_reg, "i32*");

        this.currentIRStatement.addStore("i32", length_reg ,"i32*", expr_output_reg); // store the size of the array to first index
    
    }

    @Override
    public void visit(NewObjectExpr e) {
    }

    @Override
    public void visit(NotExpr e) {
        e.e().accept(this);
        int expr_reg = this.currentRegNum;
        int to_reg = ++this.currentRegNum;
        currentIRStatement.addNot(expr_reg, to_reg);
    }

    @Override
    public void visit(IntAstType t) {
        this.currentIRType = "i32";
    }

    @Override
    public void visit(BoolAstType t) {
        this.currentIRType = "i1";
    }

    @Override
    public void visit(IntArrayAstType t) {
        this.currentIRType = "i32*";
    }

    @Override
    public void visit(RefType t) {
        this.currentIRType = "i8*";
    }
}
