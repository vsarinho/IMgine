package com.splimbo;


public class StartUp {
	
	public static void main (String args[]) {
		Util.clearLogFile();
		new Messenger("Messenger").start();
	}
	
}
