/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eminent.util;

import com.eminent.issue.formbean.IssueFormBean;
import com.eminent.issue.formbean.IssueSearchFormBean;
import com.eminent.issue.formbean.LastAssginForm;
import static com.eminent.issue.formbean.PlannedIssueReport.severityColor;
import static com.eminent.util.GetAge.issueNewlastAsigneeAge;
import com.eminentlabs.mom.MoMUtil;
import dashboard.CheckDate;
import java.net.URLEncoder;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Calendar;
import java.util.Collection;
import java.util.GregorianCalendar;
import org.apache.log4j.Logger;
import pack.eminent.encryption.MakeConnection;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.logging.Level;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 *
 * @author ADAL
 */
public class IssueDetails {

    static Logger logger = null;

    static {
        logger = Logger.getLogger("IssueDetails");

    }

    public static String[][] openIssuesByProject(String projectId) {
        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        String total[][] = null;
        String sql = "select i.issueid, pname as project, type, s.status, subject, description, priority, severity, createdby, createdon, assignedto, modifiedon, due_date,rating,feedback,module,ceil(to_number(sysdate-to_date(createdon)))as age  from issue i,issuestatus s,project p,modules m where i.issueid = s.issueid and i.module_id=m.moduleid and  i.pid = p.pid and i.pid='" + projectId + "'  and s.status != 'Closed'  order by module asc,due_date asc, modifiedon asc, type asc, priority asc, severity asc, createdon asc";

        logger.info("Project SQL" + sql);
        try {
            connection = MakeConnection.getConnection();
            statement = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);

            resultset = statement.executeQuery(sql);
            resultset.last();
            int rowcount = resultset.getRow();
            resultset.beforeFirst();
            int column = 17;

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
                issues[i][16] = resultset.getString(17);

                i++;
                logger.info("Adding record no" + i);
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

    public static String[][] closedIssuesByProject(String projectId) {
        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        String total[][] = null;
        String sql = "select i.issueid, pname as project, type, s.status, subject, description, priority, severity, createdby, createdon, assignedto, modifiedon, due_date,rating,feedback,module,ceil(to_number(modifiedOn-to_date(createdon)))as age,to_char(modifiedOn,'DD-Mon-YYYY')  from issue i,issuestatus s,project p,modules m where i.issueid = s.issueid and i.module_id=m.moduleid and  i.pid = p.pid and i.pid='" + projectId + "'  and s.status = 'Closed'  order by due_date asc, modifiedon asc, type asc, priority asc, severity asc, createdon asc";

        logger.info("Project SQL" + sql);
        try {
            connection = MakeConnection.getConnection();
            statement = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);

            resultset = statement.executeQuery(sql);
            resultset.last();
            int rowcount = resultset.getRow();
            resultset.beforeFirst();
            int column = 18;

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
                issues[i][16] = resultset.getString(17);
                issues[i][17] = resultset.getString(18);

                i++;
                logger.info("Adding record no" + i);
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

    public static int closedIssuesCountByProject(String projectId) {
        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        String sql = "select count(i.issueid) from issue i,issuestatus s,project p,modules m where i.issueid = s.issueid and i.module_id=m.moduleid and  i.pid = p.pid and i.pid='" + projectId + "'  and s.status = 'Closed'  ";
        int i = 0;
        logger.info("Project SQL" + sql);
        try {
            connection = MakeConnection.getConnection();
            statement = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);

            resultset = statement.executeQuery(sql);

            if (resultset.next()) {
                i = resultset.getInt(1);
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
                logger.error(ex.getMessage());
            }
        }
        return i;
    }

    public static String[][] dueDateExceededIssues(String projectId) {
        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        String total[][] = null;
        String sql = "select i.issueid, pname as project, type, s.status, subject, description, priority, severity, createdby, createdon, assignedto, modifiedon, due_date,rating,feedback,module,ceil(to_number(sysdate-to_date(createdon)))as age from issue i,issuestatus s,project p,modules m where i.issueid = s.issueid and i.module_id=m.moduleid and  i.pid = p.pid and i.pid='" + projectId + "'  and s.status != 'Closed' and i.due_date< to_date(to_char((select sysdate from dual),'DD-Mon-YY'),'DD-Mon-YY') order by due_date asc, modifiedon asc, type asc, priority asc, severity asc, createdon asc";

        logger.info("Project SQL" + sql);
        try {
            connection = MakeConnection.getConnection();
            statement = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);

            resultset = statement.executeQuery(sql);
            resultset.last();
            int rowcount = resultset.getRow();
            resultset.beforeFirst();
            int column = 17;

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
                issues[i][16] = resultset.getString(17);
                i++;
                logger.info("Adding record no" + i);
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

    public static List getRejectednDuplicateIssues(String startDate, String endDate) {
        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        List rejectedNclosedlist = new ArrayList();
        try {

            connection = MakeConnection.getConnection();
            statement = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            String reSQL = "select issueid from issuestatus where status='Closed' minus (select distinct issueid from issuecomments where status!='Closed' and (status='Verified' OR status='User Error')   group by comment_date ,issueid having to_char(Max(comment_date),'DD-Mon-YYYY HH:mi:ss') =to_char(issuecomments.comment_date,'DD-Mon-YYYY HH:mi:ss'))";
            resultset = statement.executeQuery(reSQL);
            while (resultset.next()) {
                rejectedNclosedlist.add(resultset.getString("issueid"));
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
                logger.error(ex.getMessage());
            }
        }
        return rejectedNclosedlist;
    }

    public static List<String> currentMonthclosed(int userId, String startDate, String endDate) {
        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        String sql = null;
        List<String> currentMonthIssues = new ArrayList<String>();
        try {
            List rejectedNclosedlist = getRejectednDuplicateIssues(startDate, endDate);
            connection = MakeConnection.getConnection();
            statement = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            sql = "select i.issueid from issue i, issuestatus s, project p, modules m where i.pid = p.pid and i.module_id=m.moduleid and i.issueid=s.issueid and i.issueid in (select distinct issuecomments.issueid from issuecomments,issue,issuestatus where issue.issueid=issuestatus.issueid and issue.issueid=issuecomments.issueid and issuestatus.status='Closed' and to_date(to_char(comment_date, 'DD-Mon-YYYY'),'DD-Mon-YY') between '" + startDate + "' and '" + endDate + "' and to_date(to_char(modifiedon, 'DD-Mon-YY'),'DD-Mon-YY') between '" + startDate + "' and '" + endDate + "' and commentedto='" + userId + "' and commentedby='" + userId + "')";
            logger.info(sql);
            resultset = statement.executeQuery(sql);
            while (resultset.next()) {
                String issue = resultset.getString("issueid");
                if (!rejectedNclosedlist.contains(issue.trim())) {
                    currentMonthIssues.add(issue);
                }
            }
        } catch (Exception e) {
            logger.error("displayIssues" + e.getMessage());

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
        return currentMonthIssues;
    }

    public static String[][] displayIssues(int userId, String startDate, String endDate, String issueType) {
        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        String total[][] = null;
        String sql = null;
        int rowcount = 0;
        try {

            List rejectedNclosedlist = getRejectednDuplicateIssues(startDate, endDate);
            connection = MakeConnection.getConnection();
            statement = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);

            if (issueType.equalsIgnoreCase("Closed")) {
                sql = "select i.issueid, pname as project, type, s.status, subject, description, priority, severity, createdby, createdon, assignedto, modifiedon, due_date,rating,feedback,module from issue i, issuestatus s, project p, modules m where i.pid = p.pid and i.module_id=m.moduleid and i.issueid=s.issueid and i.issueid in (select distinct issuecomments.issueid from issuecomments,issue,issuestatus where issue.issueid=issuestatus.issueid and issue.issueid=issuecomments.issueid and issuestatus.status='Closed'  and to_date(to_char(modifiedon, 'DD-Mon-YYYY'),'DD-Mon-YY') between '" + startDate + "' and '" + endDate + "' and commentedto='" + userId + "' and commentedby='" + userId + "')";
            } else if (issueType.equalsIgnoreCase("Created")) {
                sql = "select i.issueid, pname as project, type, s.status, subject, description, priority, severity, createdby, createdon, assignedto, modifiedon, due_date,rating,feedback,module from issue i, issuestatus s, project p, modules m where i.pid = p.pid and i.module_id=m.moduleid and i.issueid=s.issueid and i.issueid in (select distinct issuecomments.issueid from issuecomments,issue where issue.issueid=issuecomments.issueid and to_date(to_char(createdon, 'DD-Mon-YYYY'),'DD-Mon-YY') between '" + startDate + "' and '" + endDate + "' and commentedby='" + userId + "' and createdby='" + userId + "')";
            } else if (issueType.equalsIgnoreCase("Worked")) {
                sql = "select i.issueid, pname as project, type, s.status, subject, description, priority, severity, createdby, createdon, assignedto, modifiedon, due_date,rating,feedback,module from issue i, issuestatus s, project p, modules m where i.pid = p.pid and i.module_id=m.moduleid and i.issueid=s.issueid and i.issueid in (select distinct issuecomments.issueid from issuecomments,issue where issue.issueid=issuecomments.issueid and to_date(to_char(comment_date, 'DD-Mon-YYYY'),'DD-Mon-YY') between '" + startDate + "' and '" + endDate + "' and commentedto='" + userId + "' and commentedby='" + userId + "')";
            } else if (issueType.equalsIgnoreCase("Worked Open")) {
                sql = "select i.issueid, pname as project, type, s.status, subject, description, priority, severity, createdby, createdon, assignedto, modifiedon, due_date,rating,feedback,module from issue i, issuestatus s, project p, modules m where i.pid = p.pid and i.module_id=m.moduleid and i.issueid=s.issueid and s.status!='Closed' and i.issueid in (select distinct issuecomments.issueid from issuecomments,issue where issue.issueid=issuecomments.issueid and to_date(to_char(comment_date, 'DD-Mon-YYYY'),'DD-Mon-YY') between '" + startDate + "' and '" + endDate + "' and commentedto='" + userId + "' and commentedby='" + userId + "')";
            } else if (issueType.equalsIgnoreCase("Open")) {
                sql = "select i.issueid, pname as project, type, s.status, subject, description, priority, severity, createdby, createdon, assignedto, modifiedon, due_date,rating,feedback,module from issue i, issuestatus s, project p, modules m where i.pid = p.pid and i.module_id=m.moduleid and i.issueid=s.issueid and i.issueid in (select distinct issuecomments.issueid from issuecomments,issue,issuestatus where issue.issueid=issuestatus.issueid and issue.issueid=issuecomments.issueid and issuestatus.status!='Closed' and to_date(to_char(comment_date, 'DD-Mon-YY'),'DD-Mon-YY') between '" + startDate + "' and '" + endDate + "' and to_date(to_char(modifiedon, 'DD-Mon-YY'),'DD-Mon-YY') between '" + startDate + "' and '" + endDate + "' and commentedto='" + userId + "' and commentedby='" + userId + "')";
            } else {
                sql = "select i.issueid, pname as project, type, s.status, subject, description, priority, severity, createdby, createdon, assignedto, modifiedon, due_date,rating,feedback,module from issue i, issuestatus s, project p, modules m where i.pid = p.pid and i.module_id=m.moduleid and i.issueid=s.issueid and i.issueid in (select distinct issuecomments.issueid from issuecomments,issue where issue.issueid=issuecomments.issueid and to_date(to_char(comment_date, 'DD-Mon-YY'),'DD-Mon-YY') between '" + startDate + "' and '" + endDate + "' and commentedto='" + userId + "' and commentedby='" + userId + "')";
            }
            logger.info(sql);

            resultset = statement.executeQuery(sql);

            while (resultset.next()) {
                if (issueType.equalsIgnoreCase("Closed")) {
                    if (!rejectedNclosedlist.contains(resultset.getString(1))) {
                        rowcount++;
                    }
                } else {
                    resultset.last();
                    rowcount = resultset.getRow();
                }
            }

            resultset.beforeFirst();
            int column = 16;
            java.util.Date date = null;
            String issues[][] = new String[rowcount][column];

            int i = 0;
            while (resultset.next()) {

                if (issueType.equalsIgnoreCase("Closed")) {

                    if (!rejectedNclosedlist.contains(resultset.getString(1))) {
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
                        date = resultset.getDate(13);
                        if (date != null) {
                            issues[i][12] = date.toString();
                        }

                        //                   issues[i][12] =   resultset.getDate(13).toString();
                        issues[i][13] = resultset.getString(14);
                        issues[i][14] = resultset.getString(15);
                        issues[i][15] = resultset.getString(16);

                        i++;
                    }

                } else {
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
                    date = resultset.getDate(13);
                    if (date != null) {
                        issues[i][12] = date.toString();
                    }

                    //                   issues[i][12] =   resultset.getDate(13).toString();
                    issues[i][13] = resultset.getString(14);
                    issues[i][14] = resultset.getString(15);
                    issues[i][15] = resultset.getString(16);

                    i++;

                }

                //                   logger.info("Adding record no"+i);
            }
            total = issues;
        } catch (Exception e) {
            logger.error("displayIssues" + e.getMessage());

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

    public static String[][] displayEminentIssues(String issueType, String startDate, String endDate, String projectId) {
        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        String total[][] = null;
        String sql = null;
        try {
            connection = MakeConnection.getConnection();
            statement = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            if (issueType.equalsIgnoreCase("Closed")) {
                sql = "Select i.issueid, pname as project, type, s.status, subject, description, priority, severity, createdby, createdon, assignedto, modifiedon, due_date,rating,feedback,module from issue i , issuestatus s,project p,modules m where p.pid='" + projectId + "' and p.pid=i.pid and i.issueid=s.issueid and m.moduleid=i.module_id and to_date(to_char(modifiedon,'DD-Mon-YYYY'),'DD-Mon-YYYY') between '" + startDate + "' and '" + endDate + "' and s.status='Closed'";
            } else if (issueType.equalsIgnoreCase("Created")) {
                sql = "Select i.issueid, pname as project, type, s.status, subject, description, priority, severity, createdby, createdon, assignedto, modifiedon, due_date,rating,feedback,module from issue i , issuestatus s,project p,modules m where p.pid='" + projectId + "' and p.pid=i.pid and i.issueid=s.issueid and m.moduleid=i.module_id and to_date(to_char(createdon,'DD-Mon-YYYY'),'DD-Mon-YYYY') between '" + startDate + "' and '" + endDate + "'";
            } else if (issueType.equalsIgnoreCase("Worked")) {
                sql = "Select i.issueid, pname as project, type, s.status, subject, description, priority, severity, createdby, createdon, assignedto, modifiedon, due_date,rating,feedback,module from issue i , issuestatus s,project p,modules m where p.pid='" + projectId + "' and p.status!='Finished' and p.phase!='Closed' and p.phase!='Suspended' and p.pid=i.pid and m.moduleid=i.module_id and i.issueid=s.issueid and i.issueid in (select distinct issueid  from issuecomments where to_date(to_char(comment_date,'DD-Mon-YYYY'),'DD-Mon-YYYY') between '" + startDate + "' and '" + endDate + "' and comments!='Assigning to PM as due date exceeded')";
            } else {
                sql = "Select i.issueid, pname as project, type, s.status, subject, description, priority, severity, createdby, createdon, assignedto, modifiedon, due_date,rating,feedback,module from issue i , issuestatus s,project p,modules m where p.pid='" + projectId + "' and p.pid=i.pid and i.issueid=s.issueid and m.moduleid=i.module_id and to_date(to_char(modifiedon,'DD-Mon-YYYY'),'DD-Mon-YYYY') between '" + startDate + "' and '" + endDate + "'";
            }
            resultset = statement.executeQuery(sql);
            resultset.last();
            int rowcount = resultset.getRow();
            resultset.beforeFirst();
            int columns = 16;

            String issues[][] = new String[rowcount][columns];
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
                logger.info("Adding record no" + i);
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

    public static String[][] displayOpenIssues(String startDate, String endDate, String projectId) {
        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        String total[][] = null;
        String sql = null;
        try {
            connection = MakeConnection.getConnection();
            statement = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            if (projectId.equalsIgnoreCase("All")) {
                sql = "Select i.issueid, pname as project, type, s.status, subject, description, priority, severity, createdby, createdon, assignedto, modifiedon, due_date,module from issue i , issuestatus s,project p,modules m where p.pid=i.pid and i.issueid=s.issueid and i.module_id=m.moduleid and to_date(to_char(createdon,'DD-Mon-YY'),'DD-Mon-YY')<'" + endDate + "' and i.issueid not in (Select i.issueid from issue i , issuestatus s where i.issueid=s.issueid and status='Closed' and to_date(to_char(modifiedon,'DD-Mon-YY'),'DD-Mon-YY')<'" + startDate + "')";
            } else {
                sql = "Select i.issueid, pname as project, type, s.status, subject, description, priority, severity, createdby, createdon, assignedto, modifiedon, due_date,module from issue i , issuestatus s,project p,modules m where p.pid='" + projectId + "' and p.pid=i.pid and i.module_id=m.moduleid and i.issueid=s.issueid and to_date(to_char(createdon,'DD-Mon-YY'),'DD-Mon-YY')<'" + endDate + "' and i.issueid not in (Select i.issueid from issue i , issuestatus s where i.issueid=s.issueid and status='Closed' and to_date(to_char(modifiedon,'DD-Mon-YY'),'DD-Mon-YY')<'" + startDate + "') ";
            }
            resultset = statement.executeQuery(sql);
            resultset.last();
            int rowcount = resultset.getRow();
            resultset.beforeFirst();
            String issues[][] = new String[rowcount][14];
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

    public static HashMap getIssue(String issueId) {
        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        HashMap<String, String> issueDetails = new HashMap<String, String>();
        try {
            connection = MakeConnection.getConnection();
            statement = connection.createStatement();
            String sql = "select i.issueid,p.pname,p.pid,p.version as fixversion,m.moduleid,m.module,p.platform,i.createdon,i.modifiedon,i.createdby, i.assignedto, i.type,i.priority,i.severity,i.due_date,i.subject,i.description,i.expected_result,i.rootcause,i.found_version as foundversion,p.customer as customer ,s.status,to_char(i.due_date,'dd-Mon-yyyy')  from issue i,project p,modules m ,issuestatus s where i.pid=p.pid  and i.issueid='" + issueId + "'  and moduleid=(select module_id from issue where issueid='" + issueId + "' and i.issueid=s.issueid)";
            resultset = statement.executeQuery(sql);
            while (resultset.next()) {
                issueDetails.put("issueid", resultset.getString(1));
                issueDetails.put("projectname", resultset.getString(2));
                issueDetails.put("projectid", resultset.getString(3));
                issueDetails.put("fixversion", resultset.getString(4));
                issueDetails.put("moduleid", resultset.getString(5));
                issueDetails.put("modulename", resultset.getString(6));
                issueDetails.put("platform", resultset.getString(7));
                issueDetails.put("createdon", resultset.getString(8));
                issueDetails.put("modifiedon", resultset.getString(9));
                issueDetails.put("createdby", resultset.getString(10));
                issueDetails.put("assignedto", resultset.getString(11));
                issueDetails.put("type", resultset.getString(12));
                issueDetails.put("priority", resultset.getString(13));
                issueDetails.put("severity", resultset.getString(14));
                issueDetails.put("duedate", resultset.getString(15));
                issueDetails.put("subject", resultset.getString(16));
                issueDetails.put("description", resultset.getString(17));
                issueDetails.put("expectedresult", resultset.getString(18));
                issueDetails.put("rootcause", resultset.getString(19));
                issueDetails.put("foundversion", resultset.getString(20));
                issueDetails.put("customer", resultset.getString(21));
                issueDetails.put("status", resultset.getString(22));
                issueDetails.put("Formatduedate", resultset.getString(23));

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
                logger.error(ex.getMessage());
            }
        }
        return issueDetails;
    }

    public static int displayFiles(String issueId) {
        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        int files = 0;
        try {
            connection = MakeConnection.getConnection();
            statement = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);

            resultset = statement.executeQuery("select count(*) from fileattach where issueid='" + issueId + "'");

            if (resultset.next()) {
                files = resultset.getInt(1);
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
                logger.error(ex.getMessage());
            }
        }
        return files;
    }

    public static int displayModuleFiles(String pId) {
        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        int files = 0;
        try {
            connection = MakeConnection.getConnection();
            statement = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);

            resultset = statement.executeQuery("select count(*) from APM_MODULE_ATTACHMENT where PROJECTID='" + pId + "'");

            if (resultset.next()) {
                files = resultset.getInt(1);
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
                logger.error(ex.getMessage());
            }
        }
        return files;
    }

    public static Map<String, Integer> displayFilesCount(String issuenos) {

        String query = "";
        Map<String, Integer> files = new HashMap<String, Integer>();
        String issues[] = issuenos.split(",");
        if (issues.length > 1000) {

            int j = issues.length / 1000;
            int l = issues.length % 1000;
            if (l != 0) {
                j = j + 1;
            }
            for (int k = 1; k <= j; k++) {
                String totalIssue = "";
                int start = (1000 * (k - 1));
                int end = 1000 * (k);
                if (end > issues.length) {
                    end = issues.length;
                }
                for (int i = start; i < end; i++) {
                    if (issues[i] != null) {
                        totalIssue = totalIssue + issues[i] + ",";
                    }
                }
                if (!"".equals(totalIssue)) {
                    totalIssue = totalIssue.substring(0, totalIssue.length() - 1);
                }
                query = "select count(*),issueid from fileattach where issueid in(" + totalIssue + ") group by issueid";
                files = issueNewFileAge(query);
            }
        } else {
            query = "select count(*),issueid from fileattach where issueid in(" + issuenos + ") group by issueid";
            files = issueNewFileAge(query);
        }
        return files;
    }

    public static Map issueNewFileAge(String query) {
        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        Map<String, Integer> files = new HashMap<String, Integer>();
        try {
            connection = MakeConnection.getConnection();
            statement = connection.createStatement();
            resultset = statement.executeQuery(query);
            while (resultset.next()) {
                files.put(resultset.getString(2), resultset.getInt(1));
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
                logger.error(ex.getMessage());
            }
        }
        return files;
    }

    public static List<IssueFormBean> displayIssuesDetails(String issuenos) {
        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        String totalissuenos = "";
        SimpleDateFormat sdf = new SimpleDateFormat("dd-MMM-yy");
        SimpleDateFormat dateConversion = new SimpleDateFormat("yyyy-MM-dd");
        String query = "";
        String modifiedQuery = "";
        List<IssueFormBean> issuesList = new ArrayList<IssueFormBean>();
        HashMap<Integer, String> member = GetProjectMembers.showUsersSName();
        String issues[] = issuenos.split(",");
        if (issues.length > 1000) {

            int j = issues.length / 1000;
            int l = issues.length % 1000;
            if (l != 0) {
                j = j + 1;
            }
            for (int k = 1; k <= j; k++) {
                String totalIssue = "";
                int start = (1000 * (k - 1));
                int end = 1000 * (k);
                if (end > issues.length) {
                    end = issues.length;
                }
                for (int i = start; i < end; i++) {
                    if (issues[i] != null) {
                        totalIssue = totalIssue + issues[i] + ",";
                    }
                }
                if (!"".equals(totalIssue)) {
                    totalIssue = totalIssue.substring(0, totalIssue.length() - 1);
                }
                if ("".equals(modifiedQuery)) {
                    modifiedQuery = modifiedQuery + "(i.issueid in (" + totalIssue + ")";
                } else {
                    modifiedQuery = modifiedQuery + " OR i.issueid in (" + totalIssue + ")";
                }
            }
            query = "select distinct(i.issueid),CONCAT(pname ,CONCAT(' v',version)) as project, type, s.status, subject, description, priority, severity, createdby, createdon, assignedto, modifiedon, due_date,rating,feedback,module,ceil(to_number(modifiedon-to_date(createdon)))as age from issue i, issuestatus s, project p, modules m where i.pid = p.pid and i.module_id=m.moduleid and i.issueid=s.issueid and s.status='Closed' and  " + modifiedQuery + ") ";
        } else {
            query = "select distinct(i.issueid),CONCAT(pname ,CONCAT(' v',version)) as project, type, s.status, subject, description, priority, severity, createdby, createdon, assignedto, modifiedon, due_date,rating,feedback,module,ceil(to_number(modifiedon-to_date(createdon)))as age from issue i, issuestatus s, project p, modules m where i.pid = p.pid and i.module_id=m.moduleid and i.issueid=s.issueid  and s.status='Closed' and i.issueid in(" + issuenos + ") ";
        }
        try {
            connection = MakeConnection.getConnection();
            statement = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            resultset = statement.executeQuery(query);

            while (resultset.next()) {
                totalissuenos = totalissuenos + "'" + resultset.getString("issueid").trim() + "',";
            }
            Map<String, Integer> lastAsigneeAgeList = new HashMap<String, Integer>();
            Map<String, Integer> fileCountList = new HashMap<String, Integer>();
            if (totalissuenos.contains(",")) {
                totalissuenos = totalissuenos.substring(0, totalissuenos.length() - 1);
                lastAsigneeAgeList = GetAge.issuelastAsigneeAge(totalissuenos);
                fileCountList = IssueDetails.displayFilesCount(totalissuenos);
            }
            resultset.beforeFirst();
            while (resultset.next()) {
                IssueFormBean isfb = new IssueFormBean();

                isfb.setSeverity(severityColor(resultset.getString("severity")));
                isfb.setIssueId(resultset.getString("issueid"));
                isfb.setType(resultset.getString("type"));

                String p = "NA";
                String pri = resultset.getString("priority");
                if (pri != null) {
                    p = pri.substring(0, 2);
                }
                isfb.setPriority(p);

                isfb.setpName(resultset.getString("project"));
                if (isfb.getpName().length() >= 15) {
                    isfb.setRedPName(isfb.getpName().substring(0, 14) + "..");
                } else {
                    isfb.setRedPName(resultset.getString("project"));
                }
                isfb.setmName(resultset.getString("module"));
                if (isfb.getmName().length() >= 10) {
                    isfb.setRedMName(isfb.getmName().substring(0, 9) + "..");
                } else {
                    isfb.setRedMName(resultset.getString("module"));
                }
                String sub = resultset.getString("subject");
                if (sub.length() > 42) {
                    sub = sub.substring(0, 42) + "...";
                }
                isfb.setSubject(sub);
                isfb.setDescription(resultset.getString("description"));
                String status = resultset.getString("status");
                isfb.setStatus(status);
                String dueDateFormat = resultset.getDate("due_date").toString();
                String dueDate = "NA";
                if (dueDateFormat != null) {
                    dueDate = sdf.format(dateConversion.parse(dueDateFormat));
                }
                String dateString1 = sdf.format(dateConversion.parse(resultset.getDate("modifiedon").toString()));
                String create = sdf.format(dateConversion.parse(resultset.getDate("createdon").toString()));

                isfb.setDueDate(dueDate);
                if ((status != null) && (!status.equalsIgnoreCase("Closed")) && (!dueDate.equalsIgnoreCase("NA")) && (CheckDate.getFlag(dueDate) == true)) {
                    isfb.setDueDateColor("red");
                } else if ((status.equalsIgnoreCase("Closed") && (CheckDate.getClosedIssueFlag(dueDate, dateString1) == true))) {
                    isfb.setDueDateColor("red");
                } else {
                    isfb.setDueDateColor("#000000");
                }
                isfb.setModifiedOn(dateString1);
                isfb.setCreatedOn(create);
                if (resultset.getString("createdby") != null) {
                    isfb.setCreatedBy(member.get(Integer.valueOf(resultset.getString("createdby"))));
                }
                if (resultset.getString("assignedto") != null) {
                    isfb.setAssignto(member.get(Integer.valueOf(resultset.getString("assignedto"))));
                }
                int filesCount = 0;
                if (fileCountList.containsKey(resultset.getString("issueid"))) {
                    filesCount = fileCountList.get(resultset.getString("issueid"));
                }
                if (filesCount > 0) {
                    isfb.setRefer("View Files(" + filesCount + ")");
                } else {
                    isfb.setRefer("No Files");
                }
                int lastAsigneeAge = 1;
                if (lastAsigneeAgeList.containsKey(resultset.getString("issueid"))) {
                    lastAsigneeAge = lastAsigneeAgeList.get(resultset.getString("issueid"));
                }
                if (lastAsigneeAge == 1) {
                    lastAsigneeAge = resultset.getInt("age");
                }

                if (lastAsigneeAge == 0) {
                    lastAsigneeAge = lastAsigneeAge + 1;
                }
                isfb.setAge(resultset.getInt("age"));
                isfb.setLastAssigneeAge(lastAsigneeAge);
                String color = "";
                String rating = resultset.getString("rating");
                String feedback = resultset.getString("feedback");
                if (status.equalsIgnoreCase("Closed")) {
                    if (rating != null) {
                        if (rating.equalsIgnoreCase("Excellent")) {
                            color = "#336600";

                        } else if (rating.equalsIgnoreCase("Good")) {
                            color = "#33CC66";

                        } else if (rating.equalsIgnoreCase("Average")) {
                            color = "#CC9900";

                        } else if (rating.equalsIgnoreCase("Need Improvement")) {
                            color = "#CC0000";

                        }
                    }
                    isfb.setRating(rating);
                }
                if (feedback == null) {
                    feedback = "";
                }
                isfb.setRatingColor(color);
                isfb.setFeedback(feedback);
                issuesList.add(isfb);
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
                logger.error(ex.getMessage());
            }
        }
        return issuesList;
    }

    public static HashMap getCRID(String issueId) {
        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        HashMap<String, String> hm = new HashMap<String, String>();

        try {
            connection = MakeConnection.getConnection();
            statement = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            resultset = statement.executeQuery("select crid,description from apm_sap_crid where issueid='" + issueId + "'");
            while (resultset.next()) {
                hm.put(resultset.getString("crid"), resultset.getString("description"));

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
                logger.error(ex.getMessage());
            }
        }
        return hm;
    }

    public static String[][] getCRIDS(String issueId) {
        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        String total[][] = null;
        try {
            connection = MakeConnection.getConnection();
            statement = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            resultset = statement.executeQuery("select sno,crid,description,originator,to_char(crcreatedOn,'DD-Mon-yyyy HH:MI:SS') as crCreated_On,crcreatedOn,status from apm_sap_crid where issueid='" + issueId + "' order by SNO");
//            resultset = statement.executeQuery("select sno,crid,description,originator,to_char(crcreatedOn,'DD-Mon-yyyy HH:MI:SS') as crCreated_On,crcreatedOn,status from apm_sap_crid where issueid='"+issueId+"' or issueid in (select SUB_ISSUE_ID from issue_link where MAIN_ISSUE_ID ='"+issueId+"') order by SNO");
            resultset.last();
            int rowcount = resultset.getRow();
            resultset.beforeFirst();
            String issues[][] = new String[rowcount][6];
            int i = 0;
            while (resultset.next()) {
                issues[i][0] = resultset.getString("crid");
                if (resultset.getString("description") != null) {
                    issues[i][1] = resultset.getString("description");
                } else {
                    issues[i][1] = "";
                }
                issues[i][2] = resultset.getString("sno");
                if (resultset.getString("originator") != null) {
                    issues[i][3] = resultset.getString("originator");
                } else {
                    issues[i][3] = "Nil";
                }
                if (resultset.getString("crCreated_On") != null) {
                    issues[i][4] = resultset.getString("crCreated_On");
                } else {
                    issues[i][4] = "Nil";
                }

                if (resultset.getString("status") != null) {
                    issues[i][5] = resultset.getString("status");
                } else {
                    issues[i][5] = "Nil";
                }

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

    public static void addCRID(String issueId, String crId, String Description, Timestamp createdOn, int createdBy, String status) {
        Connection connection = null;
        PreparedStatement ps = null;
        ResultSet resultset = null;

        try {
            HashMap cridDb = getCRID(issueId);
            connection = MakeConnection.getConnection();
            if (cridDb.size() == 1) {
                Collection setCR = cridDb.keySet();
                Iterator iterCR = setCR.iterator();
                while (iterCR.hasNext()) {
                    String key = (String) iterCR.next();
                    if (key.equalsIgnoreCase("NA")) {
                        ps = connection.prepareStatement("update apm_sap_crid set crid='" + crId + "',description='" + Description + "' where issueid='" + issueId + "'");
                        ps.executeUpdate();
                    } else {
                        if (!cridDb.containsKey(crId)) {
                            ps = connection.prepareStatement("insert into apm_sap_crid(sno,issueid,crid,description,crcreatedOn,originator,status) values(?,?,?,?,?,?,?)");
                            ps.setInt(1, getSNO());
                            ps.setString(2, issueId);
                            ps.setString(3, crId);
                            ps.setString(4, Description);
                            ps.setTimestamp(5, createdOn);
                            ps.setInt(6, createdBy);
                            ps.setString(7, status);
                            ps.executeUpdate();
                        } else {
                            logger.info("Cr Id already exists");
                        }
                    }
                }
            } else {
                if (!cridDb.containsKey(crId)) {
                    ps = connection.prepareStatement("insert into apm_sap_crid(sno,issueid,crid,description,crcreatedOn,originator,status) values(?,?,?,?,?,?,?)");
                    ps.setInt(1, getSNO());
                    ps.setString(2, issueId);
                    ps.setString(3, crId);
                    ps.setString(4, Description);
                    ps.setTimestamp(5, createdOn);
                    ps.setInt(6, createdBy);
                    ps.setString(7, status);
                    ps.executeUpdate();
                } else {
                    logger.info("Cr Id already exists");
                }
            }

        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            try {

                if (resultset != null) {
                    resultset.close();
                }
                if (ps != null) {
                    ps.close();
                }
                if (connection != null) {
                    connection.close();
                }
            } catch (Exception ex) {
                logger.error(ex.getMessage());
            }
        }
    }

    public static void deleteCrId(String sno) {
        Connection connection = null;
        Statement statement = null;

        try {

            connection = MakeConnection.getConnection();
            statement = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            int r = statement.executeUpdate("delete from apm_sap_crid where sno='" + sno + "'");

        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            try {

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
    }

    public static void updateCRID(String issueId, String crId, String Description) {
        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;

        try {

            connection = MakeConnection.getConnection();
            statement = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            int r = statement.executeUpdate("update apm_sap_crid set crid='" + crId + "',description='" + Description + "' where issueid='" + issueId + "'");

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
    }

    public static void editCRID(String sno, String crId, String Description) {
        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;

        try {

            connection = MakeConnection.getConnection();
            statement = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            int r = statement.executeUpdate("update apm_sap_crid set crid='" + crId + "',description='" + Description + "' where sno='" + sno + "'");

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
    }

    public static int getSNO() {
        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        int sNo = 0;

        try {
            connection = MakeConnection.getConnection();
            statement = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            resultset = statement.executeQuery("select CRID_SEQ.nextval as sno from dual");
            if (resultset.next()) {
                sNo = resultset.getInt("sno");
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
                logger.error(ex.getMessage());
            }
        }
        return sNo;
    }

    public static HashMap getTestCaseStatus(String projectId) {
        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        HashMap<String, String> hm = new HashMap<String, String>();

        try {
            connection = MakeConnection.getConnection();
            statement = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            resultset = statement.executeQuery("select s.status,count(*) from tqm_issuetestcases i,tqm_ptcm p,TQM_TESTCASESTATUS s where p.ptcid=i.ptcid and p.pid='" + projectId + "' and i.statusid=s.statusid group by s.status");
            while (resultset.next()) {
                hm.put(resultset.getString(1), resultset.getString(2));

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
                logger.error(ex.getMessage());
            }
        }
        return hm;
    }

    public static HashMap getTestPlanTestCaseStatus(String projectId) {
        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        HashMap<String, String> hm = new HashMap<String, String>();

        try {
            connection = MakeConnection.getConnection();
            statement = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            resultset = statement.executeQuery("select  s.status ,count(*) from  tqm_testcaseexecution e,tqm_testcaseexecutionplan p,TQM_TESTCASESTATUS s where p.pid= '" + projectId + "' and e.tepid=p.tepid and s.statusid=e.statusid group by s.status ");
            while (resultset.next()) {
                hm.put(resultset.getString(1), resultset.getString(2));

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
                logger.error(ex.getMessage());
            }
        }
        return hm;
    }

    public static HashMap getTestCaseStatus() {
        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        HashMap<String, String> hm = new HashMap<String, String>();

        try {
            connection = MakeConnection.getConnection();
            statement = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            resultset = statement.executeQuery("select s.status, p.ptcid from tqm_issuetestcases i,tqm_ptcm p,TQM_TESTCASESTATUS s where p.ptcid=i.ptcid  and i.statusid=s.statusid group by s.status, p.ptcid");
            while (resultset.next()) {
                hm.put(resultset.getString(2), resultset.getString(1));

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
                logger.error(ex.getMessage());
            }
        }
        return hm;
    }

    public static String[][] userAssignedIssues(String userId, String selectedUser) {
        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        String total[][] = null;
        String sql = null;
        String extendedQuery = " and i.pid in (select u.pid from userproject u where u.userid='" + selectedUser + "' intersect select k.pid from userproject k where k.userid='" + userId + "')";
        if (userId.equalsIgnoreCase("104")) {
            extendedQuery = "";

        }
        try {
            connection = MakeConnection.getConnection();
            statement = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            sql = "select i.issueid, pname as project, type, s.status, subject, description, priority, severity, createdby, createdon, assignedto, modifiedon, due_date,module from issue i,issuestatus s,project p,modules m where i.assignedto = '" + selectedUser + "' and i.issueid = s.issueid and m.moduleid=i.module_id and s.status!='Closed' and i.pid=p.pid " + extendedQuery + " order by i.due_date ";
            logger.info(sql);
            resultset = statement.executeQuery(sql);
            resultset.last();
            int rowcount = resultset.getRow();
            resultset.beforeFirst();
            String issues[][] = new String[rowcount][14];
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
                issues[i][13] = resultset.getString(14).toString();
                i++;
            }
            total = issues;
        } catch (Exception e) {
            logger.error(e.getMessage());
            logger.info("userAssignedIssues" + e.getMessage());
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

    public static String[][] userAssignedIssues(String userId, String selectedUser, String query) {
        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        String total[][] = null;
        String sql = null;
        String extendedQuery = " and i.pid in (select u.pid from userproject u where u.userid='" + selectedUser + "' intersect select k.pid from userproject k where k.userid='" + userId + "')";
        if (userId.equalsIgnoreCase("104")) {
            extendedQuery = "";

        }
        try {
            connection = MakeConnection.getConnection();
            statement = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            sql = query + extendedQuery + " order by i.due_date ";
            logger.info(sql);
            resultset = statement.executeQuery(sql);
            resultset.last();
            int rowcount = resultset.getRow();
            resultset.beforeFirst();
            String issues[][] = new String[rowcount][15];
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
                issues[i][13] = resultset.getString(14).toString();
                issues[i][14] = resultset.getString(15).toString();
                i++;
                logger.info("Adding record no" + i);
            }
            total = issues;
        } catch (Exception e) {
            logger.error(e.getMessage());
            logger.info("userAssignedIssues" + e);
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

    public static String[][] showModulewiseIssue(String project) {
        String[][] moduleOpenIssue = null;
        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        int rowcount = 0;
        try {

            connection = MakeConnection.getConnection();
            statement = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            resultset = statement.executeQuery("SELECT MODULE_ID,M.MODULE, COUNT(*) AS NO_OF_ISSUES FROM ISSUE I, PROJECT P,ISSUESTATUS S,MODULES M WHERE P.PID=I.PID AND S.ISSUEID=I.ISSUEID AND P.PID='" + project + "' AND s.STATUS!='Closed' AND M.PID=I.PID AND I.MODULE_ID=M.MODULEID GROUP BY MODULE_ID,MODULE,PNAME ORDER BY NO_OF_ISSUES DESC");
            resultset.last();
            rowcount = resultset.getRow();
            resultset.beforeFirst();
            String issues[][] = new String[rowcount][3];
            int i = 0;
            while (resultset.next()) {
                issues[i][0] = resultset.getString(1);
                issues[i][1] = resultset.getString(2);
                issues[i][2] = resultset.getString(3);

                i++;
            }
            moduleOpenIssue = issues;
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
        return moduleOpenIssue;
    }

    public static String proposeDuedate(String project, String module, String version, String severity, String priority) {
        String duedate = null;
        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;

        Date date = null;
        int val = 0;
        SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-YYYY");
        Calendar cal = new GregorianCalendar();
        Date today = cal.getTime();
        HashMap<String, Integer> resolutioDays = getResolutionDays();

        try {

            connection = MakeConnection.getConnection();
            statement = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            resultset = statement.executeQuery("select max(due_date) as proposeddate from issue i, issuestatus s, project p, modules m where p.pid=i.pid and p.pid=m.pid and i.issueid=s.issueid and m.moduleid= i.module_id and s.status!='Closed' and pname='" + project + "' and p.VERSION='" + version + "' and m.MODULE='" + module + "' order by due_date desc");
            while (resultset.next()) {
                date = resultset.getDate("proposeddate");
            }
            logger.info("System Date" + date);
            if (date != null) {
                if (today.after(date)) {
                    date = today;
                }
            } else {
                date = today;
            }
            logger.info("Validation Date" + date);

            String sev = severity.substring(0, severity.indexOf("-")).trim();
            String pri = priority.substring(0, severity.indexOf("-")).trim();
            logger.info("System Severity" + sev);
            logger.info("System Priority" + pri);
            String finalval = pri + sev;
            logger.info("Final Value Priority" + finalval);
            logger.info(resolutioDays);
            val = resolutioDays.get(finalval);
            logger.info(val);
//            switch(finalval) {
//                case "P1S1":
//                    val=1;
//                    break;
//                case "P1S2":
//                    val=2;
//                    break;
//                case "P2S1":
//                    val=3;
//                    break;
//                case "P2S2":
//                    val=4;
//                    break;
//                case "P3S1":
//                    val=5;
//                    break;
//                case "P4S1":
//                    val=6;
//                    break;
//                case "P1S3":
//                    val=7;
//                    break;
//                case "P2S3":
//                    val=8;
//                    break;
//                case "P3S2":
//                    val=9;
//                    break;
//                case "P4S2":
//                    val=10;
//                    break;
//                case "P3S3":
//                    val=11;
//                    break;
//                case "P4S3":
//                    val=12;
//                    break;
//                case "P1S4":
//                    val=13;
//                    break;
//                case "P2S4":
//                    val=14;
//                    break;
//                case "P3S4":
//                    val=15;
//                    break;
//                case "P4S4":
//                    val=16;
//                    break;
//            }
            logger.info("Proposed days based on S & P" + val);
            Calendar calendar = Calendar.getInstance();
            calendar.setTime(date);
            calendar.add(Calendar.DATE, val); // add due dates 
            date = calendar.getTime();
            logger.info("Final Date before formatting" + date);
            duedate = sdf.format(date);
            logger.info("Final Date" + duedate);

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
        return duedate;
    }

    public static void deleteResolutionDays() {
        Connection connection = null;
        PreparedStatement ps = null;
        try {
            String sql = "Delete from issue_resolution_days";
            connection = MakeConnection.getConnection();
            ps = connection.prepareStatement(sql);
            ps.executeQuery();
        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            try {
                ps.close();
            } catch (Exception e) {
                logger.error(e.getMessage());
            }

            try {
                connection.close();
            } catch (Exception e) {
                logger.error(e.getMessage());
            }

        }
    }

    public static void createResolutionDays(String[][] days) {
        Connection connection = null;
        PreparedStatement ps = null;
        try {
            deleteResolutionDays();
            String sql = "insert into issue_resolution_days (type, days) values (?, ?)";
            connection = MakeConnection.getConnection();
            ps = connection.prepareStatement(sql);
            for (int i = 0; i < days.length; i++) {
                ps.setString(1, days[i][0]);
                ps.setString(2, days[i][1]);
                ps.addBatch();
            }
            ps.executeBatch();
        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            try {
                ps.close();
            } catch (Exception e) {
                logger.error(e.getMessage());
            }

            try {
                connection.close();
            } catch (Exception e) {
                logger.error(e.getMessage());
            }

        }
    }

    public static HashMap<String, Integer> getResolutionDays() {
        Connection connection = null;
        PreparedStatement ps = null;
        ResultSet resultSet = null;
        HashMap<String, Integer> resolutionDays = new HashMap<String, Integer>();
        try {
            String sql = "select type ,days from issue_resolution_days";
            connection = MakeConnection.getConnection();
            ps = connection.prepareStatement(sql);
            resultSet = ps.executeQuery();
            while (resultSet.next()) {
                String type = resultSet.getString("type");
                int days = resultSet.getInt("days");
                resolutionDays.put(type, days);
            }
            logger.info(resolutionDays);
        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            try {
                resultSet.close();
            } catch (Exception e) {
                logger.error(e.getMessage());
            }
            try {
                ps.close();
            } catch (Exception e) {
                logger.error(e.getMessage());
            }
            try {
                connection.close();
            } catch (Exception e) {
                logger.error(e.getMessage());
            }

        }
        return resolutionDays;
    }

    public static String[][] prposalIssues(int pId, String mId, int days) {
        Connection connection = null;
        PreparedStatement ps = null;
        ResultSet resultSet = null;
        String prposedIssue[][] = null;
        int rowcount = 0;

        try {
            String sql = "select i.issueid,s.status,i.severity,i.priority,i.assignedto,to_char(i.due_date+(10),'dd-mm-yyyy') as duedate,"
                    + "i.subject,to_char(i.due_date,'dd-mm-yyyy') as\n"
                    + " originalDueDate from issue i,issuestatus s where pid=" + pId + " and module_id=" + mId + " and i.due_date > sysdate-1\n"
                    + " and i.issueid =s.issueid and s.status<>'Closed' and (upper(i.escalation) ='NO' or i.escalation is null) and i.ISSUEID not in (SELECT a.ISSUEID FROM APM_WRM_PLAN a WHERE a.wrmday = (select MAX(b.wrmday) from APM_WRM_PLAN b where b.pid=" + pId + ") AND a.pid=" + pId + ")\n"
                    + "";
            connection = MakeConnection.getConnection();
            logger.info(sql);
            ps = connection.prepareStatement(sql, ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            resultSet = ps.executeQuery();
            resultSet.last();
            rowcount = resultSet.getRow();
            prposedIssue = new String[rowcount][8];
            resultSet.beforeFirst();
            int count = 0;
            while (resultSet.next()) {

                prposedIssue[count][0] = resultSet.getString("issueid");
                prposedIssue[count][1] = resultSet.getString("status");
                prposedIssue[count][2] = resultSet.getString("assignedto");
                prposedIssue[count][3] = resultSet.getString("severity");
                prposedIssue[count][4] = resultSet.getString("priority");
                prposedIssue[count][5] = resultSet.getString("duedate");
                prposedIssue[count][6] = resultSet.getString("subject");
                prposedIssue[count][7] = resultSet.getString("originalDueDate");

                count++;

            }
        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            try {
                ps.close();
            } catch (Exception e) {
                logger.error(e.getMessage());
            }
            try {
                resultSet.close();
            } catch (Exception e) {
                logger.error(e.getMessage());
            }
            try {
                connection.close();
            } catch (Exception e) {
                logger.error(e.getMessage());
            }

        }
        return prposedIssue;
    }

    public static Map<String, Integer> bgcount(String userid) {
        Map<String, Integer> counts = new HashMap<String, Integer>();
        Connection dbConnection = null;
        CallableStatement callableStatement = null;
        int bgcount = 0;
        int cwcount = 0;
        int nwcount = 0;
        int atwcount = 0;
        int allcount = 0;
        int tcecount = 0;
        int wapcount = 0;
        int tmscount = 0;
        String createbgSql = "{call ASSIGNMENTCOUNTS(?,?,?,?,?,?,?,?,?)}";
        try {
            dbConnection = MakeConnection.getConnection();
            callableStatement = dbConnection.prepareCall(createbgSql);
            callableStatement.setString(1, userid);
            callableStatement.registerOutParameter(2, java.sql.Types.NUMERIC);
            callableStatement.registerOutParameter(3, java.sql.Types.NUMERIC);
            callableStatement.registerOutParameter(4, java.sql.Types.NUMERIC);
            callableStatement.registerOutParameter(5, java.sql.Types.NUMERIC);
            callableStatement.registerOutParameter(6, java.sql.Types.NUMERIC);
            callableStatement.registerOutParameter(7, java.sql.Types.NUMERIC);
            callableStatement.registerOutParameter(8, java.sql.Types.NUMERIC);
            callableStatement.registerOutParameter(9, java.sql.Types.NUMERIC);
            int eows = callableStatement.executeUpdate();

            if (eows != 0) {
                bgcount = callableStatement.getInt(2);
                cwcount = callableStatement.getInt(3);
                nwcount = callableStatement.getInt(4);
                atwcount = callableStatement.getInt(5);
                allcount = callableStatement.getInt(6);
                tcecount = callableStatement.getInt(7);
                wapcount = callableStatement.getInt(8);
                tmscount = callableStatement.getInt(9);

            } else {
            }
            counts.put("bgcount", bgcount);
            counts.put("cwcount", cwcount);
            counts.put("nwcount", nwcount);
            counts.put("atwcount", atwcount);
            counts.put("allcount", allcount);
            counts.put("tcecount", tcecount);
            counts.put("wapcount", wapcount);
            counts.put("tmscount", tmscount);
        } catch (Exception ex) {
            logger.error(ex.getMessage());
        } finally {

            if (callableStatement != null) {
                try {
                    callableStatement.close();
                } catch (SQLException ex) {
                    logger.error(ex.getMessage());
                }
            }

            if (dbConnection != null) {
                try {
                    dbConnection.close();
                } catch (SQLException ex) {
                    logger.error(ex.getMessage());
                }
            }

        }
        return counts;
    }

    public static List<String> plannedForList() {
        List<String> plannedForList = new ArrayList<String>();
        plannedForList.add("Today");
        plannedForList.add("Next Working Day");
        return plannedForList;
    }

    public static Map issueAsignee(String issuenos) throws SQLException {
        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        long startTime = System.currentTimeMillis();
        String query = "";
        String modifiedQuery = "";

        String issues[] = issuenos.split(",");
        if (issues.length > 1000) {

            int j = issues.length / 1000;
            int l = issues.length % 1000;
            if (l != 0) {
                j = j + 1;
            }
            for (int k = 1; k <= j; k++) {
                String totalIssue = "";
                int start = (1000 * (k - 1));
                int end = 1000 * (k);
                if (end > issues.length) {
                    end = issues.length;
                }
                logger.info("start,end" + start + "," + end);
                for (int i = start; i < end; i++) {
                    if (issues[i] != null) {
                        totalIssue = totalIssue + issues[i] + ",";
                    }
                }
                if (!"".equals(totalIssue)) {
                    totalIssue = totalIssue.substring(0, totalIssue.length() - 1);
                }
                if ("".equals(modifiedQuery)) {
                    modifiedQuery = modifiedQuery + "(i.issueid in (" + totalIssue + ")";
                } else {
                    modifiedQuery = modifiedQuery + " OR i.issueid in (" + totalIssue + ")";
                }
            }
            query = "select i.issueid ,i.assignedTo from issue i, issuestatus s where " + modifiedQuery + ") and i.issueid=s.issueid and s.status<>'Closed'";
        } else {
            query = "select i.issueid ,i.assignedTo from issue, issuestatus s  where i.issueid in (" + issuenos + ") and i.issueid=s.issueid and s.status<>'Closed'";
        }
        Map<String, Integer> issueAsigneeList = new HashMap<String, Integer>();
        try {
            connection = MakeConnection.getConnection();
            statement = connection.createStatement();
            logger.info(query);
            resultset = statement.executeQuery(query);

            while (resultset.next()) {
                String issueid = resultset.getString(1);
                int userId = resultset.getInt(2);

                issueAsigneeList.put(issueid, userId);
            }
            long endTime = System.currentTimeMillis();
            logger.info("Total time taken for retirving" + (endTime - startTime) / 1000);

        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            if (resultset != null) {
                resultset.close();
            }
            if (statement != null) {
                statement.close();
            }
            if (connection != null) {
                connection.close();
                logger.info("connection closed");
            }
        }
        return issueAsigneeList;
    }

    public static List<LastAssginForm> lastAssign() throws SQLException {
        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        List<LastAssginForm> lastAsigneeList = new ArrayList<LastAssginForm>();
        try {
            connection = MakeConnection.getConnection();
            statement = connection.createStatement();
            resultset = statement.executeQuery("select * from LASTASSIGNEENAME");
            while (resultset.next()) {
                LastAssginForm lastAssginForm = new LastAssginForm();
                lastAssginForm.setIssueId(resultset.getString(1));
                lastAssginForm.setLastAssigneeName(resultset.getString(2));
                lastAssginForm.setLastModifiedOn(resultset.getString(3));
                lastAssginForm.setEmail(resultset.getString(4));
                lastAsigneeList.add(lastAssginForm);
            }
        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            if (resultset != null) {
                resultset.close();
            }
            if (statement != null) {
                statement.close();
            }
            if (connection != null) {
                connection.close();
                logger.info("connection closed");
            }
        }
        return lastAsigneeList;
    }

    public static List<IssueSearchFormBean> eTrackerIssueSearch(String searchQuery, String issueId) throws SQLException {
        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        List<IssueSearchFormBean> searchResults = new ArrayList<IssueSearchFormBean>();
        try {
            connection = MakeConnection.getConnection();
            statement = connection.createStatement();
            String query = "SELECT issueid, subject FROM issue WHERE CONTAINS(subject , 'about(" + URLEncoder.encode(searchQuery, "UTF-8") + ")', 1) > 0 and issueid <> '" + issueId.trim() + "' ORDER BY SCORE(1) DESC";
            resultset = statement.executeQuery(query);
            logger.info(query);

            while (resultset.next()) {

                IssueSearchFormBean isfb = new IssueSearchFormBean();
                isfb.setIssueId(resultset.getString("issueid"));
                isfb.setSubject(resultset.getString("subject"));
                searchResults.add(isfb);
            }

        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            if (resultset != null) {
                resultset.close();
            }
            if (statement != null) {
                statement.close();
            }
            if (connection != null) {
                connection.close();
                logger.info("connection closed");
            }
        }
        return searchResults;
    }

    public static int eTrackerIssueSearchCount(String searchQuery, String issueId) throws SQLException {
        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        int count = 0;
        try {
            connection = MakeConnection.getConnection();
            statement = connection.createStatement();
            String query = "";
            if (searchQuery == null) {
                HashMap subMap = IssueDetails.getIssue(issueId.trim());
                if (subMap.get("subject") != null) {
                    String sub = (String) subMap.get("subject");
                    query = "SELECT Count(*) as count FROM issue WHERE CONTAINS(subject , 'about(" + URLEncoder.encode(sub, "UTF-8") + ")', 1) > 0 and issueid <> '" + issueId.trim() + "' ORDER BY SCORE(1) DESC";
                } else {
                    query = "SELECT Count(*) as count FROM issue WHERE CONTAINS(subject , 'about(!##############################!@#!@!)', 1) > 0 and issueid <> '" + issueId.trim() + "' ORDER BY SCORE(1) DESC";
                }

            } else {
                query = "SELECT Count(*) as count FROM issue WHERE CONTAINS(subject , 'about(" + URLEncoder.encode(searchQuery, "UTF-8") + ")', 1) > 0 and issueid <> '" + issueId.trim() + "' ORDER BY SCORE(1) DESC";
            }
            logger.info(query);

            resultset = statement.executeQuery(query);

            while (resultset.next()) {

                count = resultset.getInt("count");

            }

        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            if (resultset != null) {
                resultset.close();
            }
            if (statement != null) {
                statement.close();
            }
            if (connection != null) {
                connection.close();
                logger.info("connection closed");
            }
        }
        return count;
    }

    public static int findMaxMatch(String input, List<String> names) {
        int count = 0;
        for (String str : names) {
            if (input.contains(str)) {
                count++;
            }
        }
        return count;
    }

    public static String maxMatch(String input, List<String> names) {
        for (String name : names) {
            int i = input.indexOf(name);
            if (i > -1) {
                return name;
            }
        }
        return null;
    }

    public static List<String> ignoreWords() {
        List<String> words = new ArrayList<String>();
        words.add("A");
        words.add("AN");
        words.add("THE");
        words.add("AND");
        words.add("OR");
        words.add("ABOUT");
        words.add("IS");
        words.add("WAS");
        words.add("ISSUE");
        words.add("AS");
        words.add("IT");
        return words;

    }

    public static int matcher(String subject, String orgSubject) {
        int count = 0;

        orgSubject = "\\B" + orgSubject.replaceAll(" ", "|") + "\\B";

        Pattern pattern = Pattern.compile(orgSubject, Pattern.CASE_INSENSITIVE);
        Matcher matcher = pattern.matcher(orgSubject);
        while (matcher.find()) {
            count++;
        }
        return count;
    }

    public static Map<String, List<IssueHistory>> checkIssueHistory(String searchsql, Map<Integer, String> member) {
        SimpleDateFormat sdf = new SimpleDateFormat("dd-MMM-yyyy");
        Connection connection = null;
        PreparedStatement statement = null;
        ResultSet resultset = null;
        Map<String, List<IssueHistory>> issuesHistoryMap = new LinkedHashMap<String, List<IssueHistory>>();
        try {
            connection = MakeConnection.getConnection();
            String query = "select ic.issueid ,to_char(comment_date,'dd-MM-yyyy') as commentdate,commentedby,commentedto  from issuecomments ic,(" + searchsql + ")filt where  filt.issueid=ic.issueid and comments not like 'Due date is realigned because of issue#%' and COMMENTEDTO is not null and COMMENTEDTO <> 'Nil' order by ic.issueid,comment_date";

            //   String query = "select issueid ,to_char(comment_date,'dd-MM-yyyy') as commentdate,commentedby,commentedto,status  from issuecomments where " + extededQuery + " and comments not like 'Due date is realigned because of issue#%' and COMMENTEDTO is not null and COMMENTEDTO <> 'Nil' order by issueid,comment_date";
            statement = connection.prepareStatement(query, ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            resultset = statement.executeQuery();
            Integer prevCommentedby = null;
            String prevCommentDate = null;
            Integer prevCommentedTo = null;
            String prestatus = "";

            resultset.last();
            int size = resultset.getRow();
            resultset.beforeFirst();
            List<IssueHistory> issueHistoryList = new ArrayList<IssueHistory>();
            int counter = 0;
            IssueHistory issueHistory = new IssueHistory();
            String issue = "";

            while (resultset.next()) {
                String status = "";

                String issueId = resultset.getString("issueid");
                String commentedBystring = resultset.getString("commentedby");
                Integer commentedby = MoMUtil.parseInteger(commentedBystring, 0);

                String commentedTostring = resultset.getString("commentedto");
                Integer commentedTo = MoMUtil.parseInteger(commentedTostring, 0);
                String commentDate = resultset.getString("commentdate");

                if (issue.equalsIgnoreCase("")) {
                    counter++;
                    issue = issueId;
                    issueHistory.setUserName(member.get(commentedby));
                    issueHistory.setUserId(commentedby);
                    issueHistory.setDays(0);
                    prevCommentedby = commentedby;
                    prevCommentDate = commentDate;
                    prevCommentedTo = commentedTo;
                    if (commentedTo.intValue() != commentedby.intValue()) {
                        issueHistoryList.add(issueHistory);
                        issueHistory.setStatus(status);
                        issueHistory = new IssueHistory();
                        issueHistory.setDays(0);
                        issueHistory.setUserId(commentedTo);
                        issueHistory.setUserName(member.get(commentedTo));
                    }
                    prestatus = status;
                } else if (issue.equalsIgnoreCase(issueId)) {
                    if (prevCommentedTo.intValue() == commentedTo.intValue()) {
                        int days = MoMUtil.getDays(prevCommentDate, commentDate);
                        if (days == 0) {
                            days = 1;
                        }
                        issueHistory.setDays(days);
                        prevCommentedby = commentedby;
                        prevCommentedTo = commentedTo;
                    } else {
                        int days = MoMUtil.getDays(prevCommentDate, commentDate);
                        if (days == 0) {
                            days = 1;
                        }
                        issueHistory.setStatus(prestatus);
                        issueHistory.setDays(days);
                        issueHistoryList.add(issueHistory);

                        issueHistory = new IssueHistory();
                        issueHistory.setDays(0);
                        issueHistory.setUserName(member.get(commentedTo));
                        issueHistory.setUserId(commentedTo);
                        prevCommentedby = commentedby;
                        prevCommentDate = commentDate;
                        prevCommentedTo = commentedTo;
                    }
                    prestatus = status;
                    counter++;
                } else {
                    counter++;

                    issueHistory.setStatus(prestatus);
                    if (prestatus.equalsIgnoreCase("Closed")) {
                        issueHistory.setDays(1);
                        issueHistoryList.add(issueHistory);
                    } else {
                        String lastdate = sdf.format(new Date());
                        int days = MoMUtil.getDays(prevCommentDate, lastdate);
                        if (days == 0) {
                            days = 1;
                        }
                        issueHistory.setDays(days);
                        issueHistoryList.add(issueHistory);
                    }

                    issuesHistoryMap.put(issue, issueHistoryList);

                    issue = issueId;
                    issueHistory = new IssueHistory();
                    issueHistoryList = new ArrayList<IssueHistory>();

                    prevCommentedby = null;
                    prevCommentDate = null;
                    prevCommentedTo = null;

                    issueHistory.setDays(0);
                    issueHistory.setUserName(member.get(commentedby));
                    issueHistory.setUserId(commentedby);
                    prevCommentedby = commentedby;
                    prevCommentDate = commentDate;
                    prevCommentedTo = commentedTo;

                    if (commentedTo.intValue() != commentedby.intValue()) {
                        issueHistoryList.add(issueHistory);
                        issueHistory.setStatus(status);
                        issueHistory = new IssueHistory();
                        issueHistory.setDays(1);
                        issueHistory.setUserName(member.get(commentedTo));
                        issueHistory.setUserId(commentedTo);
                    }
                    prestatus = status;
                }

                if (counter == size) {
                    issueHistory.setStatus(status);
                    if (status.equalsIgnoreCase("Closed")) {
                        issueHistory.setDays(1);
                        issueHistoryList.add(issueHistory);
                    } else {
                        String lastdate = sdf.format(new Date());
                        int days = MoMUtil.getDays(prevCommentDate, lastdate);
                        if (days == 0) {
                            days = 1;
                        }
                        issueHistory.setDays(days);
                        issueHistoryList.add(issueHistory);
                    }
                    issuesHistoryMap.put(issue, issueHistoryList);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
            logger.error(e.getMessage());
        } finally {
            if (resultset != null) {
                try {
                    resultset.close();
                } catch (SQLException ex) {
                    java.util.logging.Logger.getLogger(MoMUtil.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
            if (statement != null) {
                try {
                    statement.close();
                } catch (SQLException ex) {
                    java.util.logging.Logger.getLogger(MoMUtil.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
            if (connection != null) {
                try {
                    connection.close();
                    logger.info("connection closed");
                } catch (SQLException ex) {
                    java.util.logging.Logger.getLogger(MoMUtil.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
        }
        return issuesHistoryMap;
    }

    public static Map<String, Integer> subIssueCount(String issuenos) {
        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        String query = "";
        Map<String, Integer> files = new HashMap<String, Integer>();
        try {
            String issues[] = issuenos.split(",");
            if (issues.length > 1000) {

                int j = issues.length / 1000;
                int l = issues.length % 1000;
                if (l != 0) {
                    j = j + 1;
                }
                for (int k = 1; k <= j; k++) {
                    String totalIssue = "";
                    int start = (1000 * (k - 1));
                    int end = 1000 * (k);
                    if (end > issues.length) {
                        end = issues.length;
                    }
                    for (int i = start; i < end; i++) {
                        if (issues[i] != null) {
                            totalIssue = totalIssue + issues[i] + ",";
                        }
                    }
                    if (!"".equals(totalIssue)) {
                        totalIssue = totalIssue.substring(0, totalIssue.length() - 1);
                    }
                    query = "select count(*),main_issue_id from issue_link where main_issue_id in(" + totalIssue + ") group by main_issue_id";
                }
            } else {
                query = "select count(*),main_issue_id from issue_link where main_issue_id in(" + issuenos + ") group by main_issue_id";
            }

            connection = MakeConnection.getConnection();
            statement = connection.createStatement();
            resultset = statement.executeQuery(query);
            while (resultset.next()) {
                files.put(resultset.getString(2), resultset.getInt(1));
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
                logger.error(ex.getMessage());
            }
        }
        return files;
    }

    public static String[][] getSubIssues(String issue) {
        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        String total[][] = null;
        String sql = "select i.issueid, pname as project, type, s.status, subject, description, priority, severity, createdby, createdon, assignedto, modifiedon, due_date,rating,feedback,module,ceil(to_number(sysdate-to_date(createdon)))as age  from issue i,issuestatus s,project p,modules m,issue_link l where i.issueid = s.issueid and i.issueid = l.SUB_ISSUE_ID and  i.pid = p.pid and i.module_id=m.moduleid and  l.MAIN_ISSUE_ID='" + issue + "'    order by module asc,due_date asc, modifiedon asc, type asc, priority asc, severity asc, createdon asc";
        try {
            connection = MakeConnection.getConnection();
            statement = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);

            resultset = statement.executeQuery(sql);
            resultset.last();
            int rowcount = resultset.getRow();
            resultset.beforeFirst();
            int column = 17;

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
                issues[i][16] = resultset.getString(17);

                i++;
                logger.info("Adding record no" + i);
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

    public static Map<String, List<IssueHistory>> checkIssueAgeHistory(String searchsql, Map<Integer, String> member) {
        SimpleDateFormat sdf = new SimpleDateFormat("dd-MMM-yyyy");
        Connection connection = null;
        PreparedStatement statement = null;
        ResultSet resultset = null;
        Map<String, List<IssueHistory>> issuesHistoryMap = new LinkedHashMap<String, List<IssueHistory>>();

        try {
            connection = MakeConnection.getConnection();
            String query = "select ic.issueid ,to_char(comment_date,'dd-MM-yyyy') as commentdate,commentedby,commentedto  from issuecomments ic,(" + searchsql + ")filt where  filt.issueid=ic.issueid and comments not like 'Due date is realigned because of issue#%' and COMMENTEDTO is not null and COMMENTEDTO <> 'Nil' order by ic.issueid,comment_date";

            //   String query = "select issueid ,to_char(comment_date,'dd-MM-yyyy') as commentdate,commentedby,commentedto,status  from issuecomments where " + extededQuery + " and comments not like 'Due date is realigned because of issue#%' and COMMENTEDTO is not null and COMMENTEDTO <> 'Nil' order by issueid,comment_date";
            logger.info(query);
            statement = connection.prepareStatement(query, ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            resultset = statement.executeQuery();
            Integer prevCommentedby = null;
            String prevCommentDate = null;
            Integer prevCommentedTo = null;
            String prestatus = "";

            resultset.last();
            int size = resultset.getRow();
            resultset.beforeFirst();
            List<IssueHistory> issueHistoryList = new ArrayList<IssueHistory>();
            int counter = 0;
            IssueHistory issueHistory = new IssueHistory();
            String issue = "";

            while (resultset.next()) {

                String status = "";

                String issueId = resultset.getString("issueid");
                String commentedBystring = resultset.getString("commentedby");
                Integer commentedby = MoMUtil.parseInteger(commentedBystring, 0);

                String commentedTostring = resultset.getString("commentedto");
                Integer commentedTo = MoMUtil.parseInteger(commentedTostring, 0);
                String commentDate = resultset.getString("commentdate");

//                if(counter==0){
//                    prevCommentedby = commentedby;
//                    prevCommentDate = commentDate;
//                    prevCommentedTo = commentedTo;
//                    
//                }else if(counter==1){
//                    
//                }else{
                //}
                if (issue.equalsIgnoreCase("")) {
                    counter++;
                    issue = issueId;
//                    issueHistory.setUserName(member.get(commentedby));
//                    issueHistory.setDays(1);
                    prevCommentedby = commentedby;
                    prevCommentDate = commentDate;
                    prevCommentedTo = commentedTo;
                    if (commentedTo.intValue() != commentedby.intValue()) {
//                        issueHistoryList.add(issueHistory);
//                        issueHistory.setStatus(status);
//                        issueHistory = new IssueHistory();
//                        issueHistory.setDays(1);

                        issueHistory.setUserName(member.get(commentedTo));
                    }
                    prestatus = status;
                } else if (issue.equalsIgnoreCase(issueId)) {
                    if (prevCommentedTo.intValue() == commentedTo.intValue()) {
                        int days = MoMUtil.getDays(prevCommentDate, commentDate);
                        if (days == 0) {
                            days = 1;
                        }
                        issueHistory.setDays(days);
                        prevCommentedby = commentedby;
                        prevCommentedTo = commentedTo;
                    } else {
                        int days = MoMUtil.getDays(prevCommentDate, commentDate);
                        if (days == 0) {
                            days = 1;
                        }
                        issueHistory.setStatus(prestatus);
                        issueHistory.setDays(days);
                        issueHistoryList.add(issueHistory);

                        issueHistory = new IssueHistory();
                        issueHistory.setDays(0);
                        issueHistory.setUserName(member.get(commentedTo));

                        prevCommentedby = commentedby;
                        prevCommentDate = commentDate;
                        prevCommentedTo = commentedTo;
                    }
                    prestatus = status;
                    counter++;
                } else {
                    counter++;

                    issueHistory.setStatus(prestatus);
                    if (prestatus.equalsIgnoreCase("Closed")) {
                        issueHistory.setDays(1);
                        issueHistoryList.add(issueHistory);
                    } else {
                        String lastdate = sdf.format(new Date());
                        int days = MoMUtil.getDays(prevCommentDate, lastdate);
                        if (days == 0) {
                            days = 1;
                        }
                        issueHistory.setDays(days);
                        issueHistoryList.add(issueHistory);
                    }

                    issuesHistoryMap.put(issue, issueHistoryList);

                    issue = issueId;
                    issueHistory = new IssueHistory();
                    issueHistoryList = new ArrayList<IssueHistory>();

                    prevCommentedby = null;
                    prevCommentDate = null;
                    prevCommentedTo = null;

                    issueHistory.setDays(1);
                    issueHistory.setUserName(member.get(commentedby));

                    prevCommentedby = commentedby;
                    prevCommentDate = commentDate;
                    prevCommentedTo = commentedTo;

                    if (commentedTo.intValue() != commentedby.intValue()) {
                        issueHistoryList.add(issueHistory);
                        issueHistory.setStatus(status);
                        issueHistory = new IssueHistory();
                        issueHistory.setDays(1);
                        issueHistory.setUserName(member.get(commentedTo));
                    }
                    prestatus = status;
                }

                if (counter == size) {
                    issueHistory.setStatus(status);
                    if (status.equalsIgnoreCase("Closed")) {
                        issueHistory.setDays(1);
                        issueHistoryList.add(issueHistory);
                    } else {
                        String lastdate = sdf.format(new Date());
                        int days = MoMUtil.getDays(prevCommentDate, lastdate);
                        if (days == 0) {
                            days = 1;
                        }
                        issueHistory.setDays(days);
                        issueHistoryList.add(issueHistory);
                    }
                    issuesHistoryMap.put(issue, issueHistoryList);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
            logger.error(e.getMessage());
        } finally {
            if (resultset != null) {
                try {
                    resultset.close();
                } catch (SQLException ex) {
                    java.util.logging.Logger.getLogger(MoMUtil.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
            if (statement != null) {
                try {
                    statement.close();
                } catch (SQLException ex) {
                    java.util.logging.Logger.getLogger(MoMUtil.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
            if (connection != null) {
                try {
                    connection.close();
                    logger.info("connection closed");
                } catch (SQLException ex) {
                    java.util.logging.Logger.getLogger(MoMUtil.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
        }
        return issuesHistoryMap;
    }

}
