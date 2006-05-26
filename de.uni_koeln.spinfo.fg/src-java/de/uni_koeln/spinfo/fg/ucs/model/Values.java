/**
 * @author Fabian Steeg
 * Created on 05.11.2005
 */
package de.uni_koeln.spinfo.fg.ucs.model;

import java.util.ArrayList;
import java.util.Collection;

/**
 * Contains the values of an Predicate or a Term
 * 
 * @author Fabian Steeg (fsteeg)
 */
public class Values {

    private String def;

    private String num;

    private String type;

    private String index;

    private String form;

    private String nav;

    Collection<Predicate> children;

    public int count;

    /**
     * @param def
     *            like "d" for definite or "i" for indefinite
     * @param num
     *            the number, like "1" or "2"
     * @param type
     *            the type, like "e" or "x"
     * @param index
     *            the index, a number
     * @param form
     *            the form, like "attack" or "city"
     * @param nav
     *            The type of predication, n, a, v
     * @param count
     */
    public Values(String def, String num, String type, String index,
            String form, String nav) {
        super();
        //TODO this in antlr, using an prop file to map "i" to "indef" etc
        if(def.equals("i"))
        	def = "indef";
        else if(def.equals("d"))
        	def = "def";
        this.def = def;
        if(num.equals("1"))
        	num = "sing";
        else if(num.equals("2"))
        	num = "plural";
        this.num = num;
        this.type = type;
        this.index = index;
        this.nav = nav;
        this.form = form;
        this.children = new ArrayList<Predicate>();
    }

    public void addChild(Predicate p) {
        // System.out.println("Will add Child: " + p.toString());
        children.add(p);
    }

    public Values() {
        super();
        this.children = new ArrayList<Predicate>();
    }

    @Override
    public String toString() {
        return "Form: " + form + ", Def: " + def + ", Num: " + num + ", Type: "
                + type + ", Index: " + index + ", N/A/V: " + nav;
    }

    public String getForm() {
        return form;
    }

    public String getNum() {
        return num;
    }

    public String getDef() {
        return def;
    }

    public String getNav() {
        if (nav != null)
            return nav.toLowerCase();
        else
            return null;
    }

    public int getIndex() {
        return Integer.parseInt(index);
    }

}
