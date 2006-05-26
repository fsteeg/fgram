package com.declarativa.interprolog; 
import com.xsb.interprolog.*;
import junit.framework.*;
import junit.extensions.*;
public class AllTests{

	public static void main(String args[]) { 
		com.declarativa.interprolog.gui.ListenerWindow.commonGreeting();
		/*startCommand=args[0];
		if (args.length>1) System.out.println("Invoke tests with a single argument");
    	else*/ junit.swingui.TestRunner.run(AllTests.class);
	}
	
	public static Test suite(){
		TestSuite suite= new TestSuite("Testing InterProlog"); 
		suite.addTestSuite(XSBSubprocessEngineTest.class);
		suite.addTest(new XSBNativeEngineTest("testNativeEngine"));
		suite.addTestSuite(SWISubprocessEngineTest.class);
		return suite;
	}
}