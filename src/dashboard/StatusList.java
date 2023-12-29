/*
 * To change this template, choose Tools | Templates
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
public class StatusList {

    static Logger logger = Logger.getLogger("StatusList");

    public static String getProjecType(String userId) {

        ResultSet rsBoth = null, rSAP = null;
        Connection connection = null;
        PreparedStatement psBoth = null, pSAP = null;
        String projecType = null;

        try {
            connection = MakeConnection.getConnection();

            //Checking whether the user has been assigned for both SAP and Non SAP projects
            String query = "select firstname from users u where userid = ? and userid in "
                    + "(select userid from userproject up, project_type pt where up.pid = pt.pid) "
                    + "and userid in "
                    + "(select userid from userproject up  where pid not in (select pid from project_type))";

            psBoth = connection.prepareStatement(query);
            psBoth.setString(1, userId);
            rsBoth = psBoth.executeQuery();

            if (rsBoth.next()) {
                projecType = "both";
            } else {

                ////Checking whether the user has been assigned for SAP Projects
                query = "select firstname from users u where userid = ? and userid in "
                        + "(select userid from userproject up, project_type pt where up.pid = pt.pid) ";

                pSAP = connection.prepareStatement(query);
                pSAP.setString(1, userId);
                rSAP = pSAP.executeQuery();

                if (rSAP.next()) {
                    projecType = "SAP";
                } else {
                    projecType = "nonSAP";
                }
            }
        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            try {
                if (rsBoth != null) {
                    rsBoth.close();
                }
                if (psBoth != null) {
                    psBoth.close();
                }
                if (rSAP != null) {
                    rSAP.close();
                }
                if (pSAP != null) {
                    pSAP.close();
                }

                if (connection != null) {
                    connection.close();
                }
            } catch (SQLException e) {
                logger.error(e.getMessage());
            }
        }

        return projecType;

    }

    public static ArrayList<String> getMyDashboardStatusList(String statusLisType) {

        Connection connection = null;
        Statement stmt = null;
        ResultSet rs = null;
        ArrayList<String> status = new ArrayList<String>();
        String tableName = null;

        if (statusLisType.equalsIgnoreCase("both")) {
            tableName = "SAP_NONSAP_STATUS_LIST";
        } else if (statusLisType.equalsIgnoreCase("nonSAP")) {
            tableName = "STATUS_MASTER";
        } else {
            tableName = "SAP_IMPLEM_STATUS_MASTER";
        }

        try {
            connection = MakeConnection.getConnection();
            String query = "select status from " + tableName + " where status!='Closed' order by status_id asc";

            stmt = connection.createStatement();

            rs = stmt.executeQuery(query);

            if (statusLisType.equalsIgnoreCase("both")) {
                while (rs.next()) {
                    status.add(rs.getString("status"));
                }
            } else if (statusLisType.equalsIgnoreCase("SAP")) {
                while (rs.next()) {
                    if (rs.getString("status").equalsIgnoreCase("Customizing Request")) {
                        status.add("Customizing Requset");
                    } else {
                        status.add(rs.getString("status"));
                    }
                    if (rs.getString("status").equalsIgnoreCase("Detail Design")) {
                        status.add("Replicating in DS");
                    }
                }
            } else {
                while (rs.next()) {
                    if (rs.getString("status").equalsIgnoreCase("Performance Testing")) {
                        status.add("Performance QA");
                    } else {
                        status.add(rs.getString("status"));
                    }
                }
            }

        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (stmt != null) {
                    stmt.close();
                }
                if (connection != null) {
                    connection.close();
                }
            } catch (SQLException e) {
                logger.error(e.getMessage());
            }
        }

        return status;

    }

    public static ArrayList<String> getIssueSummaryStatusList(String statusLisType) {

        Connection connection = null;
        Statement stmt = null;
        ResultSet rs = null;
        ArrayList<String> status = new ArrayList<String>();
        String tableName = null;

        if (statusLisType.equalsIgnoreCase("both")) {
            tableName = "SAP_NONSAP_STATUS_LIST";
        } else if (statusLisType.equalsIgnoreCase("nonSAP")) {
            tableName = "STATUS_MASTER";
        } else {
            tableName = "SAP_IMPLEM_STATUS_MASTER";
        }

        try {
            connection = MakeConnection.getConnection();
            String query = "select status from " + tableName + " order by status asc";

            stmt = connection.createStatement();

            rs = stmt.executeQuery(query);

            if (statusLisType.equalsIgnoreCase("both")) {
                while (rs.next()) {
                    if (rs.getString("status").equalsIgnoreCase("Customizing Req")) {
                        status.add("Customizing Request");
                    } else {
                        status.add(rs.getString("status"));
                    }
                }
            } else if (statusLisType.equalsIgnoreCase("SAP")) {
                while (rs.next()) {
                    status.add(rs.getString("status"));
                    if (rs.getString("status").equalsIgnoreCase("Detail Design")) {
                        status.add("Replicating in DS");
                    }
                }
            } else {
                while (rs.next()) {
                    status.add(rs.getString("status"));
                }
            }

        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (stmt != null) {
                    stmt.close();
                }
                if (connection != null) {
                    connection.close();
                }
            } catch (SQLException e) {
                logger.error(e.getMessage());
            }
        }

        return status;

    }

}
