// Part of "Functional Grammar Language Generator" (http://fgram.sourceforge.net/) (C) 2006 Fabian Steeg
// This library is free software; you can redistribute it and/or modify it under the terms of the GNU Lesser General Public License as published by the Free Software Foundation; either version 2.1 of the License, or (at your option) any later version.
// This library is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more details.
// You should have received a copy of the GNU Lesser General Public License along with this library; if not, write to the Free Software Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA

package de.uni_koeln.spinfo.fg.ucs.model;

import de.uni_koeln.spinfo.fg.util.Config;

/**
 * Represents a Predicate, or a complete Underlying Clause Structure, which is
 * an abstract representation of a linguistic expression. It is composed of
 * Terms (the arguments of the predicate).
 * 
 * @author Fabian Steeg
 * 
 */
public class Predicate {

    private Term term;

    private String role;

    private String relation;

    public Predicate() {
        this.term = new Term();
    }

    // public Predicate(String def, String num, String type, String index,
    // String form, String nav, Collection<Term> args) {
    // super();
    // this.term = new Term(def, "", num, type, index, form, nav);
    // }

    public Predicate(Term vals, String role, String relation) {
        super();
        this.term = vals;
        // this.role = role.toLowerCase();
        // this.relation = relation.toLowerCase();
        // if (!role.equals("")) {
        this.role = role.equals("") ? Config.getString("default_role")
                : Config.getString(role.toLowerCase());
        this.relation = relation.equals("") ? Config
                .getString("default_relation") : Config
                .getString(relation.toLowerCase());
        // String r = role;// getRelation(role).toLowerCase();
        // use a mapping for this, prop file, do it somewhere else?

        // String trimmedRole = role.substring(0, role.length() - r.length())
        // .toLowerCase();
        //
        // if (r.equals("subj"))
        // r = "subject";
        // else if (r.equals("obj"))
        // r = "object";
        // this.relation = r;
        //
        // if (r.equals("ag"))
        // this.role = "agent";
        // else if (r.equals("go"))
        // this.role = "goal";
        // else
        // this.role = trimmedRole;
        //
        // if (this.relation.equals(""))
        // this.relation = "unknown";
        // }

    }

    // private String getRelation(String role2) {
    // char[] cs = role2.toCharArray();
    // for (int i = 0; i < cs.length; i++) {
    // if (i != 0 && Character.isUpperCase(cs[i])) {
    // return role2.substring(i);
    // }
    // }
    // // TODO Auto-generated method stub
    // return "";
    // }

    @Override
    public String toString() {
        StringBuilder argsString = new StringBuilder();

        for (Predicate pred : term.getChildren()) {
            argsString.append(pred.toString()).append(" ");
        }
        return "Predicate Values: " + term.toString() + ", Args: "
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

    
    /**
     * @param i The depth in the internal tree representation
     * @return 
     */
//    public String getProps(int i) {
//        StringBuilder res = new StringBuilder();
//        // the predicate itself has index 1, so we start with 2:
//        i++;
//        for (int j = 0; j < term.getChildren().size(); j++) {
//            res.append("x" + i + " ");
//            i++;
//        }
//        return res.toString().trim().replaceAll(" ", ", ");
//    }

    // public void setRole(String role) {
    // this.role = role;
    // }
    
    /**
     * @return The term
     */
    public Term getTerm() {
        return term;
    }
    
    //
    /**
     * @return The semantic role or function, like "agent", "goal",...
     */
    public String getRole() {
        return this.role;
    }

    /**
     * @return The syntactic relation or function, either "subject" or "object"
     */
    public String getRelation() {
        return this.relation;
    }

    //
    // public Collection<Predicate> getArgs() {
    // return term.getChildren();
    // }
    //
    /**
     * @return Returns true if this is a Term, meaning it has no children
     */
    public boolean isTerm() {
        return term.getChildren().size() == 0;
    }
}
