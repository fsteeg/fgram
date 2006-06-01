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
	{Predicate p = null; Values v = null; Values recVal = null; boolean foundRole = false;}
	:
	LPAREN^ 
	( 
	recVal = values 
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
	role:LETTER { ret = new Predicate(v,role.getText()); foundRole = true; }
	)?
	//no role
	{ if(!foundRole) ret = new Predicate(v,""); }
;

//d1x1:(d2x2:man[N])Ag or d1x1:man[N]
values returns [Values ret = new Values()]
	{Predicate pred = null;Values v = null;}
	: 
	//d1x1:
	d:DEF n:NUMBER t:LETTER c:NUMBER RESTRIKTOR 
	{ ret = new Values(d.getText(), n.getText(), t.getText(), c.getText(), null,null); }
	//man[N]
	(
	w0:LETTER LBRACK p0:LETTER RBRACK (RESTRIKTOR)?
	{ ret = new Values(d.getText(), n.getText(), t.getText(), c.getText(), w0.getText(), p0.getText()); }
	)? 
	// a complex values: d1x1:(d2x2:man[N])...
	( pred = predicate { ret.addChild(pred); } ) * 
;
	
class UcsLexer extends Lexer;

	DEF : 'd' | 'i';
	//ROLE : "Ag" | "Pat" | "RecSubj";
	LETTER : ('a'..'z' | 'A'..'Z')+;
	NUMBER : '0'..'9';
	BLANK : ' ';
	LPAREN : '('; RPAREN : ')';
	RESTRIKTOR : ':';
	LBRACK : '['; RBRACK : ']';
	NEWLINE
    :   '\r' '\n'   // DOS
    |   '\n'        // UNIX
    ;
    