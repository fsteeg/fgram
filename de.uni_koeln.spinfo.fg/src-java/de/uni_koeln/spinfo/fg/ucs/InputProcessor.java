// Part of "Functional Grammar Language Generator" (http://fgram.sourceforge.net/) (C) 2006 Fabian Steeg
// This library is free software; you can redistribute it and/or modify it under the terms of the GNU Lesser General Public License as published by the Free Software Foundation; either version 2.1 of the License, or (at your option) any later version.
// This library is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more details.
// You should have received a copy of the GNU Lesser General Public License along with this library; if not, write to the Free Software Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA

package de.uni_koeln.spinfo.fg.ucs;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.StringReader;

import antlr.RecognitionException;
import antlr.TokenStreamException;

import com.declarativa.interprolog.SWISubprocessEngine;
import com.declarativa.interprolog.TermModel;

import de.uni_koeln.spinfo.fg.parser.UcsLexer;
import de.uni_koeln.spinfo.fg.parser.UcsParser;
import de.uni_koeln.spinfo.fg.ucs.model.Predicate;
import de.uni_koeln.spinfo.fg.util.Config;
import de.uni_koeln.spinfo.fg.util.Log;

/**
 * Controls the program flow: Input of an UCS, output of the generated
 * expression
 * 
 * @author Fabian Steeg
 * 
 */
public class InputProcessor {

    private SWISubprocessEngine engine;

    /**
     * @param swi
     *            The locations of the "swipl" application
     */
    public InputProcessor(String swi) {
        super();
        // System.out.println("SWI: " + swi);
        this.engine = new SWISubprocessEngine(swi);
    }

    /**
     * The actual processing of the input:
     * 
     * <li> parses the ucs using the antlr-parser </li>
     * <li> creates an internal object-representation of the ucs </li>
     * <li> generates and writes to disk a prolog-representation of the ucs
     * </li>
     * <li> calls an existing, non-generated prolog goal (which calls the
     * generated code) </li>
     * <li> returns the result of that prolog goal </li>
     * 
     * @param inputUCS
     *            The ucs of the expression to generate
     * @param verbose
     *            If true, genrated prolog will be retuned with the result
     * @return Will return the actual linguistic expression mapped to the
     *         input-ucs
     * @throws TokenStreamException
     * @throws RecognitionException
     */
    public String process(String inputUCS, boolean verbose)
            throws RecognitionException, TokenStreamException {
        Log.logger.info("Parsing Predicate: " + inputUCS);
        // String s = Util.getText(new File("ucs.txt"));
//        String s = ;
        
        //remove all weird special chars from the input ucs
        String s = inputUCS.replaceAll("[^a-zA-Z0-9\\[\\]\\(\\):-]", "");
        // use antlr-generated lexer and parser to parse the input ucs
        UcsLexer lexer = new UcsLexer(new StringReader(s));
        UcsParser parser = new UcsParser(lexer);
        Predicate p = parser.input();
        
//        System.out.println(p.toString());

        String result = "";
        // Parser parser = new Parser(inputUCS);
        // String result = parser.process();
        String prologResult = null;
        if (p == null) {
            Log.logger.info("Parsing of Predicate '" + inputUCS + "' failed! ");
            // + result);
            return result;
        } else {
            try {
                Log.logger.info("Generating Prolog Code...");

               result = new PrologGenerator(p).generateProlog();
                
//                System.out.println(gen.generateProlog());

                // PrologGenerator gen = new PrologGenerator(parser.getUCS());
//                result = gen.generateProlog();
//                String prologSourcePath = "src-prolog";
//                String placeToSave = prologSourcePath + File.separator
//                        + "generated_ucs.pl";
//                Log.logger.info("Saving generated Prolog Code to: "
//                        + placeToSave);
//                gen.saveProlog(placeToSave);
                // consult the calling prolog code:
                prologResult = callProlog(prologResult);

            } catch (Throwable t) {
                t.printStackTrace();
                if (verbose)
                    return "An error occured during calling Prolog (see console), Predicate.toString is:\n\n"
                            + p.toString()
                            + ", \n\ngenerated Prolog Code is:\n\n"
                            + result
                            + "";
                else
                    return "Something went wrong (select verbose for details).";
            }

            if (verbose) {
                return result + "\nReturned from Prolog call: " + prologResult;
            } else
                return prologResult.replaceAll("[\\[\\],]", " ").trim();
        }
    }

    private String callProlog(String prologResult) throws FileNotFoundException {
        File fileToConsult = new File(Config.getString("prolog_sources") + File.separator
                + "fg-controller.pl");
        if (fileToConsult.exists())
            Log.logger.info("Will consult: "
                    + fileToConsult.getAbsolutePath());
        else
            throw new FileNotFoundException(
                    "File to consult does not exist: "
                            + fileToConsult.getAbsolutePath());
        engine.consultAbsolute(fileToConsult);
        // test: call with a return value of true or false only
        boolean sucess = engine.deterministicGoal("expression(M)");
        Log.logger.info("Result of calling Prolog: " + sucess);
        // prolog call without params, with return value
        Object[] bindings = engine.deterministicGoal(
                "expression(PrologResult), name(Result,PrologResult)",
                "[string(Result)]");
        System.out.println("Bindings is: " + bindings);
        Log.logger.info("Result of calling Prolog: " + bindings[0]);
        if (bindings[0] instanceof String)
            prologResult = (String) bindings[0];
        // get all the values asserted as expression_results:
        String goal = "nonDeterministicGoal(X,expression_result(X),ListModel)";
        // Notice that 'ListModel' is referred in both deterministicGoal
        // arguments:
        TermModel solutionVars = (TermModel) (engine.deterministicGoal(
                goal, "[ListModel]")[0]);
        if (solutionVars.isList()) {
            Log.logger.info("Is list!");
            prologResult = "" + solutionVars;
        }
        Log.logger.info("Solution bindings list:" + solutionVars);
        return prologResult;
    }

    public void close() {
        engine.shutdown();
    }
}
