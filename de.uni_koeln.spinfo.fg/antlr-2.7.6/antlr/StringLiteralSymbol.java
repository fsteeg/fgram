package antlr;

/* ANTLR Translator Generator
 * Project led by Terence Parr at http://www.cs.usfca.edu
 * Software rights: http://www.antlr.org/license.html
 *
 * $Id: StringLiteralSymbol.java,v 1.1 2006/03/06 00:54:28 fsteeg Exp $
 */

class StringLiteralSymbol extends TokenSymbol {
    protected String label;	// was this string literal labeled?


    public StringLiteralSymbol(String r) {
        super(r);
    }

    public String getLabel() {
        return label;
    }

    public void setLabel(String label) {
        this.label = label;
    }
}
