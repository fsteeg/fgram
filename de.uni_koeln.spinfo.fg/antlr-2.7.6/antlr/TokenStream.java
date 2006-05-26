package antlr;

/* ANTLR Translator Generator
 * Project led by Terence Parr at http://www.cs.usfca.edu
 * Software rights: http://www.antlr.org/license.html
 *
 * $Id: TokenStream.java,v 1.1 2006/03/06 00:54:27 fsteeg Exp $
 */

public interface TokenStream {
    public Token nextToken() throws TokenStreamException;
}
