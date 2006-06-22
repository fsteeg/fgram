// Part of "Functional Grammar Language Generator" (http://fgram.sourceforge.net/) (C) 2005 Fabian Steeg
// This library is free software; you can redistribute it and/or modify it under the terms of the GNU Lesser General Public License as published by the Free Software Foundation; either version 2.1 of the License, or (at your option) any later version.
// This library is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more details.
// You should have received a copy of the GNU Lesser General Public License along with this library; if not, write to the Free Software Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA

package de.uni_koeln.spinfo.fg.ucs.model;

import java.util.ArrayList;
import java.util.List;

import de.uni_koeln.spinfo.fg.util.Config;

/**
 * Represents a Terms (an argument of a predicate)
 * 
 * @author Fabian Steeg (fsteeg)
 */
public class Term {

    private String def, num, layer, index, wordForm, wordClass, tense;

    private List<Predicate> children;

    private boolean perfect;

    private boolean progressive;

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
     *            The tense, like "past" or "pres"
     * @param number
     *            The number, like "1" or "m"
     * @param layer
     *            The layer, like "e" or "X"
     * @param wordForm
     *            The form, like "attack" or "city"
     * @param wordClass
     *            The word class, "N", "A", "V", "T"
     */
    public Term(String det, String tense, String number, String layer,
            String wordForm, String wordClass) {
        super();
        // get the mapped values or the default values
        this.def = det != null ? Config.getString(det.toLowerCase()) : Config
                .getString("default_det");

        // TODO
        if (tense != null) {
            if (tense.contains("prog")) {
                this.progressive = true;
                tense = tense.replaceAll("prog", "");
            }
            //TODO tense vs aspect...
            if (tense.contains("perf")) {
                this.perfect = true;
                tense = "pres";
            }
        }

        this.tense = tense != null ? Config.getString(tense.toLowerCase())
                : Config.getString("default_tense");
        this.num = number != null ? Config.getString(number.toLowerCase())
                : Config.getString("default_num");
        this.layer = layer;
        this.wordClass = wordClass;
        // TODO temp
        this.wordForm = wordForm == null || wordForm.equals("") ? "" : wordForm
                .replaceAll("/", "");
        this.children = new ArrayList<Predicate>();
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

    /**
     * @return The children predicates
     */
    public List<Predicate> getChildren() {
        return children;
    }

    /**
     * @return The Definiteness: indef or def
     */
    public String getDef() {
        return def;
    }

    /**
     * @return The Number: singular, plural, ...
     */
    public String getNum() {
        return num;
    }

    /**
     * @return The Tense: past, present TODO FG: anterior, no past?
     */
    public String getTense() {
        return tense;
    }

    /**
     * @return The word form: "attack" or "man", ...
     */
    public String getWordForm() {
        return wordForm;
    }

    /**
     * @return The word class: V, N, A, T
     */
    public String getWordClass() {
        return wordClass;
    }

    public boolean isPerfect() {
        return perfect;
    }

    public boolean isProgressive() {
        return progressive;
    }

}
