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
move	:	'(' 'M' INDEX ':' '['
				act+
		']' '(' 'M' INDEX ')' ( ':' WORD '(' 'M' INDEX ')' )* ')' ;
			
act	:	'(' 'A' INDEX ':' '['
			(	speech_occurence
			|	speaker
			|	addressee
			|	communicated_content
			)*
		']' '(' 'A' INDEX ')' ( ':' WORD '(' 'A' INDEX ')' )* ')' ;
		
		
speech_occurence
	:	'(' 'F' INDEX ':' ILL '(' 'F' INDEX ')' ( ':' WORD '(' 'F' INDEX ')' )* ')' ;
		 
speaker	
	:	'(' 'P' INDEX ':' WORD '(' 'P' INDEX ')' ( ':' WORD '(' 'P' INDEX ')' )* ')' ;
	
addressee
	:	'(' 'P' INDEX ':' WORD '(' 'P' INDEX ')' ( ':' WORD '(' 'P' INDEX ')' )* ')' ;
	
ascription
	:	'(' 'T' INDEX '[' WORD ']' '(' 'T' INDEX ')'( ':' WORD '(' 'T' INDEX ')' )* ')' ;
	
reference
	:	'(' 'R' INDEX '[' WORD ']' '(' 'R' INDEX ')'( ':' WORD '(' 'R' INDEX ')' )* ')' ;
	
communicated_content
	:	'(' 'C' INDEX ':' '['
			( ascription
			| reference
			)*
		']' '(' 'C' INDEX ')' ( ':' WORD '(' 'C' INDEX ')' )* ')' ;
		

	
ILL	:	'DECL' | 'INTER' | 'IMPER' | 'PROH' | 'OPTAT' | 'HORT' | 'IMPR' | 'ADMO' | 'CAUT' | 'COMM';
WORD	:	('a'..'z')+ ;
INDEX	:	('0'..'9')+ ;
