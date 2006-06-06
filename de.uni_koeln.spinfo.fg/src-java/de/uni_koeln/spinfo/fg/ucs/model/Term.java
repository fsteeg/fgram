// Part of "Functional Grammar Language Generator" (http://fgram.sourceforge.net/) (C) 2005 Fabian Steeg
// This library is free software; you can redistribute it and/or modify it under the terms of the GNU Lesser General Public License as published by the Free Software Foundation; either version 2.1 of the License, or (at your option) any later version.
// This library is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more details.
// You should have received a copy of the GNU Lesser General Public License along with this library; if not, write to the Free Software Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA

package de.uni_koeln.spinfo.fg.ucs.model;

import java.util.ArrayList;
import java.util.Collection;

import de.uni_koeln.spinfo.fg.util.Config;

/**
 * Represents a Terms (an argument of a predicate)
 * 
 * @author Fabian Steeg (fsteeg)
 */
public class Term {

    protected String def, num, layer, index, wordForm, wordClass, tense;

    // private String num;

    // private String type;

    // private String index;

    // private String form;

    // private String nav;

    private Collection<Predicate> children;

    // public int count;

    // private String tense;

    /**
     * Default constructor, instantiates the children
     */
    public Term() {
        super();
        this.children = new ArrayList<Predicate>();
    }

    /**
     * @param det
     *            Like "D" for definite or "I" for indefinite (currently only
     *            uppercase)
     * @param tense
     *            The tense, like "Past" or "Pres"
     * @param number
     *            The number, like "1" or "M" (currently only uppercase)
     * @param layer
     *            The layer, like "E" or "X" (currently only uppercase)
     * @param wordForm
     *            The form, like "attack" or "city"
     * @param wordClass
     *            The word class, "N", "A", "v", "T"
     */
    public Term(String det, String tense, String number, String layer, /*
                                                                         * String
                                                                         * index,
                                                                         */
    String wordForm, String wordClass) {
        super();
        // TODO this in antlr, using an prop file to map "i" to "indef" etc
        // if(def.equals("i")) //$NON-NLS-1$
        this.def = det != null ? Config.getString(det.toLowerCase())
                : Config.getString("default_det"); //$NON-NLS-1$
        this.tense = tense != null ? Config.getString(tense
                .toLowerCase()) : Config.getString("default_tense");
        this.num = number != null ? Config.getString(number
                .toLowerCase()) : Config.getString("default_num");
        // else if(def.equals("d")) //$NON-NLS-1$
        // def = Abbreviations.getString("d"); //$NON-NLS-1$
        // TODO provisorically... we need distinction...
        // if(def.toLowerCase().equals(Abbreviations.getString("past")))
        // //$NON-NLS-1$
        // tense = "past"; //$NON-NLS-1$
        // else if(def.toLowerCase().equals("pres")) //$NON-NLS-1$
        // tense = Abbreviations.getString("pres"); //$NON-NLS-1$
        // this.def = def;
        // if(num.equals("1")) //$NON-NLS-1$
        // num = Abbreviations.getString("1"); //$NON-NLS-1$
        // else if(num.toLowerCase().equals("m")) //$NON-NLS-1$
        // num = Abbreviations.getString("m"); //$NON-NLS-1$
        // this.num = num;

        // this.index = index;
        this.layer = layer;
        this.wordClass = wordClass;
        this.wordForm = wordForm;
        this.children = new ArrayList<Predicate>();
    }

    /**
     * @param p
     *            The Predicate to add as a child, doen during parsing.
     */
    // public void addChild(Predicate p) {
    // // System.out.println("Will add Child: " + p.toString());
    // children.add(p);
    // }
    // @Override
    // public String toString() {
    // return "Form: " + wordForm + ", Def: " + def + ", Num: " + num + ", Type:
    // " //$NON-NLS-1$ //$NON-NLS-2$ //$NON-NLS-3$ //$NON-NLS-4$
    // + layer + ", Index: " + index + ", N/A/V: " + wordClass; //$NON-NLS-1$
    // //$NON-NLS-2$
    // }
    // public String getForm() {
    // return wordForm;
    // }
    //
    // public String getNum() {
    // return num;
    // }
    //
    // public String getDef() {
    // return def;
    // }
    //
    // public String getNav() {
    // if (wordClass != null)
    // return wordClass.toLowerCase();
    // else
    // return null;
    // }
    //
    // public int getIndex() {
    // return Integer.parseInt(index);
    // }
    //
    // public String getTense() {
    // return tense;
    // }
    public Collection<Predicate> getChildren() {
        return children;
    }

    /**
     * 
     * @return A string representation of this.
     */
    public String toString() {
        StringBuilder builder = new StringBuilder();
        builder.append("Term[");
        builder.append("children = ").append(children);
        builder.append(" def = ").append(def);
        builder.append(" index = ").append(index);
        builder.append(" layer = ").append(layer);
        builder.append(" num = ").append(num);
        builder.append(" tense = ").append(tense);
        builder.append(" wordClass = ").append(wordClass);
        builder.append(" wordForm = ").append(wordForm);
        builder.append("]");
        return builder.toString();
    }

    public String getDef() {
        return def;
    }

    public String getNum() {
        return num;
    }

    public String getTense() {
        return tense;
    }

    public String getWordForm() {
        return wordForm;
    }

    public String getWordClass() {
        return wordClass;
    }

}
