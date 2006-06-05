package de.uni_koeln.spinfo.fg.ucs;

import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.util.Collection;

import de.uni_koeln.spinfo.fg.ucs.model.Predicate;

/**
 * Generates a Prolog-representation of a Predicate
 * 
 * @author Fabian Steeg
 * 
 */
public class PrologGenerator {
	String result = null;

	private Predicate ucs = null;

	private String prologResultString = null;

	public PrologGenerator(Predicate ucs) {
		this.ucs = ucs;
	}

	/**
	 * Generates Prolog from the associated Predicate.
	 * 
	 * @return Returns the Prolog generated, a string with line-breaks
	 */
	public String generateProlog() {
		StringBuilder nodesBuffer = new StringBuilder();
		StringBuilder propsBuffer = new StringBuilder();

		String lineStep = System.getProperty("line.separator");

		generate(1, 0, lineStep, nodesBuffer, propsBuffer, ucs);
		String clauseStuff = "";

		clauseStuff += "prop(clause, illocution, decl)." + lineStep;
		clauseStuff += "prop(clause, type, mainclause)." + lineStep;

		prologResultString = "% this file is generated - do not edit!\n\n"
				+ nodesBuffer.append(
						lineStep + clauseStuff + lineStep + propsBuffer)
						.toString();

		return prologResultString;
	}

	private void generate(int i, int level, String lineStep,
			StringBuilder nodesBuffer, StringBuilder propsBuffer,
			Predicate predicate) {
		nodesBuffer.append("node(x" + i + ", " + level + ")." + lineStep);
		if (predicate.isTerm()) {
			propsBuffer.append("prop(x" + i + ", type, term)." + lineStep);

			propsBuffer.append("prop(x" + i + ", role, " + predicate.getRole()
					+ ")." + lineStep);
			propsBuffer.append("prop(x" + i + ", relation, "
					+ predicate.getRelation() + ")." + lineStep);
			propsBuffer.append("prop(x" + i + ", proper, false)." + lineStep);
			propsBuffer.append("prop(x" + i + ", pragmatic, null)." + lineStep);
			propsBuffer.append("prop(x" + i + ", num, "
					+ predicate.getValues().getNum() + ")." + lineStep);
			propsBuffer.append("prop(x" + i + ", modifs, [])." + lineStep);

		} else {
			propsBuffer.append("prop(x" + i + ", type, pred)." + lineStep);
			propsBuffer.append("prop(x" + i + ", tense, " + predicate.getValues().getTense() +")." + lineStep);
			propsBuffer.append("prop(x" + i + ", perfect, false)." + lineStep);
			propsBuffer.append("prop(x" + i + ", progressive, false)."
					+ lineStep);
			propsBuffer.append("prop(x" + i + ", mode, ind)." + lineStep);
			propsBuffer.append("prop(x" + i + ", voice, active)." + lineStep);

			propsBuffer.append("prop(x" + i + ", subnodes, ["
					+ predicate.getProps(i) + "])." + lineStep);
		}
		// common
		propsBuffer.append("prop(x" + i + ", lex, '"
				+ predicate.getValues().getForm() + "')." + lineStep);
		propsBuffer.append("prop(x" + i + ", nav, "
				+ predicate.getValues().getNav() + ")." + lineStep);
		propsBuffer.append("prop(x" + i + ", det, "
				+ predicate.getValues().getDef() + ")." + lineStep);
		propsBuffer.append(lineStep);
		i++;
		level++;
		Collection<Predicate> args = predicate.getArgs();
		for (Predicate arg : args) {
			generate(i, level, lineStep, nodesBuffer, propsBuffer, arg);
			i++;
		}

	}

	/**
	 * Writes the generated Prolog to disk. Call generateProlog() first.
	 */
	public void saveProlog(String path) {
		if (prologResultString == null)
			throw new NullPointerException("No Prolog has been generated.");
		// write generated prolog:
		File pFile = new File(path);
		try {
			pFile.createNewFile();
			FileWriter f = new FileWriter(pFile);
			f.write(prologResultString);
			f.close();
		} catch (IOException e1) {
			System.out.println("File IO failed!");
			e1.printStackTrace();
		}
	}

}
