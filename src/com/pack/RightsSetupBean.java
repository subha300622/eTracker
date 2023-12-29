/**
 * 
 */
package com.pack;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import org.apache.log4j.Logger;

public class RightsSetupBean 
{
		static Logger logger = Logger.getLogger("RightsSetupBean");
		Statement st = null;
		ResultSet rs = null;
	
		public ArrayList<Integer> Query(Connection connection) throws SQLException
		{
			ArrayList<Integer> al=new ArrayList<Integer>();
			Statement st = null;
			ResultSet rs = null;
			try 
			{
				st = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
				rs = st.executeQuery("SELECT roleid FROM USERS");
				while(rs.next())
				{
					al.add(rs.getInt("roleid"));
				}
			} 
			catch (SQLException e) 
			{
				logger.error("Exception:"+e);
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
			return al;
		}
		public ResultSet Query1(Connection connection,String name)throws SQLException
		{
		
			st = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
			rs=st.executeQuery("SELECT USERID,FIRSTNAME,LASTNAME FROM USERS WHERE EMAIL='"+name+ "' ");
			return rs;
		}
		
		public void close() throws SQLException
		{
			if(rs!=null) {
				rs.close();
			}
			if(st!=null) {
				st.close();
			}
		}
		
}
