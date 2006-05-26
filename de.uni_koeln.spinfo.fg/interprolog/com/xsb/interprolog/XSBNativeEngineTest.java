package com.xsb.interprolog;
import com.declarativa.interprolog.*;
import com.declarativa.interprolog.util.*;

public class XSBNativeEngineTest extends NativeEngineTest{
	public XSBNativeEngineTest(String name){super(name);}
	protected PrologEngine buildNewEngine(){
		//String dir = new XSBPeer().getBinDirectoryProperty(System.getProperties());
		return new NativeEngine(/*dir*/);
	}
}