// $ANTLR 2.7.4: "ucs.g" -> "UcsParser.java"$

	package de.uni_koeln.spinfo.fg.parser;
	import de.uni_koeln.spinfo.fg.ucs.model.*;

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

public class UcsParser extends antlr.LLkParser       implements UcsParserTokenTypes
 {

protected UcsParser(TokenBuffer tokenBuf, int k) {
  super(tokenBuf,k);
  tokenNames = _tokenNames;
  buildTokenTypeASTClassMap();
  astFactory = new ASTFactory(getTokenTypeToASTClassMap());
}

public UcsParser(TokenBuffer tokenBuf) {
  this(tokenBuf,1);
}

protected UcsParser(TokenStream lexer, int k) {
  super(lexer,k);
  tokenNames = _tokenNames;
  buildTokenTypeASTClassMap();
  astFactory = new ASTFactory(getTokenTypeToASTClassMap());
}

public UcsParser(TokenStream lexer) {
  this(lexer,1);
}

public UcsParser(ParserSharedInputState state) {
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
			consume();
			consumeUntil(_tokenSet_0);
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
		Token  relation = null;
		AST relation_AST = null;
		Token  prag = null;
		AST prag_AST = null;
		Predicate p = null; Term v = null; Term recVal = null; boolean foundRole = false;
		
		try {      // for error handling
			AST tmp2_AST = null;
			tmp2_AST = astFactory.create(LT(1));
			astFactory.makeASTRoot(currentAST, tmp2_AST);
			match(LPAREN);
			{
			int _cnt5=0;
			_loop5:
			do {
				if ((_tokenSet_1.member(LA(1)))) {
					recVal=term();
					astFactory.addASTChild(currentAST, returnAST);
						
							// first
							if(v==null) {
								v = recVal; 
							}
							// more, add them
							else{
								Predicate pred = new Predicate(recVal,"", "");
								v.getChildren().add(pred);
							}
						
				}
				else {
					if ( _cnt5>=1 ) { break _loop5; } else {throw new NoViableAltException(LT(1), getFilename());}
				}
				
				_cnt5++;
			} while (true);
			}
			AST tmp3_AST = null;
			tmp3_AST = astFactory.create(LT(1));
			astFactory.addASTChild(currentAST, tmp3_AST);
			match(RPAREN);
			{
			switch ( LA(1)) {
			case SEMANTIC_FUNCTION:
			{
				role = LT(1);
				role_AST = astFactory.create(role);
				astFactory.addASTChild(currentAST, role_AST);
				match(SEMANTIC_FUNCTION);
				{
				switch ( LA(1)) {
				case SYNTACTIC_FUNCTION:
				{
					relation = LT(1);
					relation_AST = astFactory.create(relation);
					astFactory.addASTChild(currentAST, relation_AST);
					match(SYNTACTIC_FUNCTION);
					break;
				}
				case EOF:
				case NEWLINE:
				case LPAREN:
				case RPAREN:
				case PRAGMATIC_FUNCTION:
				case DEF:
				case TENSE:
				case ASPECT:
				case LAYER:
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
				switch ( LA(1)) {
				case PRAGMATIC_FUNCTION:
				{
					prag = LT(1);
					prag_AST = astFactory.create(prag);
					astFactory.addASTChild(currentAST, prag_AST);
					match(PRAGMATIC_FUNCTION);
					break;
				}
				case EOF:
				case NEWLINE:
				case LPAREN:
				case RPAREN:
				case DEF:
				case TENSE:
				case ASPECT:
				case LAYER:
				{
					break;
				}
				default:
				{
					throw new NoViableAltException(LT(1), getFilename());
				}
				}
				}
				ret = new Predicate(v,role.getText(), relation!=null?relation.getText():null); foundRole = true;
				break;
			}
			case EOF:
			case NEWLINE:
			case LPAREN:
			case RPAREN:
			case DEF:
			case TENSE:
			case ASPECT:
			case LAYER:
			{
				break;
			}
			default:
			{
				throw new NoViableAltException(LT(1), getFilename());
			}
			}
			}
			if(!foundRole) ret = new Predicate(v,"", "");
			predicate_AST = (AST)currentAST.root;
		}
		catch (RecognitionException ex) {
			reportError(ex);
			consume();
			consumeUntil(_tokenSet_2);
		}
		returnAST = predicate_AST;
		return ret;
	}
	
	public final Term  term() throws RecognitionException, TokenStreamException {
		Term ret = new Term();
		
		returnAST = null;
		ASTPair currentAST = new ASTPair();
		AST term_AST = null;
		Token  d = null;
		AST d_AST = null;
		Token  n = null;
		AST n_AST = null;
		Token  tense = null;
		AST tense_AST = null;
		Token  aspect = null;
		AST aspect_AST = null;
		Token  t = null;
		AST t_AST = null;
		Token  w0 = null;
		AST w0_AST = null;
		Token  p0 = null;
		AST p0_AST = null;
		Token  w1 = null;
		AST w1_AST = null;
		Token  p1 = null;
		AST p1_AST = null;
		Predicate pred = null;Term v = null;
		
		try {      // for error handling
			{
			if ((LA(1)==DEF)) {
				{
				d = LT(1);
				d_AST = astFactory.create(d);
				astFactory.addASTChild(currentAST, d_AST);
				match(DEF);
				{
				switch ( LA(1)) {
				case NUMBER:
				{
					n = LT(1);
					n_AST = astFactory.create(n);
					astFactory.addASTChild(currentAST, n_AST);
					match(NUMBER);
					break;
				}
				case LAYER:
				{
					break;
				}
				default:
				{
					throw new NoViableAltException(LT(1), getFilename());
				}
				}
				}
				}
			}
			else if (((LA(1) >= TENSE && LA(1) <= LAYER))) {
				{
				{
				switch ( LA(1)) {
				case TENSE:
				{
					tense = LT(1);
					tense_AST = astFactory.create(tense);
					astFactory.addASTChild(currentAST, tense_AST);
					match(TENSE);
					break;
				}
				case ASPECT:
				case LAYER:
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
				switch ( LA(1)) {
				case ASPECT:
				{
					aspect = LT(1);
					aspect_AST = astFactory.create(aspect);
					astFactory.addASTChild(currentAST, aspect_AST);
					match(ASPECT);
					break;
				}
				case LAYER:
				{
					break;
				}
				default:
				{
					throw new NoViableAltException(LT(1), getFilename());
				}
				}
				}
				}
			}
			else if ((LA(1)==LAYER)) {
			}
			else {
				throw new NoViableAltException(LT(1), getFilename());
			}
			
			}
			t = LT(1);
			t_AST = astFactory.create(t);
			astFactory.addASTChild(currentAST, t_AST);
			match(LAYER);
			AST tmp4_AST = null;
			tmp4_AST = astFactory.create(LT(1));
			astFactory.addASTChild(currentAST, tmp4_AST);
			match(RESTRIKTOR);
			{
			if ((LA(1)==WORD)) {
				w0 = LT(1);
				w0_AST = astFactory.create(w0);
				astFactory.addASTChild(currentAST, w0_AST);
				match(WORD);
				p0 = LT(1);
				p0_AST = astFactory.create(p0);
				astFactory.addASTChild(currentAST, p0_AST);
				match(WORD_CLASS);
				{
				switch ( LA(1)) {
				case RESTRIKTOR:
				{
					AST tmp5_AST = null;
					tmp5_AST = astFactory.create(LT(1));
					astFactory.addASTChild(currentAST, tmp5_AST);
					match(RESTRIKTOR);
					break;
				}
				case LPAREN:
				case RPAREN:
				case DEF:
				case TENSE:
				case ASPECT:
				case LAYER:
				case WORD:
				{
					break;
				}
				default:
				{
					throw new NoViableAltException(LT(1), getFilename());
				}
				}
				}
			}
			else if ((_tokenSet_3.member(LA(1)))) {
			}
			else {
				throw new NoViableAltException(LT(1), getFilename());
			}
			
			}
			{
			switch ( LA(1)) {
			case WORD:
			{
				w1 = LT(1);
				w1_AST = astFactory.create(w1);
				astFactory.addASTChild(currentAST, w1_AST);
				match(WORD);
				p1 = LT(1);
				p1_AST = astFactory.create(p1);
				astFactory.addASTChild(currentAST, p1_AST);
				match(WORD_CLASS);
				{
				switch ( LA(1)) {
				case RESTRIKTOR:
				{
					AST tmp6_AST = null;
					tmp6_AST = astFactory.create(LT(1));
					astFactory.addASTChild(currentAST, tmp6_AST);
					match(RESTRIKTOR);
					break;
				}
				case LPAREN:
				case RPAREN:
				case DEF:
				case TENSE:
				case ASPECT:
				case LAYER:
				{
					break;
				}
				default:
				{
					throw new NoViableAltException(LT(1), getFilename());
				}
				}
				}
				break;
			}
			case LPAREN:
			case RPAREN:
			case DEF:
			case TENSE:
			case ASPECT:
			case LAYER:
			{
				break;
			}
			default:
			{
				throw new NoViableAltException(LT(1), getFilename());
			}
			}
			}
			ret = new Term(d!=null?d.getText():null,tense!=null?tense.getText():null,aspect!=null?aspect.getText():null, n!=null?n.getText():null, t!=null?t.getText():null,/*, c.getText()*/ w0!=null?w0.getText():null,p0!=null?p0.getText():null,w1!=null?w1.getText():null,p1!=null?p1.getText():null);
			{
			_loop21:
			do {
				if ((LA(1)==LPAREN)) {
					pred=predicate();
					astFactory.addASTChild(currentAST, returnAST);
					ret.getChildren().add(pred);
				}
				else {
					break _loop21;
				}
				
			} while (true);
			}
			term_AST = (AST)currentAST.root;
		}
		catch (RecognitionException ex) {
			reportError(ex);
			consume();
			consumeUntil(_tokenSet_4);
		}
		returnAST = term_AST;
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
		"SEMANTIC_FUNCTION",
		"SYNTACTIC_FUNCTION",
		"PRAGMATIC_FUNCTION",
		"DEF",
		"NUMBER",
		"TENSE",
		"ASPECT",
		"LAYER",
		"RESTRIKTOR",
		"WORD",
		"WORD_CLASS"
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
		long[] data = { 29696L, 0L};
		return data;
	}
	public static final BitSet _tokenSet_1 = new BitSet(mk_tokenSet_1());
	private static final long[] mk_tokenSet_2() {
		long[] data = { 29810L, 0L};
		return data;
	}
	public static final BitSet _tokenSet_2 = new BitSet(mk_tokenSet_2());
	private static final long[] mk_tokenSet_3() {
		long[] data = { 95328L, 0L};
		return data;
	}
	public static final BitSet _tokenSet_3 = new BitSet(mk_tokenSet_3());
	private static final long[] mk_tokenSet_4() {
		long[] data = { 29760L, 0L};
		return data;
	}
	public static final BitSet _tokenSet_4 = new BitSet(mk_tokenSet_4());
	
	}
