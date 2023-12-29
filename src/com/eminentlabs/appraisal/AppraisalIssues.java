/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eminentlabs.appraisal;

import java.sql.Connection;
import java.sql.Statement;
import java.sql.ResultSet;
import pack.eminent.encryption.MakeConnection;
import org.apache.log4j.Logger;

/**
 *
 * @author Tamilvelan
 */
public class AppraisalIssues {

    static Logger logger = null;

    static {
        logger = Logger.getLogger("AppraisalIssues");

    }

    public static String[][] displayIssues(String issueType, int appraisalId) {
        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        String total[][] = null;
        String sql = null;
        try {
            connection = MakeConnection.getConnection();
            statement = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            if (issueType.equalsIgnoreCase("Achievement")) {
                sql = "select i.issueid, pname as project, type, s.status, subject, description, priority, severity, createdby, createdon, assignedto, modifiedon, due_date,rating,feedback,module from issue i, issuestatus s, project p, modules m where i.pid = p.pid and i.module_id=m.moduleid and i.issueid=s.issueid and i.issueid in (SELECT ISSUE_ID FROM ERM_APPRAISAL_ACHIEVEMENT WHERE type='A' and APPRAISAL_ID=" + appraisalId + ")";
            } else if (issueType.equalsIgnoreCase("activities")) {
                sql = "select i.issueid, pname as project, type, s.status, subject, description, priority, severity, createdby, createdon, assignedto, modifiedon, due_date,rating,feedback,module from issue i, issuestatus s, project p, modules m where i.pid = p.pid and i.module_id=m.moduleid and i.issueid=s.issueid and i.issueid in (SELECT ISSUE_ID FROM ERM_APPRAISAL_ACHIEVEMENT WHERE type='O' and APPRAISAL_ID=" + appraisalId + ")";
            } else if (issueType.equalsIgnoreCase("plan")) {
                sql = "select i.issueid, pname as project, type, s.status, subject, description, priority, severity, createdby, createdon, assignedto, modifiedon, due_date,rating,feedback,module from issue i, issuestatus s, project p, modules m where i.pid = p.pid and i.module_id=m.moduleid and i.issueid=s.issueid and i.issueid in (SELECT ISSUE_ID FROM ERM_APPRAISAL_ACHIEVEMENT WHERE type='P' and APPRAISAL_ID=" + appraisalId + ")";
            } else {
                sql = "select i.issueid, pname as project, type, s.status, subject, description, priority, severity, createdby, createdon, assignedto, modifiedon, due_date,rating,feedback,module from issue i, issuestatus s, project p, modules m where i.pid = p.pid and i.module_id=m.moduleid and i.issueid=s.issueid and i.issueid in (SELECT ISSUE_ID FROM ERM_APPRAISAL_ACHIEVEMENT WHERE type='A' and APPRAISAL_ID=" + appraisalId + ")";
            }
            logger.info(sql);
            resultset = statement.executeQuery(sql);
            resultset.last();
            int rowcount = resultset.getRow();
            resultset.beforeFirst();
            int column = 16;

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
                issues[i][7] = resultset.getString(8);
                issues[i][8] = resultset.getString(9);
                issues[i][9] = resultset.getDate(10).toString();
                issues[i][10] = resultset.getString(11);
                issues[i][11] = resultset.getDate(12).toString();
                issues[i][12] = resultset.getDate(13).toString();
                issues[i][13] = resultset.getString(14);
                issues[i][14] = resultset.getString(15);
                issues[i][15] = resultset.getString(16);

                i++;
                //                   logger.info("Adding record no"+i);
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

    public static String[][] displayTimesheet(String issueType, String from, String to, int userId) {
        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        String total[][] = null;
        String sql = null;
        try {
            connection = MakeConnection.getConnection();
            statement = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);

            sql = "select ACCOMPLISHMENTS,learning,plan,hardship,suggestion,to_char(requestedon ,'DD-Mon-YY') as requested,APPROVALPERCENTAGE,WORKINGDAYS,ATTENDANCE from timesheet where to_date(to_char(requestedon ,'DD-Mon-YY'),'DD-Mon-YY') between '" + from + "' and '" + to + "' and owner=" + userId + " and ACCOMPLISHMENTS is not null order by requestedon";
            resultset = statement.executeQuery(sql);
            resultset.last();
            int rowcount = resultset.getRow();
            resultset.beforeFirst();
            int column = 8;

            String issues[][] = new String[rowcount][column];
            int i = 0, workingDays = 0, attendance = 0;
            float attendancepercentage = 0;
            while (resultset.next()) {
                issues[i][0] = resultset.getString(1);
                issues[i][1] = resultset.getString(2);
                issues[i][2] = resultset.getString(3);
                issues[i][3] = resultset.getString(4);
                issues[i][4] = resultset.getString(5);
                issues[i][5] = resultset.getString(6);
                issues[i][6] = resultset.getString(7);
                workingDays = resultset.getInt(8);
                attendance = resultset.getInt(9);
                if (attendance > 0) {
                    attendancepercentage = (attendance / workingDays) * 100;
                }

                issues[i][7] = ((Integer) Math.round(attendancepercentage)).toString();

                i++;
                //                   logger.info("Adding record no"+i);
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
}
