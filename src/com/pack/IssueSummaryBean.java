package com.pack;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class IssueSummaryBean {
	
	Statement statement1;
	ResultSet resultset1;
	
	String createdby = "";
		
	
	public ResultSet Query(Connection connection) throws SQLException
	{
		statement1 = connection.createStatement();
		resultset1 = statement1.executeQuery("SELECT CUSTOMER  FROM PROJECT GROUP BY CUSTOMER");
		return resultset1;
	}
	public ResultSet Query1(Connection connection) throws SQLException
	{
		statement1 = connection.createStatement();
		resultset1 = statement1.executeQuery("SELECT PNAME  FROM PROJECT GROUP BY PNAME");
		return resultset1;
	}
	public ResultSet Query2(Connection connection) throws SQLException
	{
		statement1 = connection.createStatement();
		resultset1 = statement1.executeQuery("SELECT VERSION  FROM PROJECT GROUP BY VERSION");
		return resultset1;
	}
	public ResultSet Query3(Connection connection) throws SQLException
	{
		statement1 = connection.createStatement();
		resultset1 = statement1.executeQuery("SELECT FIRSTNAME,LASTNAME  FROM USERS ORDER BY EMAIL");
		return resultset1;
	}
	public ResultSet Query4(Connection connection)throws SQLException
	{
		statement1 = connection.createStatement();
		resultset1 = statement1.executeQuery("SELECT CREATEDBY FROM ISSUE group by CREATEDBY");
		return resultset1;
	}
	public String Query5(Connection connection) throws SQLException
	{
		
			resultset1=Query4(connection);
			if(resultset1 != null)  
			{
				while(resultset1.next())  
				{
					createdby=resultset1.getString(1);
					
				}
			}
			return createdby;
	}
}
