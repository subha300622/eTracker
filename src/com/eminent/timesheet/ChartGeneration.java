package com.eminent.timesheet;

import com.eminent.hibernate.HibernateUtil;
import com.eminent.util.IssueDetails;
import com.eminentlabs.dao.HibernateFactory;
import com.eminentlabs.mom.MoMUtil;
import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.GregorianCalendar;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import org.apache.log4j.Logger;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import pack.eminent.encryption.MakeConnection;

/**
 *
 * @author Administrator
 */
public class ChartGeneration {

    static Logger logger = Logger.getLogger("ChartGeneration");
    private static final HashMap<Integer, String> monthSelect = new HashMap<Integer, String>();

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

    public static String[][] getValue(int userId) {
        Calendar c = new GregorianCalendar();
        int month = c.get(Calendar.MONTH);
        int year = c.get(Calendar.YEAR);
        c.add(Calendar.MONTH, -11);
        String monthValue[][] = new String[12][12];
        for (int i = 0; i <= 11; i++) {
            month = c.get(Calendar.MONTH);
            year = c.get(Calendar.YEAR);
            c.add(Calendar.MONTH, 1);
            String mon = monthSelect.get(month) + "-" + year;

            // Timesheet Id generation
            String timeSheetId = "T";
            if (month > 9) {
                timeSheetId = timeSheetId + month + year + userId;
            } else {
                timeSheetId = timeSheetId + "0" + month + year + userId;
            }

            Timesheet timesheet = CreateTimeSheet.GetTimeSheetDetails(timeSheetId);

            Calendar cale = Calendar.getInstance();
            cale.set(year, month, 1);
            int maxday = cale.getActualMaximum(Calendar.DATE);
            String start = "1" + "-" + monthSelect.get(month) + "-" + year;
            String end = maxday + "-" + monthSelect.get(month) + "-" + year;
            int workedIssues = getWorkedIssues(start, end, userId);
            int closedIssues = getClosedIssues(start, end, userId);
            int createdIssues = getCreatedIssues(start, end, userId);
            int approvalPerc = GetApprovalPercentage(timeSheetId, userId);
            monthValue[i][0] = mon;
            monthValue[i][1] = ((Integer) workedIssues).toString();
            monthValue[i][2] = ((Integer) closedIssues).toString();
            monthValue[i][3] = ((Integer) createdIssues).toString();
            monthValue[i][4] = ((Integer) month).toString();
            monthValue[i][11] = ((Integer) approvalPerc).toString();

            if (timesheet != null) {

                BigDecimal wor = timesheet.getWorkingdays();
                BigDecimal att = timesheet.getAttendance();

                if (!(wor == null)) {
                    monthValue[i][5] = ((BigDecimal) wor).toString();
                    monthValue[i][6] = ((BigDecimal) att).toString();

                } else {
                    monthValue[i][5] = "0";
                    monthValue[i][6] = "0";

                }
            } else {
                monthValue[i][5] = "0";
                monthValue[i][6] = "0";

            }
            monthValue[i][7] = ((Integer) displayCRMIssues(userId, start, end, "Contact")).toString();
            monthValue[i][8] = ((Integer) displayCRMIssues(userId, start, end, "Lead")).toString();
            monthValue[i][9] = ((Integer) displayCRMIssues(userId, start, end, "Opportunity")).toString();
            monthValue[i][10] = ((Integer) displayCRMIssues(userId, start, end, "Account")).toString();

        }
        return monthValue;
    }

    public static String[][] getSelectedValue(int userId, Calendar sel) {
        Calendar c = sel;
        int month = c.get(Calendar.MONTH);
        int year = c.get(Calendar.YEAR);
//        c.add(Calendar.MONTH, -11);
        String monthValue[][] = new String[12][12];
        for (int i = 0; i <= 11; i++) {
            month = c.get(Calendar.MONTH);
            year = c.get(Calendar.YEAR);
            c.add(Calendar.MONTH, 1);
            String mon = monthSelect.get(month) + "-" + year;

            // Timesheet Id generation
            String timeSheetId = "T";
            if (month > 9) {
                timeSheetId = timeSheetId + month + year + userId;
            } else {
                timeSheetId = timeSheetId + "0" + month + year + userId;
            }

            Timesheet timesheet = CreateTimeSheet.GetTimeSheetDetails(timeSheetId);

            Calendar cale = Calendar.getInstance();
            cale.set(year, month, 1);
            int maxday = cale.getActualMaximum(Calendar.DATE);
            String start = "1" + "-" + monthSelect.get(month) + "-" + year;
            String end = maxday + "-" + monthSelect.get(month) + "-" + year;
            int workedIssues = getWorkedIssues(start, end, userId);
            int closedIssues = getClosedIssues(start, end, userId);
            int createdIssues = getCreatedIssues(start, end, userId);
            int approvalPerc = GetApprovalPercentage(timeSheetId, userId);
            monthValue[i][0] = mon;
            monthValue[i][1] = ((Integer) workedIssues).toString();
            monthValue[i][2] = ((Integer) closedIssues).toString();
            monthValue[i][3] = ((Integer) createdIssues).toString();
            monthValue[i][4] = ((Integer) month).toString();
            monthValue[i][11] = ((Integer) approvalPerc).toString();

            if (timesheet != null) {

                BigDecimal wor = timesheet.getWorkingdays();
                BigDecimal att = timesheet.getAttendance();

                if (!(wor == null)) {
                    monthValue[i][5] = ((BigDecimal) wor).toString();
                    monthValue[i][6] = ((BigDecimal) att).toString();

                } else {
                    monthValue[i][5] = "0";
                    monthValue[i][6] = "0";

                }
            } else {
                monthValue[i][5] = "0";
                monthValue[i][6] = "0";

            }
            monthValue[i][7] = ((Integer) displayCRMIssues(userId, start, end, "Contact")).toString();
            monthValue[i][8] = ((Integer) displayCRMIssues(userId, start, end, "Lead")).toString();
            monthValue[i][9] = ((Integer) displayCRMIssues(userId, start, end, "Opportunity")).toString();
            monthValue[i][10] = ((Integer) displayCRMIssues(userId, start, end, "Account")).toString();

        }
        return monthValue;
    }

    public static Map myTimeWiseDashboardValues(int userId, int checkUser) {
        Map<String, Integer> issuesList = new LinkedHashMap<String, Integer>();
        Calendar cal = Calendar.getInstance();
        int weekOfYear = cal.get(Calendar.WEEK_OF_YEAR);
        logger.info(weekOfYear);
        int issueCount = getBacklogIssues(userId, checkUser);
        issuesList.put("Backlog", issueCount);
        int j = 0;
        for (int i = 0; i < 10; i++) {
            if (i == 0) {
                issueCount = getCurrentWeekIssues(userId, checkUser);
                issuesList.put("Week" + (weekOfYear + i), issueCount);
            } else {
                issueCount = weekWiseIssues(((i - 1) * 7) + 1, ((i - 1) * 7) + 8, userId, checkUser);
                if (weekOfYear + i > 53) {
                    j++;
                    weekOfYear = j - i;
                }
                issuesList.put("Week" + (weekOfYear + i), issueCount);

            }
        }
        logger.info(issuesList);

        return issuesList;
    }

    public static int getBacklogIssues(int userId, int checkUser) {
        int noOfWorkedIssues = 0;
        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        try {
            String extendedQuery = " and i.pid in (select u.pid from userproject u where u.userid='" + userId + "' intersect select k.pid from userproject k where k.userid='" + checkUser + "')";
            if (checkUser == 104) {
                extendedQuery = "";

            }
            String query = "select count(*) count from project p, issue i, issuestatus s,modules m where i.issueid = s.issueid and i.pid = p.pid and i.module_id=m.moduleid and m.pid = p.pid and s.status != 'Closed' and assignedto = " + userId + " and i.due_date < sysdate-1 " + extendedQuery + " order by due_date asc, modifiedon asc, type asc, priority asc, severity asc, createdon asc";
//                logger.info("Closed Query"+query);
            connection = MakeConnection.getConnection();
            statement = connection.createStatement();
            resultset = statement.executeQuery(query);
            while (resultset.next()) {
                noOfWorkedIssues = resultset.getInt(1);
            }

        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            try {
                if (resultset != null) {
                    resultset.close();
                }

            } catch (Exception ex) {
                logger.error(ex.getMessage());
            }
            try {
                if (statement != null) {
                    statement.close();
                }

            } catch (Exception ex) {
                logger.error(ex.getMessage());
            }
            try {
                if (connection != null) {
                    connection.close();
                }

            } catch (Exception ex) {
                logger.error(ex.getMessage());
            }
        }
        return noOfWorkedIssues;
    }

    public static int getCurrentWeekIssues(int userId, int checkUser) {
        int noOfWorkedIssues = 0;
        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        try {
            String extendedQuery = " and i.pid in (select u.pid from userproject u where u.userid='" + userId + "' intersect select k.pid from userproject k where k.userid='" + checkUser + "')";
            if (checkUser == 104) {
                extendedQuery = "";

            }
            String query = "select count(*) count from project p, issue i, issuestatus s,modules m where i.issueid = s.issueid and i.pid = p.pid and i.module_id=m.moduleid and m.pid = p.pid and s.status != 'Closed' and assignedto = " + userId + " and i.due_date > sysdate-1 and i.due_date<=(SELECT NEXT_DAY(SYSDATE,'FRIDAY')+1 from dual) " + extendedQuery + " order by due_date asc, modifiedon asc, type asc, priority asc, severity asc, createdon asc";
//                logger.info("Closed Query"+query);
            connection = MakeConnection.getConnection();
            statement = connection.createStatement();
            resultset = statement.executeQuery(query);
            while (resultset.next()) {
                noOfWorkedIssues = resultset.getInt(1);
            }

        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            try {
                if (resultset != null) {
                    resultset.close();
                }

            } catch (Exception ex) {
                logger.error(ex.getMessage());
            }
            try {
                if (statement != null) {
                    statement.close();
                }

            } catch (Exception ex) {
                logger.error(ex.getMessage());
            }
            try {
                if (connection != null) {
                    connection.close();
                }

            } catch (Exception ex) {
                logger.error(ex.getMessage());
            }
        }
        return noOfWorkedIssues;
    }

    public static int weekWiseIssues(int start, int end, int userId, int checkUser) {
        int noOfWorkedIssues = 0;
        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        try {
            String extendedQuery = " and i.pid in (select u.pid from userproject u where u.userid='" + userId + "' intersect select k.pid from userproject k where k.userid='" + checkUser + "')";
            if (checkUser == 104) {
                extendedQuery = "";

            }
            String query = "select count(*) count from project p, issue i, issuestatus s,modules m where i.issueid = s.issueid and i.pid = p.pid and i.module_id=m.moduleid and m.pid = p.pid and s.status != 'Closed' and assignedto = " + userId + " and i.due_date >(SELECT NEXT_DAY(SYSDATE,'SATURDAY')+" + start + " from dual) and i.due_date<(SELECT NEXT_DAY(SYSDATE,'SATURDAY')+" + end + " from dual) " + extendedQuery + " order by due_date asc, modifiedon asc, type asc, priority asc, severity asc, createdon asc";
            logger.info("Query" + query);
            connection = MakeConnection.getConnection();
            statement = connection.createStatement();
            resultset = statement.executeQuery(query);
            while (resultset.next()) {
                noOfWorkedIssues = resultset.getInt(1);
            }

        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            try {
                if (resultset != null) {
                    resultset.close();
                }

            } catch (Exception ex) {
                logger.error(ex.getMessage());
            }
            try {
                if (statement != null) {
                    statement.close();
                }

            } catch (Exception ex) {
                logger.error(ex.getMessage());
            }
            try {
                if (connection != null) {
                    connection.close();
                }

            } catch (Exception ex) {
                logger.error(ex.getMessage());
            }
        }
        return noOfWorkedIssues;
    }

    public static int getWorkedIssues(String start, String end, int userId) {
        int noOfWorkedIssues = 0;
        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        try {
            String query = "select distinct issuecomments.issueid, modifiedon from issuecomments,issue where issue.issueid=issuecomments.issueid and to_date(to_char(comment_date, 'DD-Mon-YYYY'),'DD-Mon-YY') between '" + start + "' and '" + end + "' and commentedto='" + userId + "' and commentedby='" + userId + "' order by modifiedon desc";
//                logger.info("Closed Query"+query);
            connection = MakeConnection.getConnection();
            statement = connection.createStatement();
            resultset = statement.executeQuery(query);
            while (resultset.next()) {
                noOfWorkedIssues++;

            }

        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            try {
                if (resultset != null) {
                    resultset.close();
                }

            } catch (Exception ex) {
                logger.error(ex.getMessage());
            }
            try {
                if (statement != null) {
                    statement.close();
                }

            } catch (Exception ex) {
                logger.error(ex.getMessage());
            }
            try {
                if (connection != null) {
                    connection.close();
                }

            } catch (Exception ex) {
                logger.error(ex.getMessage());
            }
        }
        return noOfWorkedIssues;
    }

    public static int getClosedIssues(String start, String end, int userId) {
        int noOfClosedIssues = 0;
        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        try {

            List rejectedNclosedlist = IssueDetails.getRejectednDuplicateIssues(start, end);

            String query = "select distinct issuecomments.issueid, modifiedon  from issuecomments,issue,issuestatus where issue.issueid=issuestatus.issueid and issue.issueid=issuecomments.issueid and issuestatus.status='Closed' and to_date(to_char(modifiedon, 'DD-Mon-YYYY'),'DD-Mon-YY') between '" + start + "' and '" + end + "' and commentedto='" + userId + "' and commentedby='" + userId + "' order by modifiedon desc";
            //               logger.info("Closed Query"+query);
            connection = MakeConnection.getConnection();
            statement = connection.createStatement();
            resultset = statement.executeQuery(query);
            while (resultset.next()) {
                if (!rejectedNclosedlist.contains(resultset.getString(1))) {
                    noOfClosedIssues++;
                }

            }

        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            try {
                if (resultset != null) {
                    resultset.close();
                }

            } catch (Exception ex) {
                logger.error(ex.getMessage());
            }
            try {
                if (statement != null) {
                    statement.close();
                }

            } catch (Exception ex) {
                logger.error(ex.getMessage());
            }
            try {
                if (connection != null) {
                    connection.close();
                }

            } catch (Exception ex) {
                logger.error(ex.getMessage());
            }
        }
//        logger.info("Month"+start+"Closed Issues"+noOfClosedIssues);
        return noOfClosedIssues;
    }

    public static int getCreatedIssues(String start, String end, int userId) {
        int noOfClosedIssues = 0;
        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        try {

            String query = "select distinct issueid, modifiedon  from issue where createdby='" + userId + "' and to_date(to_char(createdon, 'DD-Mon-YY'),'DD-Mon-YY') between '" + start + "' and '" + end + "' order by modifiedon desc";
//                logger.info("Closed Query"+query);
            connection = MakeConnection.getConnection();
            statement = connection.createStatement();
            resultset = statement.executeQuery(query);
            while (resultset.next()) {
                noOfClosedIssues++;

            }

        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            try {
                if (resultset != null) {
                    resultset.close();
                }

            } catch (Exception ex) {
                logger.error(ex.getMessage());
            }
            try {
                if (statement != null) {
                    statement.close();
                }

            } catch (Exception ex) {
                logger.error(ex.getMessage());
            }
            try {
                if (connection != null) {
                    connection.close();
                }

            } catch (Exception ex) {
                logger.error(ex.getMessage());
            }
        }
//        logger.info("Month"+start+"Closed Issues"+noOfClosedIssues);
        return noOfClosedIssues;
    }

    public static int GetApprovalPercentage(String timeSheetId, int userId) {
        int approvalPercentage = 0;
        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        try {


            String query = "select APPROVALPERCENTAGE from timesheet where timesheetid='" + timeSheetId + "'";
//                logger.info("Closed Query"+query);
            connection = MakeConnection.getConnection();
            statement = connection.createStatement();
            resultset = statement.executeQuery(query);
            while (resultset.next()) {
                approvalPercentage = resultset.getInt("APPROVALPERCENTAGE");


            }

        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            try {
                if (resultset != null) {
                    resultset.close();
                }

            } catch (Exception ex) {
                logger.error(ex.getMessage());
            }
            try {
                if (statement != null) {
                    statement.close();
                }

            } catch (Exception ex) {
                logger.error(ex.getMessage());
            }
            try {
                if (connection != null) {
                    connection.close();
                }

            } catch (Exception ex) {
                logger.error(ex.getMessage());
            }
        }
//        logger.info("Month"+start+"Closed Issues"+noOfClosedIssues);
        return approvalPercentage;
    }

    public static int displayCRMIssues(int userId, String startDate, String endDate, String issueType) {
        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        String sql = null;
        int rowcount = 0;
        try {
            connection = MakeConnection.getConnection();
            statement = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            if (issueType.equalsIgnoreCase("Account")) {
                sql = "SELECT ACCOUNTID,ACCOUNTNAME,BILLINGSTATE,PHONE,TYPE,ACCOUNT_AMOUNT,ASSIGNEDTO,DUEDATE,CREATEDON FROM ACCOUNT WHERE ACCOUNTID IN (SELECT DISTINCT ACCOUNTID FROM ACCOUNT_COMMENTS WHERE TO_DATE(TO_CHAR(COMMENT_DATE,'DD-MON-YY'),'DD-MON-YY') BETWEEN '" + startDate + "' AND '" + endDate + "' AND COMMENTEDBY='" + userId + "')  OR (ACCOUNT_OWNER='" + userId + "' AND TO_DATE(TO_CHAR(CREATEDON,'DD-MON-YY'),'DD-MON-YY') BETWEEN '" + startDate + "' AND '" + endDate + "' ) ORDER BY DUEDATE ASC";
            } else if (issueType.equalsIgnoreCase("Opportunity")) {
                sql = "SELECT OPPORTUNITYID,OPPORTUNITYNAME, STAGE,PHONE, AMOUNT,PROBABILITY,ASSIGNEDTO, CLOSE_DATE,CREATEDON FROM OPPORTUNITY WHERE OPPORTUNITYID IN (SELECT DISTINCT OPPORTUNITYID FROM OPPORTUNITY_COMMENTS WHERE TO_DATE(TO_CHAR(COMMENT_DATE,'DD-MON-YY'),'DD-MON-YY') BETWEEN '" + startDate + "' AND '" + endDate + "' AND COMMENTEDBY='" + userId + "') OR (OPPORTUNITY_OWNER='" + userId + "' AND TO_DATE(TO_CHAR(CREATEDON,'DD-MON-YY'),'DD-MON-YY') BETWEEN '" + startDate + "' AND '" + endDate + "' ) ORDER BY CLOSE_DATE ASC";
            } else if (issueType.equalsIgnoreCase("Lead")) {
                sql = "SELECT LEADID,FIRSTNAME||' '|| LASTNAME AS NAME, COMPANY, PHONE,EMAIL,RATING,ASSIGNEDTO,DUEDATE,CREATEDON FROM LEAD  WHERE  LEADID IN (SELECT DISTINCT LEADID FROM LEAD_COMMENTS WHERE TO_DATE(TO_CHAR(COMMENT_DATE,'DD-MON-YY'),'DD-MON-YY') BETWEEN '" + startDate + "' AND '" + endDate + "' AND COMMENTEDBY='" + userId + "') OR (LEAD_OWNER='" + userId + "' AND TO_DATE(TO_CHAR(CREATEDON,'DD-MON-YY'),'DD-MON-YY') BETWEEN '" + startDate + "' AND '" + endDate + "' ) ORDER BY UPPER(FIRSTNAME) ASC";
            } else {
                sql = "SELECT CONTACTID,FIRSTNAME||' '||LASTNAME AS NAME,COMPANY,PHONE,EMAIL,RATING,ASSIGNEDTO,DUEDATE,CREATEDON FROM CONTACT WHERE  CONTACTID IN (SELECT DISTINCT CONTACTID FROM CONTACT_COMMENTS WHERE TO_DATE(TO_CHAR(COMMENT_DATE,'DD-MON-YY'),'DD-MON-YY') BETWEEN '" + startDate + "' AND '" + endDate + "' AND COMMENTEDBY='" + userId + "') OR (CONTACT_OWNER='" + userId + "' AND TO_DATE(TO_CHAR(CREATEDON,'DD-MON-YY'),'DD-MON-YY') BETWEEN '" + startDate + "' AND '" + endDate + "' ) ORDER BY UPPER(FIRSTNAME) ASC";
            }
            resultset = statement.executeQuery(sql);
            resultset.last();
            rowcount = resultset.getRow();
//                if(issueType.equalsIgnoreCase("Contact")){
//
//                    logger.info("Total Contacts"+sql);
//                }

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
        return rowcount;
    }

    public static String[][] getMonthlyValue(int userId) {
        Calendar c = new GregorianCalendar();

        c.add(Calendar.MONTH, -1);
        int month = c.get(Calendar.MONTH);
        int year = c.get(Calendar.YEAR);
        int days = c.getActualMaximum(Calendar.DAY_OF_MONTH);
        String monthValue[][] = new String[days][5];
        for (int i = 0; i < days; i++) {

            String mon = (i + 1) + "-" + monthSelect.get(month) + "-" + year;
            logger.info("Month" + mon);

            int workedIssues = getDailyWorkedIssues(mon, userId);
            int closedIssues = getDailyClosedIssues(mon, userId);
            int createdIssues = getDailyCreatedIssues(mon, userId);

            monthValue[i][0] = mon;
            monthValue[i][1] = ((Integer) workedIssues).toString();
            monthValue[i][2] = ((Integer) closedIssues).toString();
            monthValue[i][3] = ((Integer) createdIssues).toString();
            monthValue[i][4] = ((Integer) month).toString();

        }
        return monthValue;
    }

    public static String[][] getLastMonthValue(int userId) {
        Calendar c = new GregorianCalendar();

        c.add(Calendar.DATE, -29);
        int month = c.get(Calendar.MONTH);
        int year = c.get(Calendar.YEAR);
        int date = c.get(Calendar.DATE);
        int days = c.getActualMaximum(Calendar.DAY_OF_MONTH);
        String monthValue[][] = new String[30][5];
        for (int i = 0; i < 30; i++) {
            month = c.get(Calendar.MONTH);
            date = c.get(Calendar.DATE);

            String mon = date + "-" + monthSelect.get(month) + "-" + year;
            logger.info("Month" + mon);

            int workedIssues = getDailyWorkedIssues(mon, userId);
            int closedIssues = getDailyClosedIssues(mon, userId);
            int createdIssues = getDailyCreatedIssues(mon, userId);

            monthValue[i][0] = mon;
            monthValue[i][1] = ((Integer) workedIssues).toString();
            monthValue[i][2] = ((Integer) closedIssues).toString();
            monthValue[i][3] = ((Integer) createdIssues).toString();
            monthValue[i][4] = ((Integer) month).toString();
            c.add(Calendar.DATE, 1);

        }
        return monthValue;
    }

    public static String[][] getLastWeekValue(int userId) {
        Calendar c = new GregorianCalendar();

        //      c.add(Calendar.WEEK_OF_MONTH, -1);
        int currentday = c.get(Calendar.DAY_OF_WEEK);
        //       c.set(Calendar.DAY_OF_WEEK,1);
        c.add(Calendar.DAY_OF_WEEK, -(currentday + 6));

        int year = c.get(Calendar.YEAR);
        int days = 7;
        String monthValue[][] = new String[7][5];
        for (int i = 0; i < days; i++) {
            int month = c.get(Calendar.MONTH);
            int date = c.get(Calendar.DATE);
            String mon = date + "-" + monthSelect.get(month) + "-" + year;
            logger.info("Month" + mon);

            int workedIssues = getDailyWorkedIssues(mon, userId);
            int closedIssues = getDailyClosedIssues(mon, userId);
            int createdIssues = getDailyCreatedIssues(mon, userId);

            monthValue[i][0] = mon;
            monthValue[i][1] = ((Integer) workedIssues).toString();
            monthValue[i][2] = ((Integer) closedIssues).toString();
            monthValue[i][3] = ((Integer) createdIssues).toString();
            monthValue[i][4] = ((Integer) month).toString();
            c.add(Calendar.DATE, 1);

        }
        return monthValue;
    }

    public static String[][] getPastWeekValue(int userId) {
        Calendar c = new GregorianCalendar();

        c.add(Calendar.DATE, -6);
        int month = c.get(Calendar.MONTH);
        int year = c.get(Calendar.YEAR);
        int date = c.get(Calendar.DATE);
        int days = 7;
        String monthValue[][] = new String[days][5];
        for (int i = 0; i < days; i++) {
            month = c.get(Calendar.MONTH);
            date = c.get(Calendar.DATE);

            String mon = date + "-" + monthSelect.get(month) + "-" + year;
            logger.info("Month" + mon);

            int workedIssues = getDailyWorkedIssues(mon, userId);
            int closedIssues = getDailyClosedIssues(mon, userId);
            int createdIssues = getDailyCreatedIssues(mon, userId);

            monthValue[i][0] = mon;
            monthValue[i][1] = ((Integer) workedIssues).toString();
            monthValue[i][2] = ((Integer) closedIssues).toString();
            monthValue[i][3] = ((Integer) createdIssues).toString();
            monthValue[i][4] = ((Integer) month).toString();
            c.add(Calendar.DATE, 1);

        }
        return monthValue;
    }

    public static int getDailyWorkedIssues(String date, int userId) {
        int noOfWorkedIssues = 0;
        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        try {
            String query = "select distinct issuecomments.issueid, modifiedon from issuecomments,issue where issue.issueid=issuecomments.issueid and to_date(comment_date, 'DD-Mon-YY') = '" + date + "' and commentedto='" + userId + "' and commentedby='" + userId + "' order by modifiedon desc";
//                logger.info("Closed Query"+query);
            connection = MakeConnection.getConnection();
            statement = connection.createStatement();
            resultset = statement.executeQuery(query);
            while (resultset.next()) {
                noOfWorkedIssues++;

            }

        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            try {
                if (resultset != null) {
                    resultset.close();
                }

            } catch (Exception ex) {
                logger.error(ex.getMessage());
            }
            try {
                if (connection != null) {
                    connection.close();
                }

            } catch (Exception ex) {
                logger.error(ex.getMessage());
            }
        }
        return noOfWorkedIssues;
    }

    public static int getDailyClosedIssues(String date, int userId) {
        int noOfClosedIssues = 0;
        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        try {

            String query = "select distinct issuecomments.issueid, modifiedon  from issuecomments,issue,issuestatus where issue.issueid=issuestatus.issueid and issue.issueid=issuecomments.issueid and issuestatus.status='Closed' and to_date(to_char(comment_date, 'DD-Mon-YY'),'DD-Mon-YY')= '" + date + "' and to_date(to_char(modifiedon, 'DD-Mon-YY'),'DD-Mon-YY') = '" + date + "' and commentedto='" + userId + "' and commentedby='" + userId + "' order by modifiedon desc";
            //               logger.info("Closed Query"+query);
            connection = MakeConnection.getConnection();
            statement = connection.createStatement();
            resultset = statement.executeQuery(query);
            while (resultset.next()) {
                noOfClosedIssues++;

            }

        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            try {
                if (resultset != null) {
                    resultset.close();
                }

            } catch (Exception ex) {
                logger.error(ex.getMessage());
            }
            try {
                if (statement != null) {
                    statement.close();
                }

            } catch (Exception ex) {
                logger.error(ex.getMessage());
            }
            try {
                if (connection != null) {
                    connection.close();
                }

            } catch (Exception ex) {
                logger.error(ex.getMessage());
            }
        }
//        logger.info("Month"+start+"Closed Issues"+noOfClosedIssues);
        return noOfClosedIssues;
    }

    public static int getDailyCreatedIssues(String date, int userId) {
        int noOfClosedIssues = 0;
        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        try {

            String query = "select distinct issueid, modifiedon  from issue where createdby='" + userId + "' and to_date(to_char(createdon, 'DD-Mon-YY'),'DD-Mon-YY') = '" + date + "' order by modifiedon desc";
//                logger.info("Closed Query"+query);
            connection = MakeConnection.getConnection();
            statement = connection.createStatement();
            resultset = statement.executeQuery(query);
            while (resultset.next()) {
                noOfClosedIssues++;

            }

        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            try {
                if (resultset != null) {
                    resultset.close();
                }

            } catch (Exception ex) {
                logger.error(ex.getMessage());
            }
            try {
                if (statement != null) {
                    statement.close();
                }

            } catch (Exception ex) {
                logger.error(ex.getMessage());
            }
            try {
                if (connection != null) {
                    connection.close();
                }

            } catch (Exception ex) {
                logger.error(ex.getMessage());
            }
        }
//        logger.info("Month"+start+"Closed Issues"+noOfClosedIssues);
        return noOfClosedIssues;
    }
    /*Edit By Mukesh*/
    public static String[][] getNewSelectedValue(int userId, Calendar sel, HttpServletRequest request) {

        Map<String, Integer> countactCount = new LinkedHashMap<String, Integer>();
        Map<String, Integer> leadCount = new LinkedHashMap<String, Integer>();
        Map<String, Integer> opportunityCount = new LinkedHashMap<String, Integer>();
        Map<String, Integer> accountCount = new LinkedHashMap<String, Integer>();

        int roleId = (Integer) request.getSession().getAttribute("Role");
        int user = (Integer) request.getSession().getAttribute("uid");

        Calendar c = sel;
        int month = c.get(Calendar.MONTH);
        int year = c.get(Calendar.YEAR);

        String startDate = 01 + "-" + monthSelect.get(month) + "-" + year;

        c.add(Calendar.MONTH, 11);
        int montha = c.get(Calendar.MONTH);
        int yeara = c.get(Calendar.YEAR);
        int max = c.getActualMaximum(Calendar.DAY_OF_MONTH);

        String endDate = max + "-" + monthSelect.get(montha) + "-" + yeara;


        Map<String, Integer> createdIssuesCount = getCreatedIssuesList(startDate, endDate, userId);

       
        Map<String, Integer> closedIssuseCount = getClosedIssuesList(startDate, endDate, userId);

        Map<String, Integer> workedIssueCount = getWorkedIssuesList(startDate, endDate, userId);

      
        String monthValue[][] = new String[12][12];

        c.add(Calendar.MONTH, -11);
        List<String> listImeSheetid=new ArrayList<String>();
        for (int i = 0; i <= 11; i++) {
            month = c.get(Calendar.MONTH);
            year = c.get(Calendar.YEAR);
            c.add(Calendar.MONTH, 1);

            String timeSheetId = "T";
            if (month > 9) {
                timeSheetId = timeSheetId + month + year + userId;
            } else {
                timeSheetId = timeSheetId + "0" + month + year + userId;
            }
            listImeSheetid.add(timeSheetId);
        }
          Map<String,Timesheet> timesheetlist = getTimeSheetDetailsList(listImeSheetid);

          
          
        if (roleId == 3 || user == 104) {
            countactCount = displayCRMIssuesList(userId, startDate, endDate, "Contact");
            leadCount = displayCRMIssuesList(userId, startDate, endDate, "Lead");
            opportunityCount = displayCRMIssuesList(userId, startDate, endDate, "Opportunity");
            accountCount = displayCRMIssuesList(userId, startDate, endDate, "Account");
        }

          
          System.out.println(c.get(Calendar.MONTH));
        c.add(Calendar.MONTH, -12);
        for (int i = 0; i <= 11; i++) {

            month = c.get(Calendar.MONTH);
            year = c.get(Calendar.YEAR);
            c.add(Calendar.MONTH, 1);
            String mon = monthSelect.get(month) + "-" + year;
           
            // Timesheet Id generation
            String timeSheetId = "T";
            if (month > 9) {
                timeSheetId = timeSheetId + month + year + userId;
            } else {
                timeSheetId = timeSheetId + "0" + month + year + userId;
            }


            String monYear = monthSelect.get(month) + "-" + year;

            monthValue[i][0] = mon;
            if (createdIssuesCount.containsKey(monYear)) {
                if (createdIssuesCount.get(monYear) != null) {
                    monthValue[i][3] = (createdIssuesCount.get(monYear)).toString();
                } else {
                    monthValue[i][3] = "0";
                }
            } else {
                monthValue[i][3] = "0";
            }
            if (closedIssuseCount.containsKey(monYear)) {
                if (closedIssuseCount.get(monYear) != null) {
                    monthValue[i][2] = (closedIssuseCount.get(monYear)).toString();
                } else {
                    monthValue[i][2] = "0";
                }
            } else {
                monthValue[i][2] = "0";
            }
            if (workedIssueCount.containsKey(monYear)) {
                if (workedIssueCount.get(monYear) != null) {
                    monthValue[i][1] = (workedIssueCount.get(monYear)).toString();
                } else {
                    monthValue[i][1] = "0";
                }
            } else {
                monthValue[i][1] = "0";
            }

            int approvalPerc = GetApprovalPercentage(timeSheetId, userId);

            monthValue[i][4] = ((Integer) month).toString();
            monthValue[i][11] = ((Integer) approvalPerc).toString();
           if(timesheetlist.containsKey(timeSheetId)){
                if (timesheetlist.get(timeSheetId) != null) {
                Timesheet timesheet=timesheetlist.get(timeSheetId);
                    BigDecimal wor = timesheet.getWorkingdays();
                    BigDecimal att = timesheet.getAttendance();

                    if (!(wor == null)) {
                        monthValue[i][5] = ((BigDecimal) wor).toString();
                        monthValue[i][6] = ((BigDecimal) att).toString();

                    } else {
                        monthValue[i][5] = "0";
                        monthValue[i][6] = "0";

                    }
                } else {
                    monthValue[i][5] = "0";
                    monthValue[i][6] = "0";

                }
           }else{
                monthValue[i][5] = "0";
                monthValue[i][6] = "0";
            }
            if (roleId == 3 || user == 104) {
                if (countactCount.containsKey(monYear)) {
                    if (countactCount.get(monYear) != null) {
                        monthValue[i][7] = (countactCount.get(monYear)).toString();
                    } else {
                        monthValue[i][7] = "0";
                    }
                } else {
                    monthValue[i][7] = "0";
                }
                if (leadCount.containsKey(monYear)) {
                    if (leadCount.get(monYear) != null) {
                        monthValue[i][8] = (leadCount.get(monYear)).toString();
                    } else {
                        monthValue[i][8] = "0";
                    }
                } else {
                    monthValue[i][8] = "0";
                }
                if (opportunityCount.containsKey(monYear)) {
                    if (opportunityCount.get(monYear) != null) {
                        monthValue[i][9] = (opportunityCount.get(monYear)).toString();
                    } else {
                        monthValue[i][9] = "0";
                    }
                } else {
                    monthValue[i][9] = "0";
                }
                if (accountCount.containsKey(monYear)) {
                    if (accountCount.get(monYear) != null) {
                        monthValue[i][10] = (accountCount.get(monYear)).toString();
                    } else {
                        monthValue[i][10] = "0";
                    }
                } else {
                    monthValue[i][10] = "0";
                }

            }
        }

        
        return monthValue;
    }

    public static Map<String, Integer> getCreatedIssuesList(String start, String end, int userId) {
        String sql = "";
        HashMap<String, Integer> hm = new HashMap<String, Integer>();
        Session session = null;
        try {
            sql = "select  createon ,count(issueid)  from ( select distinct issueid, to_char(createdon, 'Mon-yyyy')  as createon  from issue where createdby='" + userId + "' and to_date(to_char(createdon, 'DD-Mon-YY'),'DD-Mon-YY') between '" + start + "' and '" + end + "' order by to_char(createdon, 'Mon-yyyy') desc)  group by  createon  order by to_date(createon , 'Mon-yyyy') ";
            session = HibernateFactory.getCurrentSession();
            Query query = session.createSQLQuery(sql);
            Iterator iterator = query.list().iterator();
            while (iterator.hasNext()) {
                Integer count = 0;
                String month = "";
                Object[] row = (Object[]) iterator.next();
                for (int col = 0; col < row.length; col++) {
                    if (col == 1) {
                        count = MoMUtil.parseInteger(row[col].toString(), 0);
                    } else if (col == 0) {
                        month = row[col].toString();
                    }
                }
                hm.put(month, count);
            }

        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            getCloseConnection(session);
        }

        return hm;
    }

    public static Map<String, Integer> getClosedIssuesList(String start, String end, int userId) {
        HashMap<String, Integer> hm = new HashMap<String, Integer>();
        HashMap<String, List<String>> hmIssue = new HashMap<String, List<String>>();
        Session session = null;
        try {

            List<String> rejectedNclosedlist = IssueDetails.getRejectednDuplicateIssues(start, end);
            String sql = "select distinct issuecomments.issueid, to_char(modifiedon,'Mon-YYYY') as modification from issuecomments,issue,issuestatus where issue.issueid=issuestatus.issueid and issue.issueid=issuecomments.issueid and issuestatus.status='Closed' and to_date(to_char(modifiedon, 'DD-Mon-YYYY'),'DD-Mon-YY') between '" + start + "' and '" + end + "' and commentedto='" + userId + "' and commentedby='" + userId + "' order by to_date(to_char(modifiedon,'Mon-YYYY'),'Mon-YYYY') ";
            session = HibernateFactory.getCurrentSession();
            Query query = session.createSQLQuery(sql);
            Iterator iterator = query.list().iterator();
            String mon = "";
            List<String> issueList = new ArrayList<String>();
            while (iterator.hasNext()) {
                String issue = "";
                String month = "";
                Object[] row = (Object[]) iterator.next();
                for (int col = 0; col < row.length; col++) {
                    if (col == 0) {
                        issue = row[col].toString();
                    } else if (col == 1) {
                        month = row[col].toString();
                    }
                }
                if (mon.isEmpty() || mon.equalsIgnoreCase("")) {
                    mon = month;
                    issueList.add(issue);
                } else if (mon.equalsIgnoreCase(month)) {
                    issueList.add(issue);
                } else {
                    hmIssue.put(mon, issueList);
                    issueList = new ArrayList<String>();
                    mon = month;
                    issueList.add(issue);
                }

            }
            if (hmIssue.containsKey(mon)) {

            } else {
                hmIssue.put(mon, issueList);
            }
            for (Map.Entry<String, List<String>> entrySet : hmIssue.entrySet()) {
                String key = entrySet.getKey();
                int count = 0;
                for (String issue : entrySet.getValue()) {
                    if (rejectedNclosedlist.contains(issue)) {

                    } else {
                        count++;
                    }
                }
                hm.put(key, count);
            }

        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            getCloseConnection(session);
        }

        return hm;
    }

    public static Map<String, Integer> getWorkedIssuesList(String start, String end, int userId) {
        HashMap<String, Integer> hm = new HashMap<String, Integer>();
        Session session = null;
        try {
            String sql = "select Count(issueid ),month  from ( select distinct issuecomments.issueid , to_char(comment_date, 'Mon-YYYY') as month from issuecomments,issue where issue.issueid=issuecomments.issueid and comment_date between '" + start + "' and '" + end + "' and commentedto='" + userId + "' and commentedby='" + userId + "'  group by issuecomments.issueid,to_char(comment_date, 'Mon-YYYY')  order by comment_date desc ) group by month  order by month";
            session = HibernateFactory.getCurrentSession();
            Query query = session.createSQLQuery(sql);
            Iterator iterator = query.list().iterator();
            while (iterator.hasNext()) {
                Integer count = 0;
                String month = "";
                Object[] row = (Object[]) iterator.next();
                for (int col = 0; col < row.length; col++) {
                    if (col == 0) {
                        count = MoMUtil.parseInteger(row[col].toString(), 0);
                    } else if (col == 1) {
                        month = row[col].toString();
                    }
                }
                hm.put(month, count);
            }

        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            getCloseConnection(session);
        }

        return hm;
    }

    public static Map<String, Integer> displayCRMIssuesList(int userId, String startDate, String endDate, String issueType) {
        HashMap<String, Integer> hm = new HashMap<String, Integer>();
        Session session = null;
        String sql = "";
        try {
            session = HibernateFactory.getCurrentSession();
            if (issueType.equalsIgnoreCase("Account")) {
                sql = "select count(ACCOUNTID),commentDate from( select a.ACCOUNTID,a.CREATEDON,acc.commentDate  from ACCOUNT a,( SELECT ACCOUNTID,CREATEDON,commentDate FROM ACCOUNT,(SELECT ACCOUNTID as accId,TO_CHAR(COMMENT_DATE,'Mon-YYYY') as commentDate FROM ACCOUNT_COMMENTS WHERE TO_DATE(TO_CHAR(COMMENT_DATE,'DD-Mon-YY'),'DD-Mon-YY')  BETWEEN '" + startDate + "' AND '" + endDate + "' AND COMMENTEDBY='" + userId + "' group by ACCOUNTID, TO_CHAR(COMMENT_DATE,'Mon-YYYY') order by commentDate) WHERE ACCOUNTID =accId group by ACCOUNTID,CREATEDON,commentDate  union   SELECT ACCOUNTID,CREATEDON,TO_CHAR(CREATEDON,'Mon-YYYY') as commentDate  from ACCOUNT  where ACCOUNT_OWNER='" + userId + "' AND TO_DATE(TO_CHAR(CREATEDON,'DD-Mon-YY'),'DD-Mon-YY')  BETWEEN '" + startDate + "' AND '" + endDate + "' group by  ACCOUNTID,CREATEDON,TO_CHAR(CREATEDON,'Mon-YYYY')    ) acc where acc.ACCOUNTID =a.ACCOUNTID order by acc.commentDate ) group by commentDate ";
            } else if (issueType.equalsIgnoreCase("Opportunity")) {
                sql = "select count(OPPORTUNITYID),commentDate from(select p.OPPORTUNITYID,p.CREATEDON,op.commentDate  from OPPORTUNITY p,(SELECT OPPORTUNITYID,CREATEDON,TO_CHAR(CREATEDON,'Mon-YYYY') as commentDate  from OPPORTUNITY  where OPPORTUNITY_OWNER='" + userId + "' AND TO_DATE(TO_CHAR(CREATEDON,'DD-Mon-YY'),'DD-Mon-YY') BETWEEN '" + startDate + "' AND '" + endDate + "'   group by  OPPORTUNITYID,CREATEDON,TO_CHAR(CREATEDON,'Mon-YYYY') UNION SELECT ps.OPPORTUNITYID,ps.CREATEDON,commentDate   FROM OPPORTUNITY ps ,(SELECT OPPORTUNITYID as opportunity,TO_CHAR(COMMENT_DATE,'Mon-YYYY') as commentDate  FROM OPPORTUNITY_COMMENTS WHERE TO_DATE(TO_CHAR(COMMENT_DATE,'DD-Mon-YY'),'DD-Mon-YY') BETWEEN '" + startDate + "' AND '" + endDate + "'  AND COMMENTEDBY='" + userId + "' group by OPPORTUNITYID,TO_CHAR(COMMENT_DATE,'Mon-YYYY') order by commentDate ) WHERE ps.OPPORTUNITYID =opportunity group by  OPPORTUNITYID,CREATEDON,commentDate ) op where op.OPPORTUNITYID =p.OPPORTUNITYID group by  p.OPPORTUNITYID,p.CREATEDON,op.commentDate order by op.commentDate ) group by commentDate ";
            } else if (issueType.equalsIgnoreCase("Lead")) {
                sql = "select count(LEADID),commentDate from(SELECT l.LEADID,le.CREATEDON,le.commentDate  FROM LEAD l,(SELECT LEADID,CREATEDON,commentDate  FROM LEAD,(SELECT LEADID as lead,TO_CHAR(COMMENT_DATE,'Mon-YYYY') as commentDate FROM LEAD_COMMENTS WHERE TO_DATE(TO_CHAR(COMMENT_DATE,'DD-Mon-YY'),'DD-Mon-YY') BETWEEN '" + startDate + "' AND '" + endDate + "' AND COMMENTEDBY='" + userId + "'  group by LEADID,TO_CHAR(COMMENT_DATE,'Mon-YYYY') order by commentDate) WHERE  LEADID=lead group by LEADID,CREATEDON,commentDate  union SELECT LEADID,CREATEDON,TO_CHAR(CREATEDON,'Mon-YYYY') as commentDate  FROM LEAD where LEAD_OWNER='" + userId + "' AND TO_DATE(TO_CHAR(CREATEDON,'DD-Mon-YY'),'DD-Mon-YY') BETWEEN '" + startDate + "' AND '" + endDate + "'   group by LEADID,CREATEDON,TO_CHAR(CREATEDON,'Mon-YYYY')) le where le.LEADID=l.LEADID ) group by commentDate order by commentDate";
            } else {
                sql = "select count(CONTACTID),commentDate from( SELECT c.CONTACTID,con.CREATEDON,con.commentDate  FROM CONTACT c,( SELECT CONTACTID,CREATEDON,commentDate  FROM CONTACT,(SELECT CONTACTID as contact,TO_CHAR(COMMENT_DATE,'Mon-YYYY') as commentDate FROM CONTACT_COMMENTS WHERE TO_DATE(TO_CHAR(COMMENT_DATE,'DD-Mon-YY'),'DD-Mon-YY') BETWEEN '" + startDate + "' AND '" + endDate + "' AND COMMENTEDBY='" + userId + "' group by CONTACTID,TO_CHAR(COMMENT_DATE,'Mon-YYYY') order by commentDate  ) WHERE CONTACTID=contact   group by CONTACTID,CREATEDON,commentDate union SELECT CONTACTID,CREATEDON,TO_CHAR(CREATEDON,'Mon-YYYY') as commentDate FROM CONTACT where CONTACT_OWNER='" + userId + "'  AND TO_DATE(TO_CHAR(CREATEDON,'DD-Mon-YY'),'DD-Mon-YY') BETWEEN '" + startDate + "' AND '" + endDate + "'  group by CONTACTID,CREATEDON,TO_CHAR(CREATEDON,'Mon-YYYY') ) con where con.CONTACTID=c.CONTACTID order by commentDate ) group by commentDate";
            }
            Query query = session.createSQLQuery(sql);
            Iterator iterator = query.list().iterator();
            while (iterator.hasNext()) {
                Integer count = 0;
                String month = "";
                Object[] row = (Object[]) iterator.next();
                for (int col = 0; col < row.length; col++) {
                    if (col == 0) {
                        count = MoMUtil.parseInteger(row[col].toString(), 0);
                    } else if (col == 1) {
                        month = row[col].toString();
                    }
                }
                hm.put(month, count);
            }
        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            getCloseConnection(session);
        }
        return hm;
    }

    public static Map<String, Timesheet> getTimeSheetDetailsList(List<String> timeSheetId) {
        List<Timesheet> timesheetlist = new ArrayList<Timesheet>();
        Map<String, Timesheet> map=new LinkedHashMap<String, Timesheet>();
        SessionFactory sessionFactory = null;
        Session session = null;
        try {
            sessionFactory = HibernateUtil.getSessionFactory();
            session = sessionFactory.openSession();
            session.beginTransaction();
            Query query = session.createQuery("from usertimesheets where timesheetid in  (:timeSheetId) ");
            query.setParameterList("timeSheetId", timeSheetId);
            timesheetlist = (List<Timesheet>) query.list();

            for (Timesheet timesheet : timesheetlist) {
                map.put(timesheet.getTimesheetid(), timesheet);
            }

        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            if (session != null) {
                session.close();
            }
        }

        return map;

    }
    public static void getCloseConnection(Session session) {
        if (session != null) {
            if (session.isOpen()) {
                try {
                    session.close();
                } catch (Exception e) {
                    logger.error(e.getMessage());
                }
            }
        }
    }
}
