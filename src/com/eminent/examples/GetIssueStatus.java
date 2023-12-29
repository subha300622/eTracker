package com.eminent.examples;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.HashMap;
public class GetIssueStatus {
	
	public static HashMap<String,String> getStatus(String issueid){
		HashMap<String,String> hm=null;
		Connection connection=null;
	try{
		
		ResultSet resultset=null;
		Statement statement=null;
		hm=new HashMap<String, String>();
		Class.forName("oracle.jdbc.driver.OracleDriver");
		
		connection=DriverManager.getConnection("jdbc:oracle:thin:@e0178:1521:XE", "eminenttracker", "eminentlabs");
		statement=connection.createStatement();
		resultset=statement.executeQuery("select * from issuecomments where issueid='"+issueid+"'");
		while(resultset.next()){
			
			String commentedby	=	resultset.getString("commentedby");
			String status		=	resultset.getString("status");
		
			hm.put(commentedby,status);
			
			
		}
		
	
		
	}
	catch(Exception e){
	System.out.println(e);	
	}
	finally{
		if(connection!=null){
			try{
			connection.close();
			}
			catch(SQLException s){
				
			}
		}
	}
	return hm;
	}

}
