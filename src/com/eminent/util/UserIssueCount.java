/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eminent.util;

import java.sql.Connection;
import pack.eminent.encryption.MakeConnection;
import java.sql.ResultSet;
import java.sql.Statement;
import org.apache.log4j.Logger;
import java.util.HashMap;
import java.util.GregorianCalendar;
import java.util.Calendar;

/**
 *
 * @author Balaguru Ramasamy
 */
public class UserIssueCount {

    private static HashMap<Integer, String> monthSelect = new HashMap<Integer, String>();

    static {

        monthSelect.put(0, "Jan");
        monthSelect.put(1, "Feb");
        monthSelect.put(2, "Mar");
        monthSelect.put(3, "Apr");
        monthSelect.put(4, "May");
        monthSelect.put(5, "Jun");
        monthSelect.put(6, "Jul");
        monthSelect.put(7, "Aug");
        monthSelect.put(8, "Sep");
        monthSelect.put(9, "Oct");
        monthSelect.put(10, "Nov");
        monthSelect.put(11, "Dec");

    }

    static Logger logger = null;

    static {
        logger = Logger.getLogger("UserIssueCount");

    }

    public static int getAssignmentCount(String userId) {

        Connection connection = null;
        Statement st = null;
        ResultSet rs = null;
        int count = 0;

        try {
            connection = MakeConnection.getConnection();
            st = connection.createStatement();
            rs = st.executeQuery("select count(*) count from issue i, issuestatus s where i.issueid = s.issueid and status != 'Closed' and assignedto = '" + userId + "' ");
            if (rs.next()) {
                count = rs.getInt("count");

            }

        } catch (Exception e) {
            logger.error("Error while finding the count"+e.getMessage());
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (st != null) {
                    st.close();
                }

                if (connection != null) {
                    connection.close();
                }
            } catch (Exception ex) {
                logger.error("Error while finding the flag"+ex.getMessage());
            }
        }

        return count;

    }

    public static int getAssignmentWithTypeCount(String query) {

        Connection connection = null;
        Statement st = null;
        ResultSet rs = null;
        int count = 0;

        try {
            connection = MakeConnection.getConnection();
            st = connection.createStatement();
            rs = st.executeQuery(query);
            if (rs.next()) {
                count = rs.getInt("count");
            }

        } catch (Exception e) {
            logger.error("Error while finding the count"+e.getMessage());
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (st != null) {
                    st.close();
                }

                if (connection != null) {
                    connection.close();
                }
            } catch (Exception ex) {
                logger.error("Error while finding the flag"+ex.getMessage());
            }
        }

        return count;

    }

    public static int getOwnCount(String userId) {

        int adminid = GetProjectMembers.getAdminID();

        Connection connection = null;
        Statement st = null;
        ResultSet rs = null;
        int count = 0;

        try {
            connection = MakeConnection.getConnection();
            st = connection.createStatement();
            rs = st.executeQuery("select count(*) count from issue i, issuestatus s,project p where i.issueid = s.issueid and i.pid = p.pid and p.STATUS='Work in progress' And pmanager <> " + adminid + " and s.status != 'Closed' and i.createdby = '" + userId + "' ");
            if (rs.next()) {
                count = rs.getInt("count");

            }

        } catch (Exception e) {
            logger.error("Error while finding the count"+e.getMessage());
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (st != null) {
                    st.close();
                }

                if (connection != null) {
                    connection.close();
                }
            } catch (Exception ex) {
                logger.error("Error while finding the flag"+ex.getMessage());
            }
        }

        return count;

    }

    public static int getQueryCount(String userId) {

        Connection connection = null;
        Statement st = null;
        ResultSet rs = null;
        int count = 0;

        try {
            connection = MakeConnection.getConnection();
            st = connection.createStatement();
            rs = st.executeQuery("select count(*) count from myquery where email = ( select email from users where userid = '" + userId + "')");
            if (rs.next()) {
                count = rs.getInt("count");

            }

        } catch (Exception e) {
            logger.error("Error while finding the count"+ e.getMessage());
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (st != null) {
                    st.close();
                }

                if (connection != null) {
                    connection.close();
                }
            } catch (Exception ex) {
                logger.error("Error while finding the flag"+ex.getMessage());
            }
        }

        return count;

    }

    public static int getTimeSheetIssueCount(String userId) {

        Connection connection = null;
        Statement st = null;
        ResultSet rs = null;
        int count = 0;
        String start, end;
        //calculating start and end date of this month
        Calendar cal = new GregorianCalendar();

        int year = cal.get(Calendar.YEAR);
        int month = cal.get(Calendar.MONTH);
        int maxday = cal.getActualMaximum(cal.DAY_OF_MONTH);

        logger.info("Year" + year);
        logger.info("Month" + monthSelect.get(month));

        logger.info("MAX DAY of MOnth" + maxday);
        start = "1" + "-" + monthSelect.get(month) + "-" + year;
        end = maxday + "-" + monthSelect.get(month) + "-" + year;
        logger.info("Start Date" + start);
        logger.info("End Date" + end);
        String sqlQuery = "select distinct issuecomments.issueid, modifiedon from issuecomments,issue where issue.issueid=issuecomments.issueid and to_date(to_char(comment_date,'DD-Mon-YY'), 'DD-Mon-YY') between '" + start + "' and '" + end + "' and commentedto='" + userId + "' and commentedby='" + userId + "' order by modifiedon desc";
        logger.info(sqlQuery);

        try {
            connection = MakeConnection.getConnection();
            st = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            rs = st.executeQuery("select distinct issuecomments.issueid, modifiedon from issuecomments,issue where issue.issueid=issuecomments.issueid and to_date(to_char(comment_date,'DD-Mon-YY'), 'DD-Mon-YY') between '" + start + "' and '" + end + "' and commentedto='" + userId + "' and commentedby='" + userId + "' order by modifiedon desc");
            rs.last();

            count = rs.getRow();

        } catch (Exception e) {
            logger.error("Error while finding the count"+e.getMessage());
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (st != null) {
                    st.close();
                }

                if (connection != null) {
                    connection.close();
                }
            } catch (Exception ex) {
                logger.error("Error while finding the flag"+ex.getMessage());
            }
        }

        return count;

    }

}
