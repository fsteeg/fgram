// Part of "Functional Grammar Language Generator" (http://fgram.sourceforge.net/) (C) 2006 Fabian Steeg
// This library is free software; you can redistribute it and/or modify it under the terms of the GNU Lesser General Public License as published by the Free Software Foundation; either version 2.1 of the License, or (at your option) any later version.
// This library is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more details.
// You should have received a copy of the GNU Lesser General Public License along with this library; if not, write to the Free Software Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA

package de.uni_koeln.spinfo.fg.ucs;

import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.util.Collection;

import de.uni_koeln.spinfo.fg.ucs.model.Predicate;
import de.uni_koeln.spinfo.fg.util.Config;
import de.uni_koeln.spinfo.fg.util.Log;

/**
 * Generates a Prolog-representation of a UCS
 * 
 * @author Fabian Steeg
 * 
 */
public class PrologGenerator {

    private Predicate ucs = null;

    private String prologResultString = null;

    /**
     * @param ucs
     *            The predicate to generate prolog for
     */
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
        String prologSourcePath = Config.getString("prolog_sources");
        String placeToSave = prologSourcePath + File.separator
                + Config.getString("prolog_ucs");
        Log.logger.debug("Saving generated Prolog Code to: " + placeToSave);
        saveProlog(placeToSave);
        return prologResultString;
    }

    /***************************************************************************
     * *************************************************************************
     **************************************************************************/

    private void saveProlog(String path) {
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
                    + predicate.getTerm().getNum() + ")." + lineStep);
            propsBuffer.append("prop(x" + i + ", modifs, [])." + lineStep);
        } else {
            propsBuffer.append("prop(x" + i + ", type, pred)." + lineStep);
            propsBuffer.append("prop(x" + i + ", tense, "
                    + predicate.getTerm().getTense() + ")." + lineStep);
            propsBuffer.append("prop(x" + i + ", perfect, false)." + lineStep);
            propsBuffer.append("prop(x" + i + ", progressive, false)."
                    + lineStep);
            propsBuffer.append("prop(x" + i + ", mode, ind)." + lineStep);
            propsBuffer.append("prop(x" + i + ", voice, active)." + lineStep);
            propsBuffer.append("prop(x" + i + ", subnodes, ["
                    + subnodes(i, predicate) + "])." + lineStep);
        }
        // common
        propsBuffer.append("prop(x" + i + ", lex, '"
                + predicate.getTerm().getWordForm() + "')." + lineStep);
        propsBuffer.append("prop(x" + i + ", nav, "
                + predicate.getTerm().getWordClass() + ")." + lineStep);
        propsBuffer.append("prop(x" + i + ", det, "
                + predicate.getTerm().getDef() + ")." + lineStep);
        propsBuffer.append(lineStep);
        i++;
        level++;
        Collection<Predicate> args = predicate.getTerm().getChildren();
        for (Predicate arg : args) {
            generate(i, level, lineStep, nodesBuffer, propsBuffer, arg);
            i++;
        }

    }

    private String subnodes(int i, Predicate predicate) {
        StringBuilder res = new StringBuilder();
        // the predicate itself has index 1, so we start with 2:
        i++;
        for (int j = 0; j < predicate.getTerm().getChildren().size(); j++) {
            res.append("x" + i + " ");
            i++;
        }
        return res.toString().trim().replaceAll(" ", ", ");
    }
}
