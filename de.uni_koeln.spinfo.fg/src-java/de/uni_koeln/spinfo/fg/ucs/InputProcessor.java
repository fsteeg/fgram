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
import de.uni_koeln.spinfo.fg.util.Log;

/**
 * Controls the program flow
 * 
 * @author Fabian Steeg
 * 
 */
public class InputProcessor {

    private SWISubprocessEngine engine;

    /**
     * 
     */
    public InputProcessor(String swi) {
        super();
        System.out.println("SWI: " + swi);
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
     * <li> will return the result of that prolog goal </li>
     * 
     * @return Will return the actual linguistic expression mapped to the
     *         input-ucs
     * @throws TokenStreamException
     * @throws RecognitionException
     */
    public String process(String inputUCS, boolean verbose)
            throws RecognitionException, TokenStreamException {
        Log.logger.info("Parsing Predicate: " + inputUCS);

        // String s = Util.getText(new File("ucs.txt"));
        String s = inputUCS;
        s = s.replaceAll("[^a-zA-Z0-9\\[\\]\\(\\):-]", "");

        UcsLexer lexer = new UcsLexer(new StringReader(s));
        UcsParser parser = new UcsParser(lexer);
        Predicate p = parser.input();
        System.out.println(p.toString());

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
                Log.logger.info("Generating Prolog Code");

                PrologGenerator gen = new PrologGenerator(p);
                System.out.println(gen.generateProlog());

                // PrologGenerator gen = new PrologGenerator(parser.getUCS());
                result = gen.generateProlog();
                String prologSourcePath = "src-prolog";
                String placeToSave = prologSourcePath + File.separator
                        + "generated_ucs.pl";
                Log.logger.info("Saving generated Prolog Code to: "
                        + placeToSave);
                gen.saveProlog(placeToSave);
                // consult the calling prolog code:
                File fileToConsult = new File(prologSourcePath + File.separator
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

    public void close() {
        engine.shutdown();
    }
}
