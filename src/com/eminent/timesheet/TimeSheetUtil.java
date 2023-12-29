/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eminent.timesheet;

import com.eminent.issue.controller.MaintainWRMDay;
import com.eminent.util.DateIterator;
import com.eminent.util.ProjectFinder;
import com.eminentlabs.dao.HibernateFactory;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Map;
import org.apache.log4j.Logger;
import org.hibernate.Query;
import org.hibernate.Session;
import pack.eminent.encryption.MakeConnection;

/**
 *
 * @author E0288
 */
public class TimeSheetUtil {

    static Logger logger = Logger.getLogger("TimeSheetUtil");

    public List<TimesheetIssue> findIssuesByTimesheetId(String timeSheetId) {
        List<TimesheetIssue> timeSheetIssueList = new ArrayList<TimesheetIssue>();
        Session session = null;
        try {
            session = HibernateFactory.getCurrentSession();
            Query query = session.getNamedQuery("TimesheetIssue.findByTimeSheetId");
            query.setParameter("timeSheetId", timeSheetId);
            timeSheetIssueList = (List<TimesheetIssue>) query.list();

        } catch (Exception e) {
            logger.error("findIssuesByTimesheetId" + e.getMessage());
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
        return timeSheetIssueList;
    }

    public static String[][] getWRMRatings(int userId, String startDate, String endDate) {
        ProjectFinder pf = new ProjectFinder();
        Connection connection = null;
        Statement statement = null;
        ResultSet rs = null, rs1 = null;
        LinkedHashSet projectSet = new LinkedHashSet<String>();
        LinkedHashSet weekSet = new LinkedHashSet<String>();
        String project = "", week = "", projSplit = "", rating = "N/A";
        HashMap hm = new HashMap<Integer, Integer>();
        String[][] finalVal = new String[1][1];
        SimpleDateFormat sdf = new SimpleDateFormat("dd-MMM-yyyy");
        int noofweek = 0, curryear = 0;
        try {
            Calendar now = Calendar.getInstance();
            Date start = sdf.parse(startDate);
            Date end = sdf.parse(endDate);
            connection = MakeConnection.getConnection();
            statement = connection.createStatement();
            String sql = "select regexp_substr(p.PNAME,'\\w+') as projects,i.HELD_ON,rating,p.pname,p.version,i.MOM_CLIENT_ID  from MOM_FOR_CLIENT i,project p  where p.pid=i.pid and TO_DATE(TO_CHAR(i.HELD_ON,'DD-MM-YYYY'),'DD-MM-YYYY') BETWEEN  '" + startDate + "' and '" + endDate + "' and i.pmanager=" + userId + "";
            rs = statement.executeQuery(sql);
            while (rs.next()) {
                project = rs.getString(1);
                now.setTime(rs.getDate(2));
                noofweek = now.get(Calendar.WEEK_OF_YEAR);
                now.set(Calendar.DAY_OF_WEEK, Calendar.MONDAY);
                now.add(Calendar.DATE, 6);//Add 6 days to get Sunday of next week
                now.set(Calendar.DAY_OF_WEEK, Calendar.SUNDAY);
                curryear = now.get(Calendar.YEAR);
                week = noofweek + "/" + curryear;
                rating = rs.getString(3);
                if (hm.containsKey(week + "-" + project)) {
                    hm.put(week + "-" + project, hm.get(week + "-" + project) + "," + rating + "&&&" + sdf.format(rs.getDate(2)));
                } else {
                    hm.put(week + "-" + project, rating + "&&&" + sdf.format(rs.getDate(2)) + "@@@@" + rs.getString(6));
                }
                projectSet.add(project + "***" + rs.getString(4) + " v" + rs.getString(5));
            }

            Iterator<Date> dateslist = new DateIterator(start, end);
            noofweek = 0;
            curryear = 0;
            while (dateslist.hasNext()) {
                Date oneOfDate = dateslist.next();
                now.setTime(oneOfDate);
                noofweek = now.get(Calendar.WEEK_OF_YEAR);
                now.set(Calendar.DAY_OF_WEEK, Calendar.MONDAY);
                now.add(Calendar.DATE, 6);//Add 6 days to get Sunday of next week
                now.set(Calendar.DAY_OF_WEEK, Calendar.SUNDAY);
                curryear = now.get(Calendar.YEAR);
                weekSet.add(noofweek + "/" + curryear + "&&&" + pf.dateRangeByWeekNumberAndYear(curryear, noofweek));
            }

            int modSize = weekSet.size() + 1;
            int projSize = projectSet.size() + 1;
            finalVal = new String[projSize][modSize];
            int col = 1, row = 1;
            String rat = "Not Done";
            try {
                for (Object prjName : projectSet) {
                    for (Object noOfweek : weekSet) {

                        projSplit = (String) prjName;
                        projSplit = projSplit.substring(0, projSplit.indexOf("***"));
                        try {
                            week = (String) noOfweek;
                            week = week.substring(0, week.indexOf("&&&"));
                            if (hm.containsKey(week + "-" + (String) projSplit)) {
                                rat = (String) hm.get(week + "-" + (String) projSplit);
                            } else {
                                rat = "Not Done";
                            }
                        } catch (Exception e) {
                            rat = "Not Done";
                        }
                        finalVal[0][col] = (String) noOfweek;
                        finalVal[row][0] = (String) projSplit;
                        finalVal[row][col] = rat;
                        col++;
                    }
                    col = 1;
                    row++;
                }

            } catch (Exception e) {
                e.printStackTrace();
                logger.error(e.getMessage());
            }
        } catch (Exception e) {
            logger.error("Error while getting the WRM Rating" + e.getMessage());
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (rs1 != null) {
                    rs1.close();
                }
                if (statement != null) {
                    statement.close();
                }
                if (connection != null) {
                    connection.close();
                }
            } catch (Exception ex) {
                logger.error("Error while getting the project id" + ex.getMessage());
            }
        }
        return finalVal;
    }

}
