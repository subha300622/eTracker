/**
 * 
 */
package com.pack;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;

/**
 * @author gabriel
 *
 */
public class LoginValidateBean 
{
	
	
	ResultSet resultSet,resultset1;
	Statement statement,statement1;
	private String username = "";
	private String password = "";
	public LoginValidateBean(){
		
	}
	
	public String getUsername()  {
		return username;
	}
	/* (non-Javadoc)
	 * @see com.pack.EtrackerBean#setFirstName(java.lang.String)
	 */
	public void setUsername(String username)  {
		if(username != null) {
			this.username = username;
		}		
	}
	
	/* (non-Javadoc)
	 * @see com.pack.EtrackerBean#getLastName()
	 */
	public String getPassword()  {
		return password;
	}
	/* (non-Javadoc)
	 * @see com.pack.EtrackerBean#setLastName(java.lang.String)
	 */
	public void setPassword(String password)  {
		if(password != null) {
			this.password = password;
		}		
	}
	public ResultSet Query(Connection connection)throws Exception
	{
		statement1 = connection.createStatement();
		resultset1 = statement1.executeQuery("SELECT email,password,roleid FROM USERS");
		return resultset1;
	}

}
