/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eminent.leaveUtil;

import com.eminent.holidays.Holidays;
import com.eminent.holidays.HolidaysUtil;
import static com.eminent.leaveUtil.LeaveUtil.logger;
import com.eminent.util.DateIterator;
import com.eminent.util.GetDate;
import com.eminent.util.GetProjectMembers;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.*;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.ResourceBundle;
import java.util.Set;
import org.apache.log4j.*;
import pack.eminent.encryption.MakeConnection;

/**
 *
 * @author Tamilvelan
 */
public class LeaveUtil {

    static Logger logger = null;

    static {
        logger = Logger.getLogger("LeaveUtil");

    }
    private static ResourceBundle rb = null;

    static {
        rb = ResourceBundle.getBundle("Resources");
    }
    LeaveBlancePeriodDAO leaveBlancePeriodDAO = new LeaveBlancePeriodDAO();

    public static String[][] getLeave(int userId) {
        String leave[][] = null;
        String leaveDetails[][] = null;
        Connection connection = null;
        ResultSet getLeaveRS = null;
        PreparedStatement getLeavePS = null;
        Calendar cal = new GregorianCalendar();
        int currentYear = cal.get(Calendar.YEAR);
        int currentMonth = cal.get(Calendar.MONTH);
        String startDate = "01-Apr-" + currentYear;
        String endDate = "31-Mar-" + (currentYear + 1);
        if (currentMonth < 3) {
            startDate = "01-Apr-" + (currentYear - 1);
            endDate = "31-Mar-" + (currentYear);
        }
        try {
            SimpleDateFormat sdf = new SimpleDateFormat("dd-MMM-yy");
            SimpleDateFormat sdfull = new SimpleDateFormat("HH:mm:ss");
            String today = sdf.format(GetDate.getDate());

            connection = MakeConnection.getConnection();
            getLeavePS = connection.prepareStatement("select * from Leave where requestedby='" + userId + "' and fromdate <= '" + endDate + "' and todate>='" + startDate + "' order by todate desc ", ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            getLeaveRS = getLeavePS.executeQuery();
            getLeaveRS.last();
            int noOfRows = getLeaveRS.getRow();
            getLeaveRS.beforeFirst();
            leaveDetails = new String[noOfRows][13];
            for (int i = 0; i < noOfRows; i++) {
                getLeaveRS.next();
                String leaveId = getLeaveRS.getString("leaveid");
                String from = sdf.format(getLeaveRS.getDate("FROMDATE"));
                String to = sdf.format(getLeaveRS.getDate("TODATE"));
                String type = getLeaveRS.getString("type");
                String description = getLeaveRS.getString("description");
                String created = sdf.format(getLeaveRS.getDate("createdon")) + " " + sdfull.format(getLeaveRS.getTime("createdon"));
                String modified = sdf.format(getLeaveRS.getDate("modifiedon"));
                String requested = getLeaveRS.getString("requestedby");
                String assigned = getLeaveRS.getString("assignedto");
                String approval = getLeaveRS.getString("approval");
                String comments = getLeaveRS.getString("comments");
                String approver = getLeaveRS.getString("approver");
                String duration = getLeaveRS.getString("duration");

                leaveDetails[i][0] = leaveId;
                leaveDetails[i][1] = from;
                leaveDetails[i][2] = to;
                leaveDetails[i][3] = type;
                leaveDetails[i][4] = description;
                leaveDetails[i][5] = created;
                leaveDetails[i][6] = modified;
                leaveDetails[i][7] = requested;
                leaveDetails[i][8] = assigned;
                leaveDetails[i][9] = approval;
                leaveDetails[i][10] = comments;
                leaveDetails[i][11] = approver;
                leaveDetails[i][12] = duration;
            }
            leave = LeaveBlancePeriodDAO.noOfLeaveDays(leaveDetails, GetProjectMembers.getBranchId(userId));
        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {

            try {
                if (getLeaveRS != null) {
                    getLeaveRS.close();
                }

            } catch (Exception ex) {
                logger.error("Error while getting Leave Details" + ex.getMessage());
            }
            try {
                if (getLeavePS != null) {
                    getLeavePS.close();
                }

            } catch (Exception ex) {
                logger.error("Error while getting Leave Details", ex);
            }
            try {
                if (connection != null) {
                    connection.close();
                    logger.info("Connection Closed");
                    if (connection.isClosed()) {
                        logger.info("Closed");
                    } else {
                        logger.info("Not Closed");
                    }
                }

            } catch (Exception ex) {
                logger.error(ex.getMessage());
            }
        }

        return leave;
    }

    public static String[][] getLeaveRequest(int userId) {
        String leaveDetails[][] = null;
        Connection leaveRequestConnection = null;
        ResultSet getLeaveRequestRS = null;
        PreparedStatement getLeaveRequestPS = null;
        try {
            SimpleDateFormat sdf = new SimpleDateFormat("dd-MMM-yy");
//            String today            =   sdf.format(GetDate.getDate());

            leaveRequestConnection = MakeConnection.getConnection();
            getLeaveRequestPS = leaveRequestConnection.prepareStatement("select * from Leave where assignedto='" + userId + "'", ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            getLeaveRequestRS = getLeaveRequestPS.executeQuery();
            getLeaveRequestRS.last();
            int noOfRows = getLeaveRequestRS.getRow();
            getLeaveRequestRS.beforeFirst();
            leaveDetails = new String[noOfRows][11];
            for (int i = 0; i < noOfRows; i++) {
                getLeaveRequestRS.next();
                String leaveId = getLeaveRequestRS.getString("leaveid");
                String from = sdf.format(getLeaveRequestRS.getDate("FROMDATE"));
                String to = sdf.format(getLeaveRequestRS.getDate("TODATE"));
                String type = getLeaveRequestRS.getString("type");
                String description = getLeaveRequestRS.getString("description");
                String created = sdf.format(getLeaveRequestRS.getDate("createdon"));
                String modified = sdf.format(getLeaveRequestRS.getDate("modifiedon"));
                String requested = getLeaveRequestRS.getString("requestedby");
                String assigned = getLeaveRequestRS.getString("assignedto");
                String approval = getLeaveRequestRS.getString("approval");
                String comments = getLeaveRequestRS.getString("comments");

                leaveDetails[i][0] = leaveId;
                leaveDetails[i][1] = from;
                leaveDetails[i][2] = to;
                leaveDetails[i][3] = type;
                leaveDetails[i][4] = description;
                leaveDetails[i][5] = created;
                leaveDetails[i][6] = modified;
                leaveDetails[i][7] = requested;
                leaveDetails[i][8] = assigned;
                leaveDetails[i][9] = approval;
                leaveDetails[i][10] = comments;

            }

        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {

            try {
                if (getLeaveRequestRS != null) {
                    getLeaveRequestRS.close();
                }

            } catch (Exception ex) {
                logger.error("Error while getting Leave Details", ex);
            }
            try {
                if (getLeaveRequestPS != null) {
                    getLeaveRequestPS.close();
                }

            } catch (Exception ex) {
                logger.error("Error while getting Leave Details", ex);
            }
            try {
                if (leaveRequestConnection != null) {
                    leaveRequestConnection.close();
                    logger.info("Connection closed");
                    if (leaveRequestConnection.isClosed()) {
                        logger.info("Closed");
                    } else {
                        logger.info("Not Closed");
                    }
                }

            } catch (Exception ex) {
                logger.error("Error while getting Leave Details", ex);
            }
        }

        return leaveDetails;
    }

    public static String[][] getEditRequest(int leaveid) {
        String leaveDetails[][] = null;
        String leave[][] = null;
        Connection editRequestConnection = null;
        ResultSet getEditRequestRS = null;
        PreparedStatement getEditRequestPS = null;
        int userid = 0;
        try {
            SimpleDateFormat sdf = new SimpleDateFormat("dd-MMM-yyyy");
            String today = sdf.format(GetDate.getDate());

            editRequestConnection = MakeConnection.getConnection();
            getEditRequestPS = editRequestConnection.prepareStatement("select leaveid,fromdate,todate,type,description,to_char(createdon,'dd-Mon-yyyy') as created,createdon,to_char(modifiedon,'dd-Mon-yyyy') as modified,modifiedon,requestedby,assignedto,approval,comments,duration from Leave where leaveid='" + leaveid + "'", ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            getEditRequestRS = getEditRequestPS.executeQuery();

            leaveDetails = new String[1][13];
            for (int i = 0; i < 1; i++) {
                if (getEditRequestRS.next()) {
                    String leaveId = getEditRequestRS.getString("leaveid");
                    String from = sdf.format(getEditRequestRS.getDate("FROMDATE"));
                    String to = sdf.format(getEditRequestRS.getDate("TODATE"));
                    String type = getEditRequestRS.getString("type");
                    String description = getEditRequestRS.getString("description");
//                String created      =   sdf.format(getEditRequestRS.getDate("createdon"));
//                String modified     =   sdf.format(getEditRequestRS.getDate("modifiedon"));
                    String created = getEditRequestRS.getString("created") + " " + getEditRequestRS.getTime("createdon");
                    String modified = getEditRequestRS.getString("modified") + " " + getEditRequestRS.getTime("modifiedon");
                    String requested = getEditRequestRS.getString("requestedby");
                    String assigned = getEditRequestRS.getString("assignedto");
                    String approval = getEditRequestRS.getString("approval");
                    String comments = getEditRequestRS.getString("comments");
                    String duration = getEditRequestRS.getString("duration");
                    userid = Integer.parseInt(requested);

                    leaveDetails[i][0] = leaveId;
                    leaveDetails[i][1] = from;
                    leaveDetails[i][2] = to;
                    leaveDetails[i][3] = type;
                    leaveDetails[i][4] = description;
                    leaveDetails[i][5] = created;
                    leaveDetails[i][6] = modified;
                    leaveDetails[i][7] = requested;
                    leaveDetails[i][8] = assigned;
                    leaveDetails[i][9] = approval;
                    leaveDetails[i][10] = comments;
                    leaveDetails[i][11] = "";
                    leaveDetails[i][12] = duration;
                }
            }
            leave = LeaveBlancePeriodDAO.noOfLeaveDays(leaveDetails, GetProjectMembers.getBranchId(userid));
        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {

            try {
                if (getEditRequestRS != null) {
                    getEditRequestRS.close();
                }

            } catch (Exception ex) {
                logger.error("Error while getting Leave Details", ex);
            }
            try {
                if (getEditRequestPS != null) {
                    getEditRequestPS.close();
                }

            } catch (Exception ex) {
                logger.error("Error while getting Leave Details", ex);
            }
            try {
                if (editRequestConnection != null) {
                    editRequestConnection.close();
                    logger.info("Connection closed");
                    if (editRequestConnection.isClosed()) {
                        logger.info("Closed");
                    } else {
                        logger.info("Not Closed");
                    }
                }

            } catch (Exception ex) {
                logger.error("Error while getting Leave Details", ex);
            }
        }

        return leave;
    }

    public static String[][] getEditForRequest(int leaveid) {
        String leaveDetails[][] = null;
        Connection editRequestConnection = null;
        ResultSet getEditRequestRS = null;
        PreparedStatement getEditRequestPS = null;
        try {
            SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy");
            String today = sdf.format(GetDate.getDate());

            editRequestConnection = MakeConnection.getConnection();
            getEditRequestPS = editRequestConnection.prepareStatement("select leaveid,to_char(fromdate,'dd-MM-yyyy') as fromdate,to_char(todate,'dd-MM-yyyy') as todate,type,description,to_char(createdon,'dd-Mon-yyyy') as created,createdon,to_char(modifiedon,'dd-Mon-yyyy') as modified,modifiedon,requestedby,assignedto,approval,comments from Leave where leaveid='" + leaveid + "'", ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            getEditRequestRS = getEditRequestPS.executeQuery();

            leaveDetails = new String[1][11];
            for (int i = 0; i < 1; i++) {
                if (getEditRequestRS.next()) {
                    String leaveId = getEditRequestRS.getString("leaveid");
                    String from = sdf.format(getEditRequestRS.getDate("FROMDATE"));
                    String to = sdf.format(getEditRequestRS.getDate("TODATE"));
                    String type = getEditRequestRS.getString("type");
                    String description = getEditRequestRS.getString("description");
//                String created      =   sdf.format(getEditRequestRS.getDate("createdon"));
//                String modified     =   sdf.format(getEditRequestRS.getDate("modifiedon"));
                    String created = getEditRequestRS.getString("created") + " " + getEditRequestRS.getTime("createdon");
                    String modified = getEditRequestRS.getString("modified") + " " + getEditRequestRS.getTime("modifiedon");
                    String requested = getEditRequestRS.getString("requestedby");
                    String assigned = getEditRequestRS.getString("assignedto");
                    String approval = getEditRequestRS.getString("approval");
                    String comments = getEditRequestRS.getString("comments");

                    leaveDetails[i][0] = leaveId;
                    leaveDetails[i][1] = from;
                    leaveDetails[i][2] = to;
                    leaveDetails[i][3] = type;
                    leaveDetails[i][4] = description;
                    leaveDetails[i][5] = created;
                    leaveDetails[i][6] = modified;
                    leaveDetails[i][7] = requested;
                    leaveDetails[i][8] = assigned;
                    leaveDetails[i][9] = approval;
                    leaveDetails[i][10] = comments;
                }
            }

        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {

            try {
                if (getEditRequestRS != null) {
                    getEditRequestRS.close();
                }

            } catch (Exception ex) {
                logger.error("Error while getting Leave Details", ex);
            }
            try {
                if (getEditRequestPS != null) {
                    getEditRequestPS.close();
                }

            } catch (Exception ex) {
                logger.error("Error while getting Leave Details", ex);
            }
            try {
                if (editRequestConnection != null) {
                    editRequestConnection.close();
                    logger.info("Connection closed");
                    if (editRequestConnection.isClosed()) {
                        logger.info("Closed");
                    } else {
                        logger.info("Not Closed");
                    }
                }

            } catch (Exception ex) {
                logger.error("Error while getting Leave Details", ex);
            }
        }

        return leaveDetails;
    }

    public static String[][] waitingForApproval(int userId) {
        String leaveDetails[][] = null;

        Connection waitingForApprovalConnection = null;
        ResultSet getwaitingForApprovalRS = null;
        PreparedStatement getwaitingForApprovalPS = null;
        try {
            SimpleDateFormat sdf = new SimpleDateFormat("dd-MMM-yy");
            SimpleDateFormat sdfull = new SimpleDateFormat("HH:mm:ss");
//            String today            =   sdf.format(GetDate.getDate());

            waitingForApprovalConnection = MakeConnection.getConnection();
            getwaitingForApprovalPS = waitingForApprovalConnection.prepareStatement("select * from Leave where approval=0 and assignedto='" + userId + "'", ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            getwaitingForApprovalRS = getwaitingForApprovalPS.executeQuery();
            getwaitingForApprovalRS.last();
            int noOfRows = getwaitingForApprovalRS.getRow();
            getwaitingForApprovalRS.beforeFirst();
            leaveDetails = new String[noOfRows][13];
            for (int i = 0; i < noOfRows; i++) {
                getwaitingForApprovalRS.next();
                String leaveId = getwaitingForApprovalRS.getString("leaveid");
                String from = sdf.format(getwaitingForApprovalRS.getDate("FROMDATE"));
                String to = sdf.format(getwaitingForApprovalRS.getDate("TODATE"));
                String type = getwaitingForApprovalRS.getString("type");
                String description = getwaitingForApprovalRS.getString("description");
                String created = sdf.format(getwaitingForApprovalRS.getDate("createdon")) + " " + sdfull.format(getwaitingForApprovalRS.getTime("createdon"));
                String modified = sdf.format(getwaitingForApprovalRS.getDate("modifiedon"));
                String requested = getwaitingForApprovalRS.getString("requestedby");
                String assigned = getwaitingForApprovalRS.getString("assignedto");
                String approval = getwaitingForApprovalRS.getString("approval");
                String comments = getwaitingForApprovalRS.getString("comments");
                String duration = getwaitingForApprovalRS.getString("duration");

                leaveDetails[i][0] = leaveId;
                leaveDetails[i][1] = from;
                leaveDetails[i][2] = to;
                leaveDetails[i][3] = type;
                leaveDetails[i][4] = description;
                leaveDetails[i][5] = created;
                leaveDetails[i][6] = modified;
                leaveDetails[i][7] = requested;
                leaveDetails[i][8] = assigned;
                leaveDetails[i][9] = approval;
                leaveDetails[i][10] = comments;
                leaveDetails[i][11] = duration;
                leaveDetails[i][12] = LeaveBlancePeriodDAO.noOfLeavedayforWating(from, to, duration, GetProjectMembers.getBranchId(userId));
            }

        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {

            try {
                if (getwaitingForApprovalRS != null) {
                    getwaitingForApprovalRS.close();
                }

            } catch (Exception ex) {
                logger.error("Error while getting Leave Details", ex);
            }
            try {
                if (getwaitingForApprovalPS != null) {
                    getwaitingForApprovalPS.close();
                }

            } catch (Exception ex) {
                logger.error("Error while getting Leave Details", ex);
            }
            try {
                if (waitingForApprovalConnection != null) {
                    waitingForApprovalConnection.close();
                    logger.info("Connection closed");
                    if (waitingForApprovalConnection.isClosed()) {
                        logger.info("Closed");
                    } else {
                        logger.info("Not Closed");
                    }
                }

            } catch (Exception ex) {
                logger.error("Error while getting Leave Details", ex);
            }
        }

        return leaveDetails;
    }

    public static int getLeaveApprover() {
        int approver = 212;
        try {
            String appId = rb.getString("leaveApprover");
            approver = Integer.parseInt(appId);
        } catch (Exception e) {
        }

        return approver;
    }

    public static int getHrLeaveApprover() {
        int approver = 212;
        try {
            String appId = rb.getString("hrleaveApprover");
            approver = Integer.parseInt(appId);
        } catch (Exception e) {
        }

        return approver;
    }

    public static void deleteleave(int leaveId) {
        Connection connection = null;
        PreparedStatement stmt = null;
        try {
            connection = MakeConnection.getConnection();
            stmt = connection.prepareStatement("Delete from leave where leaveid=?");
            stmt.setInt(1, leaveId);
            stmt.executeUpdate();
        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            try {
                stmt.close();
                connection.close();
            } catch (SQLException ex) {
                java.util.logging.Logger.getLogger(LeaveUtil.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
            }
        }
    }

    public static Map<String, Float> leaveDetailsByUser(int userId, int branch) throws SQLException, ParseException {
        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        Map<String, Float> leaveDetails = new LinkedHashMap<>();
        Calendar cal = new GregorianCalendar();
        int currentYear = cal.get(Calendar.YEAR);
        int currentMonth = cal.get(Calendar.MONTH);
        String startDate = "01-Apr-" + currentYear;
        String endDate = "31-Mar-" + (currentYear + 1);
        if (currentMonth < 3) {
            startDate = "01-Apr-" + (currentYear - 1);
            endDate = "31-Mar-" + (currentYear);
        }
        SimpleDateFormat sdf = new SimpleDateFormat("dd-MMM-yyyy");
        Set<String> holidayDatesList = new HashSet<String>();
        Date start = sdf.parse(startDate);
        Date end = sdf.parse(endDate);
        List<Holidays> holidaysList = HolidaysUtil.findCalendarYearHolidaysByBranch(start, end, branch);
        if (!holidaysList.isEmpty()) {
            for (Holidays holday : holidaysList) {
                holidayDatesList.add(sdf.format(holday.getHolidayDate()));
            }
        }
        logger.info("holidayDatesList" + holidayDatesList);
        try {
            connection = MakeConnection.getConnection();
            statement = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            logger.info("select to_Number((TODATE-FROMDATE)+1)as leaveDays,type,duration,TO_CHAR(FROMDATE,'DD-MON-YYYY') as fromdate,TO_CHAR(FROMDATE,'DD-MON-YYYY') as todate from leave where requestedby=" + userId + " and fromdate <= '" + endDate + "' and todate>='" + startDate + "' and APPROVAL=1 order by type");
            resultset = statement.executeQuery("select to_Number((TODATE-FROMDATE)+1)as leaveDays,type,duration,TO_CHAR(FROMDATE,'DD-MON-YYYY') as fromdate,TO_CHAR(TODATE,'DD-MON-YYYY') as todate from leave where requestedby=" + userId + " and fromdate <= '" + endDate + "' and todate>='" + startDate + "' and APPROVAL=1 order by type");
            String type = "";
            float days = 0;
            while (resultset.next()) {
                String leavetype = resultset.getString("type");
                float leavedays = resultset.getInt("leaveDays");
                String from = resultset.getString("fromdate");
                String to = resultset.getString("todate");
                Date fromDate = sdf.parse(from);
                Date toDate = sdf.parse(to);

                if (fromDate.compareTo(start) < 0) {
                    long extraLeaveDays = (start.getTime() - fromDate.getTime()) / (24 * 60 * 60 * 1000);
                    leavedays = leavedays - extraLeaveDays;

                    fromDate = start;
                }

                Iterator<Date> dateslist = new DateIterator(fromDate, toDate);
                if ("".equals(type)) {
                    type = leavetype;
                    if (!resultset.getString("duration").equalsIgnoreCase("Full Day")) {
                        days = days + leavedays / 2;
                        while (dateslist.hasNext()) {
                            Date oneOfDate = dateslist.next();
                            String oneDate = sdf.format(oneOfDate);
                            if (holidayDatesList.contains(oneDate)) {
                                days = (days) - 1 / 2;
                            }
                        }
                    } else {
                        days = days + leavedays;
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
                    leaveDetails.put(type, days);
                } else if (leavetype.equalsIgnoreCase(type)) {
                    if (!resultset.getString("duration").equalsIgnoreCase("Full Day")) {
                        days = days + leavedays / 2;
                        while (dateslist.hasNext()) {
                            Date oneOfDate = dateslist.next();
                            String oneDate = sdf.format(oneOfDate);
                            if (holidayDatesList.contains(oneDate)) {
                                days = (days) - 1 / 2;
                            }
                        }
                    } else {
                        days = days + leavedays;
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
                    leaveDetails.put(type, days);
                } else {
                    type = leavetype;
                    if (!resultset.getString("duration").equalsIgnoreCase("Full Day")) {
                        days = leavedays / 2;
                        while (dateslist.hasNext()) {
                            Date oneOfDate = dateslist.next();
                            String oneDate = sdf.format(oneOfDate);
                            if (holidayDatesList.contains(oneDate)) {
                                days = days - 1 / 2;
                            }
                        }
                    } else {
                        days = leavedays;
                        while (dateslist.hasNext()) {
                            Date oneOfDate = dateslist.next();

                            String oneDate = sdf.format(oneOfDate);
                            Calendar caler = Calendar.getInstance();
                            caler.setTime(oneOfDate);
                            int day = caler.get(Calendar.DAY_OF_WEEK);
                            if (day == 7 || day == 1) {
                                days = (days) - 1;
                            } else if (holidayDatesList.contains(oneDate)) {
                                days = days - 1;
                            }
                        }
                    }
                    leaveDetails.put(type, days);
                }

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
        logger.info(leaveDetails);
        return leaveDetails;

    }

    public static List durationList() {
        List durationList = new ArrayList();
        durationList.add("Full Day");
        durationList.add("First Half");
        durationList.add("Second Half");
        return durationList;

    }

    public static int getLeaveCount(int requester, int approver) {
        int count = 0;
        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        try {
            connection = MakeConnection.getConnection();
            statement = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);

            resultset = statement.executeQuery("select count(distinct(l.leaveid)) from Leave l,LEAVE_APPROVER_MAINTENANCE lam where l.approval=0 and l.requestedby=lam.REQUESTER and l.assignedto=lam.APPROVER and lam.REQUESTER=" + requester + " and lam.APPROVER=" + approver + "");
            while (resultset.next()) {
                count = resultset.getInt(1);
            }
        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            if (resultset != null) {
                try {
                    resultset.close();
                } catch (SQLException ex) {
                    java.util.logging.Logger.getLogger(LeaveUtil.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
                }
            }
            if (statement != null) {
                try {
                    statement.close();
                } catch (SQLException ex) {
                    java.util.logging.Logger.getLogger(LeaveUtil.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
                }
            }

            if (connection != null) {
                try {
                    connection.close();
                } catch (SQLException ex) {
                    java.util.logging.Logger.getLogger(LeaveUtil.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
                }
            }
        }
        return count;
    }

    public static int getWorkingDaysBetweenTwoDates(Date startDate, Date endDate) {
        Calendar startCal = Calendar.getInstance();
        startCal.setTime(startDate);

        Calendar endCal = Calendar.getInstance();
        endCal.setTime(endDate);

        int workDays = 0;

        //Return 0 if start and end are the same
        if (startCal.getTimeInMillis() == endCal.getTimeInMillis()) {
            return 0;
        }

        if (startCal.getTimeInMillis() > endCal.getTimeInMillis()) {
            startCal.setTime(endDate);
            endCal.setTime(startDate);
        }

        if (startCal.get(Calendar.DAY_OF_WEEK) != Calendar.SATURDAY && startCal.get(Calendar.DAY_OF_WEEK) != Calendar.SUNDAY) {
            ++workDays;
        }

        do {
            startCal.add(Calendar.DAY_OF_MONTH, 1);
            if (startCal.get(Calendar.DAY_OF_WEEK) != Calendar.SATURDAY && startCal.get(Calendar.DAY_OF_WEEK) != Calendar.SUNDAY) {
                ++workDays;
            }
        } while (startCal.getTimeInMillis() < endCal.getTimeInMillis());

        return workDays;
    }

    public static LinkedHashMap<String, String> userLeaveTypes() {
        LinkedHashMap<String, String> leaveType = new LinkedHashMap<>();
        leaveType.put("Casual Leave", "Casual Leave");
        leaveType.put("Sick Leave", "Sick Leave");
        leaveType.put("Privilege Leave", "Privilege Leave");
        leaveType.put("Componsation Leave", "Componsation Leave");
        leaveType.put("On Duty", "On Duty");
        return leaveType;
    }

    public static LinkedHashMap<String, String> hrLeaveTypes() {
        LinkedHashMap<String, String> leaveType = new LinkedHashMap<>();
        leaveType.put("Casual Leave", "Casual Leave");
        leaveType.put("Sick Leave", "Sick Leave");
        leaveType.put("Privilege Leave", "Privilege Leave");
        leaveType.put("Absent", "Absent");
        leaveType.put("Componsation Leave", "Componsation Leave");
        leaveType.put("Special Leave", "Special  Leave");
        leaveType.put("Medical Leave", "Medical Leave");
        leaveType.put("Metarnity Leave", "Metarnity Leave");
        leaveType.put("On Duty", "On Duty");
        leaveType.put("4 Year vacation", "4 Year vacation");
        leaveType.put("8 Year vacation", "8 Year vacation");
        return leaveType;
    }

    public static String checkMinimumWorkdays(int userid) {
        String res = "notValid";
        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        Date regDate = null;
        try {
            connection = MakeConnection.getConnection();
            statement = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            resultset = statement.executeQuery("select REGISTEREDON from users where userid=" + userid + "");
            while (resultset.next()) {
                regDate = resultset.getDate(1);
            }
            if (regDate == null) {
                resultset = statement.executeQuery("select FROMDATE from leave where requestedby=" + userid + " and APPROVAL=1 and  ROWNUM =1");
            }
            while (resultset.next()) {
                regDate = resultset.getDate(1);
            }
            if (regDate != null) {
                float daysBetween = ((new Date().getTime() - regDate.getTime()) / (1000 * 60 * 60 * 24));
                if (daysBetween >= 180f) {
                    res = "valid";
                }
            }
        } catch (Exception e) {
            res = "notValid";
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

            if (connection != null) {
                try {
                    connection.close();
                } catch (SQLException ex) {
                    logger.error(ex.getMessage());
                }
            }
        }
        return res;
    }

    public static String[][] getLeaveRequestByDateandUser(int requestedBy, String fromDate) {
        String leaveDetails[][] = null;
        Connection editRequestConnection = null;
        ResultSet getEditRequestRS = null;
        PreparedStatement getEditRequestPS = null;
        try {
            SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy");

            editRequestConnection = MakeConnection.getConnection();
            String query = "select leaveid,to_char(fromdate,'dd-MM-yyyy') as fromdate,to_char(todate,'dd-MM-yyyy') as todate,type,description,to_char(createdon,'dd-Mon-yyyy') as created,createdon,to_char(modifiedon,'dd-Mon-yyyy') as modified,modifiedon,requestedby,assignedto,approval,comments,duration from Leave where requestedby='" + requestedBy + "' and to_char(fromdate,'dd-MM-yyyy') ='" + fromDate + "'";
            System.out.println("query : " + query);
            getEditRequestPS = editRequestConnection.prepareStatement(query, ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            getEditRequestRS = getEditRequestPS.executeQuery();

            if (getEditRequestRS.next()) {
                            leaveDetails = new String[1][6];

                String leaveId = getEditRequestRS.getString("leaveid");
                String from = getEditRequestRS.getString("fromdate");
                String to = getEditRequestRS.getString("todate");
                String type = getEditRequestRS.getString("type");
                String description = getEditRequestRS.getString("description");
                String duration = getEditRequestRS.getString("duration");
                System.out.println("leaveId :" + leaveId);
                leaveDetails[0][0] = leaveId;
                leaveDetails[0][1] = from;
                leaveDetails[0][2] = to;
                leaveDetails[0][3] = type;
                leaveDetails[0][4] = description;
                leaveDetails[0][5] = duration;
            }

        } catch (Exception e) {
            e.printStackTrace();
            logger.error(e.getMessage());
        } finally {

            try {
                if (getEditRequestRS != null) {
                    getEditRequestRS.close();
                }

            } catch (Exception ex) {
                logger.error("Error while getting Leave Details", ex);
            }
            try {
                if (getEditRequestPS != null) {
                    getEditRequestPS.close();
                }

            } catch (Exception ex) {
                logger.error("Error while getting Leave Details", ex);
            }
            try {
                if (editRequestConnection != null) {
                    editRequestConnection.close();
                    logger.info("Connection closed");
                    if (editRequestConnection.isClosed()) {
                        logger.info("Closed");
                    } else {
                        logger.info("Not Closed");
                    }
                }

            } catch (Exception ex) {
                logger.error("Error while getting Leave Details", ex);
            }
        }

        return leaveDetails;
    }
    
    public static Map leaveStatus(){
        Map<Integer, String> hm = new HashMap<Integer, String>();
                hm.put(0, "Yet to Approve");
                hm.put(1, "Approved");
                hm.put(-1, "Rejected");
                hm.put(-2, "Cancelled");
        return hm;
    }
}
