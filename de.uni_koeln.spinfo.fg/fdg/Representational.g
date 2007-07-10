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
content : '(' OPER? 'p' INDEX ':' head '(' 'p' INDEX ')' restr* ')' FUNC? ;
soa 	: '(' OPER? 'e' INDEX ':' head '(' 'e' INDEX ')' restr* ')' FUNC? ;	
prop	: '(' OPER? 'f' INDEX ':' head '(' 'f' INDEX ')' restr* ')' FUNC? ;	
indiv	: '(' OPER? 'x' INDEX ':' head '(' 'x' INDEX ')' restr* ')' FUNC? ;		
loc	: '(' OPER? 'l' INDEX ':' head '(' 'l' INDEX ')' restr* ')' FUNC? ;	
time 	: '(' OPER? 't' INDEX ':' head '(' 't' INDEX ')' restr* ')' FUNC? ;

// ...can be nested in complex heads:
head	: LEMMA? ( '[' ( soa | prop | indiv | loc | time )* ']' ) ? ;

// ...and be further resticted:
restr	: ':' head '(' VAR INDEX ')' ;

//Lexer:
VAR	: 'e' | 'f' | 'x' | 't' | 'l' ;
FUNC	: 'Ag' | 'Pat' | 'Loc' | 'Inst' ;
OPER	: 'Past' ; 
LEMMA	: 'a'..'z'+ ;
INDEX	: '0'..'9'+ ;
WHITE	: ( ' ' | '\t' | '\n' | '\r' )+ { skip(); } ;
