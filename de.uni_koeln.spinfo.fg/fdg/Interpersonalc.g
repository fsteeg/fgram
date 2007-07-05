grammar Interpersonalc;

move	:	'(' 'M' NUMBER ':' '['
				(
				'(' 'A' NUMBER ':' '['
				(	'(' 'F' NUMBER ':' ILL '(' 'F' NUMBER ')' ( ':' WORD '(' 'F' NUMBER ')' )* ')'
				|	'(' 'P' NUMBER ':' WORD '(' 'P' NUMBER ')' ( ':' WORD '(' 'P' NUMBER ')' )* ')'
				|	'(' 'P' NUMBER ':' WORD '(' 'P' NUMBER ')' ( ':' WORD '(' 'P' NUMBER ')' )* ')'
				|	'(' 'C' NUMBER ':' '['
						( '(' 'T' NUMBER '[' WORD ']' '(' 'T' NUMBER')'( ':' WORD '(' 'T' NUMBER ')' )* ')'
						| '(' 'R' NUMBER '[' WORD ']' '(' 'R' NUMBER')'( ':' WORD '(' 'R' NUMBER ')' )* ')'
						)*
						']' '(' 'C' NUMBER ')' ( ':' WORD '(' 'C' NUMBER ')' )* ')'
				)*
				']' '(' 'A' NUMBER ')' ( ':' WORD '(' 'A' NUMBER ')' )* ')'
				)+
		']' '(' 'M' NUMBER ')' ( ':'WORD'(''M'NUMBER')' )* ')'
		;
		

ILL	:	'DECL' | 'INTER' | 'IMPER' | 'PROH' | 'OPTAT' | 'HORT' | 'IMPR' | 'ADMO' | 'CAUT' | 'COMM';
WORD	:	('a'..'z')+ ;
NUMBER	:	('0'..'9')+ ;
