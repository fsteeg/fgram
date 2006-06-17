// Part of "Functional Grammar Language Generator" (http://fgram.sourceforge.net/) (C) 2006 Fabian Steeg
// This library is free software; you can redistribute it and/or modify it under the terms of the GNU Lesser General Public License as published by the Free Software Foundation; either version 2.1 of the License, or (at your option) any later version.
// This library is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more details.
// You should have received a copy of the GNU Lesser General Public License along with this library; if not, write to the Free Software Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA

package de.uni_koeln.spinfo.fg.ucs;

import java.io.File;
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
     */
    public String process(String inputUCS, boolean verbose) {
        Log.logger.debug("UCS: " + inputUCS);
        String s = preprocess(inputUCS);
        Log.logger.debug("Parsing UCS...");
        Predicate p = parse(s);
        Log.logger.debug("Generating Prolog Code...");
        String generatedProlog = new PrologGenerator(p).generateProlog();
        Log.logger.debug("Calling Prolog...");
        return callProlog(generatedProlog, p, verbose);

    }

    /**
     * Closes and cleans up (closing the Prolog engine...)
     */
    public void close() {
        engine.shutdown();
    }

    /***************************************************************************
     * *************************************************************************
     **************************************************************************/

    private Predicate parse(String s) {
        // use antlr-generated lexer and parser to parse the input ucs
        UcsLexer lexer = new UcsLexer(new StringReader(s));
        UcsParser parser = new UcsParser(lexer);
        Predicate p = null;
        String errorMessage = "Parsing of Predicate '" + s + "' failed! ";
        try {
            p = parser.input();
        } catch (RecognitionException e) {
            Log.logger.debug(errorMessage);
            e.printStackTrace();
        } catch (TokenStreamException e) {
            Log.logger.debug(errorMessage);
            e.printStackTrace();
        }
        return p;
    }

    private String preprocess(String inputUCS) {
        // remove all weird special chars from the input ucs
        String s = inputUCS.replaceAll("[^a-zA-Z0-9\\[\\]\\(\\):-]", "");
        return s;
    }

    private String callProlog(String generatedProlog, Predicate p,
            boolean verbose) {
        // call prolog using interprolog
        String prologResult = null;
        File fileToConsult = loadFile();
        try {
            engine.consultAbsolute(fileToConsult);
//            engine.setDebug(true);
            Object[] bindings = engine.deterministicGoal(
                    "expression(PrologResult), name(Result,PrologResult)",
                    "[string(Result)]");
            if(bindings==null){
                return "No result from calling Prolog. This should mean Prolog answered \"No.\"";
            }
//            engine.setDebug(false);
            Log.logger.debug("Result of calling Prolog: " + bindings[0]);
            if (bindings[0] instanceof String)
                prologResult = (String) bindings[0];
            else
                throw new IllegalArgumentException(
                        "Result from Prolog is no String!");
            // get all the values asserted as expression_results
            String goal = "nonDeterministicGoal(X,expression_result(X),ListModel)";
            TermModel solutionVars = (TermModel) (engine.deterministicGoal(
                    goal, "[ListModel]")[0]);
            if (solutionVars.isList()) {
                Log.logger.debug("Is list!");
                prologResult = "" + solutionVars;
            } else
                throw new IllegalArgumentException(
                        "Result from Prolog is no List!");
            Log.logger.debug("Solution bindings list:" + solutionVars);
            if (verbose) {
                return generatedProlog + "\nReturned from Prolog call: "
                        + prologResult;
            } else
                return prologResult.replaceAll("[\\[\\],]", " ").trim();
        } catch (Exception t) {
            t.printStackTrace();
            if (verbose)
                return "An error occured during calling Prolog (see console), Predicate.toString is:\n\n"
                        + p.toString()
                        + ", \n\ngenerated Prolog Code is:\n\n"
                        + generatedProlog + "";
            else
                return "Something went wrong (select verbose for details).";
        }

    }

    private File loadFile() {
        File fileToConsult = new File(Config.getString("prolog_sources")
                + File.separator + Config.getString("prolog_controller"));
        if (fileToConsult.exists()) {
            Log.logger
                    .debug("Will consult: " + fileToConsult.getAbsolutePath());
            return fileToConsult;
        } else {
            Log.logger.debug("File does not exist: "
                    + fileToConsult.getAbsolutePath());
            return null;
        }

    }
}
