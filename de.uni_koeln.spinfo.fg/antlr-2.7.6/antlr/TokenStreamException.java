package antlr;

/* ANTLR Translator Generator
 * Project led by Terence Parr at http://www.cs.usfca.edu
 * Software rights: http://www.antlr.org/license.html
 *
 * $Id: TokenStreamException.java,v 1.1 2006/03/06 00:54:27 fsteeg Exp $
 */

/**
 * Anything that goes wrong while generating a stream of tokens.
 */
public class TokenStreamException extends ANTLRException {
    public TokenStreamException() {
    }

    public TokenStreamException(String s) {
        super(s);
    }

	public TokenStreamException(String message, Throwable cause) {
		super(message, cause);
	}

	public TokenStreamException(Throwable cause) {
		super(cause);
	}
}
