package com.eminent.util;

import com.pack.*;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import org.apache.log4j.Logger;

public class UpdateValue {
     static Logger logger = null;
    static {
        logger = Logger.getLogger("UpdateValue");

    }
	
	public static void updateUserValue(Connection connection,int userID){
        PreparedStatement ps=null;
		try{
            if(connection!=null){
			ps=connection.prepareStatement("update users set value=? where userid=?");
			ps.setInt(1,CalculateIssueValue.CreateValue(userID));
			ps.setInt(2, userID);
			ps.executeUpdate();
            }
		}
		catch(SQLException e){
			logger.error(e.getMessage());
		}
        finally{
            if(ps!=null){
                try{
                ps.close();
                }
                catch(SQLException e){
                 logger.error(e.getMessage());
                }
            }
        }
		
	}

}
