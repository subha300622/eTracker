package com.eminent.util;

import static com.eminent.util.GetAge.logger;
import java.sql.Connection;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import org.apache.log4j.Level;
import org.apache.log4j.Logger;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import pack.eminent.encryption.MakeConnection;

public class GetAge {

    static Logger logger = Logger.getLogger("GetAge");
    Connection connection = null;
    Statement statement = null;
    ResultSet resultset = null;

    public static int getIssueAge(String createdon, String status, String modifiedon) throws Exception {
       Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        int createdDate = 0;

        logger.setLevel(Level.ERROR);
        try {
            connection = MakeConnection.getConnection();
            statement = connection.createStatement();
            if (!status.equalsIgnoreCase("Closed")) {

                Calendar cal = Calendar.getInstance();
                DateFormat sdfa = new SimpleDateFormat("dd-MMM-yy");
                DateFormat sdf = new SimpleDateFormat("dd-MMM-yy HH:mm:ss");
                String sysdate = sdf.format(cal.getTime());
                Date systemdate = sdf.parse(sysdate);
                Date createdondate = sdf.parse((sdf.format(sdfa.parse(createdon))));
                long diff = systemdate.getTime() - createdondate.getTime();

                createdDate = (int) (diff / (24 * 60 * 60 * 1000));

            } else {
                DateFormat sdfa = new SimpleDateFormat("dd-MMM-yy");
                DateFormat sdf = new SimpleDateFormat("dd-MMM-yy HH:mm:ss");
                Date createdondate = sdf.parse((sdf.format(sdfa.parse(createdon))));
                Date modifiedondate = sdf.parse((sdf.format(sdfa.parse(modifiedon))));
                long diff = modifiedondate.getTime() - createdondate.getTime();
                
                createdDate = (int) (diff / (24 * 60 * 60 * 1000));
            }

        } catch (Exception e) {
            e.printStackTrace();
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

    public static int getHoldingTime(Connection connection, String issueId, String userId) throws Exception {

        Statement stForComments = null, st = null, stForInterval = null, stForCreatedon = null, stForAssignedTo = null, stForCurrent = null, stForSysdate = null;
        Statement stForFlag = null;
        ResultSet rs = null, rsForComments = null, rsForInterval = null, rsForCreatedon = null, rsForAssignedTo = null, rsForCurrent = null, rsForSysdate = null;
        ResultSet rsForFlag = null;
        int holdingTime = 0;
        int rowCount = 0;
        String createdOn = null;
        String interval = null;
        int currentUser = Integer.parseInt(userId);
        String currentMonth = null, currentYear = null, retDate = null;
        String toDate = null;
        logger.setLevel(Level.ERROR);

        int exclude = 0;

        // Retrieving all the comments and total number of counts for this issue id
        String queryForComments = "select commentedby, commentedto, to_char(comment_date, 'dd-mm-yy hh24:mi:ss') as commentdate, comment_date from issuecomments where issueid = '" + issueId + "' order by comment_date asc";
        String query = "select count(*) as rowcount from issuecomments where issueid = '" + issueId + "'";
        String queryForInterval = null;
        try {

            //Retrieving the current month and year
            String queryForCurrent = "select extract (month from sysdate) as month, extract (year from sysdate) as year  from dual";
            stForCurrent = connection.createStatement();
            stForFlag = connection.createStatement();
            rsForCurrent = stForCurrent.executeQuery(queryForCurrent);
            if (rsForCurrent.next()) {
                currentMonth = rsForCurrent.getString("month");
                currentYear = rsForCurrent.getString("year");
                currentYear = currentYear.substring(2, 4);
            }

            //Setting the current date to the first day of the current month
            String currentDate = "01-" + currentMonth + "-" + currentYear + " 00:00:00";
            logger.info("Current Date" + currentDate);

            if (rsForCurrent != null) {
                rsForCurrent.close();
            }
            if (stForCurrent != null) {
                stForCurrent.close();
            }

            //Getting today date and current time
            stForSysdate = connection.createStatement();
            rsForSysdate = stForSysdate.executeQuery("select to_char(sysdate,'dd-mm-yy hh24:mi:ss') as today from dual");
            if (rsForSysdate.next()) {
                toDate = rsForSysdate.getString("today");

            }

            if (rsForSysdate != null) {
                rsForSysdate.close();
            }
            if (stForSysdate != null) {
                stForSysdate.close();
            }

            // Counting the total number of rows in comment history
            st = connection.createStatement();
            rs = st.executeQuery(query);
            if (rs.next()) {
                rowCount = rs.getInt("rowcount");

            } else {
                rowCount = 0;
            }
            logger.info("No of comments for issue" + issueId + ":::->" + rowCount);

            /* If there is only one row then we can calculate the interval directly checking only one condition
             Who is holding the issue currently?. If the same person holds the we can use sysdate and created date to calculate the interval
             If he doesn't hold, we should use created date and comment date to calculate the interval */
            if (rowCount == 1) {
                String queryForcreatedon = "select to_char(createdon, 'dd-mm-yy hh24:mi:ss') as createdon from issue where issueid = '" + issueId + "'";
                stForCreatedon = connection.createStatement();
                rsForCreatedon = stForCreatedon.executeQuery(queryForcreatedon);
                if (rsForCreatedon.next()) {
                    createdOn = rsForCreatedon.getString("createdon");
                }

                //If created on is not in the current month, we should reset the created on to first day of the current month
                String queryForFlag = "select (to_date('" + createdOn + "','dd-mm-yy hh24:mi:ss') - to_date('" + currentDate + "','dd-mm-yy hh24:mi:ss'))*24 as flag from dual";
                logger.info("Query for Flag" + queryForFlag);
                rsForFlag = stForFlag.executeQuery(queryForFlag);
                if (rsForFlag.next()) {
                    retDate = rsForFlag.getString("flag");
                    retDate = retDate.substring(0, 1);
                }
                if (retDate.equalsIgnoreCase("-")) {
                    createdOn = currentDate;
                }

                if (rsForFlag != null) {
                    rsForFlag.close();
                }
                if (stForFlag != null) {
                    stForFlag.close();
                }

                // Finding the current assigned person    
                stForAssignedTo = connection.createStatement();
                rsForAssignedTo = stForAssignedTo.executeQuery("select assignedto from issue where issueid = '" + issueId + "'");
                int assignedTo = 0;
                if (rsForAssignedTo.next()) {
                    assignedTo = rsForAssignedTo.getInt("assignedto");
                }
                if (currentUser == assignedTo) {

                    queryForInterval = "select (sysdate - to_date('" + createdOn + "','dd-mm-yy hh24:mi:ss'))*24 as interval from dual";
                    exclude = getExcludeTime(createdOn, toDate);
                } else {
                    stForComments = connection.createStatement();
                    rsForComments = stForComments.executeQuery(queryForComments);
                    String commentDate = null;
                    if (rsForComments.next()) {
                        commentDate = rsForComments.getString("commentdate");
                    }

                    queryForInterval = "select ( to_date('" + commentDate + "','dd-mm-yy hh24:mi:ss')- to_date('" + createdOn + "','dd-mm-yy hh24:mi:ss'))*24 as interval from dual";
                    exclude = getExcludeTime(createdOn, commentDate);
                }

                stForInterval = connection.createStatement();
                rsForInterval = stForInterval.executeQuery(queryForInterval);
                if (rsForInterval.next()) {
                    Long duration = rsForInterval.getLong("interval");
                    interval = duration.toString();

                }
                //System.out.println("interval  : "+interval);
                logger.info("interval  : " + interval);
                if (Integer.parseInt(interval) != 0) {
                    holdingTime = Integer.parseInt(interval) - exclude;
                } else {
                    holdingTime = Integer.parseInt(interval);
                }

            } else if (rowCount > 1) {
                // Finding the transition rows
                String commentedTo = null;
                int start = 0;
                boolean begin = false;
                boolean end = false;
                int assignedTo = 0;
                ArrayList<Integer> al = new ArrayList<Integer>();
                stForComments = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
                rsForComments = stForComments.executeQuery(queryForComments);
                for (int i = 1; i <= rowCount; i++) {
                    rsForComments.absolute(i);
                    commentedTo = rsForComments.getString("commentedto");
                    if (commentedTo.equalsIgnoreCase("Nil")) {
                        rsForComments.absolute(i + 1);
                        commentedTo = rsForComments.getString("commentedby");
                        assignedTo = Integer.parseInt(commentedTo);
                    } else {
                        assignedTo = Integer.parseInt(commentedTo);
                    }

                    if (currentUser == assignedTo) {
                        start++;
                        if (start == 1 || end == true) {
                            al.add(i);
                            begin = true;
                        }
                    } else if (begin == true) {
                        al.add(i);
                        end = true;
                        begin = false;
                        start = 0;
                    }

                }

                // Calculating the interval
                String startDate = null, endDate = null;
                int addInterval = 0;
                boolean still = false;

                int limit = al.size();

                if (al.size() % 2 != 0) {
                    limit = limit - 1;
                    still = true;
                }
                for (int j = 0; j < limit; j += 2) {
                    rsForComments.absolute(al.get(j));
                    startDate = rsForComments.getString("commentdate");

                    //If comment date is not in the current month, we should reset the comment date to first day of the current month for both start date and end date 
                    String queryForFlag = "select (to_date('" + startDate + "','dd-mm-yy hh24:mi:ss') - to_date('" + currentDate + "','dd-mm-yy hh24:mi:ss'))*24 as flag from dual";
                    logger.info("Query for Flag" + queryForFlag);
                    rsForFlag = stForFlag.executeQuery(queryForFlag);
                    if (rsForFlag.next()) {
                        retDate = rsForFlag.getString("flag");
                        retDate = retDate.substring(0, 1);
                    }
                    if (retDate.equalsIgnoreCase("-")) {
                        startDate = currentDate;
                    }
                    if (rsForFlag != null) {
                        rsForFlag.close();
                    }
                    rsForComments.absolute(al.get((j + 1)));
                    endDate = rsForComments.getString("commentdate");
                    queryForFlag = "select (to_date('" + endDate + "','dd-mm-yy hh24:mi:ss') - to_date('" + currentDate + "','dd-mm-yy hh24:mi:ss'))*24 as flag from dual";
                    rsForFlag = stForFlag.executeQuery(queryForFlag);
                    if (rsForFlag.next()) {
                        retDate = rsForFlag.getString("flag");
                        retDate = retDate.substring(0, 1);
                    }
                    if (retDate.equalsIgnoreCase("-")) {
                        endDate = currentDate;
                    }
                    if (rsForFlag != null) {
                        rsForFlag.close();
                    }
                    queryForInterval = "select ( to_date('" + endDate + "','dd-mm-yy hh24:mi:ss')- to_date('" + startDate + "','dd-mm-yy hh24:mi:ss'))*24 as interval from dual";
                    stForInterval = connection.createStatement();
                    rsForInterval = stForInterval.executeQuery(queryForInterval);
                    if (rsForInterval.next()) {
                        Long duration = rsForInterval.getLong("interval");
                        interval = duration.toString();
                        if (Integer.parseInt(interval) != 0) {
                            exclude = getExcludeTime(startDate, endDate);
                            addInterval = addInterval + Integer.parseInt(interval) - exclude;
                        } else {
                            addInterval = addInterval + Integer.parseInt(interval);
                        }
                        if (rsForInterval != null) {
                            rsForInterval.close();
                        }
                        if (stForInterval != null) {
                            stForInterval.close();
                        }
                    }

                }

                if (still == true) {

                    Statement stStatus = connection.createStatement();
                    ResultSet rsStatus = stStatus.executeQuery("select status from issuestatus where issueid = '" + issueId + "'");
                    String status = null;
                    if (rsStatus.next()) {
                        status = rsStatus.getString("status");
                    }

                    if (rsStatus != null) {
                        rsStatus.close();
                    }

                    if (stStatus != null) {
                        stStatus.close();
                    }

                    //Checking whether all the comments are for only the current user
                    boolean all = false;
                    Statement stAll = connection.createStatement();
                    ResultSet rsAll = stAll.executeQuery("select count(*) AS count from issuecomments where issueid = '" + issueId + "' and commentedto != '" + userId + "'");
                    if (rsAll.next()) {
                        int get = rsAll.getInt("count");
                        if (get == 0) {
                            all = true;
                        }
                    }

                    // Deciding the start date, if all the comments are only for the current user, assign start date as created on date. Or else start date should be from oone of comment date
                    if (all == true) {
                        String queryForcreatedon = "select to_char(createdon, 'dd-mm-yy hh24:mi:ss') as createdon from issue where issueid = '" + issueId + "'";
                        stForCreatedon = connection.createStatement();
                        rsForCreatedon = stForCreatedon.executeQuery(queryForcreatedon);
                        if (rsForCreatedon.next()) {
                            startDate = rsForCreatedon.getString("createdon");
                        }

                        //If created on is not in the current month, we should reset the created on to first day of the current month
                        String queryForFlag = "select (to_date('" + startDate + "','dd-mm-yy hh24:mi:ss') - to_date('" + currentDate + "','dd-mm-yy hh24:mi:ss'))*24 as flag from dual";
                        rsForFlag = stForFlag.executeQuery(queryForFlag);
                        if (rsForFlag.next()) {
                            retDate = rsForFlag.getString("flag");
                            retDate = retDate.substring(0, 1);
                        }
                        if (retDate.equalsIgnoreCase("-")) {
                            startDate = currentDate;
                        }

                        if (rsForFlag != null) {
                            rsForFlag.close();
                        }
                        if (stForFlag != null) {
                            stForFlag.close();
                        }
                    } else {

                        int lastIndex = al.size() - 1;
                        rsForComments.absolute(al.get(lastIndex));
                        startDate = rsForComments.getString("commentdate");

                        //If comment date is in the current month, we should reset the comment date on to first day of the current month for both start date and end date 
                        String queryForFlag = "select (to_date('" + startDate + "','dd-mm-yy hh24:mi:ss') - to_date('" + currentDate + "','dd-mm-yy hh24:mi:ss'))*24 as flag from dual";
                        rsForFlag = stForFlag.executeQuery(queryForFlag);
                        if (rsForFlag.next()) {
                            retDate = rsForFlag.getString("flag");
                            retDate = retDate.substring(0, 1);
                        }
                        if (retDate.equalsIgnoreCase("-")) {
                            startDate = currentDate;
                        }

                        //Closing resultset and statement
                        if (rsForFlag != null) {
                            rsForFlag.close();
                        }
                        if (stForFlag != null) {
                            stForFlag.close();
                        }

                    }

                    //Checking whether this issue has already been closed or not
                    exclude = 0;
                    if (!status.equalsIgnoreCase("Closed")) {
                        queryForInterval = "select (sysdate - to_date('" + startDate + "','dd-mm-yy hh24:mi:ss'))*24 as interval from dual";
                        exclude = getExcludeTime(startDate, toDate);
                    } else {
                        rsForComments.last();
                        String closeCommentDate = rsForComments.getString("commentdate");
                        queryForInterval = "select (to_date('" + closeCommentDate + "','dd-mm-yy hh24:mi:ss') - to_date('" + startDate + "','dd-mm-yy hh24:mi:ss'))*24 as interval from dual";
                        exclude = getExcludeTime(startDate, closeCommentDate);
                    }
                    stForInterval = connection.createStatement();
                    rsForInterval = stForInterval.executeQuery(queryForInterval);
                    if (rsForInterval.next()) {
                        Long duration = rsForInterval.getLong("interval");
                        interval = duration.toString();
                        logger.info("interval  : " + interval);
                        if (Integer.parseInt(interval) != 0) {
                            addInterval = addInterval + Integer.parseInt(interval) - exclude;
                        } else {
                            addInterval = addInterval + Integer.parseInt(interval);
                        }
                    }
                }

                holdingTime = addInterval;

            } else {
                interval = "0";
            }

        } catch (Exception e) {
            logger.error("Error while calculating the time" + e.getMessage());
        } finally {
            if (rs != null) {
                rs.close();
            }

            if (rsForAssignedTo != null) {
                rsForAssignedTo.close();
            }
            if (rsForComments != null) {
                rsForComments.close();
            }
            if (rsForCreatedon != null) {
                rsForCreatedon.close();
            }
            if (rsForInterval != null) {
                rsForInterval.close();
            }
            if (st != null) {
                st.close();
            }
            if (stForAssignedTo != null) {
                stForAssignedTo.close();
            }
            if (stForComments != null) {
                stForComments.close();
            }
            if (stForCreatedon != null) {
                stForCreatedon.close();
            }
            if (stForInterval != null) {
                stForInterval.close();
            }
        }
        if (holdingTime == -1 || holdingTime == -2) {
            holdingTime = 0;
        }
        return holdingTime;
    }

    public static int getExcludeTime(String start, String end) {

        Calendar c = Calendar.getInstance();
        Calendar d = Calendar.getInstance();

        int startYear = Integer.parseInt(start.substring((start.lastIndexOf("-") + 1), start.indexOf(" "))) + 2000;
        int startMonth = Integer.parseInt(start.substring((start.indexOf("-") + 1), start.lastIndexOf("-"))) - 1;
        int startDay = Integer.parseInt(start.substring(0, start.indexOf("-")));
        int startHour = Integer.parseInt(start.substring((start.indexOf(":") - 2), start.indexOf(":")));
        int startMin = Integer.parseInt(start.substring((start.lastIndexOf(":") - 2), start.lastIndexOf(":")));
        int startSec = Integer.parseInt(start.substring((start.lastIndexOf(":") + 1), (start.lastIndexOf(":") + 3)));
        int startHourSec = (startHour * 3600) + (startMin * 60) + (startSec);

        c.set(startYear, startMonth, startDay);

        int endYear = Integer.parseInt(end.substring((end.lastIndexOf("-") + 1), end.indexOf(" "))) + 2000;
        int endMonth = Integer.parseInt(end.substring((end.indexOf("-") + 1), end.lastIndexOf("-"))) - 1;
        int endDay = Integer.parseInt(end.substring(0, end.indexOf("-")));
        int endHour = Integer.parseInt(end.substring((end.indexOf(":") - 2), end.indexOf(":")));
        int endMin = Integer.parseInt(end.substring((end.lastIndexOf(":") - 2), end.lastIndexOf(":")));
        int endSec = Integer.parseInt(end.substring((end.lastIndexOf(":") + 1), (end.lastIndexOf(":") + 3)));
        int endHourSec = (endHour * 3600) + (endMin * 60) + (endSec);

        d.set(endYear, endMonth, endDay);

        int startOffset = 0;
        int endOffset = 0;

        if (c.get(Calendar.DAY_OF_WEEK) != 1 && c.get(Calendar.DAY_OF_WEEK) != 7) {
            if (startHourSec < 64800 & startHourSec >= 50400) {
                startOffset = 10;
            } else if (startHourSec >= 32400 & startHourSec <= 46800) {
                startOffset = 9;
            } else if (startHourSec >= 64800) {
                startOffset = 10 + (startHour - 18);
            } else if (startHourSec < 32400) {
                startOffset = startHour;
            } else if (startHourSec > 46800 & startHourSec < 50400) {
                startOffset = 9;
            }
        } else {
            startOffset = startHour;
        }

        if (d.get(Calendar.DAY_OF_WEEK) != 1 && d.get(Calendar.DAY_OF_WEEK) != 7) {
            if (endHourSec < 64800 & endHourSec >= 50400) {
                endOffset = 6;
            } else if (endHourSec >= 32400 & endHourSec <= 46800) {
                endOffset = 7;
            } else if (endHourSec >= 64800) {
                endOffset = 24 - endHour;
            } else if (endHourSec < 32400) {
                endOffset = 16 - endHour;
            } else if (endHourSec > 46800 & endHourSec < 50400) {
                endOffset = 6;
            }
        } else {
            endOffset = 24 - endHour;
        }

        int holidays = 0;
        int totalDays = 1;
        if (!c.equals(d)) {

            if (c.get(Calendar.DAY_OF_WEEK) == 1 || c.get(Calendar.DAY_OF_WEEK) == 7) {
                holidays++;
            }
            do {
                c.add(Calendar.DAY_OF_MONTH, 1);
                if (c.get(Calendar.DAY_OF_WEEK) == 1 || c.get(Calendar.DAY_OF_WEEK) == 7) {
                    holidays++;
                }
                totalDays++;
            } while (!c.equals(d));
        } else if (c.get(Calendar.DAY_OF_WEEK) == 1 || c.get(Calendar.DAY_OF_WEEK) == 7) {
            holidays = 1;
        }

        int exclude = (holidays * 24) + ((totalDays - holidays) * 16) - startOffset - endOffset;

        return exclude;

    }

    public static int getContactAge(Connection connection, String createdon) throws Exception {

        Statement statement = null;
        ResultSet resultset = null;
        int createdDate = 0;

        logger.setLevel(Level.ERROR);
        logger.info("Created On" + createdon);

        try {

            statement = connection.createStatement();

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

        }
        return createdDate + 1;
    }

    public static int getResourceRequestAge(Connection connection, String createdon) throws Exception {

        Statement statement = null;
        ResultSet resultset = null;
        int createdDate = 0;

        logger.setLevel(Level.ERROR);
        logger.info("Created On" + createdon);

        try {

            statement = connection.createStatement();

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

        }
        return createdDate + 1;
    }

    public static int lastAsigneeAge(String issueid) throws SQLException {
        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        int diff = 0;

        try {
            connection = MakeConnection.getConnection();
            statement = connection.createStatement();

            resultset = statement.executeQuery("select to_Number(sysdate-(select Max(Comment_date) from issuecomments ic where ic.issueid='" + issueid + "' and ic.COMMENTedBy!=ic.commentedTo)) from dual");

            while (resultset.next()) {
                diff = resultset.getInt(1);
                if (diff == 0) {
                    diff = -1;
                }
                logger.info(issueid + "diff" + diff);

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
        return diff + 1;
    }

    public static Map issuelastAsigneeAge(String issuenos) throws SQLException {
        Map<String, Integer> issueAgeList = new HashMap<String, Integer>();
        String query = "";

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
                query = "select issueid ,to_Number(sysdate-Max(Comment_date)) from issuecomments ic where ic.issueid in (" + totalIssue + ") and ic.COMMENTedBy!=ic.commentedTo group by issueid";
                issueAgeList = issueNewlastAsigneeAge(query);
            }
        } else {
            query = "select issueid ,to_Number(sysdate-Max(Comment_date)) from issuecomments ic where ic.issueid in (" + issuenos + ") and ic.COMMENTedBy!=ic.commentedTo group by issueid";
            issueAgeList = issueNewlastAsigneeAge(query);
        }

        return issueAgeList;
    }

    public static Map issueNewlastAsigneeAge(String query) throws SQLException {
        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        Map<String, Integer> issueAgeList = new HashMap<String, Integer>();
        try {
            connection = MakeConnection.getConnection();
            statement = connection.createStatement();
            resultset = statement.executeQuery(query);

            while (resultset.next()) {
                String issueid = resultset.getString(1);
                int diff = resultset.getInt(2);
                if (diff == 0) {
                    diff = -1;
                }
                diff = diff + 1;

                issueAgeList.put(issueid, diff);
            }

        } catch (Exception e) {
            e.printStackTrace();
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
        return issueAgeList;
    }
}
