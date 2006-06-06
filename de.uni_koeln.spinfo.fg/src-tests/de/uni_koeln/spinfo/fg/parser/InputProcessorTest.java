// Part of "Functional Grammar Language Generator" (http://fgram.sourceforge.net/) (C) 2006 Fabian Steeg
// This library is free software; you can redistribute it and/or modify it under the terms of the GNU Lesser General Public License as published by the Free Software Foundation; either version 2.1 of the License, or (at your option) any later version.
// This library is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more details.
// You should have received a copy of the GNU Lesser General Public License along with this library; if not, write to the Free Software Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA

package de.uni_koeln.spinfo.fg.parser;

import junit.framework.TestCase;
import antlr.RecognitionException;
import antlr.TokenStreamException;
import de.uni_koeln.spinfo.fg.ucs.InputProcessor;
import de.uni_koeln.spinfo.fg.util.Config;
import de.uni_koeln.spinfo.fg.util.Log;
import de.uni_koeln.spinfo.fg.util.Util;

public class InputProcessorTest extends TestCase {
    InputProcessor inputProcessor;

    protected void setUp() throws Exception {
        super.setUp();
        Log.init(Config.getString("log_folder"));
        inputProcessor = new InputProcessor(Config.getString("prolog_application"));
        
    }

    public void testProcessFromFile() {
        try {
            String text = Util.getText("ucs/ucs.txt");
            assertTrue("Problem on opening text", text != null);
            System.out.println("Text: " + text);
            assertTrue("Problem on creating InputProcessor",
                    inputProcessor != null);
            String process = inputProcessor.process(text, true);
            assertTrue("No Result!", process != null);
            process = inputProcessor.process(
                    "(E:love[V]:(X:man[N])(DMX:woman[N])Go Obj)", true);
            assertTrue("No Result!", process != null);
            System.out.println(process);
            process = inputProcessor.process(
                    "(E:please[V]:(X:man[N])(DMX:woman[N])Go Obj)", true);
            assertTrue("No Result!", process != null);
            System.out.println(process);
        } catch (RecognitionException e) {
            e.printStackTrace();
        } catch (TokenStreamException e) {
            e.printStackTrace();
        }
    }

    public void testProcessFromString() {
        try {

            String process = inputProcessor.process(
                    "(E:love[V]:(X:man[N])(DMX:woman[N])Go Obj)", true);
            assertTrue("No Result!", process != null);
            System.out.println(process);
            process = inputProcessor.process(
                    "(E:please[V]:(X:man[N])(DMX:woman[N])Go Obj)", true);
            assertTrue("No Result!", process != null);
            System.out.println(process);
            inputProcessor.close();
        } catch (RecognitionException e) {
            e.printStackTrace();
        } catch (TokenStreamException e) {
            e.printStackTrace();
        }
    }

    @Override
    protected void tearDown() throws Exception {
        inputProcessor.close();
        super.tearDown();
    }

}
