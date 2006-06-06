package de.uni_koeln.spinfo.fg.ucs.model;

import java.util.Collection;

//TODO a term can be a predicate again

/**
 * Represents a Predicate, or a complete Underlying Clause Structure, which is
 * an abstract representation of a linguistic expression. It is composed of
 * Predicate-specific values and Arguments (Terms of the Predicate)
 * 
 * @author Fabian Steeg
 * 
 */
public class Predicate {

    private Term values;

    private String role;

    private String relation;

    public Predicate() {
        this.values = new Term();
    }

    public Predicate(String def, String num, String type, String index,
            String form, String nav, Collection<Term> args) {
        super();
        this.values = new Term(def, "", num, type, index, form, nav);
    }

    public Predicate(Term vals, String role) {
        super();
        this.values = vals;
        this.role = role.toLowerCase();
        if (!role.equals("")) {
            String r = getRelation(role).toLowerCase();
            // use a mapping for this, prop file, do it somewhere else?

            String trimmedRole = role.substring(0,
                    role.length() - r.length()).toLowerCase();
            
            if (r.equals("subj"))
                r = "subject";
            else if (r.equals("obj"))
                r = "object";
            this.relation = r;
            
            if (r.equals("ag"))
                this.role = "agent";
            else if (r.equals("go"))
                this.role = "goal";
            else
                this.role = trimmedRole;

            if (this.relation.equals(""))
                this.relation = "unknown";
        }

    }

    private String getRelation(String role2) {
        char[] cs = role2.toCharArray();
        for (int i = 0; i < cs.length; i++) {
            if (i != 0 && Character.isUpperCase(cs[i])) {
                return role2.substring(i);
            }
        }
        // TODO Auto-generated method stub
        return "";
    }

    @Override
    public String toString() {
        StringBuilder argsString = new StringBuilder();

        for (Predicate pred : values.children) {
            argsString.append(pred.toString()).append(" ");
        }
        return "Predicate Values: " + values.toString() + ", Args: "
                + argsString.toString().trim() + "";
    }

    // public Collection<Term> getArgs() {
    // return this.args;
    // }

    // public void addChild(Predicate p) {
    // // TODO implement
    // System.out.println("Will add Child: " + p.toString());
    // children.add(p);
    // }

    public Term getValues() {
        return values;
    }

    /**
     * @param i2
     * @return Something like "start1, start2, start3"
     */
    public String getProps(int i) {
        StringBuilder res = new StringBuilder();
        // the predicate itself has index 1, so we start with 2:
        i++;
        for (Predicate term : values.children) {
            res.append("x" + i + " ");
            i++;
        }
        return res.toString().trim().replaceAll(" ", ", ");
    }

    public void setRole(String role) {
        this.role = role;
    }

    public String getRole() {
        return this.role;
    }

    public Collection<Predicate> getArgs() {
        return values.children;
    }

    public boolean isTerm() {
        return values.children.size() == 0;
    }

    public String getRelation() {
        return this.relation;
    }
}
