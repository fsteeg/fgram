package de.uni_koeln.spinfo.fg.parser;


import java.io.File;
import java.io.StringReader;

import junit.framework.TestCase;
import antlr.RecognitionException;
import antlr.TokenStreamException;
import antlr.collections.AST;
import de.uni_koeln.spinfo.fg.parser.UcsLexer;
import de.uni_koeln.spinfo.fg.parser.UcsParser;
import de.uni_koeln.spinfo.fg.ucs.PrologGenerator;
import de.uni_koeln.spinfo.fg.ucs.model.Predicate;
import de.uni_koeln.spinfo.fg.util.Util;

public class UcsParserTest extends TestCase {

    public void testParser() {
        String s = Util.getText(new File("ucs/ucs.txt"));
        assertTrue("Error while reading UCS from file", s != null);
        s = s.replaceAll("[^a-zA-Z0-9\\[\\]\\(\\):-]", "");
        UcsLexer lexer = new UcsLexer(new StringReader(s));
        assertTrue("Error while instantiating Lexer", lexer != null);
        UcsParser parser = new UcsParser(lexer);
        assertTrue("Error while instantiating parser", parser != null);
        Predicate p;
        try {
            p = parser.input();
            System.out.println(p.toString());
            assertTrue("Error while parsing", p != null);
            AST t = parser.getAST();
            System.out.println("AST: " + t.toStringTree());
            PrologGenerator gen = new PrologGenerator(p);
            assertTrue("Error while instantiating PrologGenerator", gen != null);
            String generateProlog = gen.generateProlog();
            assertTrue("Error while generating Prolog", generateProlog != null);
            System.out.println(generateProlog);
        } catch (RecognitionException e) {
            e.printStackTrace();
        } catch (TokenStreamException e) {
            e.printStackTrace();
        }

    }
}
