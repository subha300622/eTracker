/*
 * IssueCheck.java
 *
 * Created on February 22, 2007, 10:21 AM
 *
 * To change this template, choose Tools | Template Manager
 * and open the template in the editor.
 */

package com.pack;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;

import org.apache.log4j.Level;
import org.apache.log4j.Logger;

import pack.eminent.encryption.MakeConnection;

/**
 *
 * @author ttamilvelan
 */
public class IssueCheck {
	
	 static Logger logger = Logger.getLogger("ChangeFormat");
	    /** Creates a new instance of IssueCheck */
	    public IssueCheck() {
	    	logger.setLevel(Level.DEBUG);
	    }
    
   
    public static void main(String args[]) throws Exception
    {
        
        Connection connection=MakeConnection.getConnection();
        Statement st=connection.createStatement();
        ResultSet rs=st.executeQuery("select * from project");
        rs.next();
        String pname=rs.getString("pname");
        logger.info("Project Name Length"+pname.length());
        logger.info("Project Name Length After trim");
        
    }
}
