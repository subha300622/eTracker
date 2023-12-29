/*
 * FinishProject.java
 *
 * Created on March 24, 2008, 3:13 PM
 *
 * To change this template, choose Tools | Template Manager
 * and open the template in the editor.
 */
package com.pack;

import java.sql.*;
import org.apache.log4j.Logger;
//import java.util.*;
import pack.eminent.encryption.MakeConnection;

/**
 *
 * @author Balaguru Ramasamy
 */
public class FinishProject {

    static Logger logger = Logger.getLogger("FinishProject");

    /**
     * Creates a new instance of FinishProject
     */
    public FinishProject() {
    }

    public static String getProject() {
        ResultSet rs = null;
        Connection conn = null;
        Statement stmt = null;
        String projectVersion = null;
        try {
            conn = MakeConnection.getConnection();
            String query = "select pname,version from project where status!='Finished' order by enddate asc";
            stmt = conn.createStatement();

            rs = stmt.executeQuery(query);

            if (rs.next()) {

                String project = rs.getString("pname");
                String version = rs.getString("version");
                projectVersion = project + ":" + version;

            } else {

                projectVersion = null;

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

        return projectVersion;
    }

}
