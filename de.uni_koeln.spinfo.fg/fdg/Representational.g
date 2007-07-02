grammar Representational;

/* 
(Past p1: 
	[ 
	(Past e1: 
		[
		(Past x1:boy(x1))
		(Past f1:toy(f1))Ag
		](e1))Ag
	(Perf e1:
		[
		(Past x1:boy(x1): young(x1))Ag
		(Past f1:toy(f1))Ag
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
		']' '(' 'p' NUMBER ')' (':' LEMMA '(' 'p' NUMBER ')')* ')' PHI?
	;
	
/*
(Past e1 : 
	[ 
	(Past x1:boy(x1):(x1))Ag 
	] 
(e1): (e1))Ag
*/
state_of_affair 	
	:	'(' PI 'e' NUMBER ':' '[' 
			(	property 
			| 	individual 
			|	location 
			| 	time
			)* 
		']' '(' 'e' NUMBER ')' (':' LEMMA '(' 'e' NUMBER ')')* ')' PHI?
	;
		
property:	'(' PI 'f' NUMBER ':' LEMMA '(' 'f' NUMBER ')' (':' LEMMA '(' 'f' NUMBER ')')* ')' PHI?;

// (Past x1:boy(x1):young(x1))Ag
individual
	:	'(' PI 'x' NUMBER ':' LEMMA '(' 'x' NUMBER ')' (':' LEMMA '(' 'x' NUMBER ')')* ')' PHI?;
	
location:	'(' PI 'l' NUMBER ':' LEMMA '(' 'l' NUMBER ')' (':' LEMMA '(' 'l' NUMBER ')')* ')' PHI?;

time 	: 	'(' PI 't' NUMBER ':' LEMMA '(' 't' NUMBER ')' (':' LEMMA '(' 't' NUMBER ')')* ')' PHI?;


PHI	:	'Ag'|'Pat'|'Loc' ; // This could specify which roles can be used, like 'Ag' or 'Exp'
PI	:	MOD ; // This could be further specified, for things like '1' or 'Past'

MOD	:	('A'..'Z')('a'..'z')+ ; // like 'Perf', 'Past'...
LEMMA	:	('a'..'z')+ ;
NUMBER	:	('0'..'9')+ ;
WS	:	(' '|'\t'|'\n'|'\r')+ {skip(); } ;
