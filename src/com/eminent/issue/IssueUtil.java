/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package com.eminent.issue;

/**
 *
 * @author Tamilvelan
 */

import java.sql.Connection;
import pack.eminent.encryption.MakeConnection;
import java.sql.ResultSet;
import java.sql.Statement;
import org.apache.log4j.Logger;
public class IssueUtil {
    static Logger logger = null;
    static {
        logger = Logger.getLogger("UserIssueCount");

    }
    	public  static int getAttachedFile(String issueId ) {




		Connection connection = null;
		Statement st          = null;
		ResultSet rs          = null;
                int count             = 0;



			try {
				connection = MakeConnection.getConnection();
				st = connection.createStatement();
                                rs = st.executeQuery("select count(*) count from fileattach where issueId='"+issueId+"'");
				if(rs.next()) {
                                    count = rs.getInt("count");

				}

			} catch(Exception e) {
				logger.error("Error while finding the count", e);
			} finally {
				try {
                if(rs!=null) {
					rs.close();
				}
				if(st!=null) {
					st.close();
				}

				if(connection!=null) {
					connection.close();
				}
				} catch(Exception ex) {
					logger.error("Error while finding the flag", ex);
				}
			}


		return count;

	}


}
