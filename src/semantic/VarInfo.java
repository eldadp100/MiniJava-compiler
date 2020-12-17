package semantic;

public class VarInfo {
    private String name;
    private String type;

    public VarInfo(String name, String type) {
        this.name = name;
        this.type = type;
    }

    public String getName() {
        return name;
    }

    public String getType() {
        return type;
    }
}
