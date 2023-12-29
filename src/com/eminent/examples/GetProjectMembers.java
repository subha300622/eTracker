package com.eminent.examples;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.*;
import org.apache.log4j.Logger;


//import pack.eminent.encryption.MakeConnection;

public  class GetProjectMembers {
      static Logger logger = null;

    static {
        logger = Logger.getLogger("GetProjectMembers");
    }
	public  static HashMap<String,String> getMembers(String projectName,String version){
		

		
		
		Connection connection=null;
		Statement statement=null;
		ResultSet resultset=null;
		String id=null;
//		String name=null;
		ArrayList<String> al =new ArrayList<String>();
		ArrayList<String> userid=new ArrayList<String>();
		ArrayList<String> username=new ArrayList<String>();
		HashMap<String,String> member=new HashMap<String,String>();
	
			
			try{
		//		connection=MakeConnection.getConnection();
				Class.forName("oracle.jdbc.driver.OracleDriver");
				
				connection=DriverManager.getConnection("jdbc:oracle:thin:@e0178:1521:XE", "eminenttracker", "eminentlabs");
				statement=connection.createStatement();
				resultset=statement.executeQuery("select userproject.userid from userproject,project where userproject.pid=project.pid and project.pname='"+projectName+"'and version='"+version+"'");
				while(resultset.next()){
					id=resultset.getString(1);
					userid.add(id);
					
					username.add("NAME");
					member.put(id,"NAME");
					
				}
				
			}
			catch(Exception e){
				logger.error(e.getMessage());
			}
			finally{
				try{
				if(statement!=null) {
					statement.close();
				}
				if(resultset!=null) {
					resultset.close();
				}
				if(connection!=null) {
					connection.close();
				}
				}
				catch(Exception ex){
					logger.error(ex.getMessage());
				}
			}
		
	
		
		
		al.addAll(userid);		
		al.addAll(username);
	
		return member;
		
	}
	public static void main(String[] args){
//		String pname="eTracker";
//		String version="2.9.1";
		HashMap<String,String> uid=new HashMap<String,String>();
//		GetProjectMembers g=new GetProjectMembers();
		uid=GetProjectMembers.getMembers("FICOSDMM", "1.0");
	}

}
