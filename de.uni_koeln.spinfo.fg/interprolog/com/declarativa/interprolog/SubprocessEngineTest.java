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

public abstract class SubprocessEngineTest extends PrologEngineTest {
	public SubprocessEngineTest(String name){
		super(name);
	}
	protected void setUp() throws java.lang.Exception{
		engine = buildNewEngine();
		System.out.println("SubprocessEngineTest version:"+engine.getPrologVersion());
		thisID = engine.registerJavaObject(this);
		//engine.setDebug(true);
		loadTestFile(); engine.waitUntilAvailable();
    }
	protected void tearDown() throws java.lang.Exception{
 		engine.shutdown();
    }
	
	public void testDeterministicGoal(){ 
		super.testDeterministicGoal();
		
		try{ // Now working thanks to catch:
			engine.deterministicGoal("nowaythisisdefined");
			fail("should raise an IPException... with undefined predicate message");
		} catch (IPException e){
			// Too strict for the stream-based recognizers:
			// assertTrue("proper message in exception",e.toString().indexOf("Undefined")!=-1);
			assertTrue("No more listeners",((SubprocessEngine)engine).errorTrigger.numberListeners()==0);
		}
	}
	public void testManyEngines(){
		SubprocessEngine[] engines = new SubprocessEngine[2]; // 3 hangs on my Windows 98, at least 10 work on NT 4 Workstation
		for (int i=0;i<engines.length;i++) {
			//System.out.println("Creating engine "+i);
			engines[i] = (SubprocessEngine)buildNewEngine();
		}
		for (int i=0;i<engines.length;i++) 
			assertTrue(engines[i].isAvailable());
		for (int i=0;i<engines.length;i++) 
			engines[i].shutdown();
	}
	StringBuffer buffer;
	public void testOutputListening(){
		buffer = new StringBuffer();
		PrologOutputListener listener = new PrologOutputListener(){
			public void print(String s){
				buffer.append(s);
			}
		};
		assertEquals(0,((SubprocessEngine)engine).listeners.size());
		((SubprocessEngine)engine).addPrologOutputListener(listener);
		assertEquals(1,((SubprocessEngine)engine).listeners.size());
		
		engine.deterministicGoal("write('hello,'), write(' tester'), nl");
		//try{Thread.sleep(200);} catch(Exception e){fail(e.toString());}
		engine.waitUntilAvailable();
		assertTrue("printed something",buffer.toString().indexOf("hello, tester") != -1);
		
		assertTrue("available",engine.isAvailable());
		assertTrue("detecting regular and break prompts",((SubprocessEngine)engine).isDetectingPromptAndBreak());
		engine.command("thisIsUndefined");
		engine.waitUntilAvailable();
		
		//FAILING ALWAYS:
		//engine.sendAndFlushLn("bad term."); 
		//System.out.println("now waiting; buffer:"); System.out.println(buffer);
		//engine.sendAndFlushLn("true."); //This "fixes" the problem on Win98 but not on NT4...
		engine.waitUntilAvailable();
		
		((SubprocessEngine)engine).removePrologOutputListener(listener);
		assertEquals(0,((SubprocessEngine)engine).listeners.size());
	}

	/* Works/fails sometimes. contains XSB specific test
	public void testInterrupt(){ // crashes JNI version (and for now this one too)
		System.out.println("May be...");
		engine.command("repeat,fail");
		assertTrue("Busy",!engine.isAvailable());
		engine.setDebug(true);
		System.out.println("Interrupting...");
		engine.interrupt();
		assertTrue("Free",engine.isAvailable()); 
		// FAILING SOMETIMES:
		System.out.println("this...");
		engine.command("import conget/2 from gensym");
		//System.out.println("and this...");
		assertTrue("Not in break mode1", engine.deterministicGoal("conget('_$break_level', 0)"));
		//System.out.println("...whatever...");
		engine.command("repeat,fail");
		assertTrue("Busy2",!engine.isAvailable());
		engine.interrupt();
		assertTrue("Free2",engine.isAvailable());
		assertTrue("Not in break mode2", engine.deterministicGoal("conget('_$break_level', 0)"));
		engine.setDebug(false);
	}*/
}