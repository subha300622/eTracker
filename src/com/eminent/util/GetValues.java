/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eminent.util;

import java.util.HashMap;
import java.util.ArrayList;
import java.sql.ResultSet;
import java.sql.Statement;
import java.sql.PreparedStatement;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.logging.Level;
import pack.eminent.encryption.MakeConnection;

import org.apache.log4j.Logger;

/**
 *
 * @author Tamilvelan
 */
public class GetValues {

    static Logger logger = Logger.getLogger("GetValues");

    public static HashMap getStatus() {

        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;

        HashMap status = new HashMap<Integer, String>();
        try {

            connection = MakeConnection.getConnection();
            statement = connection.createStatement();
            resultset = statement.executeQuery("select * from status_master order by status_id asc");

            while (resultset.next()) {
                status.put(resultset.getInt(1), resultset.getString(2));
            }

        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            try {

                if (resultset != null) {
                    resultset.close();
                }
            } catch (SQLException e) {
                logger.error(e.getMessage());
            }
            try {
                if (statement != null) {
                    statement.close();
                }
            } catch (SQLException e) {
                logger.error(e.getMessage());
            }
            try {
                if (connection != null) {
                    connection.close();
                }
            } catch (SQLException e) {
                logger.error(e.getMessage());
            }
        }
        return status;
    }

    public static ArrayList getValue(String table) {
        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;

        logger.info("Table Value" + table);
        ArrayList<String> al = new ArrayList<String>();
        try {
            connection = MakeConnection.getConnection();
            statement = connection.createStatement();

            if (table.equals("bug")) {
                resultset = statement.executeQuery("select * from VALUE_NONSAP_BUG order by status_id asc");
            } else if (table.equals("enhancement")) {
                resultset = statement.executeQuery("select * from VALUE_NONSAP_ENHANCEMENT order by status_id asc");
            } else if (table.equals("newtask")) {
                resultset = statement.executeQuery("select * from VALUE_NONSAP_NEWTASK order by status_id asc");
            } else {
                logger.info("havent got in to the loop");
            }

            while (resultset.next()) {
                logger.info("Adding values in to AL");
                String status = resultset.getString("status_id");

                logger.info("Adding Status" + status);
                String p1s1 = resultset.getString("p1s1");
                String p1s2 = resultset.getString("p1s2");
                String p1s3 = resultset.getString("p1s3");
                String p1s4 = resultset.getString("p1s4");

                String p2s1 = resultset.getString("p2s1");
                String p2s2 = resultset.getString("p2s2");
                String p2s3 = resultset.getString("p2s3");
                String p2s4 = resultset.getString("p2s4");

                String p3s1 = resultset.getString("p3s1");
                String p3s2 = resultset.getString("p3s2");
                String p3s3 = resultset.getString("p3s3");
                String p3s4 = resultset.getString("p3s4");

                String p4s1 = resultset.getString("p4s1");
                String p4s2 = resultset.getString("p4s2");
                String p4s3 = resultset.getString("p4s3");
                String p4s4 = resultset.getString("p4s4");

                al.add(status);

                al.add(p1s1);
                al.add(p1s2);
                al.add(p1s3);
                al.add(p1s4);

                al.add(p2s1);
                al.add(p2s2);
                al.add(p2s3);
                al.add(p2s4);

                al.add(p3s1);
                al.add(p3s2);
                al.add(p3s3);
                al.add(p3s4);

                al.add(p4s1);
                al.add(p4s2);
                al.add(p4s3);
                al.add(p4s4);

            }

        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            try {
                if (resultset != null) {
                    resultset.close();
                }
            } catch (Exception e) {
                logger.error(e.getMessage());
            }
            try {
                if (statement != null) {
                    statement.close();
                }
            } catch (Exception e) {
                logger.error(e.getMessage());
            }
            try {
                if (connection != null) {
                    connection.close();
                }
            } catch (Exception e) {
                logger.error(e.getMessage());
            }
        }

        return al;

    }

    public static HashMap getSPValue(String type, String Sp) {
        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;

        logger.info("Type" + type);
        logger.info("SP" + Sp);
        HashMap<String, Integer> values = new HashMap();
        try {
            connection = MakeConnection.getConnection();
            statement = connection.createStatement();

            if (type.equalsIgnoreCase("bug")) {

                resultset = statement.executeQuery("select s.status," + Sp + " from VALUE_NONSAP_BUG b,status_master s where b.status_id=s.status_id order by s.status_id asc");
            } else if (type.equalsIgnoreCase("enhancement")) {
                resultset = statement.executeQuery("select s.status," + Sp + " from VALUE_NONSAP_ENHANCEMENT b,status_master s where b.status_id=s.status_id order by s.status_id asc");
            } else if (type.equalsIgnoreCase("newtask")) {
                resultset = statement.executeQuery("select s.status," + Sp + " from VALUE_NONSAP_NEWTASK b,status_master s where b.status_id=s.status_id order by s.status_id asc");
            }

            while (resultset.next()) {

                values.put(resultset.getString(1), resultset.getInt(2));

                logger.info("Status :" + resultset.getString(1));
                logger.info("Value :" + resultset.getString(2));

            }

        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            try {
                if (resultset != null) {
                    resultset.close();
                }
            } catch (Exception e) {
                logger.error(e.getMessage());
            }
            try {
                if (statement != null) {
                    statement.close();
                }
            } catch (Exception e) {
                logger.error(e.getMessage());
            }
            try {
                if (connection != null) {
                    connection.close();
                }
            } catch (Exception e) {
                logger.error(e.getMessage());
            }
        }

        return values;

    }

    public static HashMap getPS(String issueId) {

        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;

        HashMap<String, String> PST = new HashMap();

        try {
            connection = MakeConnection.getConnection();
            statement = connection.createStatement();

            resultset = statement.executeQuery("select priority,severity,type from issue where issueid='" + issueId + "'");

            while (resultset.next()) {

                PST.put("priority", resultset.getString("priority"));
                PST.put("severity", resultset.getString("severity"));
                PST.put("type", resultset.getString("type"));
            }

        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            try {
                if (resultset != null) {
                    resultset.close();
                }
            } catch (Exception e) {
                logger.error(e.getMessage());
            }
            try {
                if (statement != null) {
                    statement.close();
                }
            } catch (Exception e) {
                logger.error(e.getMessage());
            }
            try {
                if (connection != null) {
                    connection.close();
                }
            } catch (Exception e) {
                logger.error(e.getMessage());
            }
        }

        return PST;
    }

    public static void UpdateValue(String issueID) {

        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        PreparedStatement prestatement = null;

        HashMap<String, String> PST = new HashMap();

        HashMap<String, Integer> SPValues = new HashMap();

        logger.info("Issue ID" + issueID);

        PST = getPS(issueID);

        String priority = PST.get("priority");
        String severity = PST.get("severity");
        String PS = priority.substring(0, priority.indexOf("-")) + severity.substring(0, severity.indexOf("-"));

        String type = PST.get("type");

        logger.info("PS:" + PS);

        SPValues = getSPValue(type, PS);

        int i = 0;

        try {

            connection = MakeConnection.getConnection();
            statement = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            resultset = statement.executeQuery("select c.commentedby,c.status,c.commentedto from issuecomments c where c.issueid='" + issueID + "'");
            resultset.last();

            int rowcount = resultset.getRow();
            resultset.beforeFirst();
            logger.info("No of Rows" + rowcount);
            String values[] = new String[rowcount * 4];

            while (resultset.next()) {

                values[i++] = resultset.getString(1);
                values[i++] = resultset.getString(2);
                values[i++] = resultset.getString(3);
                values[i++] = SPValues.get(resultset.getString(2)).toString();

            }

            prestatement = connection.prepareStatement("update users set value=value+? where userid=?", ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);

            int j = 3;
            for (int s = 0; s < rowcount; s++, j = j + 4) {
                prestatement.setInt(1, Integer.parseInt(values[j]));
                prestatement.setInt(2, Integer.parseInt(values[j - 3]));
                prestatement.addBatch();
            }
            prestatement.executeBatch();
            /*        int k=0;
             while(k<(rowcount*3)){
             System.out.print(values[k++]);
             System.out.print("\t"+values[k++]);
             System.out.println("\t"+values[k++]);
             }
             */
        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            if (resultset != null) {
                try {
                    resultset.close();
                } catch (SQLException ex) {
                    logger.error(ex.getMessage());
                }
            }
            if (statement != null) {
                try {
                    statement.close();
                } catch (SQLException ex) {
                    logger.error(ex.getMessage());
                }
            }
            if (prestatement != null) {
                try {
                    prestatement.close();
                } catch (SQLException ex) {
                    logger.error(ex.getMessage());
                }
            }
            if (connection != null) {
                try {
                    connection.close();
                } catch (SQLException ex) {
                    logger.error(ex.getMessage());
                }
            }
        }

    }

    public static HashMap checkValue() {

        Connection connection = null;
        PreparedStatement bugPS = null, enhancementPS = null, newTaskPS = null;
        ResultSet bugResultSet = null;
        ResultSet enhancementResultSet = null;
        ResultSet newTaskResultSet = null;

        HashMap hm = new HashMap<String, Integer>();

        int bug = 0;
        int enhancement = 0;
        int newtask = 0;

        try {
            connection = MakeConnection.getConnection();

            bugPS = connection.prepareStatement("select count(*) as total from VALUE_NONSAP_BUG");

            bugResultSet = bugPS.executeQuery();
            if (bugResultSet.next()) {
                bug = bugResultSet.getInt(1);
            }

            enhancementPS = connection.prepareStatement("select count(*) as total from VALUE_NONSAP_ENHANCEMENT");
            enhancementResultSet = enhancementPS.executeQuery();
            if (enhancementResultSet.next()) {
                enhancement = enhancementResultSet.getInt(1);
            }

            newTaskPS = connection.prepareStatement("select count(*) as total from VALUE_NONSAP_NEWTASK");
            newTaskResultSet = newTaskPS.executeQuery();
            if (newTaskResultSet.next()) {
                newtask = newTaskResultSet.getInt(1);
            }

        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            try {
                if (bugResultSet != null) {
                    bugResultSet.close();
                }
            } catch (Exception e) {
                logger.error(e.getMessage());
            }
            try {
                if (enhancementResultSet != null) {
                    enhancementResultSet.close();
                }
            } catch (Exception e) {
                logger.error(e.getMessage());
            }
            try {
                if (newTaskResultSet != null) {
                    newTaskResultSet.close();
                }
            } catch (Exception e) {
                logger.error(e.getMessage());
            }
            try {
                if (bugPS != null) {
                    bugPS.close();
                }
            } catch (Exception e) {
                logger.error(e.getMessage());
            }
            try {
                if (enhancementPS != null) {
                    enhancementPS.close();
                }
            } catch (Exception e) {
                logger.error(e.getMessage());
            }
            try {
                if (newTaskPS != null) {
                    newTaskPS.close();
                }
            } catch (Exception e) {
                logger.error(e.getMessage());
            }

            try {
                if (connection != null) {
                    connection.close();
                }
            } catch (Exception e) {
                logger.error(e.getMessage());
            }

        }
        hm.put("bug", bug);
        hm.put("enhancement", enhancement);
        hm.put("newtask", newtask);

        return hm;
    }

}
