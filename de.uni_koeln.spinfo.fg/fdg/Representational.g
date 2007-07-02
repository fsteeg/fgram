grammar Representational;

/* 
(Past p1: 
	[ 
	(Past e1: 
		[
		(Past x1: boy(x1))
		(Past f1: toy(f1))Ag
		](e1))Ag
	(Perf e1:
		[
		(Past x1: boy(x1): young(x1))Ag
		(Past f1: toy(f1))Ag
		](e1))Ag 
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
	:	'(' PI 'p' NUMBER ':' '[' 
				state_of_affair+ 
		']' '(' 'p' NUMBER ')' (':' WORD '(' 'p' NUMBER ')')* ')' PHI?
	;
	
/*
(Past e1 : 
	[ 
	(Past x1:boy(x1): old(x1))Ag 
	] 
(e1))Ag
*/
state_of_affair 	
	:	'(' PI 'e' NUMBER ':' '[' 
			(	property 
			| 	individual 
			|	location 
			| 	time
			)* 
		']' '(' 'e' NUMBER ')' (':' WORD '(' 'e' NUMBER ')')* ')' PHI?
	;
		
// e.g. (Past x1:boy(x1): young(x1))Ag
individual
	:	'(' PI 'x' NUMBER ':' WORD '(' 'x' NUMBER ')' (':' WORD '(' 'x' NUMBER ')')* ')' PHI?;
property
	:	'(' PI 'f' NUMBER ':' WORD '(' 'f' NUMBER ')' (':' WORD '(' 'f' NUMBER ')')* ')' PHI?;
location
	:	'(' PI 'l' NUMBER ':' WORD '(' 'l' NUMBER ')' (':' WORD '(' 'l' NUMBER ')')* ')' PHI?;
time 	
	: 	'(' PI 't' NUMBER ':' WORD '(' 't' NUMBER ')' (':' WORD '(' 't' NUMBER ')')* ')' PHI?;


PHI	:	'Ag'|'Pat'|'Loc' ; // etc.
PI	:	('A'..'Z')('a'..'z')+ ; // like 'Perf', 'Past' etc.
WORD	:	('a'..'z')+ ;
NUMBER	:	('0'..'9')+ ;
WS	:	(' '|'\t'|'\n'|'\r')+ {skip(); } ;
