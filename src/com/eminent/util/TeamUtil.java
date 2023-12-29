package com.eminent.util;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import org.apache.log4j.Logger;
//import org.apache.log4j.PropertyConfigurator;

import com.pack.StringUtil;

public class TeamUtil {
	static Logger logger = Logger.getLogger("TeamUtil");
	private String teamName=null;
	
	public String getTeamName(){
		return teamName;
	}
	public void setTeamName(String teamName){
		if(teamName!=null){
			this.teamName=teamName;
		}
	}
	public boolean TeamExist(Connection connection,String teamname) throws SQLException  
	{
		
		Statement st = null;
		ResultSet rs = null;
				
		String unamem="";
		try  
		{
			st = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
			rs = st.executeQuery("select teamname from team");
			if(rs!=null)  
			{
				if (rs.next())
				{
					rs.first();
			
					do  
					{
						unamem=rs.getString("teamname");
						if((unamem.toUpperCase().equals(teamname.toUpperCase())))  
						{
							return true;
						}
					}while(rs.next());
				}
			}
				
		}
		catch(SQLException Ex)  
		{
			logger.error("Exception in Team Exist Method:"+Ex.getMessage());
		}
		finally
		{
			if(rs!=null) {
				rs.close();
			}
			if(st!=null) {
				st.close();
			}
		}
		return false;
		
	}
	public void CreateNewTeam(Connection connection,String teamname) throws SQLException  
	{
		Statement st = null;
		ResultSet rs = null;
		PreparedStatement ps = null;
		
		try  
		{
			st = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
			rs = st.executeQuery("select teamid_seq.nextval from dual");
			if(rs!=null)  
			{
				if(rs.next())  
				{
        			int nextValue = rs.getInt("nextval");		        
						
					ps=connection.prepareStatement("insert into team(teamid,teamname) values(?,?)");
					ps.setInt(1,nextValue);
					ps.setString(2,StringUtil.fixSqlFieldValue(teamname));
					
					
					ps.executeUpdate();
				
				}
			}
		}
		catch(SQLException Ex)  
		{
			logger.error("Exception while creating Team:"+Ex.getMessage());
		}
		finally
		{
			if(rs!=null) {
				rs.close();
			}
			if(st!=null) {
				st.close();
			}
			if(ps!=null) {
				ps.close();
			}
		}
	}
	public ResultSet SelectTeam(Connection connection) throws SQLException  
	{
		
		Statement st = null;
		ResultSet rs = null;
		try  
		{
			st = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
			rs = st.executeQuery("select * from team");

		}
		
		catch(SQLException Ex)  
		{
			logger.error("Error in Select Team():"+Ex.getMessage());
		}
		
		return rs;
	
	}
	public void UpdateTeam(Connection connection,int mid,String teamname, int teamid) throws SQLException  
	{
		
		PreparedStatement ps = null;
		try  
		{
			ps = connection.prepareStatement("update Team set teamname=? where teamid=?");
			ps.setString(1,StringUtil.fixSqlFieldValue(teamname));
			ps.setInt(2,teamid);
			
			int x = ps.executeUpdate();
			logger.debug(x+"Team Details has been updated");
		
		}
		
		catch(SQLException Ex)  
		{
			logger.error("Error in UpdateTeam():"+Ex.getMessage());
		}
		finally
		{
			if(ps!=null) {
				ps.close();
			}
		}
	
	}
}
