package antlr.collections;

/* ANTLR Translator Generator
 * Project led by Terence Parr at http://www.cs.usfca.edu
 * Software rights: http://www.antlr.org/license.html
 *
 * $Id: ASTEnumeration.java,v 1.1 2006/03/06 00:54:28 fsteeg Exp $
 */

public interface ASTEnumeration {
    public boolean hasMoreNodes();

    public AST nextNode();
}
