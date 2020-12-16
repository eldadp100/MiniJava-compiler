package semantic;

import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

public class MethodInfo {
    private String name;
    private String retType;
    private List<String> argsType = new LinkedList<>();

    public MethodInfo(String name) {
        this.name = name;
    }

    public String getName() {
        return name;
    }

    public String getRetType() {
        return retType;
    }

    public List<String> getArgsType() {
        return argsType;
    }

    public void setRetType(String retType) {
        this.retType = retType;
    }

    public void addArgType(String argType) {
        this.argsType.add(argType);
    }
}
