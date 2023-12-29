package com.eminent.resource;

import java.sql.Connection;
import pack.eminent.encryption.MakeConnection;
import java.sql.ResultSet;
import java.sql.PreparedStatement;
import org.apache.log4j.Logger;
import java.sql.SQLException;
/**
 *
 * @author Balaguru Ramasamy
 */
public class ResourceCheck {

    
    static Logger logger = null;
    static {
        logger = Logger.getLogger("ResourceCheck");
	
    }
	public  static int getResourceId(String reqId ) {
		

		
		
		Connection connection = null;
		PreparedStatement ps  = null;
		ResultSet rs          = null;
                int apId              = 0;
                
	
			
			try {
				connection = MakeConnection.getSAPConnection();
				ps = connection.prepareStatement("Select apid from yapn where reqid = '"+ reqId +"' ");
                                rs = ps.executeQuery();
				if(rs.next()) {
                                    apId = rs.getInt("apid");
								
				} 
				
			} catch(Exception e) {
				logger.error("Error while finding the locked Resource"+ e.getMessage());
			} finally {
				try {
				
				if(rs!=null) {
					rs.close();
				}
                if(ps!=null) {
					ps.close();
				}
				if(connection!=null) {
					connection.close();
				}
				} catch(Exception ex) {
					logger.error("Error while finding the locked Resource"+ ex.getMessage());
				}
			}
		
	
		return apId;
		
	}
        
        public  static void lockResource(String reqId, int lock, int lockedResource, int userId, String status ) {
		

		
		
		Connection connection = null;
		PreparedStatement ps  = null, preSt = null, psForUpdate = null, psForSuccess = null;
		ResultSet rs          = null;
                
                
	
			
			try {
				connection = MakeConnection.getSAPConnection();
                                
                                if(status.equalsIgnoreCase("In Process") || status.equalsIgnoreCase("Confirmed") || status.equalsIgnoreCase("Sourcing")) {
                                    ps = connection.prepareStatement("update yapn set reqid = '"+ reqId +"', follower = "+ userId +" where apid = '"+ lock +"' ");
                                    ps.execute();
                                 
                                    if ( lockedResource != 0) {
                                    connection.setAutoCommit(false);
                                    
                                    psForUpdate = connection.prepareStatement("update yapn set reqid = null, follower = null where apid = '"+ lockedResource +"' ");
                                    psForUpdate.execute();
                                    
                                    status = "R";
                                    preSt = connection.prepareStatement("insert into yrr_history(apid, reqid, follower, sel_status) values ( ?, ?, ?, ?)");
                                    preSt.setInt(1,lockedResource);
                                    preSt.setString(2,reqId);
                                    preSt.setInt(3,userId);
                                    preSt.setString(4,status);
                                    preSt.execute();
                                    
                                    connection.commit();
                                    connection.setAutoCommit(true);
                                }
                                } else if(status.equalsIgnoreCase("Fulfilled")){
                                    ps = connection.prepareStatement("update yapn set sel_status = 'S' where apid = '"+ lock +"' ");
                                    ps.execute();
                                    
                                    status = "S";
                                    psForSuccess = connection.prepareStatement("insert into yrr_history(apid, reqid, follower, sel_status) values ( ?, ?, ?, ?)");
                                    psForSuccess.setInt(1,lock);
                                    psForSuccess.setString(2,reqId);
                                    psForSuccess.setInt(3,userId);
                                    psForSuccess.setString(4,status);
                                    psForSuccess.execute();
                                    
                                    if ( lockedResource != 0) {
                                    connection.setAutoCommit(false);
                                    
                                    psForUpdate = connection.prepareStatement("update yapn set reqid = null, follower = null where apid = '"+ lockedResource +"' ");
                                    psForUpdate.execute();
                                    
                                    status = "R";
                                    preSt = connection.prepareStatement("insert into yrr_history(apid, reqid, follower, sel_status) values ( ?, ?, ?, ?)");
                                    preSt.setInt(1,lockedResource);
                                    preSt.setString(2,reqId);
                                    preSt.setInt(3,userId);
                                    preSt.setString(4,status);
                                    preSt.execute();
                                    
                                    connection.commit();
                                    connection.setAutoCommit(true);
                                }
                                }
				
				
			} catch(Exception e) {
                                try{
                                    if(connection != null){
                                        connection.rollback();
                                    }
                                } catch(SQLException ex){
                                    logger.error("Exception:"+ex.getMessage());
                                }
                                
				logger.error("Error while locking the Resource"+e.getMessage());
			} finally {
				try {

                if(rs!=null) {
					rs.close();
				}
				if(ps!=null) {
					ps.close();
				}
                                if(psForUpdate!=null) {
					psForUpdate.close();
				}
                                if(preSt!=null) {
					preSt.close();
				}
                                if(psForSuccess!=null) {
					psForSuccess.close();
				}
				
				if(connection!=null) {
					connection.close();
				}
				} catch(Exception ex) {
					logger.error("Error while locking the Resource"+ ex.getMessage());
				}
			}
		
	
		
		
	}
        
        
        public  static void doUpdateSelected(String reqId, int lock, int userId ) {
		

		
		
		Connection connection = null;
		PreparedStatement ps  = null, psForSuccess = null;
		ResultSet rs          = null;
                
                
	
			
			try {
				connection = MakeConnection.getSAPConnection();
                                
                                
                                    ps = connection.prepareStatement("update yapn set sel_status = 'S' where apid = '"+ lock +"' ");
                                    ps.execute();
                                    
                                    String status = "S";
                                    psForSuccess = connection.prepareStatement("insert into yrr_history(apid, reqid, follower, sel_status) values ( ?, ?, ?, ?)");
                                    psForSuccess.setInt(1,lock);
                                    psForSuccess.setString(2,reqId);
                                    psForSuccess.setInt(3,userId);
                                    psForSuccess.setString(4,status);
                                    psForSuccess.execute();
                                    
                                                                        
                                    connection.commit();
                                    connection.setAutoCommit(true);
                                
                                
				
				
			} catch(Exception e) {
                                try{
                                    if(connection != null){
                                        connection.rollback();
                                    }
                                } catch(SQLException ex){
                                    logger.error("Exception:"+ ex.getMessage());
                                }
                                
				logger.error("Error while updating the Resource"+ e.getMessage());
			} finally {
				try {

                    if(rs!=null) {
					rs.close();
				}
                    if(ps!=null) {
					ps.close();
				}
                                if(psForSuccess!=null) {
					psForSuccess.close();
				}
				
				if(connection!=null) {
					connection.close();
				}
				} catch(Exception ex) {
					logger.error("Error while updating the Resource"+ ex.getMessage());
				}
			}
		
	
		
		
	}
    
}
