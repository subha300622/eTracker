package com.eminent.examples;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;


//import pack.eminent.encryption.MakeConnection;

public class WorkedIssues {

	Connection connection=null;
	Statement statement=null,state=null;
	ResultSet resultset=null,result=null;

	
	public void getIssues(){
		
		long time;
		time=System.currentTimeMillis();
		
		try{
			Class.forName("oracle.jdbc.driver.OracleDriver");
			
			connection=DriverManager.getConnection("jdbc:oracle:thin:@e0178:1521:XE", "eminenttracker", "eminentlabs");
		statement=connection.createStatement();
		resultset=statement.executeQuery("select distinct issuecomments.issueid from issuecomments,issue where issue.issueid=issuecomments.issueid and to_date(comment_date, 'DD-Mon-YY') between '01-feb-08' and '29-feb-08' and commentedby='112'");
		state=connection.createStatement();
		
		while(resultset.next()){
			result=state.executeQuery("select * from issue where issueid='"+resultset.getString(1)+"'");
			while(result.next()){
				
			}
			
		}
		time=System.currentTimeMillis()-time;
	}
	catch(Exception e){
			e.printStackTrace();
	}
	finally{
		try{
			if(statement!=null){
				statement.close();
			}
			if(resultset!=null){
				resultset.close();
			}
			if(state!=null){
				state.close();
			}
			if(result!=null){
				result.close();
			}
		if(connection!=null){
			connection.close();
		}
		}
		catch(Exception ex){
			ex.printStackTrace();
		}
	}
	}
	
	public static void main(String []args){
		long time;
		time=System.currentTimeMillis();
		WorkedIssues work=new WorkedIssues();
		work.getIssues();
		time=System.currentTimeMillis()-time;
		
	
		
		
	}
}
