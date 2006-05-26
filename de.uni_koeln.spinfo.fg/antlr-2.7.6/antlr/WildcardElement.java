package antlr;

/* ANTLR Translator Generator
 * Project led by Terence Parr at http://www.cs.usfca.edu
 * Software rights: http://www.antlr.org/license.html
 *
 * $Id: WildcardElement.java,v 1.1 2006/03/06 00:54:27 fsteeg Exp $
 */

class WildcardElement extends GrammarAtom {
    protected String label;

    public WildcardElement(Grammar g, Token t, int autoGenType) {
        super(g, t, autoGenType);
        line = t.getLine();
    }

    public void generate() {
        grammar.generator.gen(this);
    }

    public String getLabel() {
        return label;
    }

    public Lookahead look(int k) {
        return grammar.theLLkAnalyzer.look(k, this);
    }

    public void setLabel(String label_) {
        label = label_;
    }

    public String toString() {
        String s = " ";
        if (label != null) s += label + ":";
        return s + ".";
    }
}
