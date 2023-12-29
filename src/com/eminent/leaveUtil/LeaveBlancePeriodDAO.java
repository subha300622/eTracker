/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eminent.leaveUtil;

import com.eminent.holidays.Holidays;
import com.eminent.holidays.HolidaysUtil;
import static com.eminent.leaveUtil.LeaveBalancePeriod.logger;
import com.eminent.util.DateIterator;
import com.eminent.util.GetProjectMembers;
import com.eminentlabs.dao.HibernateFactory;
import com.eminentlabs.mom.MoMAttendance;
import com.eminentlabs.mom.MoMUtil;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
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
import java.util.logging.Level;
import java.util.logging.Logger;
import org.hibernate.Query;
import org.hibernate.Session;
import pack.eminent.encryption.MakeConnection;

/**
 *
 * @author admin
 */
public class LeaveBlancePeriodDAO {

    public static float getPrivilegeLeave(int userID) {
        Set<String> attStatu = MoMUtil.attendancsStatus();
        float Pleave = 8.0f;
        Date d = new Date();
        try {
            SimpleDateFormat sdf = new SimpleDateFormat("dd-MMM-yyyy");
            if (d.getTime() >= sdf.parse("01-Apr-2016").getTime()) {
                List<MoMAttendance> moMAttendancePL = new LeaveBlancePeriodDAO().userAttendanceByUserId(userID);
                float pLleavepresent = 0.0f;
                for (String status : attStatu) {
                    int count = 0;
                    for (MoMAttendance uds : moMAttendancePL) {
                        if (status.equalsIgnoreCase(uds.getStatus())) {
                            count = uds.getCount();
                        }
                    }
                    if (status.equalsIgnoreCase("Present") || status.contains("Permission") || status.contains("Client") || status.contains("Intimated")) {
                        pLleavepresent = pLleavepresent + count / 2;

                    }
                }
                Pleave = (float) ((int) (pLleavepresent / 20));

                if (Pleave > 8.0f) {
                    Pleave = 8.0f;
                }
            }
        } catch (ParseException e) {
            logger.error(e.getMessage());
        }
        return Pleave;
    }

    public static Map<Integer, LinkedHashMap<String, Float>> leaveBalnceAllUser(int year, int month) {
        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        LinkedHashMap<String, Float> leaveDetails = new LinkedHashMap<>();
        Map<Integer, LinkedHashMap<String, Float>> leaveDetailsBlance = new HashMap();

        String startDate = "01-Apr-" + year;
        String endDate = "31-Mar-" + (year + 1);
        if (month < 3) {
            startDate = "01-Apr-" + (year - 1);
            endDate = "31-Mar-" + (year);
        }
        try {

            SimpleDateFormat sdf = new SimpleDateFormat("dd-MMM-yyyy");
            Set<String> holidayDatesList = new HashSet<String>();
            Date start = sdf.parse(startDate);
            Date end = sdf.parse(endDate);
                       Map<Integer, Set<String>> holidaysMap = new HashMap<>();
            List<Holidays> holidaysList = HolidaysUtil.findCalendarYearHolidays(start, end);

            if (!holidaysList.isEmpty()) {
                for (Holidays holday : holidaysList) {
                    Set<String> holidays = holidaysMap.get(holday.getBranchId());
                    if(holidays==null){
                       holidays = new HashSet<>();
                       holidaysMap.put(holday.getBranchId(), holidays);
                    }
                    holidays.add(sdf.format(holday.getHolidayDate()));
                }
            }
            logger.info("holidayDatesList" + holidayDatesList);
            connection = MakeConnection.getConnection();
            statement = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            logger.info("select requestedby ,to_Number((TODATE-FROMDATE)+1)as leaveDays,type,duration,TO_CHAR(FROMDATE,'DD-MON-YYYY') as fromdate,TO_CHAR(Todate,'DD-MON-YYYY') as todate from leave where  fromdate <= '" + endDate + "' and todate>='" + startDate + "' and APPROVAL=1 order by requestedby , type");
            resultset = statement.executeQuery("select requestedby, to_Number((TODATE-FROMDATE)+1)as leaveDays,type,duration,TO_CHAR(FROMDATE,'DD-MON-YYYY') as fromdate,TO_CHAR(TODATE,'DD-MON-YYYY') as todate from leave where  fromdate <= '" + endDate + "' and todate>='" + startDate + "' and APPROVAL=1 order by requestedby , type");
            String type = "";
            float days = 0;
            int requestedby = 0;
            int size = 0;
            if (resultset != null) {
                resultset.beforeFirst();
                resultset.last();
                size = resultset.getRow();
            }
            int i = 0;
            resultset.beforeFirst();
            while (resultset.next()) {
                i++;
                String requsetb = resultset.getString("requestedby");
                int requ = MoMUtil.parseInteger(requsetb, 0);
                holidayDatesList = holidaysMap.get(GetProjectMembers.getBranchId(requ));

                String leavetype = resultset.getString("type");
                float leavedays = resultset.getInt("leaveDays");
                String from = resultset.getString("fromdate");
                String to = resultset.getString("todate");
                Date fromDate = sdf.parse(from);
                Date toDate = sdf.parse(to);

                if (start.compareTo(fromDate) > 0) {
                    long extraLeaveDays = (start.getTime() - fromDate.getTime()) / (24 * 60 * 60 * 1000);
                    leavedays = leavedays - extraLeaveDays;
                    fromDate = start;
                }
                if (toDate.compareTo(end) > 0) {
                    long extraLeaveDays = (toDate.getTime() - end.getTime()) / (24 * 60 * 60 * 1000);
                    leavedays = leavedays - extraLeaveDays;
                    toDate = end;
                }

                Iterator<Date> dateslist = new DateIterator(fromDate, toDate);
                if (requestedby == requ || requestedby == 0) {
                    requestedby = requ;
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
                } else {
                    leaveDetailsBlance.put(requestedby, leaveDetails);
                    leaveDetails = new LinkedHashMap<>();

                    requestedby = requ;
                    days = 0.0f;
                    type = leavetype;

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
                                logger.info("--------------->" + oneOfDate + ", " + day);
                                if (day == 7 || day == 1) {
                                    days = (days) - 1;
                                    logger.info("--------------->" + oneOfDate + ", " + day);
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
                                logger.info("--------------->" + oneOfDate + ", " + day);
                                if (day == 7 || day == 1) {
                                    days = (days) - 1;
                                    logger.info("--------------->" + oneOfDate + ", " + day);
                                } else if (holidayDatesList.contains(oneDate)) {
                                    days = days - 1;
                                }
                            }
                        }
                        leaveDetails.put(type, days);
                    }
                }

                if (size == i) {
                    leaveDetailsBlance.put(requestedby, leaveDetails);
                }
            }
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

            if (connection != null) {
                try {
                    connection.close();
                } catch (SQLException ex) {
                    logger.error(ex.getMessage());
                }
            }
        }
        return leaveDetailsBlance;

    }

    public List<MoMAttendance> userAttendanceByMomths(String startDate, String endDate) {
        List<MoMAttendance> mAttendances = new ArrayList<MoMAttendance>();
        List<MoMAttendance> mAttendancesFinal = new ArrayList<MoMAttendance>();
        Session session = null;
        try {
            session = HibernateFactory.getCurrentSession();
            String sqlQuery = "";
            sqlQuery = "select m.userid,status, u.firstname||' '||substr(u.lastname,0,1)  as name,(to_char(momdate,'DD-Mon-YYYY')||', '||momtime),u.team  from mom_user_detail m, users u where m.userid=u.USERID and momdate between '" + startDate + "' and '" + endDate + "' order by name,userid,status";
            logger.info(sqlQuery);
            Query query = session.createSQLQuery(sqlQuery);
            Iterator iterator = query.list().iterator();
            while (iterator.hasNext()) {
                Object[] row = (Object[]) iterator.next();
                MoMAttendance mAttendance = new MoMAttendance();

                for (int col = 0; col < row.length; col++) {
                    if (col == 0) {
                        mAttendance.setUserId((BigDecimal) row[col]);
                    } else if (col == 1) {
                        mAttendance.setStatus(row[col].toString());
                    } else if (col == 3) {
                        mAttendance.setTime(row[col].toString());
                    } else if (col == 2) {
                        mAttendance.setName(row[col].toString());
                    } else if (col == 4) {
                        mAttendance.setPeriod(row[col].toString());
                    }
                }
                mAttendances.add(mAttendance);
            }
            final long startTime = System.currentTimeMillis();

            for (MoMAttendance mAttendance1 : mAttendances) {
                mAttendance1.setCount(getCount(mAttendance1.getUserId(), mAttendance1.getStatus(), mAttendances));
                //  mAttendance1.setDatesList(getDate(mAttendance1.getUserId(), mAttendance1.getStatus(), mAttendances));
                if (!mAttendancesFinal.contains(mAttendance1)) {
                    mAttendancesFinal.add(mAttendance1);
                }
            }
            final long endTime = System.currentTimeMillis();

        } catch (Exception e) {
            logger.error("Errorfgdggffgfg: " + e.getMessage());
        } finally {
            if (session != null) {
                if (session.isOpen()) {
                    try {
                        session.close();
                    } catch (Exception e) {
                        logger.error("Errorfgdggffgfg: " + e.getMessage());

                    }
                }
            }
        }
        return mAttendancesFinal;
    }

    public static Map<Integer, LinkedHashMap<String, Float>> leaveCountByPeriod(String startDate, String endDate) throws SQLException, ParseException {
        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        LinkedHashMap<String, Float> leaveDetails = new LinkedHashMap<>();
        Map<Integer, LinkedHashMap<String, Float>> leaveDetailsReq = new HashMap();

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

        try {
            connection = MakeConnection.getConnection();
            statement = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            logger.info("select requestedby ,to_Number((TODATE-FROMDATE)+1)as leaveDays,type,duration,TO_CHAR(FROMDATE,'DD-MON-YYYY') as fromdate,TO_CHAR(FROMDATE,'DD-MON-YYYY') as todate from leave where  fromdate <= '" + endDate + "' and todate>='" + startDate + "' and APPROVAL=1 order by requestedby , type");
            resultset = statement.executeQuery("select requestedby, to_Number((TODATE-FROMDATE)+1)as leaveDays,type,duration,TO_CHAR(FROMDATE,'DD-MON-YYYY') as fromdate,TO_CHAR(TODATE,'DD-MON-YYYY') as todate from leave where  fromdate <= '" + endDate + "' and todate>='" + startDate + "' and APPROVAL=1 order by requestedby , type");
            String type = "";
            float days = 0;
            int requestedby = 0;
            int size = 0;
            if (resultset != null) {
                resultset.beforeFirst();
                resultset.last();
                size = resultset.getRow();
            }
            int i = 0;
            resultset.beforeFirst();
            while (resultset.next()) {
                i++;
                String requsetb = resultset.getString("requestedby");
                int requ = MoMUtil.parseInteger(requsetb, 0);

                String leavetype = resultset.getString("type");
                float leavedays = resultset.getInt("leaveDays");
                String from = resultset.getString("fromdate");
                String to = resultset.getString("todate");
                Date fromDate = sdf.parse(from);
                Date toDate = sdf.parse(to);

                if (start.compareTo(fromDate) > 0) {
                    long extraLeaveDays = (start.getTime() - fromDate.getTime()) / (24 * 60 * 60 * 1000);
                    leavedays = leavedays - extraLeaveDays;
                    fromDate = start;
                }
                if (toDate.compareTo(end) > 0) {
                    long extraLeaveDays = (toDate.getTime() - end.getTime()) / (24 * 60 * 60 * 1000);
                    leavedays = leavedays - extraLeaveDays;
                    toDate = end;
                }

                Iterator<Date> dateslist = new DateIterator(fromDate, toDate);
                if (requestedby == requ || requestedby == 0) {
                    requestedby = requ;
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
                                logger.info("--------------->" + oneOfDate + ", " + day);
                                if (day == 7 || day == 1) {
                                    days = (days) - 1;
                                    logger.info("--------------->" + oneOfDate + ", " + day);
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
                                logger.info("--------------->" + oneOfDate + ", " + day);
                                if (day == 7 || day == 1) {
                                    days = (days) - 1;
                                    logger.info("--------------->" + oneOfDate + ", " + day);
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
                                logger.info("--------------->" + oneOfDate + ", " + day);
                                if (day == 7 || day == 1) {
                                    days = (days) - 1;
                                    logger.info("--------------->" + oneOfDate + ", " + day);
                                } else if (holidayDatesList.contains(oneDate)) {
                                    days = days - 1;
                                }
                            }
                        }
                        leaveDetails.put(type, days);
                    }
                } else {
                    leaveDetailsReq.put(requestedby, leaveDetails);
                    leaveDetails = new LinkedHashMap<>();

                    requestedby = requ;
                    days = 0.0f;
                    type = leavetype;

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
                                logger.info("--------------->" + oneOfDate + ", " + day);
                                if (day == 7 || day == 1) {
                                    days = (days) - 1;
                                    logger.info("--------------->" + oneOfDate + ", " + day);
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
                                logger.info("--------------->" + oneOfDate + ", " + day);
                                if (day == 7 || day == 1) {
                                    days = (days) - 1;
                                    logger.info("--------------->" + oneOfDate + ", " + day);
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
                                logger.info("--------------->" + oneOfDate + ", " + day);
                                if (day == 7 || day == 1) {
                                    days = (days) - 1;
                                    logger.info("--------------->" + oneOfDate + ", " + day);
                                } else if (holidayDatesList.contains(oneDate)) {
                                    days = days - 1;
                                }
                            }
                        }
                        leaveDetails.put(type, days);
                    }
                }
                if (size == i) {
                    leaveDetailsReq.put(requestedby, leaveDetails);
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
        logger.info(leaveDetailsReq);

        return leaveDetailsReq;

    }

    public List<MoMAttendance> userAttendanceByUserId(int userid) {
        List<MoMAttendance> mAttendances = new ArrayList<MoMAttendance>();
        List<MoMAttendance> mAttendancesFinal = new ArrayList<MoMAttendance>();
        Session session = null;
        try {
            Calendar cal = Calendar.getInstance();
            cal.setTime(new Date());
            int month = cal.get(Calendar.MONTH);
            int year = cal.get(Calendar.YEAR);
            String startDate = "01-Apr-" + year;
            String enddate = "31-Mar-" + (year + 1);
            if (month < 3) {
                startDate = "01-Apr-" + (year - 1);
                enddate = "31-Mar-" + (year);
            }

            session = HibernateFactory.getCurrentSession();
            String sqlQuery = "";
            sqlQuery = "select m.userid,status, u.firstname||' '||substr(u.lastname,0,1)  as name,(to_char(momdate,'DD-Mon-YYYY')||', '||momtime) from mom_user_detail m, users u where m.userid=u.USERID and u.userID=" + userid + " and momdate between '" + startDate + "' and '" + enddate + "' order by name,userid,status";
            logger.info(sqlQuery);
            Query query = session.createSQLQuery(sqlQuery);
            Iterator iterator = query.list().iterator();
            while (iterator.hasNext()) {
                Object[] row = (Object[]) iterator.next();
                MoMAttendance mAttendance = new MoMAttendance();
                for (int col = 0; col < row.length; col++) {
                    if (col == 0) {
                        mAttendance.setUserId((BigDecimal) row[col]);
                    } else if (col == 1) {
                        mAttendance.setStatus(row[col].toString());
                    } else if (col == 3) {
                        mAttendance.setTime(row[col].toString());
                    } else if (col == 2) {
                        mAttendance.setName(row[col].toString());
                    }
                }
                mAttendances.add(mAttendance);
            }
            for (MoMAttendance mAttendance1 : mAttendances) {
                mAttendance1.setCount(getCount(mAttendance1.getUserId(), mAttendance1.getStatus(), mAttendances));
                //  mAttendance1.setDatesList(getDate(mAttendance1.getUserId(), mAttendance1.getStatus(), mAttendances));
                if (!mAttendancesFinal.contains(mAttendance1)) {
                    mAttendancesFinal.add(mAttendance1);
                }
            }
        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
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
        return mAttendancesFinal;
    }

    public Map<Integer, String> userTeam() {
        Map<Integer, String> userTeam = new HashMap();
        Session session = null;
        try {
            session = HibernateFactory.getCurrentSession();
            String sqlQuery = "";
            //            sqlQuery = "select u.userID,u.EMP_ID,m.team from MOM_MAINTANANCE m,users u where u.userid=m.userId";

            sqlQuery = "select distinct (u.userID),u.EMP_ID,m.team from MOM_MAINTANANCE m,users u  where m.userid=u.userid and EMP_ID  IS NOT NULL group by u.userID,u.EMP_ID,m.team";
            logger.info(sqlQuery);
            Query query = session.createSQLQuery(sqlQuery);
            Iterator iterator = query.list().iterator();
            while (iterator.hasNext()) {
                Object[] row = (Object[]) iterator.next();

                for (int col = 0; col < row.length; col++) {
                    if (col == 0) {
                        userTeam.put(((BigDecimal) row[0]).intValue(), row[1] + "-" + row[2]);
                    }
                }

            }

        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
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

        return userTeam;
    }

    public static String[][] noOfLeaveDays(String[][] leaveDeatalis,int branchId) throws ParseException {
        SimpleDateFormat sdf = new SimpleDateFormat("dd-MMM-yyyy");
        String leave[][] = null;
        Set<String> holidayDatesList = new HashSet<>();
        float days = 0.0f;
        try {
            Calendar cal = Calendar.getInstance();
            cal.setTime(new Date());
            int month = cal.get(Calendar.MONTH);
            int year = cal.get(Calendar.YEAR);
            String startDate = "01-Apr-" + year;
            String enddate = "31-Mar-" + (year + 1);
            if (month < 3) {
                startDate = "01-Apr-" + (year - 1);
                enddate = "31-Mar-" + (year);
            }
            Date start = sdf.parse(startDate);
            Date end = sdf.parse(enddate);
            List<Holidays> holidaysList = HolidaysUtil.findCalendarYearHolidaysByBranch(start, end,branchId);
            if (!holidaysList.isEmpty()) {
                for (Holidays holday : holidaysList) {
                    holidayDatesList.add(sdf.format(holday.getHolidayDate()));
                }
            }
            leave = new String[leaveDeatalis.length][14];
            for (int i = 0; i < leaveDeatalis.length; i++) {
                days = 0.0f;
                long ndays = 0l;
                SimpleDateFormat sdfa = new SimpleDateFormat("dd-MMM-yy");
                Iterator<Date> dateslist = new DateIterator(sdfa.parse(leaveDeatalis[i][1]), sdfa.parse(leaveDeatalis[i][2]));
                while (dateslist.hasNext()) {
                    Date oneOfDate = dateslist.next();
                    Calendar caler = Calendar.getInstance();
                    String oneDate = sdf.format(oneOfDate);

                    caler.setTime(oneOfDate);
                    int dayss = caler.get(Calendar.DAY_OF_WEEK);
                    if (dayss == 1 || dayss == 7) {
                        ndays = (ndays) + 1;
                    } else if (holidayDatesList.contains(oneDate)) {
                        ndays = (ndays) + 1;
                    }
                }
                if (sdfa.parse(leaveDeatalis[i][1]).getTime() == sdfa.parse(leaveDeatalis[i][2]).getTime()) {
                    if (ndays == 0) {
                        if (leaveDeatalis[i][12].contains("Half")) {
                            days = 0.5F;
                        } else {
                            days = 1.0f;
                        }
                    }
                } else {
                    days = (1 + (sdfa.parse(leaveDeatalis[i][2]).getTime() - sdfa.parse(leaveDeatalis[i][1]).getTime()) / (24 * 60 * 60 * 1000)) - ndays;
                }
                String nday;
                if (days > 0) {
                    nday = Float.toString(days);
                } else {
                    nday = "0";
                }

                leave[i][0] = leaveDeatalis[i][0];
                leave[i][1] = leaveDeatalis[i][1];
                leave[i][2] = leaveDeatalis[i][2];
                leave[i][3] = leaveDeatalis[i][3];
                leave[i][4] = leaveDeatalis[i][4];
                leave[i][5] = leaveDeatalis[i][5];
                leave[i][6] = leaveDeatalis[i][6];
                leave[i][7] = leaveDeatalis[i][7];
                leave[i][8] = leaveDeatalis[i][8];
                leave[i][9] = leaveDeatalis[i][9];
                leave[i][10] = leaveDeatalis[i][10];
                leave[i][11] = leaveDeatalis[i][11];
                leave[i][12] = leaveDeatalis[i][12];
                leave[i][13] = nday;
            }

        } catch (Exception e) {
            logger.error(e.getMessage());
        }
        return leave;
    }

    public static String noOfLeavedayforWating(String fromdate, String todate, String duration,int branch) throws ParseException {
        SimpleDateFormat sdf = new SimpleDateFormat("dd-MMM-yy");
        String nday = "0";
        Set<String> holidayDatesList = new HashSet<>();
        float days = 0.0f;
        try {

            Date start = sdf.parse(fromdate);
            Date end = sdf.parse(todate);
            List<Holidays> holidaysList = HolidaysUtil.findCalendarYearHolidaysByBranch(start, end,branch);
            if (!holidaysList.isEmpty()) {
                for (Holidays holday : holidaysList) {
                    holidayDatesList.add(sdf.format(holday.getHolidayDate()));
                }
            }

            days = 0.0f;
            long ndays = 0l;

            Iterator<Date> dateslist = new DateIterator(start, end);
            while (dateslist.hasNext()) {
                Date oneOfDate = dateslist.next();
                Calendar caler = Calendar.getInstance();
                String oneDate = sdf.format(oneOfDate);
                caler.setTime(oneOfDate);
                int dayss = caler.get(Calendar.DAY_OF_WEEK);
                if (dayss == 1 || dayss == 7) {
                    ndays = (ndays) + 1;
                } else if (holidayDatesList.contains(oneDate)) {
                    ndays = (ndays) + 1;
                }
            }
            if (start.getTime() == end.getTime()) {
                if (ndays == 0) {
                    if (duration.contains("Half")) {
                        days = 0.5F;
                    } else {
                        days = 1.0f;
                    }
                }
            } else {
                days = (1 + (end.getTime() - start.getTime()) / (24 * 60 * 60 * 1000)) - ndays;
            }

            if (days > 0) {
                nday = Float.toString(days);
            } else {
                nday = "0";
            }

        } catch (Exception e) {
            logger.error(e.getMessage());
        }
        return nday;
    }

    public float getLeaveDays(Set<String> holidayDatesList, String start, String end, String duration) {
        SimpleDateFormat sdf = new SimpleDateFormat("dd-MMM-yy");
        float nday = 0.0f;

        float days = 0.0f;
        try {
            days = 0.0f;
            long ndays = 0l;

            Iterator<Date> dateslist = new DateIterator(sdf.parse(start), sdf.parse(end));
            while (dateslist.hasNext()) {
                Date oneOfDate = dateslist.next();
                Calendar caler = Calendar.getInstance();
                String oneDate = sdf.format(oneOfDate);
                caler.setTime(oneOfDate);
                int dayss = caler.get(Calendar.DAY_OF_WEEK);
                if (dayss == 1 || dayss == 7) {
                    ndays = (ndays) + 1;
                } else if (holidayDatesList!=null && holidayDatesList.contains(oneDate)) {
                    ndays = (ndays) + 1;
                }
            }
            if (sdf.parse(start).getTime() == sdf.parse(end).getTime()) {
                if (ndays == 0) {
                    if (duration.contains("Half")) {
                        days = 0.5F;
                    } else {
                        days = 1.0f;
                    }
                }
            } else {
                days = (1 + (sdf.parse(end).getTime() - sdf.parse(start).getTime()) / (24 * 60 * 60 * 1000)) - ndays;
            }

            if (days > 0) {
                nday = days;
            } else {
                nday = 0.0f;
            }
        } catch (Exception e) {
            logger.error(e.getMessage());
        }
        return nday;
    }

    public int getCount(BigDecimal userId, String status, List<MoMAttendance> att) {
        int count = 0;
        for (MoMAttendance mom : att) {
            if (mom.getUserId().equals(userId) && mom.getStatus().equalsIgnoreCase(status)) {
                count++;
            } else if (count > 0) {
                break;
            }
        }
        return count;
    }
}
