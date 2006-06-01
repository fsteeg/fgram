header {
	package de.uni_koeln.spinfo.fg.parser;
	import de.uni_koeln.spinfo.fg.ucs.model.*;
	import antlr.*;
}

class FormParser extends Parser;

options { 
	buildAST = true;
}

class WordLexer extends Lexer;
	LETTER : ('a'..'z' | 'A'..'Z')+;
	BLANK : ' ';
	NEWLINE
    :   '\r' '\n'   // DOS
    |   '\n'        // UNIX
    ;