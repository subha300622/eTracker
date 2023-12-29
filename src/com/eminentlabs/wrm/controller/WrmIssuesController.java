/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eminentlabs.wrm.controller;

import com.eminent.holidays.Holidays;
import com.eminent.holidays.HolidaysUtil;
import com.eminent.issue.PlanStatus;
import com.eminent.issue.ProjectPlannedIssue;
import com.eminent.issue.formbean.IssueFormBean;
import com.eminent.issue.formbean.LastAssginForm;
import static com.eminent.issue.formbean.PlannedIssueReport.severityColor;
import com.eminent.util.GetAge;
import com.eminent.util.GetProjectMembers;
import com.eminent.util.IssueDetails;
import com.eminent.util.ProjectPlanUtil;
import com.eminentlabs.mom.MoMUtil;
import com.eminentlabs.mom.controller.MomMaintananceController;
import dashboard.CheckDate;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;
import javax.servlet.http.HttpServletRequest;
import pack.eminent.encryption.MakeConnection;

/**
 *
 * @author EMINENT
 */
public class WrmIssuesController {

    static org.apache.log4j.Logger logger = null;
    List<String> plannedIssues = new ArrayList();
    List<String> wrmTouchedIssues = new ArrayList();
    List<String> wrmTouchedIssueByCustomer = new ArrayList();
    List<String> wrmTouchedIssueByEspl = new ArrayList();
    List<IssueFormBean> wrmTouchedByEspl = new ArrayList();
    List<IssueFormBean> wrmTouchedByCustomer = new ArrayList();
    List<IssueFormBean> wrmUnTouchedByEspl = new ArrayList();
    List<IssueFormBean> wrmUnTouchedByCustomer = new ArrayList();
    Map<Integer, String> momProjects = new LinkedHashMap< Integer, String>();
    private String plannedFor;
    List<Integer> technicalHead = new ArrayList();
    List<Long> pids = new ArrayList<Long>();

    static {
        logger = org.apache.log4j.Logger.getLogger(WrmIssuesController.class.getName());
    }
    SimpleDateFormat sdf = new SimpleDateFormat("dd-MMM-yy");
    SimpleDateFormat dateConversion = new SimpleDateFormat("yyyy-MM-dd");

    public void setAll(HttpServletRequest request) throws SQLException, Exception {
        technicalHead = MoMUtil.findByTechnicalHead();
        HashMap<Integer, String> member = GetProjectMembers.showUsersSName();
        Connection connection = null;
        PreparedStatement ps = null;
        ResultSet resultSet = null;
        SimpleDateFormat sdfa = new SimpleDateFormat("dd-MM-yyyy");
        Calendar c = Calendar.getInstance();
        Date currentDate = c.getTime();
        Date date = c.getTime();
        String dateFor = sdfa.format(date);
        int adminid = GetProjectMembers.getAdminID();
        plannedFor = request.getParameter("plannedFor");
        String pid = request.getParameter("pid");
        if (pid != null) {
            if ("".equals(pid)) {
                pid = null;
            }
        }
        if (request.getMethod().equalsIgnoreCase("post")) {
            MomMaintananceController mmc = new MomMaintananceController();
            mmc.setSendMomAll(request);

            Set<Integer> momusersList = mmc.getTotalUsers();

            if (plannedFor.equalsIgnoreCase(IssueDetails.plannedForList().get(1))) {
                date = MoMUtil.nextDay(date);
                dateFor = sdf.format(date);
                boolean flag = true;
                while (flag == true) {
                    List<Holidays> holidaysList = HolidaysUtil.findByHolidayDate(date);
                    if (!holidaysList.isEmpty()) {
                        date = MoMUtil.nextDay(date);
                    } else {
                        flag = false;
                    }
                }
            }

            String pIds[] = request.getParameterValues("selectItempIds");
            int userId = (Integer) request.getSession().getAttribute("userid_curr");
            if (pIds != null) {
                for (String project : pIds) {
                    long pId = Long.valueOf(project);
                    String issues[] = request.getParameterValues(pId + "pIssue");

                    List<String> newPlan = new ArrayList<>();
                    if (issues != null) {
                        newPlan = Arrays.asList(issues);
                    }

                    List<ProjectPlannedIssue> planIssue = ProjectPlanUtil.findByDayAndProjectId(date, pId);
                    List<String> planIssues = new ArrayList();
                    for (ProjectPlannedIssue ppi : planIssue) {

                        if (newPlan.contains(ppi.getIssueId())) {
                            if (ppi.getStatus().equalsIgnoreCase(PlanStatus.INACTIVE.getStatus())) {

                                ppi.setStatus(PlanStatus.ACTIVE.getStatus());
                                ppi.setModifiedOn(currentDate);
                                ProjectPlanUtil.updateProjectPlanIssue(ppi);
                            }

                            planIssues.add(ppi.getIssueId());
                            String assignedTo = request.getParameter(ppi.getIssueId() + "assignedTo");
                            int assign = Integer.valueOf(assignedTo.trim());
                            if (plannedFor.equalsIgnoreCase("Today")) {
                                if (momusersList.contains(assign)) {
                                    MoMUtil.createTask(assign, ppi.getIssueId().trim(), userId, "Issue", "Planned");
                                }
                            } else {
                                if (momusersList.contains(assign)) {
                                    MoMUtil.createTask(assign, ppi.getIssueId().trim(), userId, "Issue", "Planned", date);
                                }
                            }
                        } else {
                            ppi.setStatus(PlanStatus.INACTIVE.getStatus());
                            ppi.setModifiedOn(currentDate);
                            ProjectPlanUtil.updateProjectPlanIssue(ppi);
                        }

                    }
                    if (issues != null) {
                        for (int i = 0; i < issues.length; i++) {
                            if (!planIssues.contains(issues[i])) {
                                ProjectPlannedIssue projectPlannedIssue = new ProjectPlannedIssue(pId, issues[i], userId, date, currentDate, currentDate, PlanStatus.ACTIVE.getStatus());
                                ProjectPlanUtil.createProjectPlanIssue(projectPlannedIssue);
                                String assignedTo = request.getParameter(issues[i] + "assignedTo");
                                int assign = Integer.valueOf(assignedTo.trim());
                                if (plannedFor.equalsIgnoreCase("Today")) {
                                    if (momusersList.contains(assign)) {
                                        MoMUtil.createTask(assign, issues[i].trim(), userId, "Issue", "Planned");
                                    }
                                } else {
                                    if (momusersList.contains(assign)) {
                                        MoMUtil.createTask(assign, issues[i].trim(), userId, "Issue", "Planned", date);
                                    }
                                }
                            }
                        }

                    }
                    pids.add(pId);
                }
            }
        }
        plannedIssues = ProjectPlanUtil.findByPlannedOn(date);
        wrmTouched(pid);
        wrmTouchedByCustomer(pid);
        wrmTouchedByEspl(pid);
        try {
            String extended = "";
            if (pid != null) {
                int prid = MoMUtil.parseInteger(pid, 0);
                if (prid > 0) {
                    extended = " and i.pid=" + pid;
                }
            }
            String sql = "select i.issueid,  CONCAT(pname ,CONCAT(' v',version)) as project, type, s.status, subject, description, priority, severity, createdby, createdon, assignedto, modifiedon, due_date,rating,feedback,module,ceil(to_number(sysdate-to_date(createdon)))as age,email as assignemail,p.pid from issue i,issuestatus s,WRMPERIOD w,project p,Apm_Wrm_Plan ap,modules m,users u where i.PID=w.pid and ap.pid=i.pid and u.userid=assignedto and  ap.pid=p.pid " + extended + " and p.STATUS='Work in progress' And pmanager <> " + adminid + " and  i.module_id=m.moduleid  and i.issueid=s.issueid and (to_char(ap.plannedon,'DD-Mon-YYYY'),ap.pid) in (select MAX(wrmday),pid from Apm_Wrm_Plan group by pid) and ap.issueid=i.issueid and ap.status='Active' and s.status!='Closed' order by due_date asc";
            connection = MakeConnection.getConnection();
            logger.info(sql);
            ps = connection.prepareStatement(sql, ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);

            resultSet = ps.executeQuery();
            String totalissuenos = "";

            while (resultSet.next()) {
                totalissuenos = totalissuenos + "'" + resultSet.getString("issueid").trim() + "',";
            }
            List<LastAssginForm> lastAssign = new ArrayList<LastAssginForm>();
            Map<String, Integer> lastAsigneeAgeList = new HashMap<String, Integer>();
            Map<String, Integer> fileCountList = new HashMap<String, Integer>();
            if (totalissuenos.contains(",")) {
                totalissuenos = totalissuenos.substring(0, totalissuenos.length() - 1);
                lastAsigneeAgeList = GetAge.issuelastAsigneeAge(totalissuenos);
                fileCountList = IssueDetails.displayFilesCount(totalissuenos);
                lastAssign = IssueDetails.lastAssign();
            }
            resultSet.beforeFirst();
            while (resultSet.next()) {
                IssueFormBean isfb = new IssueFormBean();
                momProjects.put(resultSet.getInt("pid"), resultSet.getString("project"));
                isfb.setSeverity(severityColor(resultSet.getString("severity")));
                isfb.setIssueId(resultSet.getString("issueid"));
                isfb.setType(resultSet.getString("type"));

                String p = "NA";
                String pri = resultSet.getString("priority");
                if (pri != null) {
                    p = pri.substring(0, 2);
                }
                isfb.setPriority(p);

                isfb.setpName(resultSet.getString("project"));
                if (isfb.getpName().length() >= 15) {
                    isfb.setRedPName(isfb.getpName().substring(0, 14) + "..");
                } else {
                    isfb.setRedPName(resultSet.getString("project"));
                }
                isfb.setmName(resultSet.getString("module"));
                if (isfb.getmName().length() >= 10) {
                    isfb.setRedMName(isfb.getmName().substring(0, 9) + "..");
                } else {
                    isfb.setRedMName(resultSet.getString("module"));
                }
                String sub = resultSet.getString("subject");
                if (sub.length() > 42) {
                    sub = sub.substring(0, 42) + "...";
                }
                isfb.setSubject(sub);
                isfb.setDescription(resultSet.getString("description"));
                String status = resultSet.getString("status");
                isfb.setStatus(status);
                String dueDateFormat = resultSet.getDate("due_date").toString();
                String dueDate = "NA";
                if (dueDateFormat != null) {
                    dueDate = sdf.format(dateConversion.parse(dueDateFormat));
                }
                String dateString1 = sdf.format(dateConversion.parse(resultSet.getDate("modifiedon").toString()));
                String create = sdf.format(dateConversion.parse(resultSet.getDate("createdon").toString()));

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
                isfb.setAssigneeEmail(resultSet.getString("assignemail"));
                if (resultSet.getString("createdby") != null) {
                    isfb.setCreatedBy(member.get(Integer.valueOf(resultSet.getString("createdby"))));
                    isfb.setCreatedById(Integer.valueOf(resultSet.getString("createdby")));
                }
                if (resultSet.getString("assignedto") != null) {
                    isfb.setAssignto(member.get(Integer.valueOf(resultSet.getString("assignedto"))));
                    isfb.setAssigntoId(Integer.valueOf(resultSet.getString("assignedto")));
                }
                int filesCount = 0;
                if (fileCountList.containsKey(resultSet.getString("issueid"))) {
                    filesCount = fileCountList.get(resultSet.getString("issueid"));
                }
                if (filesCount > 0) {
                    isfb.setRefer("View Files(" + filesCount + ")");
                } else {
                    isfb.setRefer("No Files");
                }
                int lastAsigneeAge = 1;
                if (lastAsigneeAgeList.containsKey(resultSet.getString("issueid"))) {
                    lastAsigneeAge = lastAsigneeAgeList.get(resultSet.getString("issueid"));
                }
                if (lastAsigneeAge == 1) {
                    lastAsigneeAge = resultSet.getInt("age");
                }

                if (lastAsigneeAge == 0) {
                    lastAsigneeAge = lastAsigneeAge + 1;
                }
                isfb.setpId(resultSet.getInt("pid"));
                isfb.setAge(resultSet.getInt("age"));
                isfb.setLastAssigneeAge(lastAsigneeAge);
                isfb.setRating(resultSet.getString("rating"));
                for (LastAssginForm lastAssignForm : lastAssign) {
                    if (resultSet.getString("issueid").equals(lastAssignForm.getIssueId())) {
                        isfb.setLastAssigneeName(lastAssignForm.getLastAssigneeName());
                        isfb.setLastModifiedOn(lastAssignForm.getLastModifiedOn());
                        isfb.setLastAssigneeEmail(lastAssignForm.getEmail());
                    }
                }
                if (wrmTouchedIssueByCustomer.contains(resultSet.getString("issueid").trim()) && wrmTouchedIssueByEspl.contains(resultSet.getString("issueid").trim())) {

                    if (isfb.getAssigneeEmail().contains("eminentlabs.net")) {
                        wrmTouchedByEspl.add(isfb);
                    } else {
                        wrmTouchedByCustomer.add(isfb);
                    }
                } else if (wrmTouchedIssueByCustomer.contains(resultSet.getString("issueid").trim())) {

                    if (isfb.getAssigneeEmail().contains("eminentlabs.net")) {
                        wrmUnTouchedByEspl.add(isfb);
                    } else {
                        wrmTouchedByCustomer.add(isfb);
                    }
                } else if (wrmTouchedIssueByEspl.contains(resultSet.getString("issueid").trim())) {
                    if (isfb.getAssigneeEmail().contains("eminentlabs.net")) {
                        wrmTouchedByEspl.add(isfb);
                    } else {
                        wrmUnTouchedByCustomer.add(isfb);
                    }
                } else {
                    if (isfb.getAssigneeEmail().contains("eminentlabs.net")) {
                        wrmUnTouchedByEspl.add(isfb);
                    } else {
                        wrmUnTouchedByCustomer.add(isfb);
                    }
                }
            }
        } catch (Exception e) {
            logger.info("getIssuesDetail" +e.getMessage());
        } finally {
            try {
                if (ps != null) {
                    ps.close();
                }
            } catch (Exception e) {
                logger.error(e.getMessage());
            }
            try {
                if (resultSet != null) {
                    resultSet.close();
                }

            } catch (Exception e) {
                logger.error(e.getMessage());
            }
            try {
                if (connection != null) {
                    connection.close();
                }

            } catch (Exception e) {
                logger.error(e.getMessage());
            }

        }
        if (plannedFor == null) {
            plannedFor = "";
        }
    }

    public List<String> wrmTouched(String pid) {
        ResultSet rs = null;
        Connection conn = null;
        PreparedStatement pstmt = null;
        try {
            conn = MakeConnection.getConnection();
            String extended = "";
            if (pid != null) {
                int prid = MoMUtil.parseInteger(pid, 0);
                if (prid > 0) {
                    extended = " where pid=" + pid;
                }
            }
            String query = "select distinct(ISSUEID) from WRM_UPDATED" + extended;
            logger.info(query);
            pstmt = conn.prepareStatement(query);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                if (rs.getString("ISSUEID") != null) {
                    wrmTouchedIssues.add(rs.getString("ISSUEID"));
                }
            }
        } catch (Exception e) {
            logger.info("todayPlannedIssues" +e.getMessage());
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (pstmt != null) {
                    pstmt.close();
                }
                if (conn != null) {
                    conn.close();
                }
            } catch (SQLException e) {
                logger.error(e.getMessage());
            }
        }
        return wrmTouchedIssues;
    }

    public List<String> wrmTouchedByEspl(String pid) {
        ResultSet rs = null;
        Connection conn = null;
        PreparedStatement pstmt = null;
        try {
            conn = MakeConnection.getConnection();
            String extended = "";
            if (pid != null) {
                int prid = MoMUtil.parseInteger(pid, 0);
                if (prid > 0) {
                    extended = " and  pid=" + pid;
                }
            }
            String query = "select distinct(ISSUEID) from WRM_UPDATED w, Users u where u.userid=w.commentedby and email like '%eminentlabs.net'" + extended;
            logger.info(query);
            pstmt = conn.prepareStatement(query);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                if (rs.getString("ISSUEID") != null) {
                    wrmTouchedIssueByEspl.add(rs.getString("ISSUEID"));
                }
            }
        } catch (Exception e) {
            logger.info("wrmTouchedByEspl" +e.getMessage());
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (pstmt != null) {
                    pstmt.close();
                }
                if (conn != null) {
                    conn.close();
                }
            } catch (SQLException e) {
                logger.error(e.getMessage());
            }
        }
        return wrmTouchedIssueByEspl;
    }

    public List<String> wrmTouchedByCustomer(String pid) {
        ResultSet rs = null;
        Connection conn = null;
        PreparedStatement pstmt = null;
        try {
            conn = MakeConnection.getConnection();
            String extended = "";
            if (pid != null) {
                int prid = MoMUtil.parseInteger(pid, 0);
                if (prid > 0) {
                    extended = " and pid=" + pid;
                }
            }
            String query = "select distinct(ISSUEID) from WRM_UPDATED w, Users u where u.userid=w.commentedby and email not like '%eminentlabs.net'" + extended;
            logger.info(query);
            pstmt = conn.prepareStatement(query);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                if (rs.getString("ISSUEID") != null) {
                    wrmTouchedIssueByCustomer.add(rs.getString("ISSUEID"));
                }
            }
        } catch (Exception e) {
            logger.info("wrmTouchedByCustomer" + e.getMessage());
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (pstmt != null) {
                    pstmt.close();
                }
                if (conn != null) {
                    conn.close();
                }
            } catch (SQLException e) {
                logger.error(e.getMessage());
            }
        }
        return wrmTouchedIssueByCustomer;
    }

    public List<String> getPlannedIssues() {
        return plannedIssues;
    }

    public void setPlannedIssues(List<String> plannedIssues) {
        this.plannedIssues = plannedIssues;
    }

    public List<String> getWrmTouchedIssues() {
        return wrmTouchedIssues;
    }

    public void setWrmTouchedIssues(List<String> wrmTouchedIssues) {
        this.wrmTouchedIssues = wrmTouchedIssues;
    }

    public List<IssueFormBean> getWrmTouchedByEspl() {
        return wrmTouchedByEspl;
    }

    public void setWrmTouchedByEspl(List<IssueFormBean> wrmTouchedByEspl) {
        this.wrmTouchedByEspl = wrmTouchedByEspl;
    }

    public List<IssueFormBean> getWrmTouchedByCustomer() {
        return wrmTouchedByCustomer;
    }

    public void setWrmTouchedByCustomer(List<IssueFormBean> wrmTouchedByCustomer) {
        this.wrmTouchedByCustomer = wrmTouchedByCustomer;
    }

    public List<IssueFormBean> getWrmUnTouchedByEspl() {
        return wrmUnTouchedByEspl;
    }

    public void setWrmUnTouchedByEspl(List<IssueFormBean> wrmUnTouchedByEspl) {
        this.wrmUnTouchedByEspl = wrmUnTouchedByEspl;
    }

    public List<IssueFormBean> getWrmUnTouchedByCustomer() {
        return wrmUnTouchedByCustomer;
    }

    public void setWrmUnTouchedByCustomer(List<IssueFormBean> wrmUnTouchedByCustomer) {
        this.wrmUnTouchedByCustomer = wrmUnTouchedByCustomer;
    }

    public Map<Integer, String> getMomProjects() {
        return momProjects;
    }

    public void setMomProjects(Map<Integer, String> momProjects) {
        this.momProjects = momProjects;
    }

    public String getPlannedFor() {
        return plannedFor;
    }

    public void setPlannedFor(String plannedFor) {
        this.plannedFor = plannedFor;
    }

    public List<Long> getPids() {
        return pids;
    }

    public void setPids(List<Long> pids) {
        this.pids = pids;
    }

    public List<Integer> getTechnicalHead() {
        return technicalHead;
    }

    public void setTechnicalHead(List<Integer> technicalHead) {
        this.technicalHead = technicalHead;
    }

}
