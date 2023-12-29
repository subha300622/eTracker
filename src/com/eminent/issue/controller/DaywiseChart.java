/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eminent.issue.controller;

import com.eminent.issue.TeamClosedIssueReport;
import com.eminent.issue.formbean.IssueFormBean;
import static com.eminent.issue.controller.ModuleIssuesChart.getChartTypeList;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.GregorianCalendar;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import org.apache.log4j.Logger;
import pack.eminent.encryption.MakeConnection;

/**
 *
 * @author E0288
 */
public class DaywiseChart {

    static Logger logger = null;

    static {
        logger = Logger.getLogger("DaywiseChart");
    }
    private int month;
    private int year;
    private String chartType;
    private String chartDate;
    List<String> daysList = new ArrayList<String>();
    Map<String, String> weekDaysList = new HashMap<String, String>();
    Map<String, Integer> openCount = new HashMap<String, Integer>();
    Map<String, Integer> closedCount = new HashMap<String, Integer>();
    Map<String, Integer> workedCount = new HashMap<String, Integer>();
    Map<String, Integer> createdCount = new HashMap<String, Integer>();
    List<IssueFormBean> issuesList = new ArrayList<IssueFormBean>();

    public void setAll(HttpServletRequest request) throws ParseException {

        ModuleIssuesChart moduleIssuesChart = new ModuleIssuesChart();
        Calendar calDuration = new GregorianCalendar();
        //calDuration.add(Calendar.MONTH, -1);
        int currMonth = calDuration.get(Calendar.MONTH);
        int currYear = calDuration.get(Calendar.YEAR);
        String monthname = request.getParameter("month");
        String yearname = request.getParameter("year");
        chartDate = request.getParameter("chartDate");
        chartType = request.getParameter("chartType");
        logger.info(chartType);

        if (chartType == null) {
            chartType = ModuleIssuesChart.getChartTypeList().get(0);
        }
        if (monthname == null) {
            month = currMonth;
        } else {
            month = Integer.parseInt(monthname);
        }
        if (yearname == null) {
            year = currYear;
        } else {
            year = Integer.parseInt(yearname);
        }

        String duration = TeamClosedIssueReport.getMonths().get(month) + "-" + year;
        Calendar cale = Calendar.getInstance();
        cale.set(year, month, 1);
        int maxday = cale.getActualMaximum(Calendar.DATE);
        //String start = "1" + "-" + TeamClosedIssueReport.getMonths().get(month) + "-" + year;
        //String end = maxday + "-" + TeamClosedIssueReport.getMonths().get(month) + "-" + year;
        SimpleDateFormat formatter = new SimpleDateFormat("EEE");
        SimpleDateFormat sdf = new SimpleDateFormat("dd-MMM-yyyy");
        for (int i = 1; i <= maxday; i++) {
            if (i < 10) {
                daysList.add("0" + i + "-" + TeamClosedIssueReport.getMonths().get(month) + "-" + year);
                weekDaysList.put("0" + i + "-" + TeamClosedIssueReport.getMonths().get(month) + "-" + year,formatter.format(sdf.parse("0" + i + "-" + TeamClosedIssueReport.getMonths().get(month) + "-" + year)));
            } else {
                daysList.add(i + "-" + TeamClosedIssueReport.getMonths().get(month) + "-" + year);
                weekDaysList.put(i + "-" + TeamClosedIssueReport.getMonths().get(month) + "-" + year,formatter.format(sdf.parse(i + "-" + TeamClosedIssueReport.getMonths().get(month) + "-" + year)));
            }
        }
        if (chartDate == null) {
            for (String day : daysList) {
                logger.info(day);
                String openQuery = "Select count(distinct i.issueid) from issue i , issuestatus s,project p,modules m where p.pid=i.pid and m.moduleid=i.module_id and i.issueid=s.issueid and to_date(to_char(createdon,'DD-Mon-YYYY'),'DD-Mon-YYYY')< '" + day + "' and i.issueid not in (Select i.issueid from issue i , issuestatus s where i.issueid=s.issueid and status='Closed' and to_date(to_char(modifiedon,'DD-Mon-YYYY'),'DD-Mon-YYYY')<'" + day + "')";
                int count = getDayWiseOpenCount(openQuery);
                openCount.put(day, count);
            }
            String workedQuery = "Select distinct(to_char(COMMENT_DATE,'DD-Mon-YYYY'))  ,count(distinct(i.issueid)) from issue i , issuestatus s,project p,modules m,issuecomments ic where p.pid=i.pid and i.issueid=s.issueid and m.moduleid=i.module_id and i.issueid=ic.issueid and to_char(COMMENT_DATE,'Mon-YYYY')= '" + duration + "' group by to_char(COMMENT_DATE,'DD-Mon-YYYY')";
            workedCount = getDayWiseCounts(workedQuery);
            String createdQuery = "Select distinct(to_char(createdon,'DD-Mon-YYYY')) ,count(distinct(i.issueid)) from issue i , issuestatus s,project p,modules m where p.pid=i.pid and i.issueid=s.issueid and m.moduleid=i.module_id and to_char(createdon,'Mon-YYYY')= '" + duration + "' group by to_char(createdon,'DD-Mon-YYYY')";
            createdCount = getDayWiseCounts(createdQuery);
            String closedQuery = "Select distinct(to_char(Modifiedon,'DD-Mon-YYYY'))  ,count(distinct(i.issueid)) from issue i , issuestatus s,project p,modules m where p.pid=i.pid and i.issueid=s.issueid and m.moduleid=i.module_id and s.status='Closed' and to_char(Modifiedon,'Mon-YYYY')= '" + duration + "' group by to_char(Modifiedon,'DD-Mon-YYYY')";
            closedCount = getDayWiseCounts(closedQuery);
        } else {
            String chartDay=chartDate+"-"+duration;
            if (chartType.equalsIgnoreCase(getChartTypeList().get(1))) {
                logger.info("Created");
                String query = "Select distinct(i.issueid), CONCAT(pname ,CONCAT(' v',version)) as project, type, s.status, i.subject, description, i.priority, i.severity, i.createdby, i.createdon, i.assignedto, i.modifiedon, i.due_date,i.rating,i.feedback,m.module,ceil(to_number(to_date(modifiedOn)-to_date(createdon)))as closedage, ceil(to_number(sysdate-to_date(createdon)))as age from issue i , issuestatus s,project p,modules m,issuecomments ic where p.pid=i.pid and i.issueid=s.issueid and m.moduleid=i.module_id and i.issueid=ic.issueid and to_char(Createdon,'DD-Mon-YYYY')= '" + chartDay + "'";
                issuesList = moduleIssuesChart.getModuleIssues(query);
            } else if (chartType.equalsIgnoreCase(getChartTypeList().get(2))) {
                String query = "select distinct(i.issueid), CONCAT(pname ,CONCAT(' v',version)) as project, type, s.status, i.subject, description, i.priority, i.severity, i.createdby, i.createdon, i.assignedto, i.modifiedon, i.due_date,i.rating,i.feedback,m.module,ceil(to_number(to_date(modifiedOn)-to_date(createdon)))as closedage from issue i,issuestatus s,project p,modules m where p.pid=i.pid and i.issueid=s.issueid and m.moduleid=i.module_id and i.issueid=s.issueid  and s.status='Closed' and to_char(i.modifiedon,'DD-Mon-YYYY')= '" + chartDay + "'";
                issuesList = moduleIssuesChart.getModuleIssues(query);
            } else if (chartType.equalsIgnoreCase(getChartTypeList().get(3))) {
                String query = "Select distinct(i.issueid), CONCAT(pname ,CONCAT(' v',version)) as project, type, s.status, i.subject, description, i.priority, i.severity, i.createdby, i.createdon, i.assignedto, i.modifiedon, i.due_date,i.rating,i.feedback,m.module,ceil(to_number(to_date(modifiedOn)-to_date(createdon)))as closedage,ceil(to_number(sysdate-to_date(createdon)))as age from issue i , issuestatus s,project p,modules m where p.pid=i.pid and m.moduleid=i.module_id and i.issueid=s.issueid and to_date(to_char(createdon,'DD-Mon-YYYY'),'DD-Mon-YYYY')< '" + chartDay + "' and i.issueid not in (Select i.issueid from issue i , issuestatus s where i.issueid=s.issueid and status='Closed' and to_date(to_char(modifiedon,'DD-Mon-YYYY'),'DD-Mon-YYYY')<'" + chartDay + "')";
                issuesList = moduleIssuesChart.getModuleIssues(query);
            } else {
                String query = "Select distinct(i.issueid), CONCAT(pname ,CONCAT(' v',version)) as project, type, s.status, i.subject, description, i.priority, i.severity, i.createdby, i.createdon, i.assignedto, i.modifiedon, i.due_date,i.rating,i.feedback,m.module,ceil(to_number(to_date(modifiedOn)-to_date(createdon)))as closedage,ceil(to_number(sysdate-to_date(createdon)))as age  from issue i , issuestatus s,project p,modules m,issuecomments ic where p.pid=i.pid and i.issueid=s.issueid and m.moduleid=i.module_id and i.issueid=ic.issueid  and to_char(comment_date,'DD-Mon-YYYY')= '" + chartDay + "'";
                issuesList = moduleIssuesChart.getModuleIssues(query);
            }
        }

    }

    public Map<String, Integer> getDayWiseCounts(String query) {
        Map<String, Integer> createdDayCount = new LinkedHashMap<String, Integer>();
        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        try {

            connection = MakeConnection.getConnection();
            statement = connection.createStatement();
            resultset = statement.executeQuery(query);
            while (resultset.next()) {
                createdDayCount.put(resultset.getString(1), resultset.getInt(2));
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
        return createdDayCount;
    }

    public int getDayWiseOpenCount(String query) {
        int count = 0;
        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        try {

            connection = MakeConnection.getConnection();
            statement = connection.createStatement();
            logger.info(query);
            resultset = statement.executeQuery(query);
            while (resultset.next()) {
                count = resultset.getInt(1);
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
        return count;
    }

    public int getMonth() {
        return month;
    }

    public void setMonth(int month) {
        this.month = month;
    }

    public int getYear() {
        return year;
    }

    public void setYear(int year) {
        this.year = year;
    }

    public String getChartType() {
        return chartType;
    }

    public void setChartType(String chartType) {
        this.chartType = chartType;
    }

    public String getChartDate() {
        return chartDate;
    }

    public void setChartDate(String chartDate) {
        this.chartDate = chartDate;
    }

    public List<String> getDaysList() {
        return daysList;
    }

    public void setDaysList(List<String> daysList) {
        this.daysList = daysList;
    }

    public Map<String, String> getWeekDaysList() {
        return weekDaysList;
    }

    public void setWeekDaysList(Map<String, String> weekDaysList) {
        this.weekDaysList = weekDaysList;
    }

    public Map<String, Integer> getOpenCount() {
        return openCount;
    }

    public void setOpenCount(Map<String, Integer> openCount) {
        this.openCount = openCount;
    }

    public Map<String, Integer> getClosedCount() {
        return closedCount;
    }

    public void setClosedCount(Map<String, Integer> closedCount) {
        this.closedCount = closedCount;
    }

    public Map<String, Integer> getWorkedCount() {
        return workedCount;
    }

    public void setWorkedCount(Map<String, Integer> workedCount) {
        this.workedCount = workedCount;
    }

    public Map<String, Integer> getCreatedCount() {
        return createdCount;
    }

    public void setCreatedCount(Map<String, Integer> createdCount) {
        this.createdCount = createdCount;
    }

    public List<IssueFormBean> getIssuesList() {
        return issuesList;
    }

    public void setIssuesList(List<IssueFormBean> issuesList) {
        this.issuesList = issuesList;
    }
}
