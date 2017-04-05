package com.splimbo;

import org.jbpm.gop.*;

abstract public class ZapApp {
	protected Node startNode = null;
	protected Execution cursor = null;
	protected String jidClient;
	protected String jidUrlClient;
	protected String appCode;
	protected String xmlConfig;
	
	public ZapApp() {
	}
			
	public String getXmlConfig() {
		return xmlConfig;
	}

	public void setXmlConfig(String xmlConfig) {
		this.xmlConfig = xmlConfig;
	}

	public String getAppCode() {
		return appCode;
	}

	public void setAppCode(String appCode) {
		this.appCode = appCode;
	}

	
	public String getJidUrlClient() {
		return jidUrlClient;
	}

	public void setJidUrlClient(String jidUrlClient) {
		this.jidUrlClient = jidUrlClient;
	}

	public String getJidClient() {
		return jidClient;
	}

	public void setJidClient(String jidClient) {
		this.jidClient = jidClient;
	}


	public Node getStartNode() {
		return startNode;
	}

	public void setStartNode(Node startNode) {
		this.startNode = startNode;
	}
	

	public void perform(String jidServer, String message, String extension, String imageLabel){
		if (cursor == null){
			cursor = new Execution(getStartNode());

			cursor.variables.put("currentReturnText", Util.RETURN_TEXT);
			cursor.variables.put("currentReturnOption", Util.RETURN_OPTION);
		}
		
		cursor.variables.put("currentMessage", message);
		cursor.variables.put("currentExtension", extension);
		cursor.variables.put("currentImageLabel", imageLabel);
		cursor.variables.put("currentMediaPath", Util.MEDIA_PATH);
		cursor.variables.put("jidServer", jidServer);
		cursor.variables.put("jidClient", jidClient);
		cursor.variables.put("jidUrlClient", jidUrlClient);
		
		cursor.enter(cursor.node);		
	}

}
