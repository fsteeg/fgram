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
propositional_content
	:	'(' operator? 'p' INDEX ':' '[' 
				state_of_affair+ 
		']' '(' 'p' INDEX ')' (':' lemma '(' 'p' INDEX ')')* ')' function?
	;
	
/*
(Past e1 : 
	[ 
	(Past x1:boy(x1): old(x1))Ag 
	] 
(e1))Ag
*/
state_of_affair 	
	:	'(' operator? 'e' INDEX ':' head '(' 'e' INDEX ')' (':' lemma '(' 'e' INDEX ')')* ')' function?
	;

head	:	'[' 
			(	property 
			| 	individual 
			|	location 
			| 	time
			)* 
		']'
	;

		
// e.g. (Past x1:boy(x1): young(x1))Ag
individual
	:	'(' operator? 'x' INDEX ':' lemma head? '(' 'x' INDEX ')' (':' lemma '(' 'x' INDEX ')')* ')' function?;	
property
	:	'(' operator? 'f' INDEX ':' lemma head? '(' 'f' INDEX ')' (':' lemma '(' 'f' INDEX ')')* ')' function?;
location
	:	'(' operator? 'l' INDEX ':' lemma head? '(' 'l' INDEX ')' (':' lemma '(' 'l' INDEX ')')* ')' function?;
time 	
	: 	'(' operator? 't' INDEX ':' lemma head? '(' 't' INDEX ')' (':' lemma '(' 't' INDEX ')')* ')' function?;

function
	:	FUNCTION
	;

operator
	:	OPERATOR
	;

lemma	:	WORD
	;



FUNCTION	:	'Ag'|'Pat'|'Loc'|'Inst' ; // etc.
OPERATOR	:	('A'..'Z')('a'..'z')+ ; // like 'Perf', 'Past' etc.
WORD	:	('a'..'z')+ ;
INDEX	:	('0'..'9')+ ;
WS	:	(' '|'\t'|'\n'|'\r')+ {skip(); } ;
