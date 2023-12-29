/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eminent.issue.controller;

import com.eminent.issue.TeamClosedIssueReport;
import static com.eminent.issue.controller.ModuleIssuesChart.getChartTypeList;
import com.eminent.issue.formbean.IssueFormBean;
import static com.eminent.issue.formbean.PlannedIssueReport.severityColor;
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
public class AgeWiseIssues {

    static Logger logger = null;

    static {
        logger = Logger.getLogger("AgeWiseIssues");
    }
    int userId = GetProjectMembers.getAdminID();
    private int month;
    private int year;
    private String chartType;
    private String ageParam;
    Map<String, Integer> workedAgeWiseList = new HashMap<String, Integer>();
    Map<String, Integer> createdAgeWiseList = new HashMap<String, Integer>();
    Map<String, Integer> closedAgeWiseList = new HashMap<String, Integer>();
    Map<String, Integer> openAgeWiseList = new HashMap<String, Integer>();
    List<IssueFormBean> issuesList = new ArrayList<IssueFormBean>();

    public void setAll(HttpServletRequest request) {

        Calendar calDuration = new GregorianCalendar();
        //calDuration.add(Calendar.MONTH, -1);
        int currMonth = calDuration.get(Calendar.MONTH);
        int currYear = calDuration.get(Calendar.YEAR);
        String monthname = request.getParameter("month");
        String yearname = request.getParameter("year");
        ageParam = request.getParameter("ageParam");
        chartType = request.getParameter("chartType");
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
        String start = "1" + "-" + TeamClosedIssueReport.getMonths().get(month) + "-" + year;
        String end = maxday + "-" + TeamClosedIssueReport.getMonths().get(month) + "-" + year;
        if (ageParam == null) {
            createdAgeWiseList = getCreatedIssuesAge(duration);
            closedAgeWiseList = getClosedIssuesAge(duration);
            openAgeWiseList = getOpenIssuesAge(start, end);
            workedAgeWiseList = getWorkedIssuesAge(duration);

        } else {
            if (chartType.equalsIgnoreCase(getChartTypeList().get(1))) {
                String query = "Select distinct(i.issueid), CONCAT(pname ,CONCAT(' v',version)) as project, type, s.status, i.subject, description, i.priority, i.severity, i.createdby, i.createdon, i.assignedto, i.modifiedon, i.due_date,i.rating,i.feedback,m.module,ceil(to_number(to_date(modifiedOn)-to_date(createdon)))as closedage, ceil(to_number(sysdate-to_date(createdon)))as age from issue i , issuestatus s,project p,modules m,issuecomments ic where p.pid=i.pid and i.issueid=s.issueid and m.moduleid=i.module_id  and i.issueid=ic.issueid and to_char(createdon,'Mon-YYYY')= '" + duration + "' ";
                getAgeWiseIssues(query, ageParam);
            } else if (chartType.equalsIgnoreCase(getChartTypeList().get(2))) {
                String query = "select distinct(i.issueid), CONCAT(pname ,CONCAT(' v',version)) as project, type, s.status, i.subject, description, i.priority, i.severity, i.createdby, i.createdon, i.assignedto, i.modifiedon, i.due_date,i.rating,i.feedback,m.module,ceil(to_number(to_date(modifiedOn)-to_date(createdon)))as closedage from issue i,issuestatus s,project p,modules m where p.pid=i.pid and i.issueid=s.issueid and m.moduleid=i.module_id  and i.issueid=s.issueid  and s.status='Closed' and to_char(i.modifiedon,'Mon-YYYY')= '" + duration + "'";
                getAgeWiseIssues(query, ageParam);
            } else if (chartType.equalsIgnoreCase(getChartTypeList().get(3))) {
                String query = "Select distinct(i.issueid), CONCAT(pname ,CONCAT(' v',version)) as project, type, s.status, i.subject, description, i.priority, i.severity, i.createdby, i.createdon, i.assignedto, i.modifiedon, i.due_date,i.rating,i.feedback,ceil(to_number(to_date(modifiedOn)-to_date(createdon)))as closedage, m.module,ceil(to_number(sysdate-to_date(createdon)))as age from issue i , issuestatus s,project p,modules m where p.pid=i.pid and m.moduleid=i.module_id  and i.issueid=s.issueid and to_date(to_char(createdon,'DD-Mon-YYYY'),'DD-Mon-YYYY')< '" + end + "' and i.issueid not in (Select i.issueid from issue i , issuestatus s where i.issueid=s.issueid and status='Closed' and to_date(to_char(modifiedon,'DD-Mon-YYYY'),'DD-Mon-YYYY')<'" + start + "')";
                getAgeWiseIssues(query, ageParam);
            } else {
                String query = "Select distinct(i.issueid), CONCAT(pname ,CONCAT(' v',version)) as project, type, s.status, i.subject, description, i.priority, i.severity, i.createdby, i.createdon, i.assignedto, i.modifiedon, i.due_date,i.rating,i.feedback,m.module,ceil(to_number(to_date(modifiedOn)-to_date(createdon)))as closedage, ceil(to_number(sysdate-to_date(createdon)))as age  from issue i , issuestatus s,project p,modules m,issuecomments ic where p.pid=i.pid and i.issueid=s.issueid and m.moduleid=i.module_id and i.issueid=ic.issueid  and to_char(comment_date,'Mon-YYYY')= '" + duration + "'";
                getAgeWiseIssues(query, ageParam);
            }
        }
    }

    public List<IssueFormBean> getAgeWiseIssues(String query, String ageParam) {
        Connection connection = null;
        PreparedStatement ps = null;
        ResultSet resultset = null;
        String totalissuenos = "";
        int min = 0;
        int max = 0;
        if (getAgeTypes().get(0).equalsIgnoreCase(ageParam)) {
            min = 0;
            max = 7;
        } else if (getAgeTypes().get(1).equalsIgnoreCase(ageParam)) {
            min = 8;
            max = 14;
        } else if (getAgeTypes().get(2).equalsIgnoreCase(ageParam)) {
            min = 15;
            max = 21;
        } else if (getAgeTypes().get(3).equalsIgnoreCase(ageParam)){
            min = 22;
            max = 1000000;
        }else if (getAgeTypes().get(4).equalsIgnoreCase(ageParam)){
            min = 0;
            max = 30;
        }else if (getAgeTypes().get(5).equalsIgnoreCase(ageParam)){
            min = 31;
            max = 90;
        }else if (getAgeTypes().get(6).equalsIgnoreCase(ageParam)){
            min = 91;
            max = 365;
        }else if (getAgeTypes().get(7).equalsIgnoreCase(ageParam)){
            min = 366;
            max = 1000000;
        }
        SimpleDateFormat sdf = new SimpleDateFormat("dd-MMM-yy");
        SimpleDateFormat dateConversion = new SimpleDateFormat("yyyy-MM-dd");
        HashMap<Integer, String> member = GetProjectMembers.showUsersSName();
        try {
            connection = MakeConnection.getConnection();
            ps = connection.prepareStatement(query, ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            logger.info(query);
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

                if (age >= min && age <= max) {
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
                    issuesList.add(isfb);
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
        return issuesList;
    }

    public Map<String, Integer> getWorkedIssuesAge(String duration) {
        List<Integer> issuesWAgeList = new ArrayList<Integer>();
        Map<String, Integer> issuesAgeList = new HashMap<String, Integer>();
        issuesAgeList = getAgeTypeValues();
        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;

        try {
            String query = "select distinct(i.issueid) ,ceil(to_number(to_date(modifiedOn)-to_date(createdon)))as closedage,ceil(to_number(sysdate-to_date(createdon)))as age,s.status from issue i,issuecomments ic,issuestatus s where i.issueid=ic.issueid and i.issueid=s.issueid and to_char(comment_date,'Mon-YYYY')= '" + duration + "' order by age";
            connection = MakeConnection.getConnection();
            statement = connection.createStatement();
            resultset = statement.executeQuery(query);
            while (resultset.next()) {
                if (resultset.getString(4).equalsIgnoreCase("Closed")) {
                    issuesWAgeList.add(resultset.getInt(2));
                } else {
                    issuesWAgeList.add(resultset.getInt(3));
                }
            }

            for (Integer val : issuesWAgeList) {
                int curval = 0;
                if (val <= 7) {

                    if (issuesAgeList.get(getAgeTypes().get(0)) != null) {
                        curval = issuesAgeList.get(getAgeTypes().get(0)) + 1;
                    } else {
                        curval = 1;
                    }
                    issuesAgeList.put(getAgeTypes().get(0), curval);
                } else if (val <= 14) {
                    if (issuesAgeList.get(getAgeTypes().get(1)) != null) {
                        curval = issuesAgeList.get(getAgeTypes().get(1)) + 1;
                    } else {
                        curval = 1;
                    }
                    issuesAgeList.put(getAgeTypes().get(1), curval);
                } else if (val <= 21) {
                    if (issuesAgeList.get(getAgeTypes().get(2)) != null) {
                        curval = issuesAgeList.get(getAgeTypes().get(2)) + 1;
                    } else {
                        curval = 1;
                    }
                    issuesAgeList.put(getAgeTypes().get(2), curval);
                } else {
                    if (issuesAgeList.get(getAgeTypes().get(3)) != null) {
                        curval = issuesAgeList.get(getAgeTypes().get(3)) + 1;
                    } else {
                        curval = 1;
                    }
                    issuesAgeList.put(getAgeTypes().get(3), curval);
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

        return issuesAgeList;
    }

    public Map<String, Integer> getClosedIssuesAge(String duration) {
        List<Integer> issuesClAgeList = new ArrayList<Integer>();
        Map<String, Integer> issuesAgeList = new HashMap<String, Integer>();
        issuesAgeList = getAgeTypeValues();
        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        try {
            String query = "select distinct(i.issueid) ,ceil(to_number(to_date(modifiedOn)-to_date(createdon)))as age from issue i,issuecomments ic,issuestatus s where i.issueid=ic.issueid and i.issueid=s.issueid and s.status='Closed' and to_char(i.modifiedon,'Mon-YYYY')= '" + duration + "' order by age";
            connection = MakeConnection.getConnection();
            statement = connection.createStatement();
            resultset = statement.executeQuery(query);
            while (resultset.next()) {
                issuesClAgeList.add(resultset.getInt(2));


            }
            for (Integer val : issuesClAgeList) {
                int curval = 0;
                if (val <= 7) {

                    if (issuesAgeList.get(getAgeTypes().get(0)) != null) {
                        curval = issuesAgeList.get(getAgeTypes().get(0)) + 1;
                    } else {
                        curval = 1;
                    }
                    issuesAgeList.put(getAgeTypes().get(0), curval);
                } else if (val <= 14) {
                    if (issuesAgeList.get(getAgeTypes().get(1)) != null) {
                        curval = issuesAgeList.get(getAgeTypes().get(1)) + 1;
                    } else {
                        curval = 1;
                    }
                    issuesAgeList.put(getAgeTypes().get(1), curval);
                } else if (val <= 21) {
                    if (issuesAgeList.get(getAgeTypes().get(2)) != null) {
                        curval = issuesAgeList.get(getAgeTypes().get(2)) + 1;
                    } else {
                        curval = 1;
                    }
                    issuesAgeList.put(getAgeTypes().get(2), curval);
                } else {
                    if (issuesAgeList.get(getAgeTypes().get(3)) != null) {
                        curval = issuesAgeList.get(getAgeTypes().get(3)) + 1;
                    } else {
                        curval = 1;
                    }
                    issuesAgeList.put(getAgeTypes().get(3), curval);
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
        return issuesAgeList;
    }

    public Map<String, Integer> getCreatedIssuesAge(String duration) {
        List<Integer> issuesCrAgeList = new ArrayList<Integer>();
        Map<String, Integer> issuesAgeList = new HashMap<String, Integer>();
        issuesAgeList = getAgeTypeValues();
        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        try {
            String query = "select distinct(i.issueid) ,ceil(to_number(to_date(modifiedOn)-to_date(createdon)))as closedage,ceil(to_number(sysdate-to_date(createdon)))as age,s.status from issue i,issuecomments ic,issuestatus s where i.issueid=ic.issueid and i.issueid=s.issueid and to_char(createdon,'Mon-YYYY')= '" + duration + "' order by age";
            logger.info("getCreatedCount" + query);
            connection = MakeConnection.getConnection();
            statement = connection.createStatement();
            resultset = statement.executeQuery(query);
            while (resultset.next()) {
                if (resultset.getString(4).equalsIgnoreCase("Closed")) {
                    issuesCrAgeList.add(resultset.getInt(2));
                } else {
                    issuesCrAgeList.add(resultset.getInt(3));
                }


            }
            for (Integer val : issuesCrAgeList) {
                int curval = 0;
                if (val <= 7) {

                    if (issuesAgeList.get(getAgeTypes().get(0)) != null) {
                        curval = issuesAgeList.get(getAgeTypes().get(0)) + 1;
                    } else {
                        curval = 1;
                    }
                    issuesAgeList.put(getAgeTypes().get(0), curval);
                } else if (val <= 14) {
                    if (issuesAgeList.get(getAgeTypes().get(1)) != null) {
                        curval = issuesAgeList.get(getAgeTypes().get(1)) + 1;
                    } else {
                        curval = 1;
                    }
                    issuesAgeList.put(getAgeTypes().get(1), curval);
                } else if (val <= 21) {
                    if (issuesAgeList.get(getAgeTypes().get(2)) != null) {
                        curval = issuesAgeList.get(getAgeTypes().get(2)) + 1;
                    } else {
                        curval = 1;
                    }
                    issuesAgeList.put(getAgeTypes().get(2), curval);
                } else {
                    if (issuesAgeList.get(getAgeTypes().get(3)) != null) {
                        curval = issuesAgeList.get(getAgeTypes().get(3)) + 1;
                    } else {
                        curval = 1;
                    }
                    issuesAgeList.put(getAgeTypes().get(3), curval);
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
        return issuesAgeList;
    }

    public Map<String, Integer> getOpenIssuesAge(String start, String end) {
        List<Integer> issuesOAgeList = new ArrayList<Integer>();
        Map<String, Integer> issuesAgeList = new HashMap<String, Integer>();
        issuesAgeList = getAgeOpenTypeValues();
        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        try {
            String query = "select distinct(i.issueid) ,ceil(to_number(to_date(modifiedOn)-to_date(createdon)))as closedage,ceil(to_number(sysdate-to_date(createdon)))as age,s.status from issue i,issuecomments ic,issuestatus s where i.issueid=ic.issueid and i.issueid=s.issueid and to_date(to_char(createdon,'DD-Mon-YYYY'),'DD-Mon-YY')< '" + end + "' and i.issueid not in (Select i.issueid from issue i , issuestatus s where i.issueid=s.issueid and status='Closed' and to_date(to_char(modifiedon,'DD-Mon-YYYY'),'DD-Mon-YYYY')<'" + start + "') order by age";
            logger.info(query);
            connection = MakeConnection.getConnection();
            statement = connection.createStatement();
            resultset = statement.executeQuery(query);
            while (resultset.next()) {
                if (resultset.getString(4).equalsIgnoreCase("Closed")) {
                    issuesOAgeList.add(resultset.getInt(2));
                } else {
                    issuesOAgeList.add(resultset.getInt(3));
                }
            }

            for (Integer val : issuesOAgeList) {
                int curval = 0;
                if (val <= 30) {

                    if (issuesAgeList.get(getAgeOpenTypes().get(4)) != null) {
                        curval = issuesAgeList.get(getAgeOpenTypes().get(4)) + 1;
                    } else {
                        curval = 1;
                    }
                    issuesAgeList.put(getAgeOpenTypes().get(4), curval);
                } else if (val <= 90) {
                    if (issuesAgeList.get(getAgeOpenTypes().get(5)) != null) {
                        curval = issuesAgeList.get(getAgeOpenTypes().get(5)) + 1;
                    } else {
                        curval = 1;
                    }
                    issuesAgeList.put(getAgeOpenTypes().get(5), curval);
                } else if (val <= 365) {
                    if (issuesAgeList.get(getAgeOpenTypes().get(6)) != null) {
                        curval = issuesAgeList.get(getAgeOpenTypes().get(6)) + 1;
                    } else {
                        curval = 1;
                    }
                    issuesAgeList.put(getAgeOpenTypes().get(6), curval);
                } else {
                    if (issuesAgeList.get(getAgeOpenTypes().get(7)) != null) {
                        curval = issuesAgeList.get(getAgeOpenTypes().get(7)) + 1;
                    } else {
                        curval = 1;
                    }
                    issuesAgeList.put(getAgeOpenTypes().get(7), curval);
                }
            }
            logger.info(issuesAgeList);
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
        return issuesAgeList;
    }

    public Map<String, Integer> getAgeTypeValues() {
        Map<String, Integer> days = new HashMap<String, Integer>();
        days.put("< 8 Days", 0);
        days.put("8 - 14 Days", 0);
        days.put("15 - 21 Days", 0);
        days.put("> 21  Days", 0);
        days.put("< 1 Month",0);
        days.put("< Quarter",0);
        days.put("> Year",0);
        days.put("< Year",0);
        return days;

    }

    public static List<String> getAgeTypes() {
        List<String> days = new ArrayList<String>();
        days.add("< 8 Days");
        days.add("8 - 14 Days");
        days.add("15 - 21 Days");
        days.add("> 21  Days");
        days.add("< 1 Month");
        days.add("< Quarter");
        days.add("< Year");
        days.add("> Year");
        return days;

    }

    public Map<String, Integer> getAgeOpenTypeValues() {
        Map<String, Integer> days = new HashMap<String, Integer>();
        days.put("< 8 days", 0);
        days.put("8 - 14 days", 0);
        days.put("15 - 21 days", 0);
        days.put("> 21  days", 0);
        days.put("< 1 Month",0);
        days.put("< Quarter",0);
        days.put("> Year",0);
        days.put("< Year",0);
        
        return days;
    }

    public static List<String> getAgeOpenTypes() {
        List<String> days = new ArrayList<String>();
        days.add("< 8 Days");
        days.add("8 - 14 Days");
        days.add("15 - 21 Days");
        days.add("> 21  Days");
        days.add("< 1 Month");
        days.add("< Quarter");
        days.add("< Year");
        days.add("> Year");
        return days;

    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
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

    public String getAgeParam() {
        return ageParam;
    }

    public void setAgeParam(String ageParam) {
        this.ageParam = ageParam;
    }

    public List<IssueFormBean> getIssuesList() {
        return issuesList;
    }

    public void setIssuesList(List<IssueFormBean> issuesList) {
        this.issuesList = issuesList;
    }

    public String getChartType() {
        return chartType;
    }

    public void setChartType(String chartType) {
        this.chartType = chartType;
    }

    public Map<String, Integer> getWorkedAgeWiseList() {
        return workedAgeWiseList;
    }

    public void setWorkedAgeWiseList(Map<String, Integer> workedAgeWiseList) {
        this.workedAgeWiseList = workedAgeWiseList;
    }

    public Map<String, Integer> getCreatedAgeWiseList() {
        return createdAgeWiseList;
    }

    public void setCreatedAgeWiseList(Map<String, Integer> createdAgeWiseList) {
        this.createdAgeWiseList = createdAgeWiseList;
    }

    public Map<String, Integer> getClosedAgeWiseList() {
        return closedAgeWiseList;
    }

    public void setClosedAgeWiseList(Map<String, Integer> closedAgeWiseList) {
        this.closedAgeWiseList = closedAgeWiseList;
    }

    public Map<String, Integer> getOpenAgeWiseList() {
        return openAgeWiseList;
    }

    public void setOpenAgeWiseList(Map<String, Integer> openAgeWiseList) {
        this.openAgeWiseList = openAgeWiseList;
    }
}
