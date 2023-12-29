package com.eminent.util;
import java.sql.Connection;
import pack.eminent.encryption.MakeConnection;
import java.sql.ResultSet;
import java.sql.Statement;
import org.apache.log4j.Logger;

public class OpportunityFinder {
	 static Logger logger = null;
	    static {
	        logger = Logger.getLogger("OpportunityFinder");
		
	    }
	    public  static String isAccountExist(String account) {
			

			
			
			Connection connection = null;
			Statement statement   = null;
			ResultSet          rs = null;
			String available      = "no";
	                
	                
		
				
				try {
					connection = MakeConnection.getConnection();
					statement  = connection.createStatement();
	                                //Checking whether the module is available in the project or not
					rs  = statement.executeQuery("select  accountname from account where upper(accountname)=upper('"+account+"')");
					
	                                        if(rs.next()) {
	                                            available = "yes";
	                                            
	                                        }
									
				
					
				} catch(Exception e) {
					logger.error("Error while checking the account"+e.getMessage());
				} finally {
					try {
					if(rs!=null) {
						rs.close();
					}
	                                if(statement!=null) {
						statement.close();
					}
					
					if(connection!=null) {
						connection.close();
					}
					} catch(Exception ex) {
						logger.error("Error while finding the account"+ ex.getMessage());
					}
				}
			
		
			return available;
			
		}
public  static String isOpportunityExist(String opportunity) {
			

			
			
			Connection connection = null;
			Statement statement   = null;
			ResultSet          rs = null;
			String available      = "no";
	                
	                
		
				
				try {
					connection = MakeConnection.getConnection();
					statement  = connection.createStatement();
	                                //Checking whether the module is available in the project or not
					rs  = statement.executeQuery("select  opportunityname from opportunity where upper(opportunityname)=upper('"+opportunity+"')");
					
	                                        if(rs.next()) {
	                                            available = "yes";
	                                            
	                                        }
									
				
					
				} catch(Exception e) {
					logger.error("Error while checking the Opportunity"+ e.getMessage());
				} finally {
					try {
					if(rs!=null) {
						rs.close();
					}
	                                if(statement!=null) {
						statement.close();
					}
					
					if(connection!=null) {
						connection.close();
					}
					} catch(Exception ex) {
						logger.error("Error while finding the Opportunity"+ ex.getMessage());
					}
				}
			
		
			return available;
			
		}
        public  static String isLeadExist(String contact) {

			Connection connection = null;
			Statement statement   = null;
			ResultSet          rs = null;
			String available      = "no";




				try {
					connection = MakeConnection.getConnection();
					statement  = connection.createStatement();
	                                //Checking whether the contact is available in the lead or not
					rs  = statement.executeQuery("select  email from lead where upper(email)=upper('"+contact+"')");

	                                        if(rs.next()) {
	                                            available = "yes";

	                                        }



				} catch(Exception e) {
					logger.error("Error while checking the lead"+ e.getMessage());
				} finally {
					try {
					if(rs!=null) {
						rs.close();
					}
	                                if(statement!=null) {
						statement.close();
					}

					if(connection!=null) {
						connection.close();
					}
					} catch(Exception ex) {
						logger.error("Error while finding the lead"+ ex.getMessage());
					}
				}


			return available;

		}

}
