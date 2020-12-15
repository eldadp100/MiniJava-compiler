public class IRVar {
    private String name;
    private String type;
    private int number;

    public IRVar(String name, int number, String type)
    {
        this.name = name;
        this.type = type;
        this.number = number;
    }

    public String getName()
    {
        return this.name;
    }

    public String getType()
    {
        return this.type;
    }

    public int getNumber()
    {
        return this.number;
    }
}
