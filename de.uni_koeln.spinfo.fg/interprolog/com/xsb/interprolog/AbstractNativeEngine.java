package com.xsb.interprolog;

import com.declarativa.interprolog.*;
import com.declarativa.interprolog.util.*;
import java.io.*;

/** A PrologEngine implemented using the Java Native Interface. This class depends on interprolog_callback.c and other files, 
that are included in the emu directory of XSB Prolog 2.5 and later */
public abstract class AbstractNativeEngine extends PrologEngine{
    private ByteArrayOutputStream bao = new ByteArrayOutputStream();

    public AbstractNativeEngine(String XSB_BIN_DIR, boolean debug, boolean loadFromJar){
    	super(XSB_BIN_DIR,debug, loadFromJar);
    }
    /** Accepts a serialized object in the argument and returns another; handleCallback does the actual work*/
    protected byte[] callback(byte[] in) {
    	progressMessage("entering callback(byte[])");
    	byte[] out;
    	Object x;
    	try{
	        ByteArrayInputStream bai = new ByteArrayInputStream(in);
			ObjectInputStream ios = new ObjectInputStream(bai);
			x = ios.readObject();
			ios.close();
		} catch (ClassNotFoundException e){
			x = e;
		} catch (IOException e){
			throw new IPException("Bad exception before callback handling:"+e);
		}
		Object y = handleCallback(x);
		try {
			synchronized(this){
				bao.reset();
    			ObjectOutputStream oos = new ObjectOutputStream(bao);
				oos.writeObject(y); oos.flush();
				out = bao.toByteArray();
			}
		} catch (IOException e){
			throw new IPException("Bad exception after callback handling:"+e);
		}
		return out;
    }
 	public Object[] deterministicGoal(String G, String OVar, Object[] objectsP, String RVars){
		if (!topGoalHasStarted) 
			throw new IPException("Premature invocation of deterministicGoal");
   		return super.deterministicGoal(G, OVar, objectsP, RVars);
   	}
   	
   	protected abstract boolean commandWithArray(String Functor, byte[] array, int nBytes);

    protected void setupPrologSide(){
        try {     	
            progressMessage("Setting up Prolog library paths...");
            command("assert(library_directory('"+tempDirectory.getAbsolutePath()+"'))");
            progressMessage("Loading initial file...");
            String F = peer.interprologFilename();
            if (loadFromJar) consultFromPackage(F, PrologEngine.class);
            else consultRelative(F, PrologEngine.class);
            progressMessage("Teaching examples to XSB...");
            ByteArrayOutputStream serializedTemp = new ByteArrayOutputStream();
            ObjectOutputStream bootObjects = new ObjectOutputStream(serializedTemp);
            teachIPobjects(bootObjects);
            teachBasicObjects(bootObjects);
            bootObjects.flush();
            byte[] b = serializedTemp.toByteArray();
            // more bytes in 1.4 with Throwable: System.out.println(b.length+" bytes to teach");
            // this is the only teaching of objects not occurring over the deterministicGoal/javaMessage mechanism:
            if(!commandWithArray("ipLearnExamples",b, b.length))
            	throw new IPException("ipLearnExamples failed");
            progressMessage("Initial examples taught.");
            if (!command("ipObjectSpec('InvisibleObject',E,["+registerJavaObject(this)+"],_), assert(ipPrologEngine(E))"))
            	throw new IPException("assert of ipPrologEngine/1 failed");
            if(debug&&!command("assert(ipIsDebugging)"))
            	throw new IPException("assert of ipIsDebugging failed");
        } catch (Exception e){
            throw new IPException("Could not initialize XSB:"+e);
        }
    }

	/** Calls the first Prolog goal in a background thread. That goal will return only if an interrupt or error occurs;
	this method should handle these conditions properly  */
	protected void startTopGoal(){
		Thread top = new Thread(){
			public void run(){
				boolean ended = false;
				while(!ended){
					progressMessage("Calling "+firstJavaMessageName+"...");
					// under normal operation the following never returns:
					//int rc = xsb_command_string("ipPrologEngine(E), javaMessage(E,"+firstJavaMessageName+").");
					boolean succeeded = realCommand("ipPrologEngine(E), javaMessage(E,"+firstJavaMessageName+")");
					if (!succeeded && interrupting) {
						interruptTasks();
					} else if (!succeeded){
						System.err.println("Prolog execution aborted and restarted");
						abortTasks();
					}else {
						ended=true;
						System.out.println("NativeEngine ending abnormally");
					}
				}
			}
		};
		topGoalHasStarted = true;
		top.setName("Prolog handler");
		top.start();
	}

    
}
