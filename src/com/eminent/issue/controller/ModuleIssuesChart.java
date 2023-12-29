/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eminent.issue.controller;

import com.eminent.issue.TeamClosedIssueReport;
import com.eminent.issue.formbean.IssueFormBean;
import com.eminent.issue.formbean.OCCWCountFormbean;
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
public class ModuleIssuesChart {

    static Logger logger = null;

    static {
        logger = Logger.getLogger("ModuleIssuesChart");
    }
    int userId = GetProjectMembers.getAdminID();
    private int month;
    private int year;
    private String chartType;
    private String module;
    Map<String, Integer> workedModuleList = new HashMap<String, Integer>();
    Map<String, Integer> createdModuleList = new HashMap<String, Integer>();
    Map<String, Integer> closedModuleList = new HashMap<String, Integer>();
    Map<String, Integer> openModuleList = new HashMap<String, Integer>();
    List<IssueFormBean> issuesList = new ArrayList<IssueFormBean>();
    List<String> modulesList = new ArrayList<String>();

    public void setAll(HttpServletRequest request) {

        Calendar calDuration = new GregorianCalendar();
        //calDuration.add(Calendar.MONTH, -1);
        int currMonth = calDuration.get(Calendar.MONTH);
        int currYear = calDuration.get(Calendar.YEAR);
        String monthname = request.getParameter("month");
        String yearname = request.getParameter("year");
        module = request.getParameter("module");
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
        if (module == null) {

            createdModuleList = getCreatedModule(duration);
            closedModuleList = getClosedModule(duration);
            openModuleList = getOpenModule(start, end);
            workedModuleList = getWorkedModule(duration);

        } else {
            if (chartType.equalsIgnoreCase(getChartTypeList().get(1))) {
                String query = "Select distinct(i.issueid), CONCAT(pname ,CONCAT(' v',version)) as project, type, s.status, i.subject, description, i.priority, i.severity, i.createdby, i.createdon, i.assignedto, i.modifiedon, i.due_date,i.rating,i.feedback,m.module,ceil(to_number(to_date(modifiedOn)-to_date(createdon)))as closedage,ceil(to_number(sysdate-to_date(createdon)))as age from issue i , issuestatus s,project p,modules m,issuecomments ic where p.pid=i.pid and i.issueid=s.issueid and m.moduleid=i.module_id and m.module like '" + module + "%' and i.issueid=ic.issueid and to_char(createdon,'Mon-YYYY')= '" + duration + "' ";
                getModuleIssues(query);
            } else if (chartType.equalsIgnoreCase(getChartTypeList().get(2))) {
                String query = "select distinct(i.issueid), CONCAT(pname ,CONCAT(' v',version)) as project, type, s.status, i.subject, description, i.priority, i.severity, i.createdby, i.createdon, i.assignedto, i.modifiedon, i.due_date,i.rating,i.feedback,m.module,ceil(to_number(to_date(modifiedOn)-to_date(createdon)))as closedage from issue i,issuestatus s,project p,modules m where p.pid=i.pid and i.issueid=s.issueid and m.moduleid=i.module_id and m.module like '" + module + "%' and i.issueid=s.issueid  and s.status='Closed' and to_char(i.modifiedon,'Mon-YYYY')= '" + duration + "'";
                getModuleIssues(query);
            } else if (chartType.equalsIgnoreCase(getChartTypeList().get(3))) {
                String query = "Select distinct(i.issueid), CONCAT(pname ,CONCAT(' v',version)) as project, type, s.status, i.subject, description, i.priority, i.severity, i.createdby, i.createdon, i.assignedto, i.modifiedon, i.due_date,i.rating,i.feedback,m.module,ceil(to_number(to_date(modifiedOn)-to_date(createdon)))as closedage,ceil(to_number(sysdate-to_date(createdon)))as age from issue i , issuestatus s,project p,modules m where p.pid=i.pid and m.moduleid=i.module_id and m.module like '" + module + "%' and i.issueid=s.issueid and to_date(to_char(createdon,'DD-Mon-YYYY'),'DD-Mon-YY')< '" + end + "' and i.issueid not in (Select i.issueid from issue i , issuestatus s where i.issueid=s.issueid and status='Closed' and to_date(to_char(modifiedon,'DD-Mon-YYYY'),'DD-Mon-YY')<'" + start + "')";
                getModuleIssues(query);
            } else {
                String query = "Select distinct(i.issueid), CONCAT(pname ,CONCAT(' v',version)) as project, type, s.status, i.subject, description, i.priority, i.severity, i.createdby, i.createdon, i.assignedto, i.modifiedon, i.due_date,i.rating,i.feedback,m.module,ceil(to_number(to_date(modifiedOn)-to_date(createdon)))as closedage,ceil(to_number(sysdate-to_date(createdon)))as age  from issue i , issuestatus s,project p,modules m,issuecomments ic where p.pid=i.pid and i.issueid=s.issueid and m.moduleid=i.module_id and m.module like '" + module + "%' and i.issueid=ic.issueid  and to_char(comment_date,'Mon-YYYY')= '" + duration + "'";
                getModuleIssues(query);
            }
        }
        modulesList = getModules();
    }

    public Map<String, Integer> getWorkedModule(String duration) {
        Map<String, Integer> moduleList = new HashMap<String, Integer>();
        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        try {
            String query = "Select module, count(distinct(i.issueid))  from issue i , issuestatus s,project p,modules m,issuecomments ic where p.pid=i.pid and i.issueid=s.issueid and m.moduleid=i.module_id and i.issueid=ic.issueid and to_char(comment_date,'Mon-YYYY')= '" + duration + "' group by module";
            connection = MakeConnection.getConnection();
            statement = connection.createStatement();
            resultset = statement.executeQuery(query);
            while (resultset.next()) {
                String moduleName = resultset.getString(1);
                if (resultset.getString(1).length() > 3) {
                    moduleName = resultset.getString(1).substring(0, 3).toUpperCase();
                    
                    if (eTrackerModules().contains(moduleName)) {
                        if (moduleList.get(moduleName) != null) {
                            moduleList.put(moduleName, resultset.getInt(2) + moduleList.get(moduleName));
                        } else {
                            moduleList.put(moduleName, resultset.getInt(2));
                        }
                    } else {
                        moduleList.put(resultset.getString(1), resultset.getInt(2));
                    }
                }else{
                    moduleList.put(resultset.getString(1), resultset.getInt(2));
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
        return moduleList;
    }

    public List<IssueFormBean> getModuleIssues(String query) {
        Connection connection = null;
        PreparedStatement ps = null;
        ResultSet resultset = null;
        String totalissuenos = "";

        SimpleDateFormat sdf = new SimpleDateFormat("dd-MMM-yy");
        SimpleDateFormat dateConversion = new SimpleDateFormat("yyyy-MM-dd");
        HashMap<Integer, String> member = GetProjectMembers.showUsersSName();
        try {
            connection = MakeConnection.getConnection();
            ps = connection.prepareStatement(query, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);
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

    public Map<String, Integer> getClosedModule(String duration) {
        Map<String, Integer> moduleList = new HashMap<String, Integer>();
        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        try {
            String query = "select module, count(distinct i.issueid) from issue i,issuestatus s,project p,modules m where p.pid=i.pid and i.issueid=s.issueid and m.moduleid=i.module_id and i.issueid=s.issueid  and s.status='Closed' and to_char(i.modifiedon,'Mon-YYYY')= '" + duration + "' group by module";
            connection = MakeConnection.getConnection();
            statement = connection.createStatement();
            resultset = statement.executeQuery(query);
            while (resultset.next()) {
                String moduleName = resultset.getString(1);
                if (resultset.getString(1).length() > 3) {
                    moduleName = resultset.getString(1).substring(0, 3).toUpperCase();
                    
                    if (eTrackerModules().contains(moduleName)) {
                        if (moduleList.get(moduleName) != null) {
                            moduleList.put(moduleName, resultset.getInt(2) + moduleList.get(moduleName));
                        } else {
                            moduleList.put(moduleName, resultset.getInt(2));
                        }
                    } else {
                        moduleList.put(resultset.getString(1), resultset.getInt(2));
                    }
                }else{
                    moduleList.put(resultset.getString(1), resultset.getInt(2));
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
        return moduleList;
    }

    public Map<String, Integer> getCreatedModule(String duration) {
        Map<String, Integer> moduleList = new HashMap<String, Integer>();
        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        try {
            String query = "Select module, count(distinct(i.issueid)) from issue i , issuestatus s,project p,modules m,issuecomments ic where p.pid=i.pid and i.issueid=s.issueid and m.moduleid=i.module_id and i.issueid=ic.issueid and to_char(createdon,'Mon-YYYY')= '" + duration + "' group by module";
            logger.info("getCreatedCount" + query);
            connection = MakeConnection.getConnection();
            statement = connection.createStatement();
            resultset = statement.executeQuery(query);
            while (resultset.next()) {
                String moduleName = resultset.getString(1);
                if (resultset.getString(1).length() > 3) {
                    moduleName = resultset.getString(1).substring(0, 3).toUpperCase();
                    
                    if (eTrackerModules().contains(moduleName)) {
                        if (moduleList.get(moduleName) != null) {
                            moduleList.put(moduleName, resultset.getInt(2) + moduleList.get(moduleName));
                        } else {
                            moduleList.put(moduleName, resultset.getInt(2));
                        }
                    } else {
                        moduleList.put(resultset.getString(1), resultset.getInt(2));
                    }
                }else{
                    moduleList.put(resultset.getString(1), resultset.getInt(2));
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
        return moduleList;
    }

    public Map<String, Integer> getOpenModule(String start, String end) {
        Map<String, Integer> moduleList = new HashMap<String, Integer>();
        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        try {
            String query = "Select module, count(distinct i.issueid) from issue i , issuestatus s,project p,modules m where p.pid=i.pid and m.moduleid=i.module_id and i.issueid=s.issueid and to_date(to_char(createdon,'DD-Mon-YYYY'),'DD-Mon-YY')< '" + end + "' and i.issueid not in (Select i.issueid from issue i , issuestatus s where i.issueid=s.issueid and status='Closed' and to_date(to_char(modifiedon,'DD-Mon-YYYY'),'DD-Mon-YY')<'" + start + "') group by module";
            connection = MakeConnection.getConnection();
            statement = connection.createStatement();
            resultset = statement.executeQuery(query);
            while (resultset.next()) {
                String moduleName = resultset.getString(1);
                if (resultset.getString(1).length() > 3) {
                    moduleName = resultset.getString(1).substring(0, 3).toUpperCase();
                     if (eTrackerModules().contains(moduleName)) {
                        if (moduleList.get(moduleName) != null) {
                            moduleList.put(moduleName, resultset.getInt(2) + moduleList.get(moduleName));
                        } else {
                            moduleList.put(moduleName, resultset.getInt(2));
                        }
                    } else {
                        moduleList.put(resultset.getString(1), resultset.getInt(2));
                    }
                }else{
                    moduleList.put(resultset.getString(1), resultset.getInt(2));
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
        return moduleList;
    }

    public List<OCCWCountFormbean> getModuleIssuesChartCount() {
        List<OCCWCountFormbean> occwcountfbList = new ArrayList<OCCWCountFormbean>();

        Calendar c = new GregorianCalendar();
        month = c.get(Calendar.MONTH);
        year = c.get(Calendar.YEAR);
        c.add(Calendar.MONTH, -11);



        for (int i = 0; i <= 11; i++) {
            OCCWCountFormbean occwcountfb = new OCCWCountFormbean();
            month = c.get(Calendar.MONTH);
            year = c.get(Calendar.YEAR);
            c.add(Calendar.MONTH, 1);
            Calendar cale = Calendar.getInstance();
            cale.set(year, month, 1);
            int maxday = cale.getActualMaximum(Calendar.DATE);
            String start = "1" + "-" + TeamClosedIssueReport.getMonths().get(month) + "-" + year;
            String end = maxday + "-" + TeamClosedIssueReport.getMonths().get(month) + "-" + year;
            String duration = TeamClosedIssueReport.getMonths().get(month) + "-" + year;
            occwcountfb.setMonth(month);
            occwcountfb.setYear(year);
            occwcountfb.setMonthYear(duration);
            occwcountfb.setWorkedCount(getWorkedCount(duration));
            occwcountfb.setClosedCount(getClosedCount(duration));
            occwcountfb.setCreateCount(getCreatedCount(duration));
            occwcountfb.setOpenCount(getOpenCount(start, end));
            occwcountfbList.add(occwcountfb);
        }
        return occwcountfbList;
    }

    public int getWorkedCount(String duration) {
        int workedCount = 0;
        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        try {
            String query = "Select count(distinct(i.issueid)) from issue i , issuestatus s,project p,modules m,issuecomments ic where p.pid=i.pid and i.issueid=s.issueid and m.moduleid=i.module_id and i.issueid=ic.issueid and to_char(comment_date,'Mon-YYYY')= '" + duration + "'";
            connection = MakeConnection.getConnection();
            statement = connection.createStatement();
            resultset = statement.executeQuery(query);
            while (resultset.next()) {
                workedCount = resultset.getInt(1);


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
        return workedCount;
    }

    public int getClosedCount(String duration) {
        int closedCount = 0;
        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        try {
            String query = "select count(distinct i.issueid) from issue i,issuestatus s,project p,modules m where p.pid=i.pid and i.issueid=s.issueid and m.moduleid=i.module_id and i.issueid=s.issueid  and s.status='Closed' and to_char(i.modifiedon,'Mon-YYYY')= '" + duration + "'";
            connection = MakeConnection.getConnection();
            statement = connection.createStatement();
            resultset = statement.executeQuery(query);
            while (resultset.next()) {
                closedCount = resultset.getInt(1);


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
        return closedCount;
    }

    public int getCreatedCount(String duration) {
        int createdCount = 0;
        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        try {
            String query = "Select count(distinct(i.issueid)) from issue i , issuestatus s,project p,modules m,issuecomments ic where p.pid=i.pid and i.issueid=s.issueid and m.moduleid=i.module_id and i.issueid=ic.issueid and to_char(createdon,'Mon-YYYY')= '" + duration + "'";
            connection = MakeConnection.getConnection();
            statement = connection.createStatement();
            resultset = statement.executeQuery(query);
            while (resultset.next()) {
                createdCount = resultset.getInt(1);


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
        return createdCount;
    }

    public int getOpenCount(String start, String end) {
        int openedCount = 0;
        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        try {
            String query = "Select count(distinct i.issueid) from issue i , issuestatus s,project p,modules m where p.pid=i.pid and m.moduleid=i.module_id and i.issueid=s.issueid and to_date(to_char(createdon,'DD-Mon-YYYY'),'DD-Mon-YY')< '" + end + "' and i.issueid not in (Select i.issueid from issue i , issuestatus s where i.issueid=s.issueid and status='Closed' and to_date(to_char(modifiedon,'DD-Mon-YYYY'),'DD-Mon-YY')<'" + start + "') ";
            connection = MakeConnection.getConnection();
            statement = connection.createStatement();
            resultset = statement.executeQuery(query);
            while (resultset.next()) {
                openedCount = resultset.getInt(1);


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
        return openedCount;
    }

    public List<String> getModules() {
        List<String> modules = new ArrayList<String>();
        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        try {
            String query = "SELECT DISTINCT MODULE FROM MODULES m,issue i WHERE  i.module_id=m.Moduleid and MODULE IS NOT NULL ORDER BY Upper(MODULE) ";
            connection = MakeConnection.getConnection();
            statement = connection.createStatement();
            resultset = statement.executeQuery(query);
            while (resultset.next()) {
                String moduleName = resultset.getString("Module");
                if (resultset.getString(1).length() > 3) {
                    moduleName = resultset.getString(1).substring(0, 3).toUpperCase();
                    if (eTrackerModules().contains(moduleName)) {
                        if (!modules.contains(moduleName)) {
                            modules.add(moduleName);
                        } 
                    } else {
                        modules.add(resultset.getString("Module"));
                    }
                }else{
                    modules.add(resultset.getString("Module"));
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
        return modules;
    }

    public static List<String> getChartTypeList() {
        List<String> chartTypeList = new ArrayList<String>();
        chartTypeList.add("Worked");
        chartTypeList.add("Created");
        chartTypeList.add("Closed");
        chartTypeList.add("Open");

        return chartTypeList;
    }

    public static List<String> eTrackerModules() {
        List<String> chartTypeList = new ArrayList<String>();
        chartTypeList.add("CRM");
        chartTypeList.add("BPM");
        chartTypeList.add("APM");
        chartTypeList.add("TQM");
        chartTypeList.add("ERM");

        return chartTypeList;
    }

    public Map<String, Integer> getWorkedModuleList() {
        return workedModuleList;
    }

    public void setWorkedModuleList(Map<String, Integer> workedModuleList) {
        this.workedModuleList = workedModuleList;
    }

    public Map<String, Integer> getCreatedModuleList() {
        return createdModuleList;
    }

    public void setCreatedModuleList(Map<String, Integer> createdModuleList) {
        this.createdModuleList = createdModuleList;
    }

    public Map<String, Integer> getClosedModuleList() {
        return closedModuleList;
    }

    public void setClosedModuleList(Map<String, Integer> closedModuleList) {
        this.closedModuleList = closedModuleList;
    }

    public Map<String, Integer> getOpenModuleList() {
        return openModuleList;
    }

    public void setOpenModuleList(Map<String, Integer> openModuleList) {
        this.openModuleList = openModuleList;
    }

    public List<IssueFormBean> getIssuesList() {
        return issuesList;
    }

    public void setIssuesList(List<IssueFormBean> issuesList) {
        this.issuesList = issuesList;
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

    public String getChartType() {
        return chartType;
    }

    public void setChartType(String chartType) {
        this.chartType = chartType;
    }

    public String getModule() {
        return module;
    }

    public void setModule(String module) {
        this.module = module;
    }

    public List<String> getModulesList() {
        return modulesList;
    }

    public void setModulesList(List<String> modulesList) {
        this.modulesList = modulesList;
    }
}
