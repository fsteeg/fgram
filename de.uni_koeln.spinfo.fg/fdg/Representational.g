grammar Representational;

// ( Past p1 : [ (Past e1 : [ (Past x1:boy(x1):(x1))Ag ] (e1) : (e1) )Ag ] (p1) : (p1))Ag
propositional_content
	:	'(' PI 'p' NUMBER ':' '[' state_of_affair+ ']' '(' 'p' NUMBER ')' ':' SIGMA* '(' 'p' NUMBER ')' ')' PHI
	;
	
// (Past e1 : [ (Past x1:boy(x1):(x1))Ag ] (e1) : (e1) )Ag
state_of_affair 	
	:	'(' PI 'e' NUMBER ':' '[' property* individual* location* time* ']' '(' 'e' NUMBER ')' ':' SIGMA* '(' 'e' NUMBER ')' ')' PHI
	;

// (Past f1:girl(f1):(f1))Ag		
property:	'(' PI 'f' NUMBER ':' LEMMA '(' 'f' NUMBER ')' ':' SIGMA* '(' 'f' NUMBER ')' ')' PHI;

// (Past x1:boy(x1):(x1))Ag
individual
	:	'(' PI 'x' NUMBER ':' LEMMA '(' 'x' NUMBER ')' ':' SIGMA* '(' 'x' NUMBER ')' ')' PHI;
	
location:	'(' PI 'l' NUMBER ':' LEMMA '(' 'l' NUMBER ')' ':' SIGMA* '(' 'l' NUMBER ')' ')' PHI;

time 	: 	'(' PI 't' NUMBER ':' LEMMA '(' 't' NUMBER ')' ':' SIGMA* '(' 't' NUMBER ')' ')' PHI;


PHI	:	'Ag' ; // This could specify which roles can be used, like 'Ag' or 'Exp'
PI	:	'Past' ; // This could be further specified, for things like '1' or 'Past'
SIGMA	:	'Perf' ; // This could further specify modifiers

LEMMA	:	('a'..'z')+ ;
NUMBER	:	('0'..'9') ;
WS	:	(' '|'\t'|'\n'|'\r')+ {skip(); } ;
