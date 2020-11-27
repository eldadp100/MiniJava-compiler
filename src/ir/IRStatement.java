package ir;

import symbol.SymbolTable;

public class IRStatement {
    StringBuilder stmt_str = new StringBuilder();

    public void addAssignment(int lv_sym_var, String lv_type, int rv_reg) {
        // "store lv_type %_this.currentRegNum lv_type* lv_symbol_var"
        // String str = String.format("store %s %_%d %s* %s\n", lv_type, rv_reg, lv_type, lv_sym_var);
        String str = String.format("store %s reg %d %s* %s\n", lv_type, rv_reg, lv_type, lv_sym_var);
        stmt_str.append(str);
    }

    public void varDecl(int sym_var, String var_type) {
        // " %this.currentSymVarNum = alloca get_type_from_symbol_table
        // String str = String.format("%%d = alloca %s\n", sym_var, var_type);
        String str = String.format("sym %d = alloca %s\n", sym_var, var_type);
        stmt_str.append(str);
    }

	public void addBranch(int cond_reg, int if_label, int else_label) {
        // String str = String.format("br i1 %_%d, label %%d, label %%d\n", cond_reg, if_label, else_label);
        String str = String.format("br i1 reg %d, label sym %d, label sym %d\n", cond_reg, if_label, else_label);
        stmt_str.append(str);
    }

	public void addLabel(int label) {
        String str = String.format("%d:\n", label);
        stmt_str.append(str);
	}

    public String toString() {
        return stmt_str.toString(); 
    }

	public void addPhi(int to_reg, int label1, int label2) {
        // String str = String.format("%_%d i1 [0, %%d], [1, %%d]\n", to_reg, label1, label2); // [TODO] - not sure %_%d
        String str = String.format("reg %d i1 [0, sym %d], [1, sym %d]\n", to_reg, label1, label2); // [TODO] - not sure %_%d
        stmt_str.append(str);
    }

	public void addJump(int to_label) {
        // String str = String.format("br label %%d\n", to_label);
        String str = String.format("br label sym %d\n", to_label);
        stmt_str.append(str);
    }

	public void addAddition(int to_reg, String type, int e1_reg, int e2_reg) {
        // String str = String.format("%_%d = add %s %_%d %_%d\n", to_reg, type, e1_reg, e2_reg);
        String str = String.format("reg %d = add %s reg %d reg %d\n", to_reg, type, e1_reg, e2_reg);
        stmt_str.append(str);
	}

	public void addNot(int expr_reg, int to_reg) {
        String str = String.format("reg %d = not reg %d\n", to_reg, to_reg, expr_reg); // TODO: it's not correct...
        stmt_str.append(str);
	}

	public void addLt(int e1_reg, int e2_reg, int to_reg) {
        String str = String.format("reg %d = icmp slt i32 reg %d, reg %d\n", to_reg, e1_reg, e2_reg); // [TODO: change i32 to general]
        stmt_str.append(str);
    }
    public void loadVar(int symVar, String type, int to_reg) {
        String str = String.format("reg %d = load %s, i32* %d\n", to_reg, type, symVar); 
        stmt_str.append(str);
    }

	public void addConstantRegAssignment(int to_reg, int int_value) {
        String str = String.format("reg %d = add i32 0, %d\n", to_reg, int_value); 
        stmt_str.append(str);
	}

	public void addCaloc(int to_reg, int length_reg, int elem_size) {
        String str = String.format("reg %d = call i8* @calloc(i32 reg %d, i32 reg %d)\n", to_reg, length_reg, elem_size); 
        stmt_str.append(str);
    }
    
    public void addCast(int fromReg, String fromType, int to_reg, String toType) {
        String str = String.format("reg %d = bitcast %s reg %d to %s\n", to_reg, fromType, fromReg, toType); 
        stmt_str.append(str);
    }

	public void addOutOfBoundException(int label) {
        // run-time exception - not compilation (which is exercise 3)
        this.addLabel(label);
        this.stmt_str.append("call void @throw_oob()"); 
    }
    public void addNotPositiveSizeException(int label) {
        // run-time exception - not compilation (which is exercise 3)
        this.addLabel(label);
        this.stmt_str.append("call void @throw_oob()"); 
    }

	public void addStore(String assignType, int assignReg, String assigneeType, int assigneeReg) {
        String str = String.format("store %s reg %d, %s %d \n", assignType,assignReg, assigneeType,assigneeReg); 
        stmt_str.append(str);        
	}

	public void addAnd(int int2_reg, int in1_reg, int to_reg) {
        // [TODO]
	}

	public void addLoadPtrAtIndex(int arr_ptr_reg, int shifted_by_one_index_reg, int output_reg) {
	}

	public void addAdditionByConstant(int shifted_by_one_index_reg, String string, int index_reg, int i) {
	}

	public void addLoadPtr(int arr_ptr_reg, int arr_length_reg) {
	}

    
    

}
