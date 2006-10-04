// Part of "Functional Grammar Language Generator" (http://fgram.sourceforge.net/) (C) 2006 Fabian Steeg
// This library is free software; you can redistribute it and/or modify it under the terms of the GNU Lesser General Public License as published by the Free Software Foundation; either version 2.1 of the License, or (at your option) any later version.
// This library is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more details.
// You should have received a copy of the GNU Lesser General Public License along with this library; if not, write to the Free Software Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA

package de.uni_koeln.spinfo.fg.ui;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;

import antlr.RecognitionException;
import antlr.TokenStreamException;
import de.uni_koeln.spinfo.fg.ucs.InputProcessor;
import de.uni_koeln.spinfo.fg.util.Config;
import de.uni_koeln.spinfo.fg.util.Log;


/**
 * @author Fabian Steeg (fsteeg)
 */
public class InterpreterConsole {

    /**
     * @param args
     */
    public static void main(String[] args) {
//        if (args.length != 1) {
//            System.out.println("Please specify the Properties file location!");
//            System.exit(1);
//        }
        Log.init(Config.getString("log_folder"));
        InputProcessor processor = new InputProcessor(Config.getString("prolog_application"));
         String line;
         BufferedReader in = new BufferedReader(new InputStreamReader(System.in));
       
        try {
            System.out.print("UCS >> ");
            while(( line = in.readLine()) != null){
                try {
                    System.out.println(processor.process(line, false));
                    System.out.print("UCS >> ");
                } catch (RecognitionException e) {
                  System.out.println("RecognitionException: " + e);
//                    e.printStackTrace();
                } catch (TokenStreamException e) {
                    System.out.println("TokenStreamException: " + e);
//                    e.printStackTrace();
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }

    }
}
