/* 
** Author(s): Miguel Calejo
** Contact:   interprolog@declarativa.com, http://www.declarativa.com
** Copyright (C) Declarativa, Portugal, 2000-2004
** Use and distribution, without any warranties, under the terms of the 
** GNU Library General Public License, readable in http://www.fsf.org/copyleft/lgpl.html
*/
package com.declarativa.interprolog;
import junit.framework.*;
import java.util.*;
import com.declarativa.interprolog.util.*;

public class XSBSubprocessEngineTest extends SubprocessEngineTest {
	public XSBSubprocessEngineTest(String name){
		super(name);
	}
	protected void setUp() throws java.lang.Exception{
		super.setUp();
		engine.command("import append/3,length/2 from basics");		
    }
	// JUnit reloads all classes, clobbering variables, 
	// so the path should be obtained from System properties or other external means:
	protected PrologEngine buildNewEngine(){
		//String path = new XSBPeer().executablePath(System.getProperties());
		return new XSBSubprocessEngine(/*path*//*,true*/);
	}
}
