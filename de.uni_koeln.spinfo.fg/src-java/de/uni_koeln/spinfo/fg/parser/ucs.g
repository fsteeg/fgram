// goal: (fehlt nur noch (x1))
// 
// (pres e1:(d1x1:man[N]:(past e2:give[V](d1x2:mary[N])(d1x3:book[N])Go(x1)RecSubj))(d1x4:john[N])0)

header {
	package de.uni_koeln.spinfo.fg.parser;
	import de.uni_koeln.spinfo.fg.ucs.model.*;
}

class UcsParser extends Parser;

options { 
	buildAST = true;
}

input returns [Predicate ret = new Predicate()]: ret = predicate (NEWLINE)? ;

//(d1x1:(d2x2:man[N])Ag)
predicate returns [Predicate ret = new Predicate()]
	{Predicate p = null; Term v = null; Term recVal = null; boolean foundRole = false;}
	:
	LPAREN^ 
	( 
	recVal = term 
	{	
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
	) +
	RPAREN 
	(
	//role given
	role:ROLE { ret = new Predicate(v,role.getText()); foundRole = true; }
	)?
	//no role
	{ if(!foundRole) ret = new Predicate(v,""); }
;

//d1x1:(d2x2:man[N])Ag or d1x1:man[N]
term returns [Term ret = new Term()]
	{Predicate pred = null;Term v = null;}
	: 
	//d1x1:
	( d:DEF | tense:TENSE ) (n:NUMBER)? /*c:INDEX*/ t:LAYER RESTRIKTOR
	
	//man[N]
	(
	w0:WORD /*LBRACK*/ p0:WORD_CLASS /*RBRACK*/ (RESTRIKTOR)?
	//{ ret = new Term(d!=null?d.getText():null,tense!=null?tense.getText():null, n.getText(), t.getText()/*, c.getText()*/,null, w0.getText(), p0.getText()); }
	)? 
	{ ret = new Term(d!=null?d.getText():null,tense!=null?tense.getText():null, n!=null?n.getText():null, t!=null?t.getText():null,/*, c.getText(),*/null, w0!=null?w0.getText():null,p0!=null?p0.getText():null); }
	// a complex values: d1x1:(d2x2:man[N])...
	( pred = predicate { ret.addChild(pred); } ) * 
;
	
class UcsLexer extends Lexer;
	ROLE : SEMANTIC_FUNCTION (SYNTACTIC_FUNCTION)?;
	SEMANTIC_FUNCTION : "Ag" | "Go" | "Rec";
	SYNTACTIC_FUNCTION : "Obj" | "Subj";
	WORD_CLASS : '['('T' | 'N' | 'V' | 'A')']';
	DEF : 'D' | 'I';
	TENSE : "P"("ast" | "res");
	LAYER : 'F' | 'X' | 'E';
	NUMBER : '1' | '2' | 'M';
	//INDEX : 'j' | 'k';
//	BLANK : ' ';
	LPAREN : '('; RPAREN : ')';
	RESTRIKTOR : ':';
//	LBRACK : '['; RBRACK : ']';
	WORD : ('a'..'z')+;
	NEWLINE : '\r' '\n' /* DOS */ | '\n' /* UNIX */ ;
    