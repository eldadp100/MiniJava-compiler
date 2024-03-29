package semantic;

import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

public class MethodInfo {
    private String name;
    private String retType;
    private List<VarInfo> args = new LinkedList<>();
    private List<VarInfo> localVars = new LinkedList<>();

    public MethodInfo(String name) {
        this.name = name;
    }

    public String getName() {
        return name;
    }

    public String getRetType() {
        return retType;
    }

    public boolean hasArg(String argName) {
        for (VarInfo varInfo : args) {
            if (varInfo.getName().equals(argName)) {
                return true;
            }
        }

        return false;
    }

    public String getArgType(String argName) {
        for (VarInfo varInfo : args) {
            if (varInfo.getName().equals(argName)) {
                return varInfo.getType();
            }
        }

        throw new RuntimeException(String.format("Arg %s is not defined", argName));
    }

    public List<String> getArgTypes() {
        var argTypes = new LinkedList<String>();

        for (VarInfo arg : args) {
            argTypes.add(arg.getType());
        }

        return argTypes;
    }

    public boolean hasLocalVar(String varName) {
        for (VarInfo varInfo : localVars) {
            if (varInfo.getName().equals(varName)) {
                return true;
            }
        }

        return false;
    }

    public String getLocalVarType(String varName) {
        for (VarInfo varInfo : localVars) {
            if (varInfo.getName().equals(varName)) {
                return varInfo.getType();
            }
        }

        throw new RuntimeException(String.format("Local var %s is not defined", varName));
    }

    public void setRetType(String retType) {
        this.retType = retType;
    }

    public void addArg(String argName, String argType) {
        if (hasArg(argName)) {
            throw new RuntimeException(String.format("Arg %s is already defined", argName));
        }
        this.args.add(new VarInfo(argName, argType));
    }

    public void addLocalVar(String varName, String varType) {
        if (hasLocalVar(varName)) {
            throw new RuntimeException(String.format("Local var %s is already defined", varName));
        }
        if (hasArg(varName)) {
            throw new RuntimeException(String.format("Local var %s name collision with arguments", varName));
        }
        this.localVars.add(new VarInfo(varName, varType));
    }
}
