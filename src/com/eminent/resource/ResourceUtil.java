/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eminent.resource;

import java.sql.Connection;
import java.sql.Statement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import pack.eminent.encryption.MakeConnection;
import org.apache.log4j.Logger;

/**
 *
 * @author Tamilvelan
 */
public class ResourceUtil {

    static Logger logger = Logger.getLogger("Resource Util");

    public static String[][] displayRRIssues(int userId, String startDate, String endDate) {
        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        String total[][] = null;
        String sql = null;
        try {
            connection = MakeConnection.getConnection();
            statement = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            sql = "SELECT R.REQUESTID,PNAME ||' v'||VERSION,R.TEAM,R.POSITION,R.SKILLSET,R.EXP_YEARS,R.STATUS,R.DUEDATE,R.CREATEDBY,R.ASSIGNEDTO,R.CREATEDON  FROM RESOURCEREQUEST R,PROJECT P WHERE R.REQUESTID IN (SELECT DISTINCT RESOURCEID FROM RR_COMMENTS WHERE TO_DATE(TO_CHAR(COMMENT_DATE,'DD-MON-YY'),'DD-MON-YY') BETWEEN '" + startDate + "' AND '" + endDate + "'  AND COMMENTEDBY='" + userId + "') AND P.PID=R.PROJECT";
            logger.info("Resource Comments" + sql);
            resultset = statement.executeQuery(sql);
            resultset.last();
            int rowcount = resultset.getRow();
            resultset.beforeFirst();
            int column = 11;

            String issues[][] = new String[rowcount][column];
            int i = 0;
            while (resultset.next()) {
                issues[i][0] = resultset.getString(1);
                issues[i][1] = resultset.getString(2);
                issues[i][2] = resultset.getString(3);
                issues[i][3] = resultset.getString(4);
                issues[i][4] = resultset.getString(5);
                issues[i][5] = resultset.getString(6);
                issues[i][6] = resultset.getString(7);
                issues[i][7] = resultset.getDate(8).toString();
                issues[i][8] = resultset.getString(9);
                issues[i][9] = resultset.getString(10);
                issues[i][10] = resultset.getDate(11).toString();

                i++;

            }
            total = issues;
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
                logger.error(ex.getMessage());
            }
        }
        return total;
    }

    public static List<String> osList() {

        List<String> osList = new ArrayList<String>();
        osList.add("Windows XP");
        osList.add("Windows Server 2000");
        osList.add("Windows Server 2003");
        osList.add("Windows Vista");
        osList.add("Windows 7");
        osList.add("Windows 8");
        osList.add("Windows 10");
        osList.add("Linux");
        osList.add("Unix");
        return osList;

    }

    public static List<String> statusList() {

        List<String> statusList = new ArrayList<String>();
        statusList.add("Working");
        statusList.add("Not Working");
        return statusList;

    }
}
