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
it is possible to do it shorter, but for readability reasons we choose the longer version

propositional_content 	: '(' OPER? 'p' INDEX ':' head '(' 'p' INDEX ')' restr* ')' FUNC? ;
struct	: '(' OPER? VAR INDEX ':' head '(' VAR INDEX ')' restr* ')' FUNC? ;
head	: LEMMA? ( '[' struct* ']' )? ;

// e.g. (Past x1:boy(x1): young(x1))Ag

*/

// underlying structures on the different layers have a common structure:
content    : '(' OPERATOR? 'p' X ( ':' head '(' 'p' X ')' )* ')' FUNCTION? ;
soa 	   : '(' OPERATOR? 'e' X ( ':' head '(' 'e' X ')' )* ')' FUNCTION? ;	
property   : '(' OPERATOR? 'f' X ( ':' head '(' 'f' X ')' )* ')' FUNCTION? ;	
individual : '(' OPERATOR? 'x' X ( ':' head '(' 'x' X ')' )* ')' FUNCTION? ;		
location   : '(' OPERATOR? 'l' X ( ':' head '(' 'l' X ')' )* ')' FUNCTION? ;	
time 	   : '(' OPERATOR? 't' X ( ':' head '(' 't' X ')' )* ')' FUNCTION? ;

// underlying structures can have nested complex heads:
head	   : LEMMA? ( '[' 
	   ( soa 
	   | property 
	   | individual 
	   | location 
	   | time )* ']' ) ? ;

//Lexer:
VAR	: 'e' | 'f' | 'x' | 't' | 'l' ;
FUNCTION	: 'Ag' | 'Pat' | 'Loc' | 'Inst' ;
OPERATOR	: 'Past' ; 
LEMMA	: 'a'..'z'+ ;
X	: '0'..'9'+ ;
WHITE	: ( ' ' | '\t' | '\n' | '\r' )+ { skip(); } ;
