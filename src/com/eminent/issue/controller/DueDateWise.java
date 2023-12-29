/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eminent.issue.controller;

import com.eminent.issue.TeamClosedIssueReport;
import static com.eminent.issue.controller.ModuleIssuesChart.getChartTypeList;
import static com.eminent.issue.formbean.PlannedIssueReport.severityColor;

import com.eminent.issue.formbean.IssueFormBean;
import com.eminent.util.GetAge;
import com.eminent.util.GetProjectMembers;
import com.eminent.util.IssueDetails;
import dashboard.CheckDate;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.GregorianCalendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import org.apache.log4j.Logger;
import pack.eminent.encryption.MakeConnection;

/**
 *
 * @author E0288
 */
public class DueDateWise {

    static Logger logger = null;

    static {
        logger = Logger.getLogger("DueDateWise");
    }
    private String noOfChanges;
    private int month;
    private int year;
    private String chartType;
    Map<Integer, Integer> workedDueDateWiseList = new HashMap<Integer, Integer>();
    Map<Integer, Integer> createdDueDateWiseList = new HashMap<Integer, Integer>();
    Map<Integer, Integer> closedDueDateWiseList = new HashMap<Integer, Integer>();
    Map<Integer, Integer> openDueDateWiseList = new HashMap<Integer, Integer>();
    List<IssueFormBean> issuesList = new ArrayList<IssueFormBean>();
    List<Integer> diffDueDateChanges = new ArrayList<Integer>();

    public void setAll(HttpServletRequest request) {
        Calendar calDuration = new GregorianCalendar();
        //calDuration.add(Calendar.MONTH, -1);
        int currMonth = calDuration.get(Calendar.MONTH);
        int currYear = calDuration.get(Calendar.YEAR);
        String monthname = request.getParameter("month");
        String yearname = request.getParameter("year");
        noOfChanges = request.getParameter("noofChanges");
        logger.info(noOfChanges);
        chartType = request.getParameter("chartType");
        if (chartType == null) {
            chartType = getChartTypeList().get(0);
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
        String start = "1" + "-" + TeamClosedIssueReport.getMonths().get(month) + "-" + year;
        String end = maxday + "-" + TeamClosedIssueReport.getMonths().get(month) + "-" + year;
        String query = "select count(distinct(duedate))-1 as count from issue i,issuecomments ic,issuestatus s where i.issueid=ic.issueid and i.issueid=s.issueid and s.status='Closed' and to_char(i.modifiedon,'Mon-YYYY')='" + duration + "' and duedate is not null group by ic.issueid order by count";
        diffDueDateChanges = new ArrayList(closedIssueDueDateChangeCount(query).keySet());
        if (noOfChanges == null) {
            String createdQuery = "select count(distinct(duedate))-1 as count from issue i,issuecomments ic,issuestatus s where i.issueid=ic.issueid and i.issueid=s.issueid  and to_char(i.Createdon,'Mon-YYYY')='" + duration + "' and duedate is not null group by ic.issueid order by count";
            String workedQuery = "select dc.count as count from issue i,issuecomments ic,issuestatus s,DUEDATECHANGECOUNT dc where i.issueid=ic.issueid and i.issueid=s.issueid and i.issueid=dc.issueid and to_char(ic.COMMENT_DATE,'Mon-YYYY')='" + duration + "' and duedate is not null group by dc.count, ic.issueid order by count";
            String openQuery = "select count(distinct(duedate))-1 as count from issue i,issuecomments ic,issuestatus s where i.issueid=ic.issueid and i.issueid=s.issueid and to_date(to_char(i.createdon,'DD-Mon-YYYY'),'DD-Mon-YY')< '" + end + "' and i.issueid not in (Select i.issueid from issue i , issuestatus s where i.issueid=s.issueid and status='Closed' and to_date(to_char(modifiedon,'DD-Mon-YYYY'),'DD-Mon-YYYY')<'" + start + "') and duedate is not null group by ic.issueid order by count";
            createdDueDateWiseList = closedIssueDueDateChangeCount(createdQuery);
            closedDueDateWiseList = closedIssueDueDateChangeCount(query);
            openDueDateWiseList = closedIssueDueDateChangeCount(openQuery);
            workedDueDateWiseList = closedIssueDueDateChangeCount(workedQuery);

        } else {
            logger.info(chartType);
            if (chartType.equalsIgnoreCase(getChartTypeList().get(1))) {
                String wquery = "select distinct(i.issueid), CONCAT(pname ,CONCAT(' v',version)) as project, type, s.status, i.subject, description, i.priority, i.severity, i.createdby, i.createdon, i.assignedto, i.modifiedon, i.due_date,i.rating,i.feedback,m.module,ceil(to_number(to_date(modifiedOn)-to_date(createdon)))as closedage,ceil(to_number(sysdate-to_date(createdon)))as age from issue i,DUEDATECHANGECOUNT dc,project p,modules m,issuestatus s where i.pid=p.pid and i.module_id=m.moduleid and i.issueid=dc.issueid and s.issueid=i.issueid and i.issueid=dc.issueid and to_char(i.createdon,'Mon-YYYY')= '" + duration + "' and dc.count=" + noOfChanges + " order by  modifiedon desc,due_date asc, type asc, priority asc, severity asc, createdon asc";
                issuesList = getClosedIssuesDuedateChange(wquery);
            } else if (chartType.equalsIgnoreCase(getChartTypeList().get(2))) {
                String wquery = "select distinct(i.issueid), CONCAT(pname ,CONCAT(' v',version)) as project, type, s.status, i.subject, description, i.priority, i.severity, i.createdby, i.createdon, i.assignedto, i.modifiedon, i.due_date,i.rating,i.feedback,m.module,ceil(to_number(to_date(modifiedOn)-to_date(createdon)))as closedage,ceil(to_number(sysdate-to_date(createdon)))as age from issue i,DUEDATECHANGECOUNT dc,issuestatus s,project p,modules m where p.pid=i.pid and i.issueid=s.issueid and m.moduleid=i.module_id  and i.issueid=s.issueid  and i.issueid=dc.issueid and s.status='Closed' and dc.count=" + noOfChanges + " and to_char(i.modifiedon,'Mon-YYYY')= '" + duration + "' order by  modifiedon desc,due_date asc, type asc, priority asc, severity asc, createdon asc";
                issuesList = getClosedIssuesDuedateChange(wquery);
            } else if (chartType.equalsIgnoreCase(getChartTypeList().get(3))) {
                String wquery = "Select distinct(i.issueid), CONCAT(pname ,CONCAT(' v',version)) as project, type, s.status, i.subject, description, i.priority, i.severity, i.createdby, i.createdon, i.assignedto, i.modifiedon, i.due_date,i.rating,i.feedback,ceil(to_number(to_date(modifiedOn)-to_date(createdon)))as closedage, m.module,ceil(to_number(sysdate-to_date(createdon)))as age from issue i ,DUEDATECHANGECOUNT dc, issuestatus s,project p,modules m,issuecomments ic where p.pid=i.pid and m.moduleid=i.module_id  and i.issueid=s.issueid and ic.issueid=i.issueid and i.issueid=dc.issueid and dc.count=" + noOfChanges + "  and to_date(to_char(createdon,'DD-Mon-YYYY'),'DD-Mon-YYYY')< '" + end + "' and i.issueid not in (Select i.issueid from issue i , issuestatus s where i.issueid=s.issueid and status='Closed' and to_date(to_char(modifiedon,'DD-Mon-YYYY'),'DD-Mon-YYYY')<'" + start + "') order by  modifiedon desc,due_date asc, type asc, priority asc, severity asc, createdon asc";
                issuesList = getClosedIssuesDuedateChange(wquery);
            } else {
                String wquery = "Select distinct(i.issueid), CONCAT(pname ,CONCAT(' v',version)) as project, type, s.status, i.subject, description, i.priority, i.severity, i.createdby, i.createdon, i.assignedto, i.modifiedon, i.due_date,i.rating,i.feedback,m.module,ceil(to_number(to_date(modifiedOn)-to_date(createdon)))as closedage, ceil(to_number(sysdate-to_date(createdon)))as age  from issue i ,DUEDATECHANGECOUNT dc, issuestatus s,project p,modules m,issuecomments ic where p.pid=i.pid and i.issueid=s.issueid and m.moduleid=i.module_id and i.issueid=ic.issueid and ic.issueid=i.issueid and i.issueid=dc.issueid  and dc.count=" + noOfChanges + " and to_char(comment_date,'Mon-YYYY')= '" + duration + "' order by  modifiedon desc,due_date asc, type asc, priority asc, severity asc, createdon asc";
                issuesList = getClosedIssuesDuedateChange(wquery);
            }
        }
    }

    public List<IssueFormBean> getClosedIssuesDuedateChange(String query) {
        List<IssueFormBean> closedIssueList = new ArrayList<IssueFormBean>();

        Connection connection = null;
        PreparedStatement ps = null;
        ResultSet resultset = null;
        String totalissuenos = "";

        SimpleDateFormat sdf = new SimpleDateFormat("dd-MMM-yy");
        SimpleDateFormat dateConversion = new SimpleDateFormat("yyyy-MM-dd");
        HashMap<Integer, String> member = GetProjectMembers.showUsersSName();
        try {
            connection = MakeConnection.getConnection();
            logger.info(query);
            ps = connection.prepareStatement(query, ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);

            resultset = ps.executeQuery();
            while (resultset.next()) {
                totalissuenos = totalissuenos + "'" + resultset.getString("issueid") + "',";
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

                int age = 0;
                String status = resultset.getString("status");
                if (status.equalsIgnoreCase("Closed")) {
                    age = resultset.getInt("closedage");
                } else {
                    age = resultset.getInt("age");
                }
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
                    lastAsigneeAge = age;
                }

                if (lastAsigneeAge == 0) {
                    lastAsigneeAge = lastAsigneeAge + 1;
                }
                isfb.setAge(age);
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

                }
                if (feedback == null) {
                    feedback = "";
                }
                isfb.setRatingColor(color);
                isfb.setFeedback(feedback);
                isfb.setLastAssigneeAge(lastAsigneeAge);
                closedIssueList.add(isfb);
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
                if (ps != null) {
                    ps.close();
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
        return closedIssueList;
    }

    public Map<Integer, Integer> closedIssueDueDateChangeCount(String query) {
        List<Integer> closedIssueDueDateChangeCount = new ArrayList<Integer>();
        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        try {
            connection = MakeConnection.getConnection();
            statement = connection.createStatement();
            logger.info(query);
            resultset = statement.executeQuery(query);
            while (resultset.next()) {
                closedIssueDueDateChangeCount.add(resultset.getInt(1));


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
        Integer prevVal = -1;
        Map<Integer, Integer> closedIssueDueDateChangesCount = new HashMap<Integer, Integer>();
        for (Integer val : closedIssueDueDateChangeCount) {
            if (prevVal == -1) {
                prevVal = val;
                closedIssueDueDateChangesCount.put(val, 1);
            } else if (val != prevVal) {
                prevVal = val;
                closedIssueDueDateChangesCount.put(val, 1);
            } else {
                closedIssueDueDateChangesCount.put(val, closedIssueDueDateChangesCount.get(val) + 1);
            }
        }
        return closedIssueDueDateChangesCount;
    }

    public String getNoOfChanges() {
        return noOfChanges;
    }

    public void setNoOfChanges(String noOfChanges) {
        this.noOfChanges = noOfChanges;
    }

    public List<Integer> getDiffDueDateChanges() {
        return diffDueDateChanges;
    }

    public void setDiffDueDateChanges(List<Integer> diffDueDateChanges) {
        this.diffDueDateChanges = diffDueDateChanges;
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

    public Map<Integer, Integer> getWorkedDueDateWiseList() {
        return workedDueDateWiseList;
    }

    public void setWorkedDueDateWiseList(Map<Integer, Integer> workedDueDateWiseList) {
        this.workedDueDateWiseList = workedDueDateWiseList;
    }

    public Map<Integer, Integer> getCreatedDueDateWiseList() {
        return createdDueDateWiseList;
    }

    public void setCreatedDueDateWiseList(Map<Integer, Integer> createdDueDateWiseList) {
        this.createdDueDateWiseList = createdDueDateWiseList;
    }

    public Map<Integer, Integer> getClosedDueDateWiseList() {
        return closedDueDateWiseList;
    }

    public void setClosedDueDateWiseList(Map<Integer, Integer> closedDueDateWiseList) {
        this.closedDueDateWiseList = closedDueDateWiseList;
    }

    public Map<Integer, Integer> getOpenDueDateWiseList() {
        return openDueDateWiseList;
    }

    public void setOpenDueDateWiseList(Map<Integer, Integer> openDueDateWiseList) {
        this.openDueDateWiseList = openDueDateWiseList;
    }

    public List<IssueFormBean> getIssuesList() {
        return issuesList;
    }

    public void setIssuesList(List<IssueFormBean> issuesList) {
        this.issuesList = issuesList;
    }
}
