public class IRVar {
    private String name;
    private String type;

    public IRVar(String name, String type)
    {
        this.name = name;
        this.type = type;
    }

    public String getName()
    {
        return this.name;
    }

    public String getType()
    {
        return this.type;
    }
}