/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eminent.customer;

import static com.eminent.customer.CustomerUtil.logger;
import com.eminent.holidays.Holidays;
import com.eminent.holidays.HolidaysUtil;
import com.eminent.util.DateIterator;
import com.eminentlabs.crm.CRMSearchBean;
import java.sql.Connection;
import java.sql.Statement;
import java.sql.ResultSet;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;
import pack.eminent.encryption.MakeConnection;
import org.apache.log4j.Logger;

/**
 *
 * @author Tamilvelan
 */
public class CustomerUtil {

    static Logger logger = Logger.getLogger("Customer Util");

    public static List<CRMSearchBean> displayCRMIssues(int userId, String startDate, String endDate, String issueType) {
        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        String sql = null;
        List<CRMSearchBean> list = new ArrayList<>();
        try {
            connection = MakeConnection.getConnection();
            statement = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            if (issueType.equalsIgnoreCase("Account")) {
                sql = "SELECT ACCOUNTID,ACCOUNTNAME,BILLINGSTATE,PHONE,TYPE,ACCOUNT_AMOUNT,ASSIGNEDTO,DUEDATE,CREATEDON,OPPORTUNITY_REFERENCE FROM ACCOUNT WHERE ACCOUNTID IN (SELECT DISTINCT ACCOUNTID FROM ACCOUNT_COMMENTS WHERE TO_DATE(TO_CHAR(COMMENT_DATE,'DD-MON-YY'),'DD-MON-YY') BETWEEN '" + startDate + "' AND '" + endDate + "' AND COMMENTEDBY='" + userId + "')  OR (ACCOUNT_OWNER='" + userId + "' AND TO_DATE(TO_CHAR(CREATEDON,'DD-MON-YY'),'DD-MON-YY') BETWEEN '" + startDate + "' AND '" + endDate + "' ) ORDER BY DUEDATE ASC";
            } else if (issueType.equalsIgnoreCase("Opportunity")) {
                sql = "SELECT OPPORTUNITYID,OPPORTUNITYNAME, STAGE,PHONE, AMOUNT,PROBABILITY,ASSIGNEDTO, CLOSE_DATE,CREATEDON,LEAD_REFERENCE FROM OPPORTUNITY WHERE OPPORTUNITYID IN (SELECT DISTINCT OPPORTUNITYID FROM OPPORTUNITY_COMMENTS WHERE TO_DATE(TO_CHAR(COMMENT_DATE,'DD-MON-YY'),'DD-MON-YY') BETWEEN '" + startDate + "' AND '" + endDate + "' AND COMMENTEDBY='" + userId + "') OR (OPPORTUNITY_OWNER='" + userId + "' AND TO_DATE(TO_CHAR(CREATEDON,'DD-MON-YY'),'DD-MON-YY') BETWEEN '" + startDate + "' AND '" + endDate + "' ) ORDER BY CLOSE_DATE ASC";
            } else if (issueType.equalsIgnoreCase("Lead")) {
                sql = "SELECT LEADID,FIRSTNAME||' '|| LASTNAME AS NAME, COMPANY, PHONE,EMAIL,RATING,ASSIGNEDTO,DUEDATE,CREATEDON,LEAD_TYPE FROM LEAD  WHERE  LEADID IN (SELECT DISTINCT LEADID FROM LEAD_COMMENTS WHERE TO_DATE(TO_CHAR(COMMENT_DATE,'DD-MON-YY'),'DD-MON-YY') BETWEEN '" + startDate + "' AND '" + endDate + "' AND COMMENTEDBY='" + userId + "') OR (LEAD_OWNER='" + userId + "' AND TO_DATE(TO_CHAR(CREATEDON,'DD-MON-YY'),'DD-MON-YY') BETWEEN '" + startDate + "' AND '" + endDate + "' ) ORDER BY UPPER(FIRSTNAME) ASC";
            } else {
                sql = "SELECT CONTACTID,FIRSTNAME||' '||LASTNAME AS NAME,COMPANY,PHONE,EMAIL,RATING,ASSIGNEDTO,DUEDATE,CREATEDON,CONTACT_TYPE FROM CONTACT WHERE  CONTACTID IN (SELECT DISTINCT CONTACTID FROM CONTACT_COMMENTS WHERE TO_DATE(TO_CHAR(COMMENT_DATE,'DD-MON-YY'),'DD-MON-YY') BETWEEN '" + startDate + "' AND '" + endDate + "' AND COMMENTEDBY='" + userId + "') OR (CONTACT_OWNER='" + userId + "' AND TO_DATE(TO_CHAR(CREATEDON,'DD-MON-YY'),'DD-MON-YY') BETWEEN '" + startDate + "' AND '" + endDate + "' ) ORDER BY UPPER(FIRSTNAME) ASC";
            }
            resultset = statement.executeQuery(sql);
            while (resultset.next()) {
                CRMSearchBean crmsb = new CRMSearchBean();
                crmsb.setId(resultset.getString(1));
                crmsb.setName(resultset.getString(2));
                crmsb.setCompany(resultset.getString(3));
                crmsb.setPhone(resultset.getString(4));
                crmsb.setEmail(resultset.getString(5));
                crmsb.setRating(resultset.getString(6));
                crmsb.setAssingedTo(resultset.getString(7));
                if (resultset.getDate(8) != null) {
                    crmsb.setDuedate(resultset.getDate(8).toString());
                }
                crmsb.setCreatedon(resultset.getDate(9).toString());
                crmsb.setContactType(resultset.getString(10));
                list.add(crmsb);
            }
        } catch (Exception e) {
            e.printStackTrace();
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
        return list;
    }

    public static String[][] displayCRMAccount() {
        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        String total[][] = null;
        String sql = null;
        try {
            connection = MakeConnection.getConnection();
            statement = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);

            sql = "SELECT ACCOUNTID,ACCOUNTNAME,VERTICALID FROM ACCOUNT ";

            resultset = statement.executeQuery(sql);
            resultset.last();
            int rowcount = resultset.getRow();
            resultset.beforeFirst();
            int column = 3;

            String issues[][] = new String[rowcount][column];
            int i = 0;
            while (resultset.next()) {
                issues[i][0] = resultset.getString(1);
                issues[i][1] = resultset.getString(2);
                issues[i][2] = resultset.getString(3);

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

    public static int getAge(String createdon) throws Exception {
        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        int createdDate = 0;

        try {
            connection = MakeConnection.getConnection();
            statement = connection.createStatement();

            logger.info("Created On for Age-->" + createdon);
            resultset = statement.executeQuery("SELECT sysdate-to_date('" + createdon + "') FROM dual");

            while (resultset.next()) {
                createdDate = resultset.getInt(1);

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
            }

        }
        return createdDate + 1;
    }

    public static int getIssueAge(String createdon, String status, String modifiedon) throws Exception {

        Statement statement = null;
        ResultSet resultset = null;
        Connection connection = null;
        int createdDate = 0;

        try {
            connection = MakeConnection.getConnection();
            statement = connection.createStatement();
            if (!status.equalsIgnoreCase("Closed")) {

                resultset = statement.executeQuery("SELECT sysdate-to_date('" + createdon + "') FROM dual");
            } else {

                resultset = statement.executeQuery("SELECT to_date('" + modifiedon + "')-to_date('" + createdon + "') FROM dual");
            }

            while (resultset.next()) {
                createdDate = resultset.getInt(1);

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
            }
        }
        return createdDate + 1;
    }

    public static String[][] displayTimesheet(int userId, String startDate, String endDate) {
        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        String total[][] = null;
        String sql = null;
        try {
            connection = MakeConnection.getConnection();
            statement = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);

            sql = "SELECT TIMESHEETID,OWNER,APPROVALSTATUS,ASSIGNEDTO,REQUESTEDON FROM TIMESHEET WHERE (APPROVEDBY=" + userId + " AND TO_DATE(TO_CHAR(APPROVEDON,'DD-MON-YY'),'DD-MON-YY') BETWEEN '" + startDate + "' AND '" + endDate + "') OR (ATTENDENCEUPDATEDBY=" + userId + " AND TO_DATE(TO_CHAR(ATTENDENCEUPDATEDON,'DD-MON-YY'),'DD-MON-YY') BETWEEN '" + startDate + "' AND '" + endDate + "') OR (ACCOUNTUPDATEDBY=" + userId + " AND TO_DATE(TO_CHAR(ACCOUNTSUPDATEDON,'DD-MON-YY'),'DD-MON-YY') BETWEEN '" + startDate + "' AND '" + endDate + "') OR (TIMESHEETID IN (SELECT DISTINCT TIMESHEETID FROM TIMESHEETINFO WHERE INFOBY=" + userId + " AND TO_DATE(TO_CHAR(INFOADDEDON,'DD-MON-YY'),'DD-MON-YY') BETWEEN '" + startDate + "' AND '" + endDate + "')) ORDER BY REQUESTEDON ASC";

            resultset = statement.executeQuery(sql);
            resultset.last();
            int rowcount = resultset.getRow();
            resultset.beforeFirst();
            int column = 5;

            String issues[][] = new String[rowcount][column];
            int i = 0;
            while (resultset.next()) {
                issues[i][0] = resultset.getString(1);
                issues[i][1] = resultset.getString(2);
                issues[i][2] = resultset.getString(3);
                issues[i][3] = resultset.getString(4);
                issues[i][4] = resultset.getDate(5).toString();

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

    public static String[][] displayLeave(int userId, String startDate, String endDate) {
        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        String total[][] = null;
        String sql = null;
        try {
            connection = MakeConnection.getConnection();
            statement = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);

            sql = "SELECT TYPE,REQUESTEDBY,APPROVAL,FROMDATE,TODATE,CREATEDON,ASSIGNEDTO,APPROVER,MODIFIEDON FROM LEAVE WHERE APPROVER=" + userId + " AND TO_DATE(TO_CHAR(MODIFIEDON,'DD-MON-YY'),'DD-MON-YY') BETWEEN '" + startDate + "' AND '" + endDate + "'";
            logger.error("Leave-->" + sql);
            resultset = statement.executeQuery(sql);
            resultset.last();
            int rowcount = resultset.getRow();
            resultset.beforeFirst();
            int column = 9;

            String issues[][] = new String[rowcount][column];
            int i = 0;
            while (resultset.next()) {
                issues[i][0] = resultset.getString(1);
                issues[i][1] = resultset.getString(2);
                issues[i][2] = resultset.getString(3);
                issues[i][3] = resultset.getDate(4).toString();
                issues[i][4] = resultset.getDate(5).toString();
                issues[i][5] = resultset.getTimestamp(6).toString();
                issues[i][6] = resultset.getString(7);
                issues[i][7] = resultset.getString(8);
                issues[i][8] = resultset.getTimestamp(9).toString();

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

    public static float getLeavedays(int userId, String startDate, String endDate) throws ParseException {
        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        float days = 0;
        String sql = null;
        SimpleDateFormat sdf = new SimpleDateFormat("dd-MMM-yyyy");
        Set<String> holidayDatesList = new HashSet<String>();
        Date start = sdf.parse(startDate);
        Date end = sdf.parse(endDate);
        List<Holidays> holidaysList = HolidaysUtil.findCalendarYearHolidays(start, end);
        if (!holidaysList.isEmpty()) {
            for (Holidays holday : holidaysList) {
                holidayDatesList.add(sdf.format(holday.getHolidayDate()));
            }
        }
        logger.info("holidayDatesList" + holidayDatesList);
        try {
            connection = MakeConnection.getConnection();
            statement = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);

            sql = "SELECT to_Number((TODATE-FROMDATE)+1)as leaveDays ,type,duration,TO_CHAR(FROMDATE,'DD-MON-YYYY') as fromdate,TO_CHAR(TODATE,'DD-MON-YYYY') as todate  FROM LEAVE WHERE REQUESTEDBY=" + userId + " AND APPROVAL=1 AND TODATE < Sysdate AND (TO_DATE(TO_CHAR(FROMDATE,'DD-MON-YY'),'DD-MON-YY') BETWEEN '" + startDate + "' AND '" + endDate + "' OR TO_DATE(TO_CHAR(TODATE,'DD-MON-YY'),'DD-MON-YY') BETWEEN '" + startDate + "' AND '" + endDate + "') and TO_DATE(TO_CHAR(TODATE,'DD-MON-YY'),'DD-MON-YY') < '" + endDate + "' ";
            logger.info("Leave dAYS-->" + sql);
            resultset = statement.executeQuery(sql);

            while (resultset.next()) {
                String type = resultset.getString("duration");
                String from = resultset.getString("fromdate");
                String to = resultset.getString("todate");
                Date fromDate = sdf.parse(from);
                Date toDate = sdf.parse(to);
                if (type.equalsIgnoreCase("First Half") || type.equalsIgnoreCase("Second Half") && !holidayDatesList.contains(sdf.format(toDate))) {
                    days = days + 0.5f;                   
                } 
                else {
                    days = days + resultset.getInt("leaveDays");
                    Iterator<Date> dateslist = new DateIterator(fromDate, toDate);
                    while (dateslist.hasNext()) {
                        Date oneOfDate = dateslist.next();
                        String oneDate = sdf.format(oneOfDate);
                        Calendar caler = Calendar.getInstance();
                        caler.setTime(oneOfDate);
                        int day = caler.get(Calendar.DAY_OF_WEEK);
                        if (day == 7 || day == 1) {
                            days = (days) - 1;
                        } else if (holidayDatesList.contains(oneDate)) {
                            days = (days) - 1;
                        }
                    }
                }
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
        return days;
    }

    public static String[][] userLeave(int userId, String startDate, String endDate) {
        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        String total[][] = null;
        String sql = null;
        try {
            connection = MakeConnection.getConnection();
            statement = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);

            sql = "SELECT TYPE,REQUESTEDBY,APPROVAL,FROMDATE,TODATE,CREATEDON,ASSIGNEDTO,APPROVER,MODIFIEDON FROM LEAVE WHERE REQUESTEDBY=" + userId + " AND APPROVAL=1 AND TODATE < Sysdate AND (TO_DATE(TO_CHAR(FROMDATE,'DD-MON-YY'),'DD-MON-YY') BETWEEN '" + startDate + "' AND '" + endDate + "' OR TO_DATE(TO_CHAR(TODATE,'DD-MON-YY'),'DD-MON-YY') BETWEEN '" + startDate + "' AND '" + endDate + "') and TO_DATE(TO_CHAR(TODATE,'DD-MON-YY'),'DD-MON-YY') < '" + endDate + "' ";
            logger.info("Leave-->" + sql);
            resultset = statement.executeQuery(sql);
            resultset.last();
            int rowcount = resultset.getRow();
            resultset.beforeFirst();
            int column = 9;

            String issues[][] = new String[rowcount][column];
            int i = 0;
            while (resultset.next()) {
                issues[i][0] = resultset.getString(1);
                issues[i][1] = resultset.getString(2);
                issues[i][2] = resultset.getString(3);
                issues[i][3] = resultset.getDate(4).toString();
                issues[i][4] = resultset.getDate(5).toString();
                issues[i][5] = resultset.getTimestamp(6).toString();
                issues[i][6] = resultset.getString(7);
                issues[i][7] = resultset.getString(8);
                issues[i][8] = resultset.getTimestamp(9).toString();

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

    public static Map getTodyLeaves() {
        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        Map<Integer, String> getTodayLeaves = new HashMap<Integer, String>();
        String sql = null;
        try {
            connection = MakeConnection.getConnection();
            statement = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);

            sql = "SELECT REQUESTEDBY,DURATION FROM LEAVE WHERE (TO_DATE(TO_CHAR(FROMDATE,'DD-MON-YY'),'DD-MON-YY') <= to_date(to_char(sysdate,'DD-Mon-yy'),'DD-MON-YY') AND TO_DATE(TO_CHAR(TODATE,'DD-MON-YY'),'DD-MON-YY')>= to_date(to_char(sysdate,'DD-Mon-yy'),'DD-MON-YY')) and approval=1";
            logger.info("Leave-->" + sql);
            resultset = statement.executeQuery(sql);

            while (resultset.next()) {
                int req = resultset.getInt("REQUESTEDBY");
                String dur = resultset.getString("DURATION");
                getTodayLeaves.put(req, dur);
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
        return getTodayLeaves;
    }

    public static Map<String, String> teamsList() {
        Map<String, String> teamList = new LinkedHashMap<String, String>();
        teamList.put("XI", "XI");
        teamList.put("BASIS", "BASIS");
        teamList.put("ABAP", "ABAP");
        teamList.put("MDM", "MDM");
        teamList.put("CRM", "CRM");
        teamList.put("MM", "MM");
        teamList.put("WM", "WM");
        teamList.put("PP", "PP");
        teamList.put("FI", "FI");
        teamList.put("CO", "CO");
        teamList.put("FICO", "FICO");
        teamList.put("BI", "BI");
        teamList.put("SD", "SD");
        teamList.put("EP", "EP");
        teamList.put("HR", "HR");
        teamList.put("QM", "QM");
        teamList.put("CS", "CS");
        teamList.put("PM", "PM");
        teamList.put("PROJMGR", "Project Manager");
        teamList.put("DM", "Delivery Manager");
        teamList.put("AM", "Account Manager");
        teamList.put("NW ADMIN", "NW ADMIN");
        teamList.put("ADMIN", "ADMIN");
        teamList.put("CUSTOMER", "CUSTOMER");
        teamList.put("DIRECTOR", "DIRECTOR");
        teamList.put("SALES", "SALES");
        teamList.put("Java", "Java");
        teamList.put(".Net", ".Net");
        teamList.put("INTERN", "INTERN");
        return teamList;
    }
}
