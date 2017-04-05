package com.splimbo;

import java.io.*;
import java.net.*;
import java.sql.*;
import java.text.SimpleDateFormat;
import java.util.*;

import javax.script.*;

import com.splimbo.xml.*;

import org.jbpm.gop.*;


public class XMLZap extends ZapApp {	
	public String currentPath = "";
	public static String defaultPath = Util.DEFAULT_PATH;
	public static ScriptEngineManager manager = new ScriptEngineManager();
    public static ScriptEngine engine = manager.getEngineByName("JavaScript");
    public static Connection conn = null;

	
	public XMLZap() {
		super();
		final XMLZap self = this;
		
		Node executor = new Node("executor"){
			@Override
			public void execute(Execution execution) {
				String message = (String) execution.variables.get("currentMessage");
				if (message == null) message = "";
				String extension = (String) execution.variables.get("currentExtension");
				if (extension == null) extension = "";
				String imageLabel = (String) execution.variables.get("currentImageLabel");
				if (imageLabel == null) imageLabel = "";
				Util.log("initial_data: message="+message+"; extension="+extension+"; imageLabel="+imageLabel);
				
				String jidServer = (String) execution.variables.get("jidServer");		
				Util.log("server_data: jidServer="+jidServer+"; jidClient="+jidClient+"; jidUrlClient="+jidUrlClient);
				
				Option currentOption = (Option) execution.variables.get("currentOption");
				
				if (currentOption == null){
					execution.variables.put("currentOption", XMLParser.loadXMLConfig(xmlConfig, self));
					execution.variables.put("currentPath", self.currentPath);					
					currentOption = (Option) execution.variables.get("currentOption");
					execution.variables.put("backInCurrentSequence", false);
				}
								
				if (currentOption instanceof Menu){
					Util.log("currentOption is Menu!!");
					Util.log("current condition => "+((Menu) currentOption).condition);

					execution.variables.put("backInCurrentSequence", false);
					
					if (evaluateCondition(execution, ((Menu) currentOption).condition)){

						String result = ((Menu) currentOption).getMenu(execution);	
						String secretKey = ((Menu) currentOption).secretKey;
						
						Util.log(result);
						
						boolean found = false;
						Option subOption = null;
						Iterator<Option> iter = ((Menu) currentOption).options.iterator();
						while (iter.hasNext() && !found){
							subOption = iter.next();
							if (message != null)
								if (!"".equals(secretKey) && secretKey.equals(message))
									found = true;
								else if(!"System.order".toUpperCase().equals(message.toUpperCase()))
									if (subOption.keycode.toUpperCase().equals(message.toUpperCase()))
										found = true;
						}
						
						if (!found){
							if (Util.isNumeric(message))
								try {
									if (((Menu) currentOption).instructions.get(Integer.parseInt(message)) != null){
										found = true;
										subOption = ((Menu) currentOption).instructions.get(Integer.parseInt(message));
									}
								}
								catch(Exception e){
									Util.log("Instructions verification!! message:"+message +"; " + e.getMessage());
								}
						}
						
						if (((Menu) currentOption).instructions.size() == 1 && ((Menu) currentOption).execIfOneInstruction){
							subOption = ((Menu) currentOption).instructions.get(1);
							found = true;
						}
						
						if (found){
							execution.variables.put("currentOption", subOption);
							clearAndRestart(execution);
						}
						else if (message != null && execution.variables.get("currentReturnOption").equals(message.toUpperCase()) && currentOption.parent != null){
							execution.variables.put("currentOption", currentOption.parent);
							execution.variables.put("backInCurrentSequence", true);
							clearAndRestart(execution);
						}
						else {
							Messenger.sendMessage(jidServer, getJidClient(), getJidUrlClient(), result);	
							clear(execution);
						}
					}
					else {
						execution.variables.put("currentOption", currentOption.parent);						
						clearAndRestart(execution);
					}	
				}
				else if (currentOption instanceof Prompt){
					Util.log("currentOption is Prompt!!");	
					Util.log("current condition => "+((Prompt) currentOption).condition);
					
					execution.variables.put("backInCurrentSequence", false);
					
					if ("".equals(extension)){
						if (evaluateCondition(execution, ((Prompt) currentOption).condition)){						
							ArrayList<HyperText> hyperTextToRemove = new ArrayList<HyperText>(); 
							
							Iterator<HyperText> iter = ((Prompt) currentOption).hyperTexts.iterator();
							while (iter.hasNext()){							
								HyperText hyperText = iter.next();
								sendHyperText(execution, hyperText);
								if (hyperText.destroyAfterShow)	hyperTextToRemove.add(hyperText);							
							}
							Iterator<HyperText> iterHyperTextToRemove = hyperTextToRemove.iterator();
							while (iterHyperTextToRemove.hasNext()){
								((Prompt) currentOption).hyperTexts.remove(iterHyperTextToRemove.next());
							}
							
							clear(execution);
						}
						else {
							execution.variables.put("currentOption", currentOption.parent);
							clearAndRestart(execution);
						}							
					}			
					else if (execution.variables.get("currentReturnOption").equals(message.toUpperCase()) && currentOption.parent != null){
						execution.variables.put("currentOption", currentOption.parent);
						execution.variables.put("backInCurrentSequence", true);
						clearAndRestart(execution);
					}
					else {
						if (((Prompt) currentOption).execAfterConfirmation != null)
							((Prompt) currentOption).execAfterConfirmation.perform(execution);
						
						if (!"".equals(((Prompt) currentOption).messageToSend))
							Messenger.sendMessage(jidServer, 
										applyContext(execution, ((Prompt) currentOption).receiver), 
										applyContext(execution, ((Prompt) currentOption).receiverUrl), 
										applyContext(execution, ((Prompt) currentOption).messageToSend));
						
						if (!"".equals(((Prompt) currentOption).confirmationMessage))
							Messenger.sendMessage(jidServer, getJidClient(), getJidUrlClient(), 
										applyContext(execution, ((Prompt) currentOption).confirmationMessage));
						
						execution.variables.put("currentOption", currentOption.parent);
						clearAndRestart(execution);
					}					
				}
				else if (currentOption instanceof Wait){
					Util.log("currentOption is Wait!!");	
					Util.log("current condition => "+((Wait) currentOption).condition);
					
					execution.variables.put("backInCurrentSequence", false);
					
					String secretKey = applyContext(execution,((Wait) currentOption).secretKey);
					Util.log("secretKey : "+secretKey);
					Util.log("secretKey equals? "+secretKey.equals(message));
					Util.log("has parent Option? "+(currentOption.parent != null));
					
					if (secretKey.equals(message) && currentOption.parent != null){
						execution.variables.put("currentOption", currentOption.parent);
						Util.log("secretKey ok -> restart "+currentOption.parent);
						clearAndRestart(execution);						
					}
					else if ("".equals(extension)){
						if (evaluateCondition(execution, ((Wait) currentOption).condition)){						
							ArrayList<HyperText> hyperTextToRemove = new ArrayList<HyperText>(); 
							
							Iterator<HyperText> iter = ((Wait) currentOption).hyperTexts.iterator();
							while (iter.hasNext()){							
								HyperText hyperText = iter.next();
								sendHyperText(execution, hyperText);
								if (hyperText.destroyAfterShow)	hyperTextToRemove.add(hyperText);							
							}
							Iterator<HyperText> iterHyperTextToRemove = hyperTextToRemove.iterator();
							while (iterHyperTextToRemove.hasNext()){
								((Wait) currentOption).hyperTexts.remove(iterHyperTextToRemove.next());
							}
							
							clear(execution);
						}
						else {
							execution.variables.put("currentOption", currentOption.parent);
							clearAndRestart(execution);
						}							
					}	
				}
				else if (currentOption instanceof Command){
					Util.log("currentOption is Command!!");
					Util.log("current condition => "+((Command) currentOption).condition);
					
					if (evaluateCondition(execution, ((Command) currentOption).condition)){
						ArrayList<HyperText> hyperTextToRemove = new ArrayList<HyperText>(); 
						
						Iterator<HyperText> iter = ((Command) currentOption).hyperTexts.iterator();
						while (iter.hasNext()){
							HyperText hyperText = iter.next();
							Util.log("command - send hypertext");
							sendHyperText(execution, hyperText);
							
							if (hyperText.destroyAfterShow)	hyperTextToRemove.add(hyperText);
						}	
						
						Iterator<HyperText> iterHyperTextToRemove = hyperTextToRemove.iterator();
						while (iterHyperTextToRemove.hasNext()){
							((Command) currentOption).hyperTexts.remove(iterHyperTextToRemove.next());
						}
						
						execution.variables.put("currentOption", currentOption.parent);
						
						Iterator<Exec> execsIter = ((Command) currentOption).execs.iterator();
						while (execsIter.hasNext()){
							execsIter.next().perform(execution);
						}
					}
					else
						execution.variables.put("currentOption", currentOption.parent);
										
					execution.variables.put("backInCurrentSequence", false);
					clearAndRestart(execution);
				}
				else if (currentOption instanceof Sequence){
					Util.log("currentOption is Sequence!!");
					Util.log("current condition => "+((Sequence) currentOption).condition);
					
					Option nextOption;					

					Integer currentIndex = (Integer) execution.variables.get(
							"SequenceIndex_"+((Sequence) currentOption).currentId);
					
					Util.log("currentIndex="+currentIndex+"; currentId="+((Sequence) currentOption).currentId+
							"; options size="+((Sequence) currentOption).options.size());
					if (currentIndex == null){
						if ("".equals(((Sequence) currentOption).condition)){
							execution.variables.put("SequenceIndex_"+((Sequence) currentOption).currentId, new Integer(0));
							currentIndex = new Integer(0);
							//Util.log("currentIndex criado sem condition");
						}
						else if (evaluateCondition(execution, ((Sequence) currentOption).condition)){
							execution.variables.put("SequenceIndex_"+((Sequence) currentOption).currentId, new Integer(0));
							currentIndex = new Integer(0);
							//Util.log("currentIndex criado após condition");
						}
					}
					
					//Util.log("step2 - currentIndex="+currentIndex);

					if (currentIndex != null && (Boolean) execution.variables.get("backInCurrentSequence")){
						currentIndex = currentIndex - 2; 
						execution.variables.put("backInCurrentSequence", false);
					}
					
					//Util.log("step3 - currentIndex="+currentIndex+" ; size="+((Sequence) currentOption).options.size());

					if (currentIndex != null && currentIndex >= ((Sequence) currentOption).options.size()){
						if (!"".equals(((Sequence) currentOption).condition) &&
							evaluateCondition(execution, ((Sequence) currentOption).condition) &&
							"true".equals(((Sequence) currentOption).isLooping)){
							currentIndex = new Integer(0);
						}						
					}
					
					//Util.log("step4 - currentIndex="+currentIndex+" ; size="+((Sequence) currentOption).options.size());
					if (currentIndex != null && currentIndex >= 0 && currentIndex < ((Sequence) currentOption).options.size()){
						nextOption = (Option) ((Sequence) currentOption).options.get(currentIndex);
						//Util.log("nextOption:"+nextOption);
						execution.variables.put("SequenceIndex_"+((Sequence) currentOption).currentId, currentIndex+1);
					}						
					else {
						nextOption = currentOption.parent;

						//Util.log("nextOption is parent:"+nextOption);
						
						//if (currentIndex != null)
							execution.variables.remove("SequenceIndex_"+((Sequence) currentOption).currentId/*, null*/);												
					}
					
					execution.variables.put("currentOption", nextOption);
					execution.variables.put("backInCurrentSequence", false);
					clearAndRestart(execution);
				}
			}
		};
		
		executor.addTransition("ok", executor);
		
		
		 // startPoint
	    this.setStartNode(executor);	
	}
	
	private void clear(Execution execution){
		execution.variables.put("currentMessage", "");
		execution.variables.put("currentExtension", "");
		execution.variables.put("currentImageLabel", "");
	}
	
	private void clearAndRestart(Execution execution){
		execution.variables.put("currentMessage", "");
		execution.variables.put("currentExtension", "");
		execution.variables.put("currentImageLabel", "");
		execution.event("ok");
	}
	
	private void sendHyperText(Execution execution, HyperText hyperText){
		String message = hyperText.content;
				
		if (message.toUpperCase().contains("SQL."))
			message = evaluateSQL(execution, message);
		else
			message = applyContext(execution, message);
		
		String receiver = applyContext(execution, hyperText.receiver);
		if ("".equals(receiver))
			receiver = (String) execution.variables.get("jidClient");

		String receiverUrl = applyContext(execution, hyperText.receiverUrl);
		if ("".equals(receiverUrl))
			receiverUrl = (String) execution.variables.get("jidUrlClient");
		
		Util.log("sendHyperText - "+message);
		Util.log("receiver - "+receiver);
		Util.log("receiverUrl - "+receiverUrl);
		
		if ("text".equals(hyperText.type))
			Messenger.sendMessage((String) execution.variables.get("jidServer"),
								receiver, receiverUrl, message);
		else if ("http-text".equals(hyperText.type)){
			try {
				URL url = new URL(message);
		        URLConnection con = url.openConnection();
		        
		        StringBuffer htmlBuffer = new StringBuffer();
		        
		        BufferedReader in = new BufferedReader(new InputStreamReader(con.getInputStream()));
		        String l;
		        while ((l=in.readLine())!=null) {
		        	htmlBuffer.append(l);        	
		        }
		        
		        Messenger.sendMessage((String) execution.variables.get("jidServer"),
									receiver, receiverUrl, htmlBuffer.toString());	  
			} catch (IOException ex) {
	            Util.log(ex.getMessage());
	        }
		}
		else if (("http-image".equals(hyperText.type)) || ("http-document".equals(hyperText.type))){
			try {
				URL url = new URL(message);
				URLConnection connection = url.openConnection();
				
				String ext = "jpg";
				if ("http-document".equals(hyperText.type)) ext = "pdf";
	
				InputStream input = connection.getInputStream();
				byte[] buffer = new byte[4096];
				int n = - 1;
				
				File file = new File(currentPath + receiver+"."+ext);
				OutputStream output = new FileOutputStream(file);
				while ((n = input.read(buffer)) != -1) {
					Util.log("read " + n + " bytes,");
					output.write(buffer, 0, n);
				}
				output.close();
								
				Messenger.sendMedia((String) execution.variables.get("jidServer"), 
									receiver, receiverUrl, currentPath + receiver+"."+ext, ext);				
			} catch (IOException ex) {
	            Util.log(ex.getMessage());
	        }						
		}
		else {
			Util.log("path + message:"+(currentPath + message));
			Messenger.sendMedia((String) execution.variables.get("jidServer"), 
								receiver, receiverUrl, currentPath + message, 
								message.substring(message.lastIndexOf(".")+1, message.length()));
		}
	}
	
	public static String applyContext(Execution execution, String message){
		for (String key : execution.variables.keySet()){
			try{
				if (execution.variables.get(key) instanceof String)
					message = message.replace("System."+key, (String) execution.variables.get(key));
			}
			catch (Exception e){
				Util.log(e.getMessage()+" key:"+key);
			}
		}		
		
		message = message.replace("System.dateTime", new SimpleDateFormat("yyyy-MM-dd HH:mm").format(new java.util.Date()));		
		
		return message;
	}
	
	public static boolean evaluateCondition(Execution execution, String condition){
		boolean result = false;
		
		if (!"".equals(condition)){
			condition = applyContext(execution, condition);
			condition = condition.trim();
			
			condition = condition.replace("\r","").replace("\n","").replace("\r\n","");
			
			try {
		        String script = "var result = ("+condition+")";
		        Util.log("script: "+script);
		        engine.eval(script);	        
		        result = (Boolean) engine.get("result");
		        Util.log("condition:"+condition+" ### result:"+result);
			}
			catch(Exception e){
				e.printStackTrace();
			}
		}
		else
			result = true;
		
		return result;
	}
	
	public static String evaluateSQL(Execution execution, String sql) {
		Util.log("Evaluating "+sql);
		String result = "";
		try{
			if ("SQL.CONNECT_URL".equals(sql.toUpperCase().substring(0,"SQL.CONNECT_URL".length()))){
				String databaseUrl = sql.substring("SQL.CONNECT_URL(".length(), sql.length()-1);
				if (XMLZap.conn != null)
					try{
						XMLZap.conn.close();
					}
					catch (Exception e){}
				XMLZap.conn = Database.getMySQLUrlConnection(applyContext(execution, databaseUrl));
				Util.log("Connected with "+databaseUrl);
			}
			else if ("SQL.CONNECT".equals(sql.toUpperCase().substring(0,"SQL.CONNECT".length()))){
				String database = sql.substring("SQL.CONNECT(".length(), sql.length()-1);
				if (XMLZap.conn != null)
					try{
						XMLZap.conn.close();
					}
					catch (Exception e){}
				XMLZap.conn = Database.getMySQLConnection(applyContext(execution, database));
				Util.log("Connected with "+database);
			}
			else if (XMLZap.conn != null && sql.toUpperCase().contains("SQL.CALL")){
				String paramText = sql.substring(sql.indexOf("SQL.CALL(")+"SQL.CALL(".length(), sql.length()-1);
				String[] params = paramText.split(",,");
				
				String call = "CALL " + params[0] + "(";
				for (int i = 1; i < params.length; i++)
					call = call + "?,";
				
				if (params.length > 1)
					call = call.substring(0, call.length()-1) + ")";
				else
					call = call.substring(0, call.length()) + ")";
				
				Util.log("Executing "+call);
				
				CallableStatement proc = XMLZap.conn.prepareCall(call);
				
				for (int i = 1; i < params.length; i++){
					Util.log("params["+i+"]:"+applyContext(execution, params[i]));
					proc.setString(i, applyContext(execution, params[i]));
				}
				
				proc.execute();
				
				ResultSet rs = (ResultSet) proc.getResultSet();
				if (rs != null){

					while (rs.next()) 
						result += rs.getString(1);					
					
					rs.close();
				}
				
				proc.close();
			}
			else if (XMLZap.conn != null && sql.toUpperCase().contains("SQL.QUERY")){
				String paramText = sql.substring(sql.indexOf("SQL.QUERY(")+"SQL.QUERY(".length(), sql.length()-1);				
				String[] params = paramText.split(",,");

				PreparedStatement pdst = XMLZap.conn.prepareStatement(params[0]);	    	

				for (int i = 1; i < params.length; i++){
					Util.log("params["+i+"]:"+applyContext(execution, params[i]));
					pdst.setString(i, applyContext(execution, params[i]));				
				}
				
				Util.log("Querying "+params[0]);
				
				ResultSet rs = pdst.executeQuery();
				
				while (rs.next()) 
					result += rs.getString(1);
				
				Util.log("result= "+result);
				
				rs.close();
				pdst.close();			
			}			
			else if (XMLZap.conn != null && sql.toUpperCase().contains("SQL.UPLOAD")){
				String paramText = sql.substring(sql.indexOf("SQL.UPLOAD(")+"SQL.UPLOAD(".length(), sql.length()-1);
				String[] params = paramText.split(",,");
				
				String call = "CALL " + params[0] + "(";
				for (int i = 1; i < params.length; i++)
					call = call + "?,";
				
				if (params.length > 1)
					call = call.substring(0, call.length()-1) + ")";
				else
					call = call.substring(0, call.length()) + ")";
				
				Util.log("Executing "+call);
				
				CallableStatement proc = XMLZap.conn.prepareCall(call);
				
				String blobPath = applyContext(execution, params[1]);
				if (!blobPath.contains(defaultPath)) blobPath = defaultPath+blobPath;
				Util.log("params[1]:"+blobPath);
				byte[] blob = null;
		        File image = new File(blobPath);        
		        ByteArrayOutputStream bos = new ByteArrayOutputStream();
		        byte[] buf = new byte[1024];
		        try {
		        	FileInputStream fis = new FileInputStream(image);
		        	
		            for (int readNum; (readNum = fis.read(buf)) != -1;){
		                bos.write(buf, 0, readNum);
		                Util.log("read " + readNum + " bytes,");
		            }
		        } catch (IOException ex) {
		            System.err.println(ex.getMessage());
		        }
		        blob = bos.toByteArray();
		        
		        proc.setBytes(1, blob);
				
		        for (int i = 2; i < params.length; i++){
					Util.log("params["+i+"]:"+applyContext(execution, params[i]));
					proc.setString(i, applyContext(execution, params[i]));
				}
				
				proc.execute();
				
				ResultSet rs = (ResultSet) proc.getResultSet();
				if (rs != null){

					while (rs.next()) 
						result += rs.getString(1);					
					
					rs.close();
				}
				
				proc.close();				
			}
			else if (XMLZap.conn != null && sql.toUpperCase().contains("SQL.DOWNLOAD")){
				String paramText = sql.substring(sql.indexOf("SQL.DOWNLOAD(")+"SQL.DOWNLOAD(".length(), sql.length()-1);
				String[] params = paramText.split(",,");
				
				String call = "CALL " + params[0] + "(";
				for (int i = 1; i < params.length; i++)
					call = call + "?,";
				
				if (params.length > 1)
					call = call.substring(0, call.length()-1) + ")";
				else
					call = call.substring(0, call.length()) + ")";
				
				Util.log("Executing "+call);
				
				CallableStatement proc = XMLZap.conn.prepareCall(call);
				
				for (int i = 1; i < params.length; i++){
					Util.log("params["+i+"]:"+applyContext(execution, params[i]));
					proc.setString(i, applyContext(execution, params[i]));
				}
				
				proc.execute();
				
				ResultSet rs = (ResultSet) proc.getResultSet();
				if (rs != null){
					while (rs.next()){ 		
						Util.log("Gerando blob!");
						Blob blob = rs.getBlob(1);
						InputStream in = blob.getBinaryStream();
						File file = new File(applyContext(execution, params[1]));
						OutputStream out = new FileOutputStream(file);
						byte[] buff = new byte[1024];  
						
						while (in.read(buff) > 0) {
						    out.write(buff);
			                Util.log("write " + buff.length + " bytes,");
						}
						in.close();
					    out.close();					    
					}					
					
					rs.close();
				}
				
				proc.close();
			}
		}
		catch (Exception e){
			e.printStackTrace();
		}
		return result;	
	}
}
