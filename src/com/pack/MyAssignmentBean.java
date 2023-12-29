package com.pack;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import org.apache.log4j.Logger;

import pack.eminent.encryption.MakeConnection;

public class MyAssignmentBean 
{
		Logger logger = Logger.getLogger("MyAssignmentBean");
		
	public MyAssignmentBean()
	{
		
	}
	Statement st;
	PreparedStatement ps;
	ResultSet rs;
	
	public String FormatTitle(java.util.Calendar thiscal)
	{
	 	java.text.SimpleDateFormat formatter=new java.text.SimpleDateFormat("ddMMyyyy");
	 	return (formatter.format(thiscal.getTime()));
	}
	
	/*public ResultSet MyQuery(Connection connection,int user) throws SQLException
	{
		st = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
		//rs = st.executeQuery("select issueid,project,subject,severity,priority,type,modifiedon,createdby,assignedto from issue where assignedto="+user+" ORDER  BY modifiedon");
		rs = st.executeQuery("select issue.issueid,project,subject,severity,priority,type,modifiedon,createdby,assignedto,issuestatus.status  from issue,issuestatus where issuestatus.owner='"+user+"' and issuestatus.status not like 'Closed%' and issue.issueid=issuestatus.issueid");
		
		return rs;
	}*/
	
	Connection connection = null;
	
	public ResultSet Query(int user)throws Exception
	{
		connection	= MakeConnection.getConnection();
		
		//select STATUS from ISSUESTATUS where ISSUEID='"+iss+"'"
		
		ps = connection.prepareStatement("select u.firstname,u.lastname,i.issueid,i.project,i.subject,i.severity,i.priority,i.type,i.modifiedon,i.createdby,i.assignedto,is.status from issue i,issuestatus is,users u where issue.issueid=issuestatus.issueid and assignedto=? ORDER  BY modifiedon");
		ps.setInt(1,user);
		rs = ps.executeQuery();
		return rs;
	}
	public String Query1(String theissno)throws SQLException,ClassNotFoundException
	{
		String issuestatus = null;
		try
		{
			connection = MakeConnection.getConnection();
			ps = connection.prepareStatement("select STATUS from ISSUESTATUS where ISSUEID=?");
			ps.setString(1,theissno);
			rs = ps.executeQuery();
			rs.next();
			issuestatus = rs.getString("issuestatus");
		}
		catch(Exception e)
		{
			logger.error("SQLException:"+e.getMessage());
		}
		finally
		{
			rs.close();
			ps.close();
			connection.close();
			
		}
		return issuestatus;
	}
	public ResultSet Query2(Connection connection,String theissno)throws SQLException
	{
		st = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
		rs = st.executeQuery("select fileid,filename from fileattach where issueid='"+theissno+"' ");//changed
		return rs;
	}
	
	public void close() throws SQLException
	{
		if(rs!=null) {
			rs.close();
		}
		if(ps!=null) {
			ps.close();
		}
		if(connection!=null) {
			connection.close();
		}
	}
		
}
