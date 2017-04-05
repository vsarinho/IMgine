package com.splimbo.xml;


public class Wait extends Command {
	public static String DEFAULT_URL = "s.whatsapp.net";
	
	public String secretKey = ""; 
	
	public String toString(){
		return "[Wait => "+super.toString() + "; secretKey: "+ secretKey +"]"; 
				
	}
}
