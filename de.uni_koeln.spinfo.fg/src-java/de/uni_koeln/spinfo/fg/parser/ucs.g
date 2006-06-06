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
	role:SEMANTIC_FUNCTION (relation:SYNTACTIC_FUNCTION)? 
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
	( d:DEF | tense:TENSE )? (n:NUMBER)? /*c:INDEX*/ t:LAYER RESTRIKTOR
	( // man[N]
	w0:WORD p0:WORD_CLASS (RESTRIKTOR)?
	)? 
	{ ret = new Term(d!=null?d.getText():null,tense!=null?tense.getText():null, n!=null?n.getText():null, t!=null?t.getText():null,/*, c.getText()*/ w0!=null?w0.getText():null,p0!=null?p0.getText():null); }
	// a complex term: D1X:(MDX:man[N])...
	( pred = predicate { ret.getChildren().add(pred); } ) * 
;
	
class UcsLexer extends Lexer;
	SEMANTIC_FUNCTION : "Ag" | "Go" | "Rec";
	SYNTACTIC_FUNCTION : "Obj" | "Subj";
	WORD_CLASS : '['('T' | 'N' | 'V' | 'A')']';
	DEF : 'D' | 'I';
	TENSE : "P"("ast" | "res" | "erf");
	LAYER : 'F' | 'X' | 'E';
	NUMBER : '1' | '2' | 'M';
	LPAREN : '('; RPAREN : ')';
	RESTRIKTOR : ':';
	WORD : ('a'..'z')+;
	NEWLINE : '\r' '\n' /* DOS */ | '\n' /* UNIX */;
    