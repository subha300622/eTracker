/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package com.eminent.util;

import pack.eminent.encryption.MakeConnection;
import java.util.ArrayList;
import java.sql.Connection;
import org.apache.log4j.Logger;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
/**
 *
 * @author Tamilvelan
 */
public class UpdateUserProject {

     static Logger logger = null;
    static {
        logger = Logger.getLogger("ProjectFinder");

    }
    
    public static void UpdateUsers(String pid, String uid) {


	
        Connection connection = null;
		PreparedStatement pt = null;
	
		try {
			connection = MakeConnection.getConnection();
            pt = connection.prepareStatement("insert into userproject(pid,userid) values(?,?)");
            pt.setString(1, pid);
            pt.setString(2, uid);
            pt.execute();
			

			

		}
		catch(Exception Ex)
		{
			logger.error("Exception in Update User Project Method:"+Ex.getMessage());
		}
		finally
		{
			try {
				
                                if(pt!=null) {
					pt.close();
				}

				if(connection!=null) {
					connection.close();
				}
				} catch(Exception ex) {
					logger.error("Exception in Update User Project Method"+ex.getMessage());
				}
		}


	}
    public static String UpdateAlerts(String[] activeAlerts,int userId){
        Connection connection=null;
        PreparedStatement  statement=null, activateAlert    =   null;
        String message  =   "false";

        try{
                ArrayList<String> projects  =   GetProjects.userEmailAlers(userId);

                if(activeAlerts!=null){
                    for(int i=0;i<activeAlerts.length;i++){
                        projects.remove(activeAlerts[i]);

                    }
                }
                connection=MakeConnection.getConnection();
            	statement=connection.prepareStatement("update apm_projectalerts set alert='No' where project=? and manager=?");
                for(int i=0;i<projects.size();i++){

                    statement.setInt(2, userId);
                    statement.setString(1,projects.get(i) );
                    statement.addBatch();
                }
                int x[] =   statement.executeBatch();

                if(activeAlerts!=null){
                    activateAlert=connection.prepareStatement("update apm_projectalerts set alert='Yes' where project=? and manager=?");
                    for(int i=0;i<activeAlerts.length;i++){

                        activateAlert.setInt(2, userId);
                        activateAlert.setString(1,activeAlerts[i] );
                        activateAlert.addBatch();
                    }
                    activateAlert.executeBatch();
                }
                message = "true";

        }
        catch(Exception e){
            logger.error(e.getMessage());
        }
        finally{
            try {
                if(statement!=null) {
                        statement.close();
                }
            } catch(Exception ex) {
                    logger.error("Exception in Update User Project Method"+ex.getMessage());
            }
            try {
                if(activateAlert!=null) {
                        activateAlert.close();
                }
            } catch(Exception ex) {
                    logger.error("Exception in Update User Project Method"+ ex.getMessage());
            }
            try {
                if(connection!=null) {
                        connection.close();
                }
            } catch(Exception ex) {
                    logger.error("Exception in Update User Project Method"+ex.getMessage());
            }
        }
        return  message;
    }

    public static String isAlertActive(String pid, String uid) {



        Connection connection = null;
	PreparedStatement pt = null;
        ResultSet         rs =  null;
        String          alert=  "No";
		try {
			connection = MakeConnection.getConnection();
                        pt = connection.prepareStatement("select alert from apm_projectalerts where project='"+pid+"' and manager='"+uid+"'");
                        rs   = pt.executeQuery();
                        while(rs.next()){
                            alert   =   rs.getString("alert");
                        }



		}
		catch(Exception Ex)
		{
			logger.error("Exception in Update User Project Method:"+Ex.getMessage());
		}
		finally
		{
			try {
                                if(rs!=null) {
                                    rs.close();
				}
                                if(pt!=null) {
					pt.close();
				}

				if(connection!=null) {
					connection.close();
				}
				} catch(Exception ex) {
					logger.error("Exception in Update User Project Method"+ ex.getMessage());
				}
		}
                return alert;

	}
}
