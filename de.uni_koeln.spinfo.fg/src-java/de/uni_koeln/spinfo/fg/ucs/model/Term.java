package de.uni_koeln.spinfo.fg.ucs.model;

/**
 * Represents an argument of an Predicate (that is a Term)
 * 
 * @author Fabian Steeg
 * @deprecated no longer used, maybe values shoudl be called term
 */
public class Term {

    private String role;

    private Values values;

    public Term(String def, String num, String type, String index, String form,
            String nav, String role) {
        super();
        this.values = new Values(def, num, type, index, form, nav);
        this.role = role;
    }

    @Override
    public String toString() {
        return "[Term values: " + values.toString() + ", Role: " + role + "]";
    }

    public String getForm() {
        return this.values.getForm();
    }

    public String getProps() {
        return values.getDef() + ", " + values.getNum() + ", "
        /* + values.getNav() + ", " + index + ", " */+ role;
    }
}
