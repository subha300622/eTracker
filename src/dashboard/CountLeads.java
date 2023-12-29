package dashboard;
import java.sql.*;
import org.apache.log4j.Logger;

import pack.eminent.encryption.MakeConnection;

public class CountLeads {
    static Logger logger = Logger.getLogger("MOMMaxIssues");
	public static int getCount(String rating,String leadstatus){  
	    ResultSet rs = null;
	    Connection conn = null;
	    Statement stmt = null;
	    int total = 0;
	    
	   
//	    System.out.println("rating"+rating);
//	    System.out.println("status"+leadstatus);
	    
	 
	    
	    try {
	      conn         = MakeConnection.getConnection();
	      String query = "select count(*) as total from lead where upper(rating) = upper('"+rating+"') and lower(leadstatus)=lower('"+leadstatus+"')and roleid=2";
	      stmt        = conn.createStatement();
	      
	            rs           = stmt.executeQuery(query);
	            
	        
	        if (rs.next()) {
	                
	                total = rs.getInt("total");
	                
	        } else {
	                
	                total = 0;
	            
	        }
	    } catch (Exception e) {
	      logger.error(e.getMessage());
	    } finally {
	    
	      try {
	        rs.close();
	        stmt.close();
	        conn.close();
	      } catch (SQLException e) {
	        logger.error(e.getMessage());
	      }
	    }
//	    System.out.println("Lead count total"+total);
	    return total;
	  } 
	public static int getStatus(String status){  
	    ResultSet rs = null;
	    Connection conn = null;
	    Statement stmt = null;
	    int total = 0;
	    
	   
	    
	    
	 
	    
	    try {
	      conn         = MakeConnection.getConnection();
	      String query = "select count(*) as total from lead where lower(leadstatus) = lower('"+status+"')and roleid=2";
	      stmt        = conn.createStatement();
	      
	            rs           = stmt.executeQuery(query);
	            
	        
	        if (rs.next()) {
	                
	                total = rs.getInt("total");
	                
	        } else {
	                
	                total = 0;
	            
	        }
	    } catch (Exception e) {
	      logger.error(e.getMessage());
	    } finally {
	    
	      try {
	        rs.close();
	        stmt.close();
	        conn.close();
	      } catch (SQLException e) {
	        logger.error(e.getMessage());
	      }
	    }
//	    System.out.println("Lead Status total"+total);
	    return total;
	  } 
	    

}
