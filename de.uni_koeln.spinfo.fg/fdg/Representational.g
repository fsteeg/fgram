grammar Representational;

/* 
(p1: 
	[ 
	(Past e1: 
		[
		(x1: im (x1)) Ag
		(x2: naif(x2)) Inst
		](e1))
	(Perf e1:
		[
		(Past x1: boy(x1): young(x1))Ag
		(Past f1: toy(f1))Ag
		](e1))Ag 
	](p1)
)

(p1: 
	[ 
	(Past e1: 
		[
		(f1:tek(
			(x1:im(x1))Ag
			(x2:naif(x2))Inst
		)(f1))
		(f2:kot(
			(x1:im(x1))Ag
			(x3:mi(x3))Pat
		)(f2))
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
	:	'(' operator? 'e' INDEX ':' '[' 
			(	property 
			| 	individual 
			|	location 
			| 	time
			)* 
		']' '(' 'e' INDEX ')' (':' lemma '(' 'e' INDEX ')')* ')' function?
	;
		
// e.g. (Past x1:boy(x1): young(x1))Ag
individual
	:	'(' operator? 'x' INDEX ':' lemma '(' 'x' INDEX ')' (':' lemma '(' 'x' INDEX ')')* ')' function?;

function
	:	FUNCTION
	;

operator
	:	OPERATOR
	;

lemma	:	WORD
	;

property
	:	'(' operator? 'f' INDEX ':' lemma ('('individual*')') '(' 'f' INDEX ')' (':' lemma '(' 'f' INDEX ')')* ')' function?;
location
	:	'(' operator? 'l' INDEX ':' lemma '(' 'l' INDEX ')' (':' lemma '(' 'l' INDEX ')')* ')' function?;
time 	
	: 	'(' operator? 't' INDEX ':' lemma '(' 't' INDEX ')' (':' lemma '(' 't' INDEX ')')* ')' function?;

FUNCTION	:	'Ag'|'Pat'|'Loc'|'Inst' ; // etc.
OPERATOR	:	('A'..'Z')('a'..'z')+ ; // like 'Perf', 'Past' etc.
WORD	:	('a'..'z')+ ;
INDEX	:	('0'..'9')+ ;
WS	:	(' '|'\t'|'\n'|'\r')+ {skip(); } ;
