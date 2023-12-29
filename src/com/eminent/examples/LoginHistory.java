/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eminent.examples;

import com.eminent.util.LoginDetails;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import pack.eminent.encryption.MakeConnection;
import org.apache.log4j.Logger;

/**
 *
 * @author Tamilvelan
 */
public class LoginHistory {
    static Logger logger = null;
    static {
        logger = Logger.getLogger("UserIssueCount");

    }
    public static void getLoginHistory(String date,int userId){
            Connection connection = null;
            Statement st          = null;
            ResultSet   rs        = null;

         try {
                                logger.info("Passed User Id"+userId);
                                logger.info("Passed date"+date);
				Class.forName("oracle.jdbc.driver.OracleDriver");

                                connection=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE", "eminenttracker", "eminentlabs");

				st=connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
                                rs  =   st.executeQuery("select h.userid,firstname ||' '||lastname as name,to_char(h.loggedon,'dd-Mon-yyyy hh24:mi:ss') as Logon_Time,to_char(h.LOGGEDOUT,'dd-Mon-yyyy hh24:mi:ss') as Logout_Time,browser,loggedon,loggedout from login_history h,users u where to_char(h.loggedon,'dd-Mon-yyyy')='"+date+"' and  h.userid="+userId+" and u.userid=h.userid order by Logon_Time desc");
                                if(rs.next()){
                                    

                                    
                                     logger.info("DB User Id"+rs.getInt(1));
                                     logger.info("DB Name"+rs.getString(2));
                                     logger.info("Logged In"+rs.getString(3));
                                     logger.info("Logged Out"+rs.getString(4));
                                     logger.info("Logged Out"+rs.getTimestamp(6));
                                     logger.info("Logged Out"+rs.getTimestamp(7));
                                     
                                   
                                }

			} catch(Exception e) {
				logger.error("Error while retriving getLoginHistory", e);
			} finally {
                                try {   

                                    if(rs!=null) {
					rs.close();
                                         logger.info("Closing result set DB User Id");
                                    }
                                }catch(Exception ex) {
					logger.error("Error while closing resultset in getLoginHistory", ex);
				}
				try {

				if(st!=null) {
					st.close();
                                        logger.info("Closing statement DB User Id");
				}
                            }catch(Exception ex) {
					logger.error("Error while closing statment in getLoginHistory", ex);
				}
                                try {
				if(connection!=null) {
					connection.close();
                                        logger.info("Closing Connection DB User Id");
				}
				} catch(Exception ex) {
					logger.error("Error while closing connection", ex);
				}
			}

        }
    public static void main(String args[]){
        getLoginHistory("28-Aug-2012",501);
    }
    
}
