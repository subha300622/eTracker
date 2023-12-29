/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eminent.issue.formbean;

import static com.eminent.issue.formbean.MyAsignmentIssues.logger;
import static com.eminent.issue.formbean.PlannedIssueReport.severityColor;
import com.eminent.util.GetAge;
import com.eminent.util.GetProjectMembers;
import com.eminent.util.IssueDetails;
import dashboard.CheckDate;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import pack.eminent.encryption.MakeConnection;

/**
 *
 * @author EMINENT
 */
public class MyIssues {

    private int pageNo;
    private String url = "";
    private Integer userId;
     
    String issueid="",prev = "", next = "", issue = "";
    String sort_method = "", sorton = "", userin = "", issueId = "", position = "";
    HashMap<Integer, String> member = GetProjectMembers.showUsersSName();
    List<IssueFormBean> issuesList = new ArrayList<IssueFormBean>();

    public void setAll(HttpServletRequest request) throws SQLException, Exception {
        // SimpleDateFormat sdfs = new SimpleDateFormat("dd-MMM-yyyy");
        //String pageNumber = request.getParameter("pageNumber");
        int adminid = GetProjectMembers.getAdminID();
        //pageNo =MyIssues.parseInteger(pageNumber, 1);
        //  int rowStart = 1, rowEnd = 15;
        // rowStart = (pageNo - 1) * 15 + 1;
        //  rowEnd = rowStart + 14;
        Calendar c = Calendar.getInstance();
        //  Date start = c.getTime();
        userId = (Integer) request.getSession().getAttribute("userid_curr");

        String mail = (String) request.getSession().getAttribute("theName");
        if (mail != null) {
            url = mail.substring(mail.indexOf("@") + 1, mail.length());
        }
        SimpleDateFormat sdf = new SimpleDateFormat("dd-MMM-yy");
        SimpleDateFormat dateConversion = new SimpleDateFormat("yyyy-MM-dd");
        Connection connection = null;
        PreparedStatement ps = null;
        ResultSet resultset = null;
        try {
            connection = MakeConnection.getConnection();
            ps = connection.prepareStatement("select i.issueid, pname as project,module, subject, severity, priority, type, createdon, due_date, modifiedon, description, createdby, assignedto, s.status,ceil(to_number(sysdate-to_date(createdon)))as age  from project p, issue i, issuestatus s,modules m where i.issueid = s.issueid and i.pid = p.pid and i.module_id=m.moduleid and s.status != 'Closed' and p.STATUS='Work in progress' And pmanager <> " + adminid + " and createdby = ? order by due_date asc, modifiedon asc, type asc, priority asc, severity asc, createdon asc", ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            ps.setInt(1, userId);
            resultset = ps.executeQuery();
            String totalissuenos = "";
            int i = 1;
            while (resultset.next()) {
                //     if (i > rowStart - 1 && i < rowEnd + 1) {
                //   if (resultset.next()) {

                totalissuenos = totalissuenos + "'" + resultset.getString("issueid").trim() + "',";
                //   }
                //    }
                //       i++;
            }
            logger.info("Total issues for the page" + totalissuenos);
            Map<String, Integer> lastAsigneeAgeList = new HashMap<String, Integer>();
            Map<String, Integer> fileCountList = new HashMap<String, Integer>();
            List<LastAssginForm> lastAssign = new ArrayList<LastAssginForm>();
            if (totalissuenos.contains(",")) {
                totalissuenos = totalissuenos.substring(0, totalissuenos.length() - 1);
                lastAsigneeAgeList = GetAge.issuelastAsigneeAge(totalissuenos);
                fileCountList = IssueDetails.displayFilesCount(totalissuenos);
                lastAssign = IssueDetails.lastAssign();
            }
            resultset.beforeFirst();
            i = 1;
            while (resultset.next()) {
                //   if (i > rowStart - 1 && i < rowEnd + 1) {
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
                String status = resultset.getString("status");
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
                    lastAsigneeAge = resultset.getInt("age");
                }

                if (lastAsigneeAge == 0) {
                    lastAsigneeAge = lastAsigneeAge + 1;
                }
                isfb.setAge(resultset.getInt("age"));
                isfb.setLastAssigneeAge(lastAsigneeAge);

                for (LastAssginForm lastAssignForm : lastAssign) {
                    if (resultset.getString("issueid").equals(lastAssignForm.getIssueId())) {
                        isfb.setLastAssigneeName(lastAssignForm.getLastAssigneeName());
                        isfb.setLastModifiedOn(lastAssignForm.getLastModifiedOn());
                    }
                }
                issuesList.add(isfb);
                // }
                i++;
            }
        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            try {

                if (resultset != null) {
                    resultset.close();
                }
                if (ps != null) {
                    ps.close();
                }
                if (connection != null) {
                    connection.close();
                }
            } catch (Exception ex) {
                logger.error(ex.getMessage());
            }
        }

    }

    public void sorting_method(HttpServletRequest request, HttpServletResponse response) throws Exception {
       
        sort_method = request.getParameter("sort_method");
        sorton = request.getParameter("sorton");
        userin = request.getParameter("userin");
        issueId = request.getParameter("issueid");

        userId = (Integer) request.getSession().getAttribute("userid_curr");
        String priority = request.getParameter("priority");
        String status = request.getParameter("status");
        String query_string_view = (String) request.getSession().getAttribute("IssueSummaryQuery");
        String clickb = request.getParameter("clickb");
        int adminid = GetProjectMembers.getAdminID();

        String sql = "";

        if (userin.equalsIgnoreCase("MyIssues")) {

            if (sorton.equalsIgnoreCase("Issue No")) {
                if (sort_method.equalsIgnoreCase("headerSortDown")) {

                    sql = "select i.issueid, pname as project,module, subject, severity, priority, type, createdon, due_date, modifiedon, description, createdby, assignedto, s.status,ceil(to_number(sysdate-to_date(createdon)))as age  from project p, issue i, issuestatus s,modules m where i.issueid = s.issueid and i.pid = p.pid and i.module_id=m.moduleid and s.status != 'Closed' and p.STATUS='Work in progress' And pmanager <> " + adminid + " and createdby =" + userId + " order by issueid asc";
                     issueid = query_fun(sql);

                } else if (sort_method.equalsIgnoreCase("headerSortUp")) {

                    sql = "select i.issueid, pname as project,module, subject, severity, priority, type, createdon, due_date, modifiedon, description, createdby, assignedto, s.status,ceil(to_number(sysdate-to_date(createdon)))as age  from project p, issue i, issuestatus s,modules m where i.issueid = s.issueid and i.pid = p.pid and i.module_id=m.moduleid and s.status != 'Closed' and p.STATUS='Work in progress' And pmanager <> " + adminid + " and createdby =" + userId + " order by issueid desc";
                     issueid = query_fun(sql);

                }

            } else if (sorton.equalsIgnoreCase("P")) {
                if (sort_method.equalsIgnoreCase("headerSortDown")) {

                    sql = "select i.issueid, pname as project,module, subject, severity, priority, type, createdon, due_date, modifiedon, description, createdby, assignedto, s.status,ceil(to_number(sysdate-to_date(createdon)))as age  from project p, issue i, issuestatus s,modules m where i.issueid = s.issueid and i.pid = p.pid and i.module_id=m.moduleid and s.status != 'Closed' and p.STATUS='Work in progress' And pmanager <> " + adminid + " and createdby =" + userId + " order by priority asc";
                     issueid = query_fun(sql);

                } else if (sort_method.equalsIgnoreCase("headerSortUp")) {

                    sql = "select i.issueid, pname as project,module, subject, severity, priority, type, createdon, due_date, modifiedon, description, createdby, assignedto, s.status,ceil(to_number(sysdate-to_date(createdon)))as age  from project p, issue i, issuestatus s,modules m where i.issueid = s.issueid and i.pid = p.pid and i.module_id=m.moduleid and s.status != 'Closed' and p.STATUS='Work in progress' And pmanager <> " + adminid + " and createdby =" + userId + " order by priority desc";
                     issueid = query_fun(sql);

                }

            } else if (sorton.equalsIgnoreCase("Project")) {
                if (sort_method.equalsIgnoreCase("headerSortDown")) {

                    sql = "select i.issueid, pname as project,module, subject, severity, priority, type, createdon, due_date, modifiedon, description, createdby, assignedto, s.status,ceil(to_number(sysdate-to_date(createdon)))as age  from project p, issue i, issuestatus s,modules m where i.issueid = s.issueid and i.pid = p.pid and i.module_id=m.moduleid and s.status != 'Closed' and p.STATUS='Work in progress' And pmanager <> " + adminid + " and createdby =" + userId + " order by Lower(project) asc";
                     issueid = query_fun(sql);

                } else if (sort_method.equalsIgnoreCase("headerSortUp")) {

                    sql = "select i.issueid, pname as project,module, subject, severity, priority, type, createdon, due_date, modifiedon, description, createdby, assignedto, s.status,ceil(to_number(sysdate-to_date(createdon)))as age  from project p, issue i, issuestatus s,modules m where i.issueid = s.issueid and i.pid = p.pid and i.module_id=m.moduleid and s.status != 'Closed' and p.STATUS='Work in progress' And pmanager <> " + adminid + " and createdby =" + userId + " order by Lower(project) desc";
                     issueid = query_fun(sql);
                }
            } else if (sorton.equalsIgnoreCase("S")) {
                if (sort_method.equalsIgnoreCase("headerSortDown")) {

                    sql = "select i.issueid, pname as project,module, subject, severity, priority, type, createdon, due_date, modifiedon, description, createdby, assignedto, s.status,ceil(to_number(sysdate-to_date(createdon)))as age  from project p, issue i, issuestatus s,modules m where i.issueid = s.issueid and i.pid = p.pid and i.module_id=m.moduleid and s.status != 'Closed' and p.STATUS='Work in progress' And pmanager <> " + adminid + " and createdby =" + userId + " order by severity asc";
                     issueid = query_fun(sql);

                } else if (sort_method.equalsIgnoreCase("headerSortUp")) {

                    sql = "select i.issueid, pname as project,module, subject, severity, priority, type, createdon, due_date, modifiedon, description, createdby, assignedto, s.status,ceil(to_number(sysdate-to_date(createdon)))as age  from project p, issue i, issuestatus s,modules m where i.issueid = s.issueid and i.pid = p.pid and i.module_id=m.moduleid and s.status != 'Closed' and p.STATUS='Work in progress' And pmanager <> " + adminid + " and createdby =" + userId + " order by severity desc";
                     issueid = query_fun(sql);

                }
            } else if (sorton.equalsIgnoreCase("Age")) {
                if (sort_method.equalsIgnoreCase("headerSortDown")) {

                    sql = "select i.issueid, pname as project,module, subject, severity, priority, type, createdon, due_date, modifiedon, description, createdby, assignedto, s.status,ceil(to_number(sysdate-to_date(createdon)))as age  from project p, issue i, issuestatus s,modules m where i.issueid = s.issueid and i.pid = p.pid and i.module_id=m.moduleid and s.status != 'Closed' and p.STATUS='Work in progress' And pmanager <> " + adminid + " and createdby =" + userId + " order by age asc";
                     issueid = query_fun(sql);

                } else if (sort_method.equalsIgnoreCase("headerSortUp")) {

                    sql = "select i.issueid, pname as project,module, subject, severity, priority, type, createdon, due_date, modifiedon, description, createdby, assignedto, s.status,ceil(to_number(sysdate-to_date(createdon)))as age  from project p, issue i, issuestatus s,modules m where i.issueid = s.issueid and i.pid = p.pid and i.module_id=m.moduleid and s.status != 'Closed' and p.STATUS='Work in progress' And pmanager <> " + adminid + " and createdby =" + userId + " order by age desc";
                     issueid = query_fun(sql);

                }
            } else if (sorton.equalsIgnoreCase("Module")) {
                if (sort_method.equalsIgnoreCase("headerSortDown")) {

                    sql = "select i.issueid, pname as project,module, subject, severity, priority, type, createdon, due_date, modifiedon, description, createdby, assignedto, s.status,ceil(to_number(sysdate-to_date(createdon)))as age  from project p, issue i, issuestatus s,modules m where i.issueid = s.issueid and i.pid = p.pid and i.module_id=m.moduleid and s.status != 'Closed' and p.STATUS='Work in progress' And pmanager <> " + adminid + " and createdby =" + userId + " order by Lower(module) asc";
                     issueid = query_fun(sql);

                } else if (sort_method.equalsIgnoreCase("headerSortUp")) {

                    sql = "select i.issueid, pname as project,module, subject, severity, priority, type, createdon, due_date, modifiedon, description, createdby, assignedto, s.status,ceil(to_number(sysdate-to_date(createdon)))as age  from project p, issue i, issuestatus s,modules m where i.issueid = s.issueid and i.pid = p.pid and i.module_id=m.moduleid and s.status != 'Closed' and p.STATUS='Work in progress' And pmanager <> " + adminid + " and createdby =" + userId + " order by Lower(module) desc";
                     issueid = query_fun(sql);

                }
            } else if (sorton.equalsIgnoreCase("Subject")) {
                if (sort_method.equalsIgnoreCase("headerSortDown")) {

                    sql = "select i.issueid, pname as project,module, subject, severity, priority, type, createdon, due_date, modifiedon, description, createdby, assignedto, s.status,ceil(to_number(sysdate-to_date(createdon)))as age  from project p, issue i, issuestatus s,modules m where i.issueid = s.issueid and i.pid = p.pid and i.module_id=m.moduleid and s.status != 'Closed' and p.STATUS='Work in progress' And pmanager <> " + adminid + " and createdby =" + userId + " order by Lower(subject) asc";
                     issueid = query_fun(sql);

                } else if (sort_method.equalsIgnoreCase("headerSortUp")) {

                    sql = "select i.issueid, pname as project,module, subject, severity, priority, type, createdon, due_date, modifiedon, description, createdby, assignedto, s.status,ceil(to_number(sysdate-to_date(createdon)))as age  from project p, issue i, issuestatus s,modules m where i.issueid = s.issueid and i.pid = p.pid and i.module_id=m.moduleid and s.status != 'Closed' and p.STATUS='Work in progress' And pmanager <> " + adminid + " and createdby =" + userId + " order by Lower(subject) desc";
                     issueid = query_fun(sql);

                }
            } else if (sorton.equalsIgnoreCase("Status")) {
                if (sort_method.equalsIgnoreCase("headerSortDown")) {

                    sql = "select i.issueid, pname as project,module, subject, severity, priority, type, createdon, due_date, modifiedon, description, createdby, assignedto, s.status,ceil(to_number(sysdate-to_date(createdon)))as age  from project p, issue i, issuestatus s,modules m where i.issueid = s.issueid and i.pid = p.pid and i.module_id=m.moduleid and s.status != 'Closed' and p.STATUS='Work in progress' And pmanager <> " + adminid + " and createdby =" + userId + " order by status asc";
                     issueid = query_fun(sql);

                } else if (sort_method.equalsIgnoreCase("headerSortUp")) {

                    sql = "select i.issueid, pname as project,module, subject, severity, priority, type, createdon, due_date, modifiedon, description, createdby, assignedto, s.status,ceil(to_number(sysdate-to_date(createdon)))as age  from project p, issue i, issuestatus s,modules m where i.issueid = s.issueid and i.pid = p.pid and i.module_id=m.moduleid and s.status != 'Closed' and p.STATUS='Work in progress' And pmanager <> " + adminid + " and createdby =" + userId + " order by status desc";
                     issueid = query_fun(sql);

                }
            } else if (sorton.equalsIgnoreCase("Due Date")) {
                if (sort_method.equalsIgnoreCase("headerSortDown")) {

                    sql = "select i.issueid, pname as project,module, subject, severity, priority, type, createdon, due_date, modifiedon, description, createdby, assignedto, s.status,ceil(to_number(sysdate-to_date(createdon)))as age  from project p, issue i, issuestatus s,modules m where i.issueid = s.issueid and i.pid = p.pid and i.module_id=m.moduleid and s.status != 'Closed' and p.STATUS='Work in progress' And pmanager <> " + adminid + " and createdby =" + userId + " order by due_date asc";
                     issueid = query_fun(sql);

                } else if (sort_method.equalsIgnoreCase("headerSortUp")) {

                    sql = "select i.issueid, pname as project,module, subject, severity, priority, type, createdon, due_date, modifiedon, description, createdby, assignedto, s.status,ceil(to_number(sysdate-to_date(createdon)))as age  from project p, issue i, issuestatus s,modules m where i.issueid = s.issueid and i.pid = p.pid and i.module_id=m.moduleid and s.status != 'Closed' and p.STATUS='Work in progress' And pmanager <> " + adminid + " and createdby =" + userId + " order by due_date desc";
                     issueid = query_fun(sql);

                }
            } else if (sorton.equalsIgnoreCase("AssignedTo")) {
                if (sort_method.equalsIgnoreCase("headerSortDown")) {

                    sql = "select i.issueid, pname as project,module, subject, severity, priority, type, createdon, due_date, modifiedon, description, createdby, assignedto, s.status,ceil(to_number(sysdate-to_date(createdon)))as age  from project p, issue i, issuestatus s,modules m where i.issueid = s.issueid and i.pid = p.pid and i.module_id=m.moduleid and s.status != 'Closed' and p.STATUS='Work in progress' And pmanager <> " + adminid + " and createdby =" + userId + " order by (select LOWER(firstname) from users where userid=assignedto) asc";
                     issueid = query_fun(sql);

                } else if (sort_method.equalsIgnoreCase("headerSortUp")) {

                    sql = "select i.issueid, pname as project,module, subject, severity, priority, type, createdon, due_date, modifiedon, description, createdby, assignedto, s.status,ceil(to_number(sysdate-to_date(createdon)))as age  from project p, issue i, issuestatus s,modules m where i.issueid = s.issueid and i.pid = p.pid and i.module_id=m.moduleid and s.status != 'Closed' and p.STATUS='Work in progress' And pmanager <> " + adminid + " and createdby =" + userId + " order by (select LOWER(firstname) from users where userid=assignedto) desc";
                     issueid = query_fun(sql);

                }
            } else if (sorton.equalsIgnoreCase("Refer")) {

                if (sort_method.equalsIgnoreCase("headerSortDown")) {
                    sql = "select i.issueid, pname as project,module, subject, severity, priority, type, createdon, due_date, modifiedon, description, createdby, assignedto, s.status,ceil(to_number(sysdate-to_date(createdon)))as age  from project p, issue i, issuestatus s,modules m where i.issueid = s.issueid and i.pid = p.pid and i.module_id=m.moduleid and s.status != 'Closed' and p.STATUS='Work in progress' And pmanager <> " + adminid + " and createdby =" + userId + " order by (select count(*) from fileattach where issueid=i.issueid) asc";
                     issueid = query_fun(sql);

                } else if (sort_method.equalsIgnoreCase("headerSortUp")) {
                    sql = "select i.issueid, pname as project,module, subject, severity, priority, type, createdon, due_date, modifiedon, description, createdby, assignedto, s.status,ceil(to_number(sysdate-to_date(createdon)))as age  from project p, issue i, issuestatus s,modules m where i.issueid = s.issueid and i.pid = p.pid and i.module_id=m.moduleid and s.status != 'Closed' and p.STATUS='Work in progress' And pmanager <> " + adminid + " and createdby =" + userId + " order by (select count(*) from fileattach where issueid=i.issueid) desc";
                     issueid = query_fun(sql);

                }

            }

        } else if (userin.equalsIgnoreCase("MyAssignment")) {

            if (sorton.equalsIgnoreCase("Issue No")) {
                if (sort_method.equalsIgnoreCase("headerSortDown")) {

                    sql = "select i.issueid, pname as project,module, subject, severity, priority, type, createdon, due_date, modifiedon, description, createdby, assignedto, s.status,ceil(to_number(sysdate-to_date(createdon)))as age  from project p, issue i, issuestatus s,modules m where i.issueid = s.issueid and i.pid = p.pid and i.module_id=m.moduleid and m.pid = p.pid and s.status != 'Closed' and assignedto =" + userId + "  order by  issueid asc";
                     issueid = query_fun(sql);

                } else if (sort_method.equalsIgnoreCase("headerSortUp")) {

                    sql = "select i.issueid, pname as project,module, subject, severity, priority, type, createdon, due_date, modifiedon, description, createdby, assignedto, s.status,ceil(to_number(sysdate-to_date(createdon)))as age  from project p, issue i, issuestatus s,modules m where i.issueid = s.issueid and i.pid = p.pid and i.module_id=m.moduleid and m.pid = p.pid and s.status != 'Closed' and assignedto =" + userId + "  order by  issueid desc";
                     issueid = query_fun(sql);

                }

            } else if (sorton.equalsIgnoreCase("P")) {
                if (sort_method.equalsIgnoreCase("headerSortDown")) {

                    sql = "select i.issueid, pname as project,module, subject, severity, priority, type, createdon, due_date, modifiedon, description, createdby, assignedto, s.status,ceil(to_number(sysdate-to_date(createdon)))as age  from project p, issue i, issuestatus s,modules m where i.issueid = s.issueid and i.pid = p.pid and i.module_id=m.moduleid and m.pid = p.pid and s.status != 'Closed' and assignedto =" + userId + "  order by  priority asc";
                     issueid = query_fun(sql);

                } else if (sort_method.equalsIgnoreCase("headerSortUp")) {

                    sql = "select i.issueid, pname as project,module, subject, severity, priority, type, createdon, due_date, modifiedon, description, createdby, assignedto, s.status,ceil(to_number(sysdate-to_date(createdon)))as age  from project p, issue i, issuestatus s,modules m where i.issueid = s.issueid and i.pid = p.pid and i.module_id=m.moduleid and m.pid = p.pid and s.status != 'Closed' and assignedto =" + userId + "  order by  priority desc";
                     issueid = query_fun(sql);

                }

            } else if (sorton.equalsIgnoreCase("Project")) {
                if (sort_method.equalsIgnoreCase("headerSortDown")) {

                    sql = "select i.issueid, pname as project,module, subject, severity, priority, type, createdon, due_date, modifiedon, description, createdby, assignedto, s.status,ceil(to_number(sysdate-to_date(createdon)))as age  from project p, issue i, issuestatus s,modules m where i.issueid = s.issueid and i.pid = p.pid and i.module_id=m.moduleid and m.pid = p.pid and s.status != 'Closed' and assignedto =" + userId + "  order by  Lower(project) asc";
                     issueid = query_fun(sql);

                } else if (sort_method.equalsIgnoreCase("headerSortUp")) {

                    sql = "select i.issueid, pname as project,module, subject, severity, priority, type, createdon, due_date, modifiedon, description, createdby, assignedto, s.status,ceil(to_number(sysdate-to_date(createdon)))as age  from project p, issue i, issuestatus s,modules m where i.issueid = s.issueid and i.pid = p.pid and i.module_id=m.moduleid and m.pid = p.pid and s.status != 'Closed' and assignedto =" + userId + "  order by  Lower(project) desc";
                     issueid = query_fun(sql);

                }
            } else if (sorton.equalsIgnoreCase("S")) {
                if (sort_method.equalsIgnoreCase("headerSortDown")) {

                    sql = "select i.issueid, pname as project,module, subject, severity, priority, type, createdon, due_date, modifiedon, description, createdby, assignedto, s.status,ceil(to_number(sysdate-to_date(createdon)))as age  from project p, issue i, issuestatus s,modules m where i.issueid = s.issueid and i.pid = p.pid and i.module_id=m.moduleid and m.pid = p.pid and s.status != 'Closed' and assignedto =" + userId + "  order by  severity asc";
                     issueid = query_fun(sql);

                } else if (sort_method.equalsIgnoreCase("headerSortUp")) {

                    sql = "select i.issueid, pname as project,module, subject, severity, priority, type, createdon, due_date, modifiedon, description, createdby, assignedto, s.status,ceil(to_number(sysdate-to_date(createdon)))as age  from project p, issue i, issuestatus s,modules m where i.issueid = s.issueid and i.pid = p.pid and i.module_id=m.moduleid and m.pid = p.pid and s.status != 'Closed' and assignedto =" + userId + "  order by  severity desc";
                     issueid = query_fun(sql);

                }
            } else if (sorton.equalsIgnoreCase("Age")) {
                if (sort_method.equalsIgnoreCase("headerSortDown")) {

                    sql = "select i.issueid, pname as project,module, subject, severity, priority, type, createdon, due_date, modifiedon, description, createdby, assignedto, s.status,ceil(to_number(sysdate-to_date(createdon)))as age  from project p, issue i, issuestatus s,modules m where i.issueid = s.issueid and i.pid = p.pid and i.module_id=m.moduleid and m.pid = p.pid and s.status != 'Closed' and assignedto =" + userId + "  order by  age asc";
                     issueid = query_fun(sql);

                } else if (sort_method.equalsIgnoreCase("headerSortUp")) {

                    sql = "select i.issueid, pname as project,module, subject, severity, priority, type, createdon, due_date, modifiedon, description, createdby, assignedto, s.status,ceil(to_number(sysdate-to_date(createdon)))as age  from project p, issue i, issuestatus s,modules m where i.issueid = s.issueid and i.pid = p.pid and i.module_id=m.moduleid and m.pid = p.pid and s.status != 'Closed' and assignedto =" + userId + "  order by  age desc";
                     issueid = query_fun(sql);

                }
            } else if (sorton.equalsIgnoreCase("Module")) {
                if (sort_method.equalsIgnoreCase("headerSortDown")) {

                    sql = "select i.issueid, pname as project,module, subject, severity, priority, type, createdon, due_date, modifiedon, description, createdby, assignedto, s.status,ceil(to_number(sysdate-to_date(createdon)))as age  from project p, issue i, issuestatus s,modules m where i.issueid = s.issueid and i.pid = p.pid and i.module_id=m.moduleid and m.pid = p.pid and s.status != 'Closed' and assignedto =" + userId + "  order by  Lower(module) asc";
                     issueid = query_fun(sql);

                } else if (sort_method.equalsIgnoreCase("headerSortUp")) {

                    sql = "select i.issueid, pname as project,module, subject, severity, priority, type, createdon, due_date, modifiedon, description, createdby, assignedto, s.status,ceil(to_number(sysdate-to_date(createdon)))as age  from project p, issue i, issuestatus s,modules m where i.issueid = s.issueid and i.pid = p.pid and i.module_id=m.moduleid and m.pid = p.pid and s.status != 'Closed' and assignedto =" + userId + "  order by  Lower(module) desc";
                     issueid = query_fun(sql);

                }
            } else if (sorton.equalsIgnoreCase("Subject")) {
                if (sort_method.equalsIgnoreCase("headerSortDown")) {

                    sql = "select i.issueid, pname as project,module, subject, severity, priority, type, createdon, due_date, modifiedon, description, createdby, assignedto, s.status,ceil(to_number(sysdate-to_date(createdon)))as age  from project p, issue i, issuestatus s,modules m where i.issueid = s.issueid and i.pid = p.pid and i.module_id=m.moduleid and m.pid = p.pid and s.status != 'Closed' and assignedto =" + userId + "  order by  Lower(subject) asc";
                     issueid = query_fun(sql);

                } else if (sort_method.equalsIgnoreCase("headerSortUp")) {

                    sql = "select i.issueid, pname as project,module, subject, severity, priority, type, createdon, due_date, modifiedon, description, createdby, assignedto, s.status,ceil(to_number(sysdate-to_date(createdon)))as age  from project p, issue i, issuestatus s,modules m where i.issueid = s.issueid and i.pid = p.pid and i.module_id=m.moduleid and m.pid = p.pid and s.status != 'Closed' and assignedto =" + userId + "  order by  Lower(subject) desc";
                     issueid = query_fun(sql);

                }
            } else if (sorton.equalsIgnoreCase("Status")) {
                if (sort_method.equalsIgnoreCase("headerSortDown")) {

                    sql = "select i.issueid, pname as project,module, subject, severity, priority, type, createdon, due_date, modifiedon, description, createdby, assignedto, s.status,ceil(to_number(sysdate-to_date(createdon)))as age  from project p, issue i, issuestatus s,modules m where i.issueid = s.issueid and i.pid = p.pid and i.module_id=m.moduleid and m.pid = p.pid and s.status != 'Closed' and assignedto =" + userId + "  order by status asc";
                     issueid = query_fun(sql);

                } else if (sort_method.equalsIgnoreCase("headerSortUp")) {

                    sql = "select i.issueid, pname as project,module, subject, severity, priority, type, createdon, due_date, modifiedon, description, createdby, assignedto, s.status,ceil(to_number(sysdate-to_date(createdon)))as age  from project p, issue i, issuestatus s,modules m where i.issueid = s.issueid and i.pid = p.pid and i.module_id=m.moduleid and m.pid = p.pid and s.status != 'Closed' and assignedto =" + userId + "  order by status desc";
                     issueid = query_fun(sql);

                }
            } else if (sorton.equalsIgnoreCase("Due Date")) {
                if (sort_method.equalsIgnoreCase("headerSortDown")) {

                    sql = "select i.issueid, pname as project,module, subject, severity, priority, type, createdon, due_date, modifiedon, description, createdby, assignedto, s.status,ceil(to_number(sysdate-to_date(createdon)))as age  from project p, issue i, issuestatus s,modules m where i.issueid = s.issueid and i.pid = p.pid and i.module_id=m.moduleid and m.pid = p.pid and s.status != 'Closed' and assignedto =" + userId + "  order by due_date asc";
                     issueid = query_fun(sql);

                } else if (sort_method.equalsIgnoreCase("headerSortUp")) {

                    sql = "select i.issueid, pname as project,module, subject, severity, priority, type, createdon, due_date, modifiedon, description, createdby, assignedto, s.status,ceil(to_number(sysdate-to_date(createdon)))as age  from project p, issue i, issuestatus s,modules m where i.issueid = s.issueid and i.pid = p.pid and i.module_id=m.moduleid and m.pid = p.pid and s.status != 'Closed' and assignedto =" + userId + "  order by due_date desc";
                     issueid = query_fun(sql);

                }
            } else if (sorton.equalsIgnoreCase("Created By")) {

                if (sort_method.equalsIgnoreCase("headerSortDown")) {

                    sql = "select i.issueid, pname as project,module, subject, severity, priority, type, createdon, due_date, modifiedon, description, createdby, assignedto, s.status,ceil(to_number(sysdate-to_date(createdon)))as age  from project p, issue i, issuestatus s,modules m where i.issueid = s.issueid and i.pid = p.pid and i.module_id=m.moduleid and m.pid = p.pid and s.status != 'Closed' and assignedto =" + userId + "  order by (select LOWER(firstname) from users where userid=createdby) asc";
                     issueid = query_fun(sql);

                } else if (sort_method.equalsIgnoreCase("headerSortUp")) {

                    sql = "select i.issueid, pname as project,module, subject, severity, priority, type, createdon, due_date, modifiedon, description, createdby, assignedto, s.status,ceil(to_number(sysdate-to_date(createdon)))as age  from project p, issue i, issuestatus s,modules m where i.issueid = s.issueid and i.pid = p.pid and i.module_id=m.moduleid and m.pid = p.pid and s.status != 'Closed' and assignedto =" + userId + "  order by (select LOWER(firstname) from users where userid=createdby) desc";
                     issueid = query_fun(sql);

                }
            } else if (sorton.equalsIgnoreCase("Refer")) {

                if (sort_method.equalsIgnoreCase("headerSortDown")) {
                    sql = "select i.issueid, pname as project,module, subject, severity, priority, type, createdon, due_date, modifiedon, description, createdby, assignedto, s.status,ceil(to_number(sysdate-to_date(createdon)))as age  from project p, issue i, issuestatus s,modules m where i.issueid = s.issueid and i.pid = p.pid and i.module_id=m.moduleid and m.pid = p.pid and s.status != 'Closed' and assignedto =" + userId + " order by (select count(*) from fileattach where issueid=i.issueid) asc";
                     issueid = query_fun(sql);

                } else if (sort_method.equalsIgnoreCase("headerSortUp")) {
                    sql = "select i.issueid, pname as project,module, subject, severity, priority, type, createdon, due_date, modifiedon, description, createdby, assignedto, s.status,ceil(to_number(sysdate-to_date(createdon)))as age  from project p, issue i, issuestatus s,modules m where i.issueid = s.issueid and i.pid = p.pid and i.module_id=m.moduleid and m.pid = p.pid and s.status != 'Closed' and assignedto =" + userId + " order by (select count(*) from fileattach where issueid=i.issueid) desc";
                     issueid = query_fun(sql);

                }

            }

        } else if (userin.equalsIgnoreCase("MyViews")) {

            int index = query_string_view.indexOf("order by");
            query_string_view = query_string_view.substring(0, index);
            if (sorton.equalsIgnoreCase("Issue No")) {
                if (sort_method.equalsIgnoreCase("headerSortDown")) {

                     issueid = query_fun(query_string_view + " order by issueid asc");

                } else if (sort_method.equalsIgnoreCase("headerSortUp")) {

                     issueid = query_fun(query_string_view + " order by  issueid desc");

                }

            } else if (sorton.equalsIgnoreCase("P")) {
                if (sort_method.equalsIgnoreCase("headerSortDown")) {

                     issueid = query_fun(query_string_view + " order by  priority asc");

                } else if (sort_method.equalsIgnoreCase("headerSortUp")) {

                     issueid = query_fun(query_string_view + " order by  priority desc");

                }

            } else if (sorton.equalsIgnoreCase("Project")) {
                if (sort_method.equalsIgnoreCase("headerSortDown")) {

                     issueid = query_fun(query_string_view + " order by LOWER(project) asc");

                } else if (sort_method.equalsIgnoreCase("headerSortUp")) {

                     issueid = query_fun(query_string_view + " order by LOWER(project) desc");

                }
            } else if (sorton.equalsIgnoreCase("S")) {
                if (sort_method.equalsIgnoreCase("headerSortDown")) {

                     issueid = query_fun(query_string_view + " order by severity  asc");

                } else if (sort_method.equalsIgnoreCase("headerSortUp")) {

                     issueid = query_fun(query_string_view + " order by severity  desc");

                }
            } else if (sorton.equalsIgnoreCase("Age")) {
                if (sort_method.equalsIgnoreCase("headerSortDown")) {

                     issueid = query_fun(query_string_view + " order by age  asc");

                } else if (sort_method.equalsIgnoreCase("headerSortUp")) {

                     issueid = query_fun(query_string_view + " order by age  desc");

                }
            } else if (sorton.equalsIgnoreCase("Module")) {
                if (sort_method.equalsIgnoreCase("headerSortDown")) {

                     issueid = query_fun(query_string_view + " order by  Lower(module) asc");

                } else if (sort_method.equalsIgnoreCase("headerSortUp")) {

                     issueid = query_fun(query_string_view + " order by  Lower(module) desc");

                }
            } else if (sorton.equalsIgnoreCase("Subject")) {
                if (sort_method.equalsIgnoreCase("headerSortDown")) {

                     issueid = query_fun(query_string_view + " order by  Lower(subject) asc");

                } else if (sort_method.equalsIgnoreCase("headerSortUp")) {

                     issueid = query_fun(query_string_view + " order by  Lower(subject) desc");

                }
            } else if (sorton.equalsIgnoreCase("Status")) {
                if (sort_method.equalsIgnoreCase("headerSortDown")) {

                     issueid = query_fun(query_string_view + " order by  status asc");

                } else if (sort_method.equalsIgnoreCase("headerSortUp")) {

                     issueid = query_fun(query_string_view + " order by  status desc");

                }
            } else if (sorton.equalsIgnoreCase("Due Date")) {
                if (sort_method.equalsIgnoreCase("headerSortDown")) {

                     issueid = query_fun(query_string_view + " order by  due_date asc");

                } else if (sort_method.equalsIgnoreCase("headerSortUp")) {

                     issueid = query_fun(query_string_view + " order by  due_date desc");

                }
            } else if (sorton.equalsIgnoreCase("AssignedTo")) {

                if (sort_method.equalsIgnoreCase("headerSortDown")) {

                     issueid = query_fun(query_string_view + " order by  (select LOWER(firstname) from users where userid=assignedto) asc");

                } else if (sort_method.equalsIgnoreCase("headerSortUp")) {

                     issueid = query_fun(query_string_view + " order by  (select LOWER(firstname) from users where userid=assignedto) desc");

                }
            } else if (sorton.equalsIgnoreCase("Refer")) {

                if (sort_method.equalsIgnoreCase("headerSortDown")) {

                     issueid = query_fun(query_string_view + " order by (select count(*) from fileattach where issueid=i.issueid) asc");

                } else if (sort_method.equalsIgnoreCase("headerSortUp")) {

                     issueid = query_fun(query_string_view + " order by (select count(*) from fileattach where issueid=i.issueid) desc");

                }

            }

        } else if (userin.equalsIgnoreCase("MyDashboard")) {
            String userId1 = (String) request.getSession().getAttribute("selectedUser");

            if (userId != 104) {
                sql = "select i.issueid, pname as project, module, subject, description, severity, type, createdon, due_date, modifiedon, createdby, assignedto, s.status  from issue i, issuestatus s, project p,modules m where i.issueid = s.issueid and i.module_id=m.moduleid and s.status ='" + status + "' and assignedto ='" + userId1 + "' and priority ='" + priority + "' and i.pid = p.pid order by ";
            } else {
                sql = "select i.issueid, pname as project, module, subject, description, severity, type, createdon, due_date, modifiedon, createdby, assignedto, s.status  from issue i, issuestatus s, project p,modules m where i.issueid = s.issueid and i.module_id=m.moduleid and s.status ='" + status + "' and assignedto ='" + userId + "' and priority = '" + priority + "'  and i.pid = p.pid and i.pid in (select u.pid from userproject u where u.userid='" + userId + "' intersect select k.pid from userproject k where k.userid='" + userId1 + "') order by";
            }

            if (sorton.equalsIgnoreCase("Issue No")) {
                if (sort_method.equalsIgnoreCase("headerSortDown")) {

                     issueid = query_fun(sql + " issueid asc");

                } else if (sort_method.equalsIgnoreCase("headerSortUp")) {

                     issueid = query_fun(sql + " issueid desc");

                }

            } else if (sorton.equalsIgnoreCase("P")) {
                if (sort_method.equalsIgnoreCase("headerSortDown")) {

                     issueid = query_fun(sql + "  priority asc");

                } else if (sort_method.equalsIgnoreCase("headerSortUp")) {

                     issueid = query_fun(sql + "  priority desc");

                }

            } else if (sorton.equalsIgnoreCase("Project")) {
                if (sort_method.equalsIgnoreCase("headerSortDown")) {

                     issueid = query_fun(sql + " LOWER(project) asc");

                } else if (sort_method.equalsIgnoreCase("headerSortUp")) {

                     issueid = query_fun(sql + " LOWER(project) desc");

                }
            } else if (sorton.equalsIgnoreCase("S")) {
                if (sort_method.equalsIgnoreCase("headerSortDown")) {

                     issueid = query_fun(sql + " severity  asc");

                } else if (sort_method.equalsIgnoreCase("headerSortUp")) {

                     issueid = query_fun(sql + " severity  desc");

                }
            } else if (sorton.equalsIgnoreCase("Age")) {
                if (sort_method.equalsIgnoreCase("headerSortDown")) {

                    //sql = "select i.issueid, pname as project,module, subject, severity, priority, type, createdon, due_date, modifiedon, description, createdby, assignedto, s.status,ceil(to_number(sysdate-to_date(createdon)))as age  from project p, issue i, issuestatus s,modules m where i.issueid = s.issueid and i.pid = p.pid and i.module_id=m.moduleid and m.pid = p.pid and s.status != 'Closed' and assignedto =" + userId + "  order by  age asc";
                     issueid = query_fun(sql + " age  asc");

                } else if (sort_method.equalsIgnoreCase("headerSortUp")) {

                     issueid = query_fun(sql + " age  desc");

                }
            } else if (sorton.equalsIgnoreCase("Module")) {
                if (sort_method.equalsIgnoreCase("headerSortDown")) {

                     issueid = query_fun(sql + "  Lower(module) asc");

                } else if (sort_method.equalsIgnoreCase("headerSortUp")) {

                     issueid = query_fun(sql + "  Lower(module) desc");

                }
            } else if (sorton.equalsIgnoreCase("Subject")) {
                if (sort_method.equalsIgnoreCase("headerSortDown")) {

                     issueid = query_fun(sql + "  Lower(subject) asc");

                } else if (sort_method.equalsIgnoreCase("headerSortUp")) {

                     issueid = query_fun(sql + "  Lower(subject) desc");

                }
            } else if (sorton.equalsIgnoreCase("Status")) {
                if (sort_method.equalsIgnoreCase("headerSortDown")) {

                     issueid = query_fun(sql + "  status asc");

                } else if (sort_method.equalsIgnoreCase("headerSortUp")) {

                     issueid = query_fun(sql + "  status desc");

                }
            } else if (sorton.equalsIgnoreCase("Due Date")) {
                if (sort_method.equalsIgnoreCase("headerSortDown")) {

                     issueid = query_fun(sql + "  due_date asc");

                } else if (sort_method.equalsIgnoreCase("headerSortUp")) {

                     issueid = query_fun(sql + "  due_date desc");

                }
            } else if (sorton.equalsIgnoreCase("Created By")) {

                if (sort_method.equalsIgnoreCase("headerSortDown")) {

                     issueid = query_fun(sql + " (select LOWER(firstname) from users where userid=createdby) asc");

                } else if (sort_method.equalsIgnoreCase("headerSortUp")) {

                     issueid = query_fun(sql + " (select LOWER(firstname) from users where userid=createdby) desc");

                }
            } else if (sorton.equalsIgnoreCase("Refer")) {

                if (sort_method.equalsIgnoreCase("headerSortDown")) {

                     issueid = query_fun(sql + " (select count(*) from fileattach where issueid=i.issueid) asc");

                } else if (sort_method.equalsIgnoreCase("headerSortUp")) {

                     issueid = query_fun(sql + " (select count(*) from fileattach where issueid=i.issueid) desc");

                }

            } else if (sorton.equalsIgnoreCase("Modified On")) {

                if (sort_method.equalsIgnoreCase("headerSortDown")) {

                     issueid = query_fun(sql + " modifiedon asc");

                } else if (sort_method.equalsIgnoreCase("headerSortUp")) {

                     issueid = query_fun(sql + " modifiedon desc");

                }

            }

        } else if (userin.equalsIgnoreCase("MySearches")) {
            String query_string_view1 = (String) request.getSession().getAttribute("IssueSummaryQuery");
            int index = query_string_view1.indexOf("order by");
            query_string_view1 = query_string_view1.substring(0, index);

            if (sorton.equalsIgnoreCase("Issue No")) {
                if (sort_method.equalsIgnoreCase("headerSortDown")) {

                     issueid = query_fun(query_string_view1 + " order by issueid asc");

                } else if (sort_method.equalsIgnoreCase("headerSortUp")) {

                     issueid = query_fun(query_string_view1 + " order by issueid desc");

                }

            } else if (sorton.equalsIgnoreCase("P")) {
                if (sort_method.equalsIgnoreCase("headerSortDown")) {

                     issueid = query_fun(query_string_view1 + " order by priority acs");

                } else if (sort_method.equalsIgnoreCase("headerSortUp")) {

                     issueid = query_fun(query_string_view1 + " order by priority desc");

                }

            } else if (sorton.equalsIgnoreCase("Project")) {
                if (sort_method.equalsIgnoreCase("headerSortDown")) {

                     issueid = query_fun(query_string_view1 + " order by Lower(project) asc");

                } else if (sort_method.equalsIgnoreCase("headerSortUp")) {

                     issueid = query_fun(query_string_view1 + " order by Lower(project) desc");
                }
            } else if (sorton.equalsIgnoreCase("S")) {
                if (sort_method.equalsIgnoreCase("headerSortDown")) {

                     issueid = query_fun(query_string_view1 + " oreder by severity asc");

                } else if (sort_method.equalsIgnoreCase("headerSortUp")) {

                     issueid = query_fun(query_string_view1 + " order by severity desc");

                }
            } else if (sorton.equalsIgnoreCase("Age")) {
                if (sort_method.equalsIgnoreCase("headerSortDown")) {

                     issueid = query_fun(query_string_view1 + " order by age asc");

                } else if (sort_method.equalsIgnoreCase("headerSortUp")) {

                     issueid = query_fun(query_string_view1 + " order by age desc");

                }
            } else if (sorton.equalsIgnoreCase("Module")) {
                if (sort_method.equalsIgnoreCase("headerSortDown")) {

                     issueid = query_fun(query_string_view1 + " order by LOWER(module) asc");

                } else if (sort_method.equalsIgnoreCase("headerSortUp")) {

                     issueid = query_fun(query_string_view1 + " order by LOWER(module) desc");

                }
            } else if (sorton.equalsIgnoreCase("Subject")) {
                if (sort_method.equalsIgnoreCase("headerSortDown")) {

                     issueid = query_fun(query_string_view1 + " order by LOWER(subject) asc");

                } else if (sort_method.equalsIgnoreCase("headerSortUp")) {

                     issueid = query_fun(query_string_view1 + " order by LOWER(subject) desc");

                }
            } else if (sorton.equalsIgnoreCase("Status")) {
                if (sort_method.equalsIgnoreCase("headerSortDown")) {

                     issueid = query_fun(query_string_view1 + " order by LOWER(status) asc");

                } else if (sort_method.equalsIgnoreCase("headerSortUp")) {

                     issueid = query_fun(query_string_view1 + " order by LOWER(status) desc");

                }
            } else if (sorton.equalsIgnoreCase("Due Date")) {
                if (sort_method.equalsIgnoreCase("headerSortDown")) {

                     issueid = query_fun(query_string_view1 + " order by due_date asc");

                } else if (sort_method.equalsIgnoreCase("headerSortUp")) {

                     issueid = query_fun(query_string_view1 + " order by due_date desc");

                }
            } else if (sorton.equalsIgnoreCase("AssignedTo")) {
                if (sort_method.equalsIgnoreCase("headerSortDown")) {

                     issueid = query_fun(query_string_view1 + " order by (select LOWER(firstname) from users where userid=assignedto) asc");

                } else if (sort_method.equalsIgnoreCase("headerSortUp")) {

                    // sql = "select i.issueid, pname as project,module, subject, severity, priority, type, createdon, due_date, modifiedon, description, createdby, assignedto, s.status,ceil(to_number(sysdate-to_date(createdon)))as age  from project p, issue i, issuestatus s,modules m where i.issueid = s.issueid and i.pid = p.pid and i.module_id=m.moduleid and s.status != 'Closed' and p.STATUS='Work in progress' And pmanager <> " + adminid + " and createdby =" + userId + " order by (select LOWER(firstname) from users where userid=assignedto) desc";
                     issueid = query_fun(query_string_view1 + " order by (select LOWER(firstname) from users where userid=assignedto) desc");

                }
            } else if (sorton.equalsIgnoreCase("Refer")) {

                if (sort_method.equalsIgnoreCase("headerSortDown")) {
                    //  sql = "select i.issueid, pname as project,module, subject, severity, priority, type, createdon, due_date, modifiedon, description, createdby, assignedto, s.status,ceil(to_number(sysdate-to_date(createdon)))as age  from project p, issue i, issuestatus s,modules m where i.issueid = s.issueid and i.pid = p.pid and i.module_id=m.moduleid and s.status != 'Closed' and p.STATUS='Work in progress' And pmanager <> " + adminid + " and createdby =" + userId + " order by (select count(*) from fileattach where issueid=i.issueid) asc";
                     issueid = query_fun(query_string_view1 + " order by (select count(*) from fileattach where issueid=i.issueid) asc");

                } else if (sort_method.equalsIgnoreCase("headerSortUp")) {
                    //   sql = "select i.issueid, pname as project,module, subject, severity, priority, type, createdon, due_date, modifiedon, description, createdby, assignedto, s.status,ceil(to_number(sysdate-to_date(createdon)))as age  from project p, issue i, issuestatus s,modules m where i.issueid = s.issueid and i.pid = p.pid and i.module_id=m.moduleid and s.status != 'Closed' and p.STATUS='Work in progress' And pmanager <> " + adminid + " and createdby =" + userId + " order by (select count(*) from fileattach where issueid=i.issueid) desc";
                     issueid = query_fun(query_string_view1 + " order by (select count(*) from fileattach where issueid=i.issueid) desc");

                }

            }

        }

        String IssueIds[] = issueid.split(",");
        for (int i = 0; i < IssueIds.length; i++) {
            if (IssueIds[i].equals(issueId)) {

                int index = i;
                if (IssueIds.length == 1) {
                    prev = IssueIds[index];
                    next = IssueIds[index];
                    position = "one";
                } else if (index == 0) {

                    prev = IssueIds[index];
                    next = IssueIds[index + 1];
                    position = "first";

                } else if (index == IssueIds.length - 1) {
                    prev = IssueIds[index - 1];
                    next = IssueIds[index];
                    position = "last";
                } else {
                    prev = IssueIds[index - 1];
                    next = IssueIds[index + 1];
                    position = "middle";
                }
            }
        }

        if (clickb != null) {
            if (clickb.equalsIgnoreCase("prev")) {

                issue = prev;

            } else if (clickb.equalsIgnoreCase("next")) {
                issue = next;

            }
        }

    }

    public String query_fun(String sql) throws Exception {

        Connection connection = null;

        ResultSet resultset = null;
        Statement statement = null;

        try {
            connection = MakeConnection.getConnection();
            statement = connection.createStatement();
            resultset = statement.executeQuery(sql);
            while (resultset.next()) {
                issueid = issueid + resultset.getString("issueid") + ",";

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
        return issueid;
    }

    public void witout_sort(HttpServletRequest request, HttpServletResponse response) throws Exception {
       

        int adminid = GetProjectMembers.getAdminID();
         userin = request.getParameter("userin");
         issueId = request.getParameter("issueid");
        userId = (Integer) request.getSession().getAttribute("userid_curr");
        String priority = request.getParameter("priority");
        String status = request.getParameter("status");
        String version = request.getParameter("version");
        String project = request.getParameter("project");

        String clickb = request.getParameter("clickb");

        if (userin.equalsIgnoreCase("MyIssues")) {

            String sql = "select i.issueid, pname as project,module, subject, severity, priority, type, createdon, due_date, modifiedon, description, createdby, assignedto, s.status,ceil(to_number(sysdate-to_date(createdon)))as age  from project p, issue i, issuestatus s,modules m where i.issueid = s.issueid and i.pid = p.pid and i.module_id=m.moduleid and s.status != 'Closed' and p.STATUS='Work in progress' And pmanager <>  " + adminid + "  and createdby =" + userId + " order by due_date asc, modifiedon asc, type asc, priority asc, severity asc, createdon asc";
             issueid = query_fun(sql);

        } else if (userin.equalsIgnoreCase("MyAssignment")) {
            String sql = "select i.issueid, pname as project,module, subject, severity, priority, type, createdon, due_date, modifiedon, description, createdby, assignedto, s.status,ceil(to_number(sysdate-to_date(createdon)))as age  from project p, issue i, issuestatus s,modules m where i.issueid = s.issueid and i.pid = p.pid and i.module_id=m.moduleid and m.pid = p.pid and s.status != 'Closed' and assignedto =" + userId + " order by due_date asc, modifiedon asc, type asc, priority asc, severity asc, createdon asc";
             issueid = query_fun(sql);
        } else if (userin.equalsIgnoreCase("MyViews")) {
             String query_string_view = (String) request.getSession().getAttribute("IssueSummaryQuery");
             issueid = query_fun(query_string_view);
        } else if (userin.equalsIgnoreCase("MyDashboard")) {
            String userId1 = (String) request.getSession().getAttribute("selectedUser");

            if (userId != 104) {
                 issueid = query_fun("select i.issueid, pname as project, module, subject, description, severity, type, createdon, due_date, modifiedon, createdby, assignedto, s.status  from issue i, issuestatus s, project p,modules m where i.issueid = s.issueid and i.module_id=m.moduleid and s.status ='" + status + "' and assignedto ='" + userId1 + "' and priority ='" + priority + "' and i.pid = p.pid order by due_date asc, modifiedon asc, type asc, priority asc, severity asc, createdon asc");
            } else {
                 issueid = query_fun("select i.issueid, pname as project, module, subject, description, severity, type, createdon, due_date, modifiedon, createdby, assignedto, s.status  from issue i, issuestatus s, project p,modules m where i.issueid = s.issueid and i.module_id=m.moduleid and s.status ='" + status + "' and assignedto ='" + userId + "' and priority = '" + priority + "'  and i.pid = p.pid and i.pid in (select u.pid from userproject u where u.userid='" + userId + "' intersect select k.pid from userproject k where k.userid='" + userId1 + "') order by due_date asc, modifiedon asc, type asc, priority asc, severity asc, createdon asc");
            }
        } else if (userin.equalsIgnoreCase("MySearches")) {
            String query_string_view1 = (String) request.getSession().getAttribute("IssueSummaryQuery");

             issueid = query_fun(query_string_view1);
        } else if (userin.equalsIgnoreCase("statusWise")) {
            

            if (project.contains(":")) {
                String projectversion[] = project.split(":");
                for (int i = 0; i < projectversion.length; i++) {
                    project = projectversion[0];
                    version = projectversion[1];
                }
            }
            issueid=query_fun("select i.issueid, pname as project,module, subject, description, severity, type, createdon,  due_date,  modifiedon, createdby, assignedto, s.status,ceil(to_number(sysdate-to_date(createdon)))as age  from issue i, issuestatus s, project p,modules m where i.issueid = s.issueid and i.module_id=m.moduleid and pname ='"+project+"'  and version ='"+version+"'  and priority ='"+priority+"' and s.status ='"+status+"' and p.pid = i.pid order by due_date asc, modifiedon asc, type asc, priority asc, severity asc, createdon asc");
   
        }

        String IssueIds[] = issueid.split(",");
        for (int i = 0; i < IssueIds.length; i++) {
            if (IssueIds[i].equals(issueId)) {

                int index = i;
                if (IssueIds.length == 1) {
                    prev = IssueIds[index];
                    next = IssueIds[index];
                    position = "one";
                } else if (index == 0) {
                    prev = IssueIds[index];
                    next = IssueIds[index + 1];
                    position = "first";

                } else if (index == IssueIds.length - 1) {
                    prev = IssueIds[index - 1];
                    next = IssueIds[index];
                    position = "last";
                } else {
                    prev = IssueIds[index - 1];
                    next = IssueIds[index + 1];
                    position = "middle";
                }
            }
        }

        if (clickb != null) {
            if (clickb.equalsIgnoreCase("prev")) {
                issue = prev;

            } else if (clickb.equalsIgnoreCase("next")) {
                issue = next;

            }
        }

    }

//Edit End by sowjanya
public static int parseInteger(String sInteger, int defaultValue) {

        try {
            return Integer.parseInt(sInteger);
        } catch (NumberFormatException nfe) {
            return defaultValue;
        }
    }

    public HashMap<Integer, String> getMember() {
        return member;
    }

    public void setMember(HashMap<Integer, String> member) {
        this.member = member;
    }

    public List<IssueFormBean> getIssuesList() {
        return issuesList;
    }

    public void setIssuesList(List<IssueFormBean> issuesList) {
        this.issuesList = issuesList;
    }

    public int getPageNo() {
        return pageNo;
    }

    public void setPageNo(int pageNo) {
        this.pageNo = pageNo;
    }

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    public String getIssueid() {
        return issueid;
    }

    public void setIssueid(String issueid) {
        this.issueid = issueid;
    }

    public String getIssue() {
        return issue;
    }

    public void setIssue(String issue) {
        this.issue = issue;
    }

    //Edit by sowjanya
    public String getPrev() {
        return prev;
    }

    public void setPrev(String prev) {
        this.prev = prev;
    }

    public String getNext() {
        return next;
    }

    public void setNext(String next) {
        this.next = next;
    }

    public String getSorton() {
        return sorton;
    }

    public void setSorton(String sorton) {
        this.sorton = sorton;
    }

    public String getUserin() {
        return userin;
    }

    public void setUserin(String userin) {
        this.userin = userin;
    }

    
    public String getPosition() {
        return position;
    }

    public void setPosition(String position) {
        this.position = position;
    }

}
