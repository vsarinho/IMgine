package com.splimbo;

import java.io.*;

public class Util {
	public static final String RETURN_TEXT = "V - Voltar";
	public static final String RETURN_OPTION = "V";
	public static final String DEFAULT_PATH = "/home/...";
	public static final String APPS_PATH = DEFAULT_PATH+"/projects/ZapServer/";
	public static final String ZAPSERVER_DATABASE = "zapserver";
	public static final String DEBUG_FILE = APPS_PATH+"debug.log";
	public static final String MEDIA_PATH = Util.DEFAULT_PATH+"/";
	
	public static boolean isNumeric(String str)
	{
		if ("".equals(str) || str == null) return false;
		
	    for (char c : str.toCharArray())
	    {
	        if (!Character.isDigit(c)) return false;
	    }
	    return true;
	}
	
	public static void clearLogFile(){
		try {			
			FileWriter fw = new FileWriter(DEBUG_FILE); 
		    fw.write("");
		    fw.flush();
		    fw.close();
		    
		} 
		catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	public static void log(String str){
		System.out.println(str);
				
		try {			
			FileWriter fw = new FileWriter(DEBUG_FILE,true); 
		    fw.write(str+'\n');
		    fw.flush();
		    fw.close();
		    
		} 
		catch (IOException e) {
			e.printStackTrace();
		}
		
	}
}
