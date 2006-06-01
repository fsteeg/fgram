// $ANTLR : "form.g" -> "FormParser.java"$

	package de.uni_koeln.spinfo.fg.parser;
	import de.uni_koeln.spinfo.fg.ucs.model.*;
	import antlr.*;

import antlr.TokenBuffer;
import antlr.TokenStreamException;
import antlr.TokenStreamIOException;
import antlr.ANTLRException;
import antlr.LLkParser;
import antlr.Token;
import antlr.TokenStream;
import antlr.RecognitionException;
import antlr.NoViableAltException;
import antlr.MismatchedTokenException;
import antlr.SemanticException;
import antlr.ParserSharedInputState;
import antlr.collections.impl.BitSet;
import antlr.collections.AST;
import java.util.Hashtable;
import antlr.ASTFactory;
import antlr.ASTPair;
import antlr.collections.impl.ASTArray;

public class FormParser extends antlr.LLkParser       implements FormParserTokenTypes
 {

	TokenStreamSelector selector = new TokenStreamSelector();
	selector.addInputStream(FormLexer, "formLexer");
	selector.addInputStream(WordLexer, "wordLexer");
	selector.select("formLexer");

protected FormParser(TokenBuffer tokenBuf, int k) {
  super(tokenBuf,k);
  tokenNames = _tokenNames;
  buildTokenTypeASTClassMap();
  astFactory = new ASTFactory(getTokenTypeToASTClassMap());
}

public FormParser(TokenBuffer tokenBuf) {
  this(tokenBuf,1);
}

protected FormParser(TokenStream lexer, int k) {
  super(lexer,k);
  tokenNames = _tokenNames;
  buildTokenTypeASTClassMap();
  astFactory = new ASTFactory(getTokenTypeToASTClassMap());
}

public FormParser(TokenStream lexer) {
  this(lexer,1);
}

public FormParser(ParserSharedInputState state) {
  super(state,1);
  tokenNames = _tokenNames;
  buildTokenTypeASTClassMap();
  astFactory = new ASTFactory(getTokenTypeToASTClassMap());
}

	public final Predicate  input() throws RecognitionException, TokenStreamException {
		Predicate ret = new Predicate();
		
		returnAST = null;
		ASTPair currentAST = new ASTPair();
		AST input_AST = null;
		
		try {      // for error handling
			ret=predicate();
			astFactory.addASTChild(currentAST, returnAST);
			{
			switch ( LA(1)) {
			case NEWLINE:
			{
				AST tmp1_AST = null;
				tmp1_AST = astFactory.create(LT(1));
				astFactory.addASTChild(currentAST, tmp1_AST);
				match(NEWLINE);
				break;
			}
			case EOF:
			{
				break;
			}
			default:
			{
				throw new NoViableAltException(LT(1), getFilename());
			}
			}
			}
			input_AST = (AST)currentAST.root;
		}
		catch (RecognitionException ex) {
			reportError(ex);
			recover(ex,_tokenSet_0);
		}
		returnAST = input_AST;
		return ret;
	}
	
	public final Predicate  predicate() throws RecognitionException, TokenStreamException {
		Predicate ret = new Predicate();
		
		returnAST = null;
		ASTPair currentAST = new ASTPair();
		AST predicate_AST = null;
		Token  role = null;
		AST role_AST = null;
		Predicate p = null; Values v = null; Values recVal = null; boolean foundRole = false;
		
		try {      // for error handling
			AST tmp2_AST = null;
			tmp2_AST = astFactory.create(LT(1));
			astFactory.makeASTRoot(currentAST, tmp2_AST);
			match(LPAREN);
			{
			int _cnt2682=0;
			_loop2682:
			do {
				if ((LA(1)==DEF)) {
					recVal=values();
					astFactory.addASTChild(currentAST, returnAST);
						
							// first
							if(v==null) {
								v = recVal; 
							}
							// more, add them
							else{
								Predicate pred = new Predicate(recVal,"");
								v.addChild(pred);
							}
						
				}
				else {
					if ( _cnt2682>=1 ) { break _loop2682; } else {throw new NoViableAltException(LT(1), getFilename());}
				}
				
				_cnt2682++;
			} while (true);
			}
			AST tmp3_AST = null;
			tmp3_AST = astFactory.create(LT(1));
			astFactory.addASTChild(currentAST, tmp3_AST);
			match(RPAREN);
			{
			switch ( LA(1)) {
			case LETTER:
			{
				role = LT(1);
				role_AST = astFactory.create(role);
				astFactory.addASTChild(currentAST, role_AST);
				match(LETTER);
				ret = new Predicate(v,role.getText()); foundRole = true;
				break;
			}
			case EOF:
			case NEWLINE:
			case LPAREN:
			case RPAREN:
			case DEF:
			{
				break;
			}
			default:
			{
				throw new NoViableAltException(LT(1), getFilename());
			}
			}
			}
			if(!foundRole) ret = new Predicate(v,"");
			predicate_AST = (AST)currentAST.root;
		}
		catch (RecognitionException ex) {
			reportError(ex);
			recover(ex,_tokenSet_1);
		}
		returnAST = predicate_AST;
		return ret;
	}
	
	public final Values  values() throws RecognitionException, TokenStreamException {
		Values ret = new Values();
		
		returnAST = null;
		ASTPair currentAST = new ASTPair();
		AST values_AST = null;
		Token  d = null;
		AST d_AST = null;
		Token  n = null;
		AST n_AST = null;
		Token  t = null;
		AST t_AST = null;
		Token  c = null;
		AST c_AST = null;
		Token  w0 = null;
		AST w0_AST = null;
		Token  p0 = null;
		AST p0_AST = null;
		Predicate pred = null;Values v = null;
		
		try {      // for error handling
			d = LT(1);
			d_AST = astFactory.create(d);
			astFactory.addASTChild(currentAST, d_AST);
			match(DEF);
			n = LT(1);
			n_AST = astFactory.create(n);
			astFactory.addASTChild(currentAST, n_AST);
			match(NUMBER);
			t = LT(1);
			t_AST = astFactory.create(t);
			astFactory.addASTChild(currentAST, t_AST);
			match(LETTER);
			c = LT(1);
			c_AST = astFactory.create(c);
			astFactory.addASTChild(currentAST, c_AST);
			match(NUMBER);
			AST tmp4_AST = null;
			tmp4_AST = astFactory.create(LT(1));
			astFactory.addASTChild(currentAST, tmp4_AST);
			match(RESTRIKTOR);
			ret = new Values(d.getText(), n.getText(), t.getText(), c.getText(), null,null);
			selector.push("wordLexer");
			{
			switch ( LA(1)) {
			case LETTER:
			{
				w0 = LT(1);
				w0_AST = astFactory.create(w0);
				astFactory.addASTChild(currentAST, w0_AST);
				match(LETTER);
				selector.pop();
				AST tmp5_AST = null;
				tmp5_AST = astFactory.create(LT(1));
				astFactory.addASTChild(currentAST, tmp5_AST);
				match(LBRACK);
				p0 = LT(1);
				p0_AST = astFactory.create(p0);
				astFactory.addASTChild(currentAST, p0_AST);
				match(LETTER);
				AST tmp6_AST = null;
				tmp6_AST = astFactory.create(LT(1));
				astFactory.addASTChild(currentAST, tmp6_AST);
				match(RBRACK);
				{
				switch ( LA(1)) {
				case RESTRIKTOR:
				{
					AST tmp7_AST = null;
					tmp7_AST = astFactory.create(LT(1));
					astFactory.addASTChild(currentAST, tmp7_AST);
					match(RESTRIKTOR);
					break;
				}
				case LPAREN:
				case RPAREN:
				case DEF:
				{
					break;
				}
				default:
				{
					throw new NoViableAltException(LT(1), getFilename());
				}
				}
				}
				ret = new Values(d.getText(), n.getText(), t.getText(), c.getText(), w0.getText(), p0.getText());
				break;
			}
			case LPAREN:
			case RPAREN:
			case DEF:
			{
				break;
			}
			default:
			{
				throw new NoViableAltException(LT(1), getFilename());
			}
			}
			}
			{
			_loop2688:
			do {
				if ((LA(1)==LPAREN)) {
					pred=predicate();
					astFactory.addASTChild(currentAST, returnAST);
					ret.addChild(pred);
				}
				else {
					break _loop2688;
				}
				
			} while (true);
			}
			values_AST = (AST)currentAST.root;
		}
		catch (RecognitionException ex) {
			reportError(ex);
			recover(ex,_tokenSet_2);
		}
		returnAST = values_AST;
		return ret;
	}
	
	
	public static final String[] _tokenNames = {
		"<0>",
		"EOF",
		"<2>",
		"NULL_TREE_LOOKAHEAD",
		"NEWLINE",
		"LPAREN",
		"RPAREN",
		"LETTER",
		"DEF",
		"NUMBER",
		"RESTRIKTOR",
		"LBRACK",
		"RBRACK",
		"BLANK"
	};
	
	protected void buildTokenTypeASTClassMap() {
		tokenTypeToASTClassMap=null;
	};
	
	private static final long[] mk_tokenSet_0() {
		long[] data = { 2L, 0L};
		return data;
	}
	public static final BitSet _tokenSet_0 = new BitSet(mk_tokenSet_0());
	private static final long[] mk_tokenSet_1() {
		long[] data = { 370L, 0L};
		return data;
	}
	public static final BitSet _tokenSet_1 = new BitSet(mk_tokenSet_1());
	private static final long[] mk_tokenSet_2() {
		long[] data = { 320L, 0L};
		return data;
	}
	public static final BitSet _tokenSet_2 = new BitSet(mk_tokenSet_2());
	
	}
