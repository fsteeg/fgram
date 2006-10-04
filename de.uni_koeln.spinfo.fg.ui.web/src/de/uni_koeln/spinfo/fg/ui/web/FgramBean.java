// Part of "Functional Grammar Language Generator" (http://fgram.sourceforge.net/) (C) 2006 Fabian Steeg
// This library is free software; you can redistribute it and/or modify it under the terms of the GNU Lesser General Public License as published by the Free Software Foundation; either version 2.1 of the License, or (at your option) any later version.
// This library is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more details.
// You should have received a copy of the GNU Lesser General Public License along with this library; if not, write to the Free Software Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA

/**
 * @author Fabian Steeg
 *
 */
package de.uni_koeln.spinfo.fg.ui.web;

import antlr.RecognitionException;
import antlr.TokenStreamException;
import de.uni_koeln.spinfo.fg.ucs.InputProcessor;
import de.uni_koeln.spinfo.fg.util.Config;
import de.uni_koeln.spinfo.fg.util.Log;

public class FgramBean {

    private String userInput = "";

    private String answer = "";

    private String preselectedUCS = Config.getString("sample_ucs");

    public FgramBean() {
    }

    /**
     * 
     */
    public void doit() {
        Log.init(Config.getString("log_folder"));
        InputProcessor processor = new InputProcessor(Config
                .getString("prolog_application"));
        try {
            this.answer = processor.process(this.userInput, false);
        } catch (RecognitionException e) {
            this.answer = "RecognitionException: " + e.toString();
            e.printStackTrace();
        } catch (TokenStreamException e) {
            this.answer = "TokenStreamException: " + e.toString();
            e.printStackTrace();
        }

    }

    public String getAnswer() {
        return answer;
    }

    public void setAnswer(String answer) {
        this.answer = answer;
    }

    public String getUserInput() {
        return userInput;
    }

    public void setUserInput(String userInput) {
        this.userInput = userInput;
        doit();
    }

    public String getPreselectedUCS() {
        return preselectedUCS;
    }

    public void setPreselectedUCS(String preselectedUCS) {
        this.preselectedUCS = preselectedUCS;
    }
}
