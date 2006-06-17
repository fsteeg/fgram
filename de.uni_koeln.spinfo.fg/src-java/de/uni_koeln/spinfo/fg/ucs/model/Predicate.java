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

    /**
     * Default constructor, used during parsing
     */
    public Predicate() {
        this.term = new Term();
    }

    /**
     * @param term
     *            The 'root' term for this predicate
     * @param role
     *            The role of the entire predicate (agent, goal...)
     * @param relation
     *            The relation of the entire predicate (subject, object)
     */
    public Predicate(Term term, String role, String relation) {
        super();
        this.term = term;
        this.role = role.equals("") ? Config.getString("default_role") : Config
                .getString(role.toLowerCase());
        this.relation = relation == null || relation.equals("") ? Config
                .getString("default_relation") : Config.getString(relation
                .toLowerCase());
    }

    /**
     * @see java.lang.Object#toString()
     */
    @Override
    public String toString() {
        StringBuilder argsString = new StringBuilder();

        for (Predicate pred : term.getChildren()) {
            argsString.append(pred.toString());
        }
        return "[Predicate] Role: " + role + " Relation: " + relation
                + " Term: " + term.toString() + " Children: "
                + argsString.toString().trim() + "" + ("\n\n ");
    }

    /**
     * @return Returns true if this is a Term, meaning it has no children
     */
    public boolean isTerm() {
        return term.getChildren().size() == 0;
    }

    /**
     * @return The term
     */
    public Term getTerm() {
        return term;
    }

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
}
