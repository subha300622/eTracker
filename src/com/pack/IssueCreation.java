package com.pack;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import org.apache.log4j.Logger;
import org.apache.log4j.PropertyConfigurator;

public class IssueCreation 
{
	static Logger logger = Logger.getLogger("AdminBean");
	Connection connection;
	ResultSet rs;
	
	PreparedStatement ps;
	
	public IssueCreation(Connection con)
	{
		connection = con;
		PropertyConfigurator.configure("log4j.properties");
		logger.info("Connection in IssueCreation Constructor:"+connection);
	}
	
	public ResultSet getCategory() throws SQLException
	{
		ps = connection.prepareStatement("SELECT CATEGORY  FROM PROJECT GROUP BY CATEGORY");
		rs = ps.executeQuery();
		return rs;
	}
	public ResultSet getProducts(String category) throws SQLException
	{
		ps = connection.prepareStatement("SELECT distinct PNAME FROM PROJECT where category=? ORDER BY PNAME ASC");
		ps.setString(1,category);
		rs = ps.executeQuery();
		return rs;
	}
	public ResultSet getCustomer(String category,String product) throws SQLException
	{
		ps = connection.prepareStatement("SELECT CUSTOMER FROM PROJECT WHERE CATEGORY=? AND PNAME=? GROUP BY CUSTOMER");
		ps.setString(1,category);
		ps.setString(2,product);
		rs = ps.executeQuery();
		return rs;
	}
	
	public ResultSet getVersion(String category,String product,String customer) throws SQLException
	{
		ps = connection.prepareStatement("SELECT VERSION  FROM PROJECT WHERE CATEGORY=? and PNAME=? and CUSTOMER=? ORDER BY VERSION");
		ps.setString(1,category);
		ps.setString(2,product);
		ps.setString(3,customer);
		rs = ps.executeQuery();
		return rs;
	}
	public ResultSet getModules(String category,String product,String customer) throws SQLException
	{
		ps = connection.prepareStatement("SELECT MODULES.MODULE FROM MODULES,PROJECT WHERE CUSTOMER=? and PNAME=? and version=? and modules.pid=project.pid GROUP BY Modules.MODULE");
		ps.setString(1,customer);
		ps.setString(2,product);
		ps.setString(3,category);
		
		rs = ps.executeQuery();
		return rs;
	}

	public ResultSet getPlatform(String category,String product,String customer,String version,String module) throws SQLException
	{
		ps = connection.prepareStatement("SELECT PLATFORM FROM PROJECT WHERE CATEGORY=? and PNAME=? and CUSTOMER=? and version=? and module=? GROUP BY PLATFORM");
		ps.setString(1,category);
		ps.setString(2,product);
		ps.setString(3,customer);
		ps.setString(4,version);
		ps.setString(5,module);
		
		rs = ps.executeQuery();
		return rs;
	}	
	
	
}
