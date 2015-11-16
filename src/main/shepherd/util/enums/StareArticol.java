package util.enums;

import java.util.HashMap;
import java.util.Map;

public enum StareArticol {
    STOC(1,"In Stoc"),
    RECUPERAT(2,"Recuperat / In Stoc"),
    IN_FOLOSINTA(3,"In folosinta"),
    TRANZIT(4,"In Tranzit"),
    DETERIORAT(5,"Deteriorat"),
    SERVICE(6,"In Service"),
    DISPARUT(7,"Disparut"),
    CASAT(8,"Casat");

    /**
     * A mapping between the integer code and its corresponding Status to facilitate lookup by code.
     */
    private static Map<Integer, StareArticol> codeToStatusMapping;
    private int code;
    private String label;

    StareArticol(int code, String label) {
        this.code = code;
        this.label = label;
    }

    public static StareArticol getStatus(int i) {
        if (codeToStatusMapping == null) {
            initMapping();
        }
        return codeToStatusMapping.get(i);
    }

    private static void initMapping() {
        codeToStatusMapping = new HashMap<Integer, StareArticol>();
        for (StareArticol s: values()) {
            codeToStatusMapping.put(s.code, s);
        }
    }

    public int getCode() {
        return code;
    }

    public String getLabel() {
        return label;
    }

    @Override
    public String toString() {
        final StringBuilder sb = new StringBuilder();
        sb.append("StareArticol");
        sb.append("{code=").append(code);
        sb.append(", label='").append(label).append('\'');
        sb.append('}');
        return sb.toString();
    }
}
