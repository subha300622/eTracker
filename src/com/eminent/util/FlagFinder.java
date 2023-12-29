/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package com.eminent.util;

import java.sql.Connection;
import pack.eminent.encryption.MakeConnection;
import java.sql.ResultSet;
import java.sql.PreparedStatement;
import org.apache.log4j.Logger;

/**
 *
 * @author Balaguru Ramasamy
 */
public class FlagFinder {
    
    static Logger logger = null;
    static {
        logger = Logger.getLogger("FlagFinder");
	
    }
	public  static boolean isDescription(String queryId ) {
		

		
		
		Connection connection = null;
		PreparedStatement ps  = null;
		ResultSet rs          = null;
                boolean flag          = false;
                
	
			
			try {
				connection = MakeConnection.getConnection();
				ps = connection.prepareStatement("Select name from myquery where query_id='"+queryId+"' and createdon < to_date('31-jul-2008')");
                                rs = ps.executeQuery();
				if(!rs.next()) {
                                    flag = true;
								
				} 
				
			} catch(Exception e) {
				logger.error("Error while finding the flag"+ e.getMessage());
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
					logger.error("Error while finding the flag"+ ex.getMessage());
				}
			}
		
	
		return flag;
		
	}
    

}
