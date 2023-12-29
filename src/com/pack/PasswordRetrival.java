package com.pack;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import org.apache.log4j.Logger;
import pack.eminent.encryption.Encryption;
import pack.eminent.encryption.MakeConnection;

//import org.apache.log4j.Logger;
//import org.apache.log4j.PropertyConfigurator;

public class PasswordRetrival 
{
	/**
	 * Logger for this class
	 */
	private static final Logger logger = Logger
			.getLogger(PasswordRetrival.class);

	//static Logger logger = Logger.getLogger("PasswordRetrival");
	Connection con;
	PreparedStatement ps;
	ResultSet rs;
	ArrayList<String> al = new ArrayList<String>();
	
	
	public ArrayList<String> getSecret(String email) throws Exception
	{
		//PropertyConfigurator.configure("log4j.properties");
		//logger.debug("EMAIL:"+email);
		try
		{
			con = MakeConnection.getConnection();
			//logger.debug("Connection:"+con);
			ps = con.prepareStatement("SELECT secret,answer FROM USERS WHERE lower(EMAIL)=? and roleid>=1",ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
			ps.setString(1,email.toLowerCase());
			rs = ps.executeQuery();
			if(rs.next())
			{
				al.add(rs.getString("secret"));
				al.add(rs.getString("answer"));
				//logger.debug("ANSWER:"+rs.getString("answer"));
			}
			else
			{
				al.add("false");
			}
		}
		catch(Exception e)
		{
			//logger.error("Exception:"+e);
			logger.error("getSecret(String) - Error in Password Retrival:" + e.getMessage());
		}
		finally
		{
			if(rs!=null) {
				rs.close();
			}
			if(ps!=null) {
				ps.close();
			}
			if(con!=null) {
				con.close();
			}
		}
		return al;
	}
	
	
	public int changePassword(String email,String newpassword) throws Exception
	{
//		Encryption encryption = new Encryption();
		//PropertyConfigurator.configure("log4j.properties");
		//logger.debug("EMAIL:"+email);
		//logger.debug("New Password:"+newpassword);
		//logger.debug("Encrypted Password:"+encryption.encrypt(newpassword));
		int x=0;
		try
		{
			con = MakeConnection.getConnection();
			//logger.debug("Connection:"+con);
			ps = con.prepareStatement("update users set password=? where upper(email)=?",ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
			ps.setString(2,email.toUpperCase());
			ps.setString(1,Encryption.encrypt(newpassword));
			x = ps.executeUpdate();
			
		}
		catch(Exception e)
		{
			//logger.error("Exception:"+e);
			logger.error(
					"changePassword(String, String) - Error in Password Retrival:"
							+ e.getMessage());
		}
		finally
		{
			if(ps!=null) {
				ps.close();
			}
			if(con!=null) {
				con.close();
			}
		}
		return x;
		
		
	}
}
