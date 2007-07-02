grammar Interpersonal;

/*

(M1:[
	(A1:[(F1:DECL(F1)) ] (A1) )
] (M1))

or

(M1:[
	(A1:[(F1:DECL(F1)) ] (A1) )
	(A1:[
		(C1:[
			(T1[boy](T1))
			(R1[toy](R1))
		] (C1))
	] (A1) )
] (M1))

*/
move	:	'(' 'M' NUMBER ':' '['
				act+
		']' '(' 'M' NUMBER ')' ( ':'WORD'(''M'NUMBER')' )* ')'
		;
		
act	:	'(' 'A' NUMBER ':' '['
			(	speech_occurence
			|	speaker
			|	addressee
			|	communicated_content
			)*
		']' '(' 'A' NUMBER ')' ( ':' WORD '(' 'A' NUMBER ')' )* ')'
		;

speech_occurence
	:	'(' 'F' NUMBER ':' ILL '(' 'F' NUMBER ')' ( ':' WORD '(' 'F' NUMBER ')' )* ')' ;	 
speaker	
	:	'(' 'P' NUMBER ':' WORD '(' 'P' NUMBER ')' ( ':' WORD '(' 'P' NUMBER ')' )* ')' ;
addressee
	:	'(' 'P' NUMBER ':' WORD '(' 'P' NUMBER ')' ( ':' WORD '(' 'P' NUMBER ')' )* ')' ;
communicated_content
	:	'(' 'C' NUMBER ':' '['
			( ascription
			| reference
			)*
		']' '(' 'C' NUMBER ')' ( ':' WORD '(' 'C' NUMBER ')' )* ')'
		;

ascription
	:	'(' 'T' NUMBER '[' WORD ']' '(' 'T' NUMBER')'( ':' WORD '(' 'T' NUMBER ')' )* ')' ;
reference
	:	'(' 'R' NUMBER '[' WORD ']' '(' 'R' NUMBER')'( ':' WORD '(' 'R' NUMBER ')' )* ')' ;
	

ILL	:	'DECL' | 'INTER' | 'IMPER' | 'PROH' | 'OPTAT' | 'HORT' | 'IMPR' | 'ADMO' | 'CAUT' | 'COMM';
WORD	:	('a'..'z')+ ;
NUMBER	:	('0'..'9')+ ;
