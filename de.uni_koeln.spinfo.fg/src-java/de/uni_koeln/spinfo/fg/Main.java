package de.uni_koeln.spinfo.fg;

import java.awt.event.WindowAdapter;
import java.awt.event.WindowEvent;
import java.awt.event.WindowListener;

import com.declarativa.interprolog.PrologEngine;
import com.declarativa.interprolog.SWISubprocessEngine;

import de.uni_koeln.spinfo.fg.ui.InterpreterFrame;
import de.uni_koeln.spinfo.fg.util.Log;

/**
 * Starts the Prolog-Engine, Logger and UI
 * 
 * @author Fabian Steeg
 * 
 */
public class Main {
	//supply two args: swipl-location and log-location, like: /opt/local/bin/swipl /Users/fsteeg/fg-logs
	public static void main(String args[]) {
		Log.init(args[1]);
		// gui:
		InterpreterFrame interpreter = new InterpreterFrame(args[0]);
		WindowListener wl = new WindowAdapter() {

			@Override
			public void windowClosing(WindowEvent e) {
				System.exit(0);
			}

		};
		interpreter.addWindowListener(wl);
	}
}