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
	:	'(' OPERATOR 'p' INDEX ':' '[' 
				state_of_affair+ 
		']' '(' 'p' INDEX ')' (':' WORD '(' 'p' INDEX ')')* ')' FUNCTION?
	;
	
/*
(Past e1 : 
	[ 
	(Past x1:boy(x1): old(x1))Ag 
	] 
(e1))Ag
*/
state_of_affair 	
	:	'(' OPERATOR 'e' INDEX ':' '[' 
			(	property 
			| 	individual 
			|	location 
			| 	time
			)* 
		']' '(' 'e' INDEX ')' (':' WORD '(' 'e' INDEX ')')* ')' FUNCTION?
	;
		
// e.g. (Past x1:boy(x1): young(x1))Ag
individual
	:	'(' OPERATOR 'x' INDEX ':' WORD '(' 'x' INDEX ')' (':' WORD '(' 'x' INDEX ')')* ')' FUNCTION?;
property
	:	'(' OPERATOR 'f' INDEX ':' WORD '(' 'f' INDEX ')' (':' WORD '(' 'f' INDEX ')')* ')' FUNCTION?;
location
	:	'(' OPERATOR 'l' INDEX ':' WORD '(' 'l' INDEX ')' (':' WORD '(' 'l' INDEX ')')* ')' FUNCTION?;
time 	
	: 	'(' OPERATOR 't' INDEX ':' WORD '(' 't' INDEX ')' (':' WORD '(' 't' INDEX ')')* ')' FUNCTION?;


FUNCTION	:	'Ag'|'Pat'|'Loc' ; // etc.
OPERATOR	:	('A'..'Z')('a'..'z')+ ; // like 'Perf', 'Past' etc.
WORD	:	('a'..'z')+ ;
INDEX	:	('0'..'9')+ ;
WS	:	(' '|'\t'|'\n'|'\r')+ {skip(); } ;
