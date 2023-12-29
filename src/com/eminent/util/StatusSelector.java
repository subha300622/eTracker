/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eminent.util;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.*;
import pack.eminent.encryption.MakeConnection;
import org.apache.log4j.Logger;

/**
 *
 * @author Balaguru Ramasamy
 */
public class StatusSelector {

    static Logger logger = null;

    static {
        logger = Logger.getLogger("StatusSelector");

    }

    public static ArrayList<String> getStatusList(String status) {

        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        String name = null;
        ArrayList<String> statusList = new ArrayList<String>();

        try {
            connection = MakeConnection.getConnection();
            statement = connection.createStatement();
            resultset = statement.executeQuery("select status from status_master where status_id in (select s.status from status_master m, status_sub s where m.status = '" + status + "' and m.status_id = s.status_id ) order by upper(status) asc");
            while (resultset.next()) {
                name = resultset.getString("status");
                statusList.add(name);

            }
        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            try {

                if (resultset != null) {
                    resultset.close();
                }
                if (statement != null) {
                    statement.close();
                }
                if (connection != null) {
                    connection.close();
                }
            } catch (Exception e) {
                logger.error(e.getMessage());
            }
        }

        return statusList;

    }

    public static ArrayList<String> getSapStatusList(String type, String status) {

        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        String name = null;
        if (type.equalsIgnoreCase("Upgradation")) {
            type = "UPGRADE";
        } else if (type.equalsIgnoreCase("Implementation")) {
            type = "IMPLEM";
        }

        String dbMasterTable = "SAP_" + type + "_STATUS_MASTER";
        String dbChildTable = "SAP_" + type + "_STATUS_SUB";
        ArrayList<String> statusList = new ArrayList<String>();

        try {
            connection = MakeConnection.getConnection();
            statement = connection.createStatement();
            resultset = statement.executeQuery("select status from " + dbMasterTable + " where status_id in (select s.status from " + dbMasterTable + " m, " + dbChildTable + " s where m.status = '" + status + "' and m.status_id = s.status_id ) order by upper(status) asc");
            while (resultset.next()) {
                name = resultset.getString("status");
                statusList.add(name);

            }
        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            try {

                if (resultset != null) {
                    resultset.close();
                }
                if (statement != null) {
                    statement.close();
                }
                if (connection != null) {
                    connection.close();
                }
            } catch (Exception e) {
                logger.error(e.getMessage());
            }
        }

        return statusList;

    }

    public static String getStatus(String issueId) {

        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        String status = null;

        try {
            connection = MakeConnection.getConnection();
            statement = connection.createStatement();
            resultset = statement.executeQuery("select status from issuestatus where issueid='" + issueId + "'");
            while (resultset.next()) {
                status = resultset.getString("status");

            }
        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            try {

                if (resultset != null) {
                    resultset.close();
                }
                if (statement != null) {
                    statement.close();
                }
                if (connection != null) {
                    connection.close();
                }
            } catch (Exception ex) {
                logger.error("Error while getting the status list" + ex.getMessage());
            }
        }

        return status;

    }

    public static String getResourceRequestStatus(String requestId) {

        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        String status = null;

        try {
            connection = MakeConnection.getConnection();
            statement = connection.createStatement();
            resultset = statement.executeQuery("select status from resourcerequest where requestid='" + requestId + "'");
            while (resultset.next()) {
                status = resultset.getString("status");

            }
        } catch (Exception e) {
            logger.error("Error while getting the status list" + e.getMessage());
        } finally {
            try {

                if (resultset != null) {
                    resultset.close();
                }
                if (statement != null) {
                    statement.close();
                }
                if (connection != null) {
                    connection.close();
                }
            } catch (Exception ex) {
                logger.error("Error while getting the status list" + ex.getMessage());
            }
        }

        return status;

    }
}
