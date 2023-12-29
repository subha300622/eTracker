package com.pack;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class MyIssueViewBean 
{
	
	PreparedStatement ps;
	ResultSet rs;
	Statement st,st1,st2;
	
	
	public ResultSet Query(Connection connection,String theissue)throws SQLException
	{
		ps = connection.prepareStatement("select i.issueid, customer, pname as project, due_date, found_version, version as fix_version, due_date, module, platform, severity, priority, type, createdby, createdon, modifiedon, subject, description, assignedto, comment1, rootcause, expected_result, s.status from issue i, issuestatus s, project p, modules m where i.issueid = s.issueid and i.issueid = ? and i.pid = p.pid and module_id = moduleid ",ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
		ps.setString(1,theissue);
		rs = ps.executeQuery();
		return rs;
	}
	public ResultSet Query1(Connection connection,String theissue)throws SQLException
	{
		st2 = connection.createStatement();
		rs = st2.executeQuery("select status from issuestatus where issueid='"+theissue+"' ");
		//System.out.println(resultset1.toString());
		return rs;
	}
	public void UpdateIssue(Connection connection,String assignedto,String issstatus,String subject,String description,String comment,String theissue) throws SQLException
	{
			st = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
			st.executeUpdate("update ISSUE set assignedto='"+assignedto+"' where issueid='"+theissue+"'");
			st.executeUpdate("update ISSUE set modifiedon=SYSDATE where issueid='"+theissue+"'");
			st.executeUpdate("update ISSUE set description='"+StringUtil.fixSqlFieldValue(description)+"' where issueid='"+theissue+"'");
			st.executeUpdate("update ISSUE set subject='"+StringUtil.fixSqlFieldValue(subject)+"' where issueid='"+theissue+"'");
			st.executeUpdate("update ISSUE set comment1='"+StringUtil.fixSqlFieldValue(comment)+"' where issueid='"+theissue+"'");
			st = connection.createStatement();			
			st.executeUpdate("update ISSUESTATUS set status='"+issstatus+"' where issueid='"+theissue+"'");
			st.executeUpdate("update ISSUESTATUS set owner='"+assignedto+"' where issueid='"+theissue+"'");
			
	}
	
	public void UpdateIssue1(Connection connection,String sub,String des,String comment,String theissue) throws SQLException
	{
		st1 = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
		st1.executeUpdate("update ISSUE set subject='"+sub+"',description='"+des+"',comment1='"+comment+"' where issueid='"+theissue+"' ");
	
	}
}
