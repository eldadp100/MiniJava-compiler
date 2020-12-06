import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import ast.*;
import ir.*;
import symbol.AstSymbols;
import symbol.SymbolTable;
import symbol.SymbolType;

public class AstIRGeneratorVisitor implements Visitor {
    private AstSymbols astSymbols;
    private IRGenerator irGenerator;
    private IRClass currentIRClass;
    private IRMethod currentIRMethod;
    private IRStatement currentIRStatement = new IRStatement(); // [TODO: remove it]
    private String currentIRType;
    private int currentRegNum = 0; // [TODO] change to last used reg num
    private int currentSymVarNum = 0; // [TODO] change to free sym var num
    private int currentLabel = 0; // [TODO] change to free label
    private Map<String, Integer> var_name_to_sym_var; 
    private Map<Integer, String> sym_var_to_type;
    private Map<String, IRClass> class_to_IRclass = new HashMap<>();
    private IRClass LastVarClass;
    private int this_reg;
    // private Map<Integer, String> reg_to_type = new HashMap<>(); // [TODO] fill and use it

    public AstIRGeneratorVisitor(AstSymbols astSymbols, IRGenerator irGenerator)
    {
        this.astSymbols = astSymbols;
        this.irGenerator = irGenerator;
    }

    public String getString()
    {
        return irGenerator.getString();
    }

    public void getFieldReg(String fieldName) {
        int index_reg = ++this.currentRegNum;
        int to_reg_before_bitcast = ++this.currentRegNum;
        int to_reg = ++this.currentRegNum; 
        this.currentIRStatement.addConstantRegAssignment(index_reg, this.currentIRClass.getObjectLocation(fieldName));
        this.currentIRStatement.addLoadPtrAtIndex(this_reg, index_reg, to_reg_before_bitcast, "i8");
        this.currentIRStatement.addCast(to_reg_before_bitcast, "i8*", to_reg, String.format("%s*",this.currentIRClass.getFieldType(fieldName)));
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
        this.currentIRClass = this.irGenerator.getClass(classDecl.name());
        //for (var fieldDecl : classDecl.fields()) {
        //    fieldDecl.accept(this);
        //}
        for (var methodDecl : classDecl.methoddecls()) {
            methodDecl.accept(this);
        }
    }

    @Override
    public void visit(MainClass mainClass) {
        this.currentIRStatement = new IRStatement();
        mainClass.mainStatement().accept(this);
        this.irGenerator.setMainStatement(this.currentIRStatement);
    }

    @Override
    public void visit(MethodDecl methodDecl) {

        this.sym_var_to_type = new HashMap<>();
        this.var_name_to_sym_var = new HashMap<>();
        this.currentRegNum = 0;
        this.currentSymVarNum = 1;

        this.currentIRMethod = this.currentIRClass.generateMethod(methodDecl.name());

        methodDecl.returnType().accept(this);
        this.currentIRMethod.setRetType(this.currentIRType);

        this.currentIRMethod.addParam(new IRVar("this", this.currentRegNum, "i8*")); // Adding "This" param
        this_reg = this.currentRegNum;
        for (var formal : methodDecl.formals()) { 
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
        this.currentIRStatement = new IRStatement();
        methodDecl.ret().accept(this);
        int return_reg = this.currentRegNum;
        this.currentIRStatement.addReturn(this.currentIRClass.getMethodRetType(methodDecl.name()), return_reg);
        this.currentIRMethod.addStatement(this.currentIRStatement);
    }

    @Override
    public void visit(FormalArg formalArg) { // We are treating formal arguments like regular local variables. their names in the function decleration will be %.0, %.1 etc.
        formalArg.type().accept(this);
        this.var_name_to_sym_var.put(formalArg.name(), this.currentSymVarNum);
        this.sym_var_to_type.put(this.currentSymVarNum, this.currentIRType);
        this.currentIRMethod.addParam(new IRVar(".%s".format(formalArg.name()), this.currentSymVarNum, this.currentIRType));
        this.currentSymVarNum++;
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
        int while_label = this.currentLabel++;
        int continue_label = this.currentLabel++;
        int skip_label = this.currentLabel++;

        currentIRStatement.addLabel(while_label);
        
        whileStatement.cond().accept(this);
        int cond_reg = this.currentRegNum;

        currentIRStatement.addBranch(cond_reg, continue_label, skip_label);
        currentIRStatement.addLabel(continue_label);

        whileStatement.body().accept(this);

        currentIRStatement.addJump(while_label);
        currentIRStatement.addLabel(skip_label);
    }

    @Override
    public void visit(SysoutStatement sysoutStatement) {
        sysoutStatement.arg().accept(this);
        int print_reg = this.currentRegNum;
        this.currentIRStatement.addPrint(print_reg);
    }

    @Override
    public void visit(AssignStatement assignStatement) { // !
        assignStatement.rv().accept(this);
        int rv_reg = this.currentRegNum;
        if (this.var_name_to_sym_var.containsKey(assignStatement.lv())) {
            int lv_sym_var = this.var_name_to_sym_var.get(assignStatement.lv());
            String lv_type = this.sym_var_to_type.get(lv_sym_var);
            this.currentIRStatement.addAssignment(lv_sym_var, lv_type, rv_reg);
        } else {
            this.getFieldReg(assignStatement.lv());
            int field_reg = this.currentRegNum;
            this.currentIRStatement.addAssignmentToReg(field_reg, this.currentIRClass.getFieldType(assignStatement.lv()), rv_reg);
        }    
    }

    @Override
    public void visit(AssignArrayStatement assignArrayStatement) { // !
        assignArrayStatement.rv().accept(this);
        int rv_reg = this.currentRegNum;
        assignArrayStatement.index().accept(this);
        int index_reg = this.currentRegNum;
        int array_ptr_reg;

        if (this.var_name_to_sym_var.containsKey(assignArrayStatement.lv())) {
            int array_sym = this.var_name_to_sym_var.get(assignArrayStatement.lv());
            array_ptr_reg = ++this.currentRegNum;
            this.currentIRStatement.addLoadSymVar(array_sym, "i32*", array_ptr_reg);
        } else {
            this.getFieldReg(assignArrayStatement.lv());
            array_ptr_reg = this.currentRegNum;
        }
            
        // define zero register
        int minus_one_reg = ++this.currentRegNum;
        this.currentIRStatement.addConstantRegAssignment(minus_one_reg, 0);

        // check out of bounds exception:
        int arr_length_reg = ++this.currentRegNum;
        this.currentIRStatement.addLoadVar(array_ptr_reg, "i32", arr_length_reg);
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
        int arr_index_ptr_reg = ++this.currentRegNum;
        this.currentIRStatement.addLoadPtrAtIndex(array_ptr_reg, shifted_by_one_index_reg, arr_index_ptr_reg, "i32");
        this.currentIRStatement.addStoreReg("i32", rv_reg, "i32*", arr_index_ptr_reg);
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
        this.currentIRStatement.addLoadVar(arr_ptr_reg, "i32", arr_length_reg);
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
        int output_reg_ptr = ++this.currentRegNum;
        this.currentIRStatement.addLoadPtrAtIndex(arr_ptr_reg, shifted_by_one_index_reg, output_reg_ptr, "i32");
        int output_reg = ++this.currentRegNum;
        this.currentIRStatement.addLoadVar(output_reg_ptr, "i32", output_reg);
    }

    @Override
    public void visit(ArrayLengthExpr e) {
        e.arrayExpr().accept(this);
        int array_ptr = this.currentRegNum;
        int output_reg = ++this.currentRegNum;
        this.currentIRStatement.addLoadVar(array_ptr, "i32", output_reg);
    }

    @Override
    public void visit(MethodCallExpr e) {       
        e.ownerExpr().accept(this);
        int owner_reg = this.currentRegNum;
        int object_bitcast_ptr_reg = ++this.currentRegNum;
        int vtable_ptr_reg = ++this.currentRegNum;
        int place_of_func_reg = ++this.currentRegNum;
        int ptr_to_func_in_vtable = ++this.currentRegNum;
        int func_ptr_reg = ++this.currentRegNum;
        int func_reg = ++this.currentRegNum;

        if (this.LastVarClass == this.currentIRClass) {
            owner_reg = 0;
        }
        this.currentIRStatement.addCast(owner_reg, "i8*", object_bitcast_ptr_reg, "i8***");

        this.currentIRStatement.addLoadVar(object_bitcast_ptr_reg, "i8**",vtable_ptr_reg );
        this.currentIRStatement.addConstantRegAssignment(place_of_func_reg, this.LastVarClass.getMethodVtableIndex(e.methodId()));
        this.currentIRStatement.addLoadPtrAtIndex(vtable_ptr_reg, place_of_func_reg, ptr_to_func_in_vtable, "i8*");
        this.currentIRStatement.addLoadVar(ptr_to_func_in_vtable, "i8*",func_ptr_reg );
        this.currentIRStatement.addCast(func_ptr_reg, "i8*", func_reg, this.LastVarClass.getMethodPtrType(e.methodId()));
        
        // registers to each argument
        String ret_type = this.LastVarClass.getMethodRetType(e.methodId());
        var FormalTypes = this.LastVarClass.getMethodFormalTypes(e.methodId());
        List<Integer> args_registers = new LinkedList<>();
        args_registers.add(owner_reg);
        for (Expr arg : e.actuals()) {
            arg.accept(this);
            args_registers.add(this.currentRegNum);
        }

        int func_call_output_reg = ++this.currentRegNum;
        this.currentIRStatement.addFunctionCall(func_call_output_reg,ret_type , func_reg, args_registers, FormalTypes);
        this.currentIRStatement.blankLine();
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

            var symbolTable = this.astSymbols.GetIdentifierScopeSymbolTable(e);
            if (symbolTable == null) {
                symbolTable = this.astSymbols.GetSymbolTableByNode(e);
            }
            var symbol = symbolTable.GetSymbol(e.id(), SymbolType.VAR);
            String ObjectClass = astSymbols.GetRefTypeName(symbol.getStaticType());
            
            this.LastVarClass = this.irGenerator.getClass(ObjectClass);

        } else {
            this.getFieldReg(e.id());
            int field_ptr = this.currentRegNum;
            int to_reg = ++this.currentRegNum;
            this.currentIRStatement.addLoadVar(field_ptr, this.currentIRClass.getFieldType(e.id()), to_reg);
        }
    }

    public void visit(ThisExpr e) {
        this.LastVarClass = this.currentIRClass;
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
        int length_reg = this.currentRegNum;
        int output_before_cast_reg = ++this.currentRegNum;
        int expr_output_reg = ++this.currentRegNum; // Q: why I put it here? (and not before accept)
        int shifted_length_reg = ++this.currentRegNum;
        

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
        this.currentIRStatement.addAdditionByConstant(shifted_length_reg, "i32", length_reg, 1);
        this.currentIRStatement.addCaloc(output_before_cast_reg, shifted_length_reg, 4);
        this.currentIRStatement.addCast(output_before_cast_reg, "i8*", expr_output_reg, "i32*");

        this.currentIRStatement.addStore("i32", length_reg ,"i32*", expr_output_reg); // store the size of the array to first index
    
    }

    @Override
    public void visit(NewObjectExpr e) {
        IRClass ObjectClass = this.irGenerator.getClass(e.classId());
        this.LastVarClass = ObjectClass;
        int object_size_reg = ++this.currentRegNum;
        int one_reg = ++this.currentRegNum;
        int bitcast_calloc_reg = ++this.currentRegNum;
        int pointer_to_vtable_reg = ++this.currentRegNum;
        int calloc_reg = ++this.currentRegNum;

        this.currentIRStatement.blankLine();
        this.currentIRStatement.addConstantRegAssignment(object_size_reg, ObjectClass.getClassObjectSize());
        this.currentIRStatement.addConstantRegAssignment(one_reg, 1);
        this.currentIRStatement.addCaloc(calloc_reg, one_reg, object_size_reg);
        this.currentIRStatement.addCast(calloc_reg, "i8*", bitcast_calloc_reg, "i8***");
        this.currentIRStatement.addLoadPtrStaticArray(ObjectClass.getVtableName(), ObjectClass.getVtableType(), pointer_to_vtable_reg);
        this.currentIRStatement.addStoreReg("i8**", pointer_to_vtable_reg, "i8***", bitcast_calloc_reg);
        this.currentIRStatement.blankLine();
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
