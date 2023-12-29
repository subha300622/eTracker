package com.pack;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import org.apache.log4j.Logger;

import pack.eminent.encryption.Encryption;


public class UserUpdateBean
{
	
	static Logger logger = Logger.getLogger("UserUpdateBean");
	Connection con;
	PreparedStatement ps;
	ResultSet rs;
	Encryption encryption = new Encryption();
	
	
	String firstName;
	String lastName;
	String company;
	String userEmail;
	String secret;
	String answer;
	String phone,phone1,phone2;
	String mobile,mobile1;
	private String operator=null;
	public String getFirstName()
	{
		return firstName;
	}
	
	public void setFirstName(String firstName)  
	{
		if(firstName != null) {
			this.firstName = firstName;
		}		
	}
	
	public String getLastName()  
	{
		return lastName;
	}

	public void setLastName(String lastName)  
	{
		if(lastName != null) {
			this.lastName = lastName;
		}		
	}
	
	public String getUserEmail()  
	{
		return userEmail;
	}

	public void setUserEmail(String userEmail)  
	{
		if(userEmail != null) {
			this.userEmail = userEmail;
		}		
	}
	
	public String getCompany()  
	{
		return company;
	}

	public void setCompany(String company)  
	{
		if(company != null) {
			this.company = company;
		}		
	}
	public String getSecret()  
	{
		return secret;
	}

	public void setSecret(String secret)  
	{
		if(secret != null) {
			this.secret = secret;
		}		
	}
	public String getAnswer()  
	{
		return answer;
	}

	public void setAnswer(String answer)  
	{
		if(answer != null) {
			this.answer = answer;
		}		
	}
	

	public String getPhone()  
	{
		return phone;
	}

	public void setPhone(String phone)  
	{
		if(phone != null) {
			this.phone = phone;
		}		
	}
	public String getPhone1()  
	{
		return phone1;
	}
	
	public void setPhone1(String phone1)  
	{
		if(phone1 != null) {
			this.phone1 = phone1;
		}		
	}
	public String getPhone2()  
	{
		return phone2;
	}

	public void setPhone2(String phone2)  
	{
		if(phone2 != null) {
			this.phone2 = phone2;
		}		
	}

	public String getMobile()  
	{
		return mobile;
	}

	public void setMobile(String mobile)  
	{
		if(mobile != null) {
			this.mobile = mobile;
		}		
	}
	public String getMobile1()  
	{
		return mobile1;
	}

	public void setMobile1(String mobile1)  
	{
		if(mobile1 != null) {
			this.mobile1 = mobile1;
		}		
	}
        public String getOperator()  
	{
		return operator;
	}

	public void setOperator(String operator)  
	{
		if(operator != null) {
			this.operator = operator;
		}
	}

	
	
	

	public String Query(Connection connection,String name) throws SQLException
	{
		String password = null;
		
		try
		{
			ps = connection.prepareStatement("select password from users where email=?");
			ps.setString(1,StringUtil.fixSqlFieldValue(name));
			rs = ps.executeQuery();
		
			if(rs.next())
			{
				password = rs.getString("password"); 
			}
			else
			{
				password = "nothing to be fetch";
			}
		}
		catch(Exception e)
		{
			logger.error("Exception:"+e.getMessage());
		}
		finally
		{
			if(rs!=null) {
				rs.close();
			}
			if(ps!=null) {
				ps.close();
			}
		}
		return password;
	}
	
	public int updateUser(Connection connection) throws SQLException
	{
		phone="+"+phone+"-"+phone1+"-"+phone2;
        mobile="+"+mobile+"-"+mobile1;
        int x=0;
		if (logger.isDebugEnabled()) {
			logger.debug("updateUser(Connection) - Operator" + operator);
		}
      
        
        try
		{
			ps = connection.prepareStatement("update users set firstname=?,lastname=?,company=?,mobile=?,phone=?,secret=?,answer=?,mobileoperator=? where email=?");
			ps.setString(1,StringUtil.fixSqlFieldValue(firstName));
			ps.setString(2,StringUtil.fixSqlFieldValue(lastName));
			ps.setString(3,StringUtil.fixSqlFieldValue(company));
			ps.setString(4,mobile);
			ps.setString(5,phone);
			ps.setString(6,StringUtil.fixSqlFieldValue(secret));
			ps.setString(7,StringUtil.fixSqlFieldValue(answer));
			
                        ps.setString(8,operator);
                        
                        ps.setString(9,StringUtil.fixSqlFieldValue(userEmail));	

			if (logger.isDebugEnabled()) {
				logger.debug("updateUser(Connection) - Operator" + operator);
			}
			x = ps.executeUpdate();
                       
		}
		catch(Exception e)
		{
			logger.error("updateUser(Connection)"+e.getMessage());
		}
		finally
		{
			if(ps!=null) {
				ps.close();
			}
		}
		return x;
	}
}