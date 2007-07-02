grammar Representational;

/* 
(Past p1: 
	[ 
	(Past e1: 
		[
		(Past x1:boy(x1))Ag
		(Past f1:toy(f1))Ag
		] 
	(e1): (e1))Ag
	(Perf e1: 
		[
		(Past x1:boy(x1))Ag
		(Past f1:toy(f1))Ag
		] 
	(e1): (e1))Ag 
	] 
(p1): (p1))Ag

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
		']' '(' 'p' NUMBER ')' ':' SIGMA* '(' 'p' NUMBER ')' ')' PHI
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
		']' '(' 'e' NUMBER ')' ':' SIGMA* '(' 'e' NUMBER ')' ')' PHI
	;

// (Past f1:girl(f1): (f1))Ag		
property:	'(' PI 'f' NUMBER ':' LEMMA '(' 'f' NUMBER ')' (':' SIGMA '(' 'f' NUMBER ')')* ')' PHI;

// (Past x1:boy(x1): (x1))Ag
individual
	:	'(' PI 'x' NUMBER ':' LEMMA '(' 'x' NUMBER ')' (':' SIGMA '(' 'x' NUMBER ')')* ')' PHI;
	
location:	'(' PI 'l' NUMBER ':' LEMMA '(' 'l' NUMBER ')' (':' SIGMA '(' 'l' NUMBER ')')* ')' PHI;

time 	: 	'(' PI 't' NUMBER ':' LEMMA '(' 't' NUMBER ')' (':' SIGMA '(' 't' NUMBER ')')* ')' PHI;


PHI	:	'Ag'|'Pat'|'Loc' ; // This could specify which roles can be used, like 'Ag' or 'Exp'
PI	:	MOD ; // This could be further specified, for things like '1' or 'Past'
SIGMA	:	MOD ; // This could further specify modifiers

MOD	:	('A'..'Z')('a'..'z')+ ; // like 'Perf', 'Past'...
LEMMA	:	('a'..'z')+ ;
NUMBER	:	('0'..'9')+ ;
WS	:	(' '|'\t'|'\n'|'\r')+ {skip(); } ;
