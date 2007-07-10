grammar Representational;

/* 
(p1: 
    [ 
        (Past e1: 
            [
                (f1:tek [
                    		(x1:im(x1))Ag
                    		(x2:naif(x2))Inst
                	](f1)
		)
                (f2:kot [
                    		(x1:im(x1))Ag
                    		(x3:mi(x3))Pat
                	](f2)
		)
            ](e1)
        )
    ](p1)
)

more compact way to typeset it
		
(p1:[ 
    (Past e1:[
        (f1:tek[
            (x1:im(x1))Ag
            (x2:naif(x2))Inst
        ](f1))
        (f2:kot[
            (x1:im(x1))Ag
            (x3:mi(x3))Pat
        ](f2))
    ](e1))
](p1))

Samples from the FDG-Article:

(Past ei: 
	[
	(fi : readV (fi))
	(1 xi:boyN(xi))Ag
	(1 xj:bookN(xj))Pat
	]
(ei))

'The boy read the book'

(1 xi: (fi:boyN (fi)PHI )(xi)PHI )

'a boy'

*/
/*
(Past e1 : 
	[ 
	(Past x1:boy(x1): old(x1))Ag 
	] 
(e1))Ag
*/

/*
state_of_affair 	
	:	'(' operator? 'e' index ':' head '(' 'e' index ')' restriction* ')' function? ;
	
property
	:	'(' operator? 'f' index ':' head '(' 'f' index ')' restriction* ')' function? ;
	
individual
	:	'(' operator? 'x' index ':' head '(' 'x' index ')' restriction* ')' function? ;
		
location
	:	'(' operator? 'l' index ':' head '(' 'l' index ')' restriction* ')' function? ;
	
time 	
	: 	'(' operator? 't' index ':' head '(' 't' index ')' restriction* ')' function? ;
	*/
	
	// e.g. (Past x1:boy(x1): young(x1))Ag

//Parser:

propos 	: '(' OPER? 'p' INDEX ':' head '(' 'p' INDEX ')' restr* ')' FUNC? ;

struct	: '(' OPER? VAR INDEX ':' head '(' VAR INDEX ')' restr* ')' FUNC? ;

head	: LEMMA? ( '[' struct* ']' )? ;
	
restr	: ( ':' LEMMA '(' VAR INDEX ')' ) ;

//Lexer:

VAR	: 'e' | 'f' | 'x' | 't' | 'l' ;

FUNC	: 'Ag' | 'Pat' | 'Loc' | 'Inst' ; // etc.

OPER	: 'Past' ; // etc.

LEMMA		: 'a'..'z'+ ;

INDEX		: '0'..'9'+ ;

/*WHITESPACE	: ( ' ' | '\t' | '\n' | '\r' )+ { skip(); } ;*/
