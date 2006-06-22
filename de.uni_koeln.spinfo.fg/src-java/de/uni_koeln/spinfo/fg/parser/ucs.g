// Part of "Functional Grammar Language Generator" (http://fgram.sourceforge.net/) (C) 2006 Fabian Steeg
// This library is free software; you can redistribute it and/or modify it under the terms of the GNU Lesser General Public License as published by the Free Software Foundation; either version 2.1 of the License, or (at your option) any later version.
// This library is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more details.
// You should have received a copy of the GNU Lesser General Public License along with this library; if not, write to the Free Software Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA

// see the folder "ucs" for sample input

header {
	package de.uni_koeln.spinfo.fg.parser;
	import de.uni_koeln.spinfo.fg.ucs.model.*;
}

class UcsParser extends Parser;

options { 
	buildAST = true;
}

input returns [Predicate ret = new Predicate()]: ret = predicate (NEWLINE)? ;

//(D1X:(DMX:man[N])AgSubj)
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
			Predicate pred = new Predicate(recVal,"", "");
			v.getChildren().add(pred);
		}
	}
	) +
	RPAREN 
	(
	// role given
	role:SEMANTIC_FUNCTION (relation:SYNTACTIC_FUNCTION)? (prag:PRAGMATIC_FUNCTION)? //TODO implement prag func.
	{ ret = new Predicate(v,role.getText(), relation!=null?relation.getText():null); foundRole = true; }
	)?
	// no role
	{ if(!foundRole) ret = new Predicate(v,"", ""); }
;

// D1X:(DMX:man[N])Ag or D1X:man[N]
term returns [Term ret = new Term()]
	{Predicate pred = null;Term v = null;}
	: 
	// D1X:
	( d:DEF | tense:TENSE)? (n:NUMBER)? /*c:INDEX*/ t:LAYER RESTRIKTOR
	( // man[N]
	w0:WORD p0:WORD_CLASS (RESTRIKTOR)?
	)? 
	//TODO multiple modifs
	( // old[A]
	w1:WORD p1:WORD_CLASS (RESTRIKTOR)?
	)? 
	{ ret = new Term(d!=null?d.getText():null,tense!=null?tense.getText():null, n!=null?n.getText():null, t!=null?t.getText():null,/*, c.getText()*/ w0!=null?w0.getText():null,p0!=null?p0.getText():null,w1!=null?w1.getText():null,p1!=null?p1.getText():null); }
	// a complex term: D1X:(MDX:man[N])...
	( pred = predicate { ret.getChildren().add(pred); } ) * 
;
	
class UcsLexer extends Lexer;
	SEMANTIC_FUNCTION 
		: "Ag" 		// agent
		| "Go" 		// goal
		| "Re"("c" 	// recipient
		| "f") 		// reference
		| "Ben" 	// beneficiary
		| "C"("irc"	// circumstance 
		| "omp") 	// company
		| "Dir" 	// direction
		| "Exp" 	// experiencer
		| "Fo" 		// force
		| "Loc" 	// location
		| "Man" 	// manner
		| "P"(("o"	// positioner
		( "ss")?)	// possessor
		| "roc")  	// processed
		//| "So" 		// source
		| "Temp" 	// time
		| "Instr" 	// instrument
		| "0" 		// zero
		;
	SYNTACTIC_FUNCTION 
		: "Obj" 	// object
		| "Subj" 	// subject
		;
	// states...
	PRAGMATIC_FUNCTION 
		//: "Foc" 	// focus
		//: "GivTop"// given topic
		: "NewTop" 	// new topic
		//| "Or" 	// orientation
		//| "ResTop"// resumed topic
		//| "SubTop"// sub-topic
		//| "Top" 	// topic
		;
	WORD_CLASS : '['
		( 'T' 		// any word class 
		| 'A' 		// adjective
		| 'V' 		// verb 
		| 'N' 		// noun
		)']';
	DEF 
		: 'd' 		// definite
		| 'i' 		// indefinite
		;
	//should actually be uppercase, but taken by sem roles... need states or such for that
	TENSE
		: "p"
		( "ast" 	// past
		| "res"  	// present
		| "erf") 	// perfect
		( "prog")?  // progressive TODO...
		;

	LAYER 
		: 'f' 		// predicate
		| 'x' 		// term
		| 'e' 		// predication
		| 'E' 		// clause
		| 'X' 		// proposition
		;
	NUMBER 
		: '1' 		// sing
		| '2' 		// dual
		| 'm' 		// plural 'many'
		;
	LPAREN : '('; 
	RPAREN : ')';
	RESTRIKTOR : ':';
	WORD : '/' ('a'..'z' | 'A'..'Z')+ '/';
	NEWLINE : '\r' '\n' /* DOS */ | '\n' /* UNIX */;
    