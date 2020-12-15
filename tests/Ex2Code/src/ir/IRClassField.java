public class IRClassField {

    private String fieldName;
    private String fieldType;
    private int fieldSize;

    public IRClassField(String fieldName, String fieldType, int fieldSize)
    {
        this.fieldName = fieldName;
        this.fieldType = fieldType;
        this.fieldSize = fieldSize;
    }

    public String getName() {
        return fieldName;
    }

    public String getType() {
        return fieldType;
    }

    public int getSize() {
        return fieldSize;
    }
}
