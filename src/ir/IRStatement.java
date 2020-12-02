package ir;
import java.util.List;
import java.util.LinkedList;


import symbol.SymbolTable;

public class IRStatement {
    StringBuilder stmt_str = new StringBuilder();

    public void addAssignment(int lv_sym_var, String lv_type, int rv_reg) {
        // "store lv_type %_this.currentRegNum lv_type* lv_symbol_var"
        // String str = String.format("store %s %_%d %s* %s\n", lv_type, rv_reg, lv_type, lv_sym_var);
        String str = String.format("    store %s %%_%d %s* %%%d\n", lv_type, rv_reg, lv_type, lv_sym_var);
        stmt_str.append(str);
    }

    public void varDecl(int sym_var, String var_type) {
        // " %this.currentSymVarNum = alloca get_type_from_symbol_table
        // String str = String.format("%%d = alloca %s\n", sym_var, var_type);
        String str = String.format("    %%%d = alloca %s\n", sym_var, var_type);
        stmt_str.append(str);
    }


	public void addBranch(int cond_reg, int if_label, int else_label) {
        // String str = String.format("br i1 %_%d, label %%d, label %%d\n", cond_reg, if_label, else_label);
        String str = String.format("    br i1 %%_%d, label %%%d, label %%%d\n", cond_reg, if_label, else_label);
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
        String str = String.format("    %%_%d i1 [0, %%%d], [1, %%%d]\n", to_reg, label1, label2); // [TODO] - not sure %_%d
        stmt_str.append(str);
    }

	public void addJump(int to_label) {
        // String str = String.format("br label %%d\n", to_label);
        String str = String.format("    br label %d\n", to_label);
        stmt_str.append(str);
    }

	public void addAddition(int to_reg, String type, int e1_reg, int e2_reg) {
        // String str = String.format("%_%d = add %s %_%d %_%d\n", to_reg, type, e1_reg, e2_reg);
        String str = String.format("    %%_%d = add %s %%_%d, %%_%d\n", to_reg, type, e1_reg, e2_reg);
        stmt_str.append(str);
    }	
    
    public void addSubstuction(int to_reg, String type, int e1_reg, int e2_reg) {
        // String str = String.format("%_%d = add %s %_%d %_%d\n", to_reg, type, e1_reg, e2_reg);
        String str = String.format("    %%_%d = sub %s %%_%d %%_%d\n", to_reg, type, e1_reg, e2_reg);
        stmt_str.append(str);
	}
    public void addMult(int to_reg, String type, int e1_reg, int e2_reg) {
        // String str = String.format("%_%d = add %s %_%d %_%d\n", to_reg, type, e1_reg, e2_reg);
        String str = String.format("    %%_%d = mul %s %%_%d %%_%d\n", to_reg, type, e1_reg, e2_reg);
        stmt_str.append(str);
	}
    
	public void addNot(int expr_reg, int to_reg) {
        String str = String.format("    %%_%d = not %%_%d\n", to_reg, to_reg, expr_reg); // TODO: it's not correct...
        stmt_str.append(str);
	}

	public void addLt(int e1_reg, int e2_reg, int to_reg) {
        String str = String.format("    %%_%d = icmp slt i32 %%_%d, %%_%d\n", to_reg, e1_reg, e2_reg); // [TODO: change i32 to general]
        stmt_str.append(str);
    }

    public void addLoadVar(int from_reg, String type, int to_reg) {
        String str = String.format("    %%_%d = load %s, %s* %%_%d\n", to_reg, type, type, from_reg); // Validate that its correct
        stmt_str.append(str);
    }

	public void addConstantRegAssignment(int to_reg, int int_value) {
        String str = String.format("    %%_%d = add i32 0, %d\n", to_reg, int_value); 
        stmt_str.append(str);
	}

	public void addCaloc(int to_reg, int length_reg, int elem_size) {
        String str = String.format("    %%_%d = call i8* @calloc(i32 %%_%d, i32 %%_%d)\n", to_reg, length_reg, elem_size); 
        stmt_str.append(str);
    }
    
    public void addCast(int fromReg, String fromType, int to_reg, String toType) {
        String str = String.format("    %%_%d = bitcast %s %%_%d to %s\n", to_reg, fromType, fromReg, toType); 
        stmt_str.append(str);
    }

	public void addOutOfBoundException(int label) {
        // run-time exception - not compilation (which is exercise 3)
        this.addLabel(label);
        this.stmt_str.append("    call void @throw_oob() \n"); 
    }
    public void addNotPositiveSizeException(int label) {
        // run-time exception - not compilation (which is exercise 3)
        this.addLabel(label);
        this.stmt_str.append("    call void @throw_oob() \n"); 
    }

	public void addStore(String assignType, int assignReg, String assigneeType, int assigneeSym) {
        String str = String.format("    store %s %%_%d, %s %%%d \n", assignType,assignReg, assigneeType,assigneeSym); 
        stmt_str.append(str);        
	}

    public void addStoreReg(String assignType, int assignReg, String assigneeType, int assigneeReg) {
        String str = String.format("    store %s %%_%d, %s %%_%d \n", assignType,assignReg, assigneeType,assigneeReg); 
        stmt_str.append(str);        
	}

    public void addStoreFormalArg(String assignType, String assignReg, String assigneeType, int assigneeSym) {
        String str = String.format("    store %s %%%s, %s %%%d \n", assignType,assignReg, assigneeType,assigneeSym); 
        stmt_str.append(str);        
	}


	public void addAnd(int in1_reg, int in2_reg, int to_reg) {
        String str = String.format("    %%_%d = and %%_%d, %%_%d \n",to_reg, in1_reg, in2_reg); 
        stmt_str.append(str); //[TODO] - not sure it's done like that
	}

	public void addLoadPtrAtIndex(int arr_ptr_reg, int shifted_by_one_index_reg, int to_reg, String type) {
        String str = String.format("    %%_%d = getelementptr %s, %s* %%_%d, i32 %%_%d \n",to_reg, type, type, arr_ptr_reg, shifted_by_one_index_reg); 
        stmt_str.append(str);
    }

	public void addAdditionByConstant(int to_reg, String type, int e1_reg, int constant) {
        String str = String.format("    %%_%d = add %s %%_%d, %d\n", to_reg, type, e1_reg, constant);
        stmt_str.append(str);
    }

	public void addLoadPtr(int arr_ptr_reg, int to_reg) {
        String str = String.format("    %%_%d = getelementptr i32, i32* %%_%d, i32 0 \n",to_reg, arr_ptr_reg); 
        stmt_str.append(str);
	}

    public void addLoadPtrStaticArray(String static_array, String static_array_type, int to_reg) {
        String str = String.format("    %%_%d = getelementptr %s, %s* %s, i32 0 \n",to_reg, static_array_type,static_array_type,static_array); 
        stmt_str.append(str);
	}


	public void addBool(int to_reg, int i) {
        String str = String.format("    %%_%d = add i1 0, %d \n",to_reg, i); 
        stmt_str.append(str);

	}

	public void addLoadSymVar(int symVar, String symVarType, int to_reg) {
        String str = String.format("    %%_%d = load %s, %s* %%%d \n",to_reg, symVarType, symVarType, symVar);
        stmt_str.append(str);
	}

	public void addFunctionCall(int to_reg, String ret_type, int func_reg, List<Integer> args, List<String> types) {
        
        StringBuilder formalArgs = new StringBuilder();
        var argsIter = args.listIterator();
        var typesIter = types.listIterator();
        while (argsIter.hasNext())
        {
            Integer arg = argsIter.next();
            String type = typesIter.next();
            formalArgs.append(String.format("%s %%_%d", type, arg));
            if (argsIter.hasNext())
                formalArgs.append(", ");
        }
        
        String str = String.format("    %%_%d = call %s %%_%d(%s)\n",to_reg, ret_type, func_reg, formalArgs.toString());
        // String str = String.format("%%_%d = call %s %s(%s) %s* %%%d \n",to_reg, ret_type, func_name, args_registers.toString()); 
        stmt_str.append(str);
	}

    public void addPrint(int register_to_print) {
        String str = String.format("    call void (i32) @print_int(i32 %%_%d) \n", register_to_print);
        stmt_str.append(str);
	}

    public void blankLine() { // For Testing!
        stmt_str.append("\n");
	}

    

}
