/*
 * SubPhaseCount.java
 *
 * Created on January 25, 2008, 3:39 PM
 *
 * To change this template, choose Tools | Template Manager
 * and open the template in the editor.
 */
package dashboard;

import java.sql.*;
import java.util.*;
import org.apache.log4j.Logger;
import pack.eminent.encryption.MakeConnection;

/**
 *
 * @author Balaguru Ramasamy
 */
public class ProjectPhase {

    static Logger logger = Logger.getLogger("ProjectPhase");

    /**
     * Creates a new instance of SubPhaseCount
     */
    public ProjectPhase() {
    }

    public static ArrayList<String> getSubPhases(String projectType, String phase) {
        ResultSet rs = null;
        Connection conn = null;
        Statement stmt = null;
        ArrayList<String> subPhase = new ArrayList<String>();
        projectType = "Project_" + projectType;

 //   System.out.println("project type"+projectType);
        //   System.out.println("phase"+phase);
        try {
            conn = MakeConnection.getConnection();
            stmt = conn.createStatement();
            String query = "select distinct subphase,subphaseindex from " + projectType + " where phase = '" + phase + "' order by subphaseindex";

            //       System.out.println("query   "+query);
            rs = stmt.executeQuery(query);

            if (rs.next()) {

                do {
                    subPhase.add(rs.getString("subphase"));
                } while (rs.next());

            } else {

                subPhase.add("Contact Administrator");

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

        return subPhase;
    }

    public static int getMaxCount(String projectVersion, String projectType, String phase) {

        ResultSet rs = null;
        Connection conn = null;
        Statement stmt = null;
        int max = 0;

        projectType = "issue_" + projectType;

        int index = projectVersion.lastIndexOf(":");

        String project = projectVersion.substring(0, index);
        String version = projectVersion.substring((index + 1));

        try {
            conn = MakeConnection.getConnection();
            String query = "select count(subphase) as most,subphase from " + projectType + ",issue i, issuestatus s, project p where i.pid = p.pid and pname = '" + project + "' and version = '" + version + "' and  i.issueid= " + projectType + ".issueid and " + projectType + ".phase = '" + phase + "' and i.issueid = s.issueid and s.status != 'Closed' group by subphase order by most desc";
            stmt = conn.createStatement();
            //     System.out.println("query   "+query);
            rs = stmt.executeQuery(query);

            if (rs.next()) {
                max = rs.getInt("most");
            } else {
                max = 0;
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
        //      System.out.println("max"+max);
        return max;
    }

    public static int getSubPhaseIssueCount(String projectVersion, String projectType, String phase, String subPhase, String priority) {
        ResultSet rs = null;
        Connection conn = null;
        Statement stmt = null;
        int total = 0;

        projectType = "issue_" + projectType;

        int index = projectVersion.lastIndexOf(":");

        String project = projectVersion.substring(0, index);
        String version = projectVersion.substring((index + 1));

        try {
            conn = MakeConnection.getConnection();
            String query = "select count(*) as total from " + projectType + ", issue i, issuestatus s, project p where i.pid = p.pid and pname = '" + project + "' and version = '" + version + "' and priority = '" + priority + "' and  i.issueid= " + projectType + ".issueid and " + projectType + ".phase = '" + phase + "'and " + projectType + ".subphase = '" + subPhase + "' and i.issueid = s.issueid and s.status != 'Closed'";
            stmt = conn.createStatement();

            rs = stmt.executeQuery(query);

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

        return total;
    }

}
