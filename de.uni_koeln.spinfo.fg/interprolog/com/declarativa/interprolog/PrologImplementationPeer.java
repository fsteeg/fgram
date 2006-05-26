/* 
** Author(s): Miguel Calejo
** Contact:   interprolog@declarativa.com, http://www.declarativa.com
** Copyright (C) Declarativa, Portugal, 2000-2004
** Use and distribution, without any warranties, under the terms of the 
** GNU Library General Public License, readable in http://www.fsf.org/copyleft/lgpl.html
*/
package com.declarativa.interprolog;
import com.declarativa.interprolog.util.*;
import java.util.*;
import java.io.*;

/** Centers most of the Prolog implementation-dependent information */
public abstract class PrologImplementationPeer{
	PrologEngine engine;
	PrologOperatorsContext operators;
	public PrologImplementationPeer(PrologEngine engine){
		this.engine=engine;
	}
	/** Prolog goal to obtain the install directory as an atom in Prolog variable V; the goal should also bind Prolog variable F to an atom. 
	This is usually obtained from a generic system predicate that returns the values (V) for differente flags (F).*/
	public abstract String getFVInstallDirGoal();
	public abstract String getBinDirectoryProperty(Properties p);
	public abstract String executablePath(String binDirectory);
	public abstract String getPrologVersion();
	public abstract String[] alternativePrologExtensions(String filename);
	public abstract String prologBinToBaseDirectory(String binDirectoryOrStartCommand);
	public abstract Recognizer makePromptRecognizer();
	public abstract Recognizer makeBreakRecognizer();
	/** Returns the path for the Prolog file that must be loaded for InterProlog to function, USING '/' AS THE SEPARATION CHARACTER independently of the OS platform*/
	public abstract String interprologFilename();
	/** Returns the path for the Prolog file that must be loaded for InterProlog's visualization predicates to function, typically
	in the context of using a ListenerWindow. Although the file is common for all Prologs, some (eg XSB) have a compiled form, others do not*/
	public abstract String visualizationFilename();
	public String executablePath(Properties p){
		return executablePath(getBinDirectoryProperty(p));
	}
	/** Some Prologs use '\' as an escape character in atoms, which can affect file paths under Windows. Use this method to preprocess
	all file paths passed to Prolog. this default implementation does no preprocessing, subclasses should define their own if needed */
	public String unescapedFilePath(String p){
		return p;
	}
	public PrologOperatorsContext getOperators(){return operators;}
}
