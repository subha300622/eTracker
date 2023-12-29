/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eminentlabs.mom.formbean;

import com.eminent.issue.formbean.IssueFormBean;
import static com.eminent.issue.formbean.PlannedIssueReport.severityColor;
import com.eminent.util.GetAge;
import com.eminent.util.GetProjectManager;
import com.eminent.util.GetProjectMembers;
import com.eminent.util.IssueDetails;
import com.eminentlabs.mom.MoMUtil;
import com.eminentlabs.mom.PmPerformance;
import com.eminentlabs.mom.controller.SendMomMaintainController;
import dashboard.CheckDate;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.ResourceBundle;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.apache.log4j.Logger;
import pack.eminent.encryption.MakeConnection;

/**
 *
 * @author E0288
 */
public class ProjectWiseClosedReport {

    static Logger logger = null;

    static {
        logger = Logger.getLogger("ProjectWiseClosedReport");

    }
    Connection connection = null;
    Statement statement = null;
    ResultSet resultset = null;
    private String startDate;
    private String endDate;
    private String bestPName;
    private String bestPManager;
    ResourceBundle rb = ResourceBundle.getBundle("Resources");
    String mods = rb.getString("mom-mods");
    String noOfIds[] = mods.split(",");
    List<String> modList = Arrays.asList(noOfIds);
    List<PMReportFormBean> pWCIR = new ArrayList<PMReportFormBean>();
    HashMap<Integer, String> member = GetProjectMembers.showUsers();
    private int branch = 0;

    public void setAll(HttpServletRequest request) throws Exception {
        SimpleDateFormat sdf = new SimpleDateFormat("dd-MMM-yyyy");
        SimpleDateFormat sdfs = new SimpleDateFormat("dd-MM-yyyy");
        Calendar c = Calendar.getInstance();
        c.set(Calendar.DAY_OF_WEEK, Calendar.MONDAY);
        Date start = c.getTime();
        c.add(Calendar.DATE, -2);
        start = c.getTime();
        c.add(Calendar.DATE, 2);
        c.set(Calendar.DAY_OF_WEEK, Calendar.FRIDAY);
        Date end = c.getTime();
        startDate = sdfs.format(start);
        endDate = sdfs.format(end);
        String startParam = sdf.format(start);
        String endParam = sdf.format(end);
        HttpSession session = request.getSession();
        if (request.getParameter("fromdate") != null) {
            startDate = request.getParameter("fromdate");
            startParam = com.pack.ChangeFormat.changeDateFormat(startDate);
        }
        if (request.getParameter("todate") != null) {
            endDate = request.getParameter("todate");
            endParam = com.pack.ChangeFormat.changeDateFormat(endDate);
        }
        Date sdate = sdf.parse(startParam);
        Date edate = sdf.parse(endParam);
        String branchId = request.getParameter("branch");
        int userId = (Integer) session.getAttribute("userid_curr");
        SendMomMaintainController smmc = new SendMomMaintainController();
        smmc.getLocationNBranch(userId);
        if (branchId != null) {
            if ("".equals(branchId)) {
                branchId = null;
            } else {
                branch = MoMUtil.parseInteger(branchId, 0);
            }
        } else {
            branch = smmc.getSendMomMaintenance().getBranchId() == null ? (Integer) session.getAttribute("branch") : smmc.getSendMomMaintenance().getBranchId();
        }

        PmPerformance bestPM = MoMUtil.findBestPMByDate(sdate, edate, branch);
        if (bestPM != null) {
            bestPManager = member.get(bestPM.getPmid());
            connection = MakeConnection.getConnection();
            String query = "select CONCAT(pname ,CONCAT(' v',version))as projectName from project  where pid=" + bestPM.getPid() + "";
            logger.info(query);
            statement = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            resultset = statement.executeQuery(query);
            while (resultset.next()) {
                bestPName = resultset.getString("projectName");
            }
            logger.info("bestPName : " + bestPName);
        }

        pWCIR = projectWiseClosedReport(startParam, endParam, branch);
    }

    public List<PMReportFormBean> projectWiseClosedReport(String start, String end, int branchId) {
        Map<Long, String> allProject = GetProjectManager.getWIPProjectsByBranch(branchId);
        String totalissuenos = "";
        SimpleDateFormat sdf = new SimpleDateFormat("dd-MMM-yy");
        SimpleDateFormat dateConversion = new SimpleDateFormat("yyyy-MM-dd");
        Map<Long, List<IssueFormBean>> closedIssuesByProject = new LinkedHashMap<Long, List<IssueFormBean>>();
        List<IssueFormBean> issuesList = new ArrayList<IssueFormBean>();

        Map<Long, String> projectIdAndManagerName = new HashMap<Long, String>(); // modified for pm name by muthuraja
        Map<Long, Integer> projectIdAndManagerID = new HashMap<Long, Integer>(); // added for pm id by muthuraja
        List<PMReportFormBean> projectWiseClosedReport = new ArrayList<PMReportFormBean>();
        Map<Long, String> findFeedBack = new HashMap<Long, String>();
        findFeedBack = findFeedback(start, end);
        try {
            connection = MakeConnection.getConnection();
            String query = null;
            if (branchId > 0) {
                query = "select i.issueid,CONCAT(pname ,CONCAT(' v',version))as project,type, s.status, subject, description, priority, severity, createdby, createdon, assignedto, modifiedon, due_date,rating,feedback,module,ceil(to_number(modifiedon-to_date(createdon)))as age, p.pid,pmanager from issue i,project p,issuestatus s,modules m,users u where i.pid=p.pid and m.moduleid=i.module_id and i.issueid=s.issueid and s.status='Closed' and u.userid=p.pmanager and to_date(to_char(i.modifiedon,'DD-Mon-YYYY'),'DD-Mon-YYYY') between '" + start + "' and '" + end + "' and u.branch_id=" + branchId + " order by upper(project) asc";

            } else {
                query = "select i.issueid,CONCAT(pname ,CONCAT(' v',version))as project,type, s.status, subject, description, priority, severity, createdby, createdon, assignedto, modifiedon, due_date,rating,feedback,module,ceil(to_number(modifiedon-to_date(createdon)))as age, p.pid,pmanager from issue i,project p,issuestatus s,modules m where i.pid=p.pid and m.moduleid=i.module_id and i.issueid=s.issueid and s.status='Closed' and to_date(to_char(i.modifiedon,'DD-Mon-YYYY'),'DD-Mon-YYYY') between '" + start + "' and '" + end + "' order by upper(project) asc";
            }
            statement = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            resultset = statement.executeQuery(query);

            while (resultset.next()) {
                totalissuenos = totalissuenos + "'" + resultset.getString("issueid").trim() + "',";
            }
            Map<String, Integer> lastAsigneeAgeList = new HashMap<String, Integer>();
            Map<String, Integer> fileCountList = new HashMap<String, Integer>();
            if (totalissuenos.contains(",")) {
                totalissuenos = totalissuenos.substring(0, totalissuenos.length() - 1);
                lastAsigneeAgeList = GetAge.issuelastAsigneeAge(totalissuenos);
                fileCountList = IssueDetails.displayFilesCount(totalissuenos);
            }
            resultset.beforeFirst();
            long pid = 0l;

            while (resultset.next()) {

                long project = resultset.getLong("pid");

                if (pid == 0) {
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
                    issuesList.add(isfb);

                    //added pm id and name by muthuraja 
                    projectIdAndManagerName.put(project, member.get(resultset.getInt("pmanager")));
                    projectIdAndManagerID.put(project, resultset.getInt("pmanager"));
                    closedIssuesByProject.put(project, issuesList);
                    pid = project;
                } else if (project != pid) {
                    issuesList = new ArrayList<IssueFormBean>();
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
                    issuesList.add(isfb);
                    pid = project;
                    //added pm id and name by muthuraja 
                    projectIdAndManagerName.put(project, member.get(resultset.getInt("pmanager")));
                    projectIdAndManagerID.put(project, resultset.getInt("pmanager"));
                    closedIssuesByProject.put(project, issuesList);

                } else {
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
                    issuesList.add(isfb);
                    //added pm id and name by muthuraja 
                    projectIdAndManagerName.put(project, member.get(resultset.getInt("pmanager")));
                    projectIdAndManagerID.put(project, resultset.getInt("pmanager"));
                    closedIssuesByProject.put(project, issuesList);
                }

            }
            if (!issuesList.isEmpty()) {
                closedIssuesByProject.put(pid, issuesList);
            }
            List<PMReportFormBean> pmClosedReport = new ArrayList<PMReportFormBean>();

            HashMap<Long, Integer> pmClosedCount = new HashMap<Long, Integer>();
            Map<Long, Integer> pmClosedCountOrder = new LinkedHashMap<Long, Integer>();
            for (Map.Entry<Long, List<IssueFormBean>> entry : closedIssuesByProject.entrySet()) {
                PMReportFormBean pmrfb = new PMReportFormBean();
                pmrfb.setPid(entry.getKey());
                pmrfb.setClosedCount(entry.getValue().size());
                pmrfb.setProjectManager(projectIdAndManagerName.get(entry.getKey()));
                pmrfb.setPmid(projectIdAndManagerID.get(entry.getKey())); //added pm id by muthuraja 
                for (IssueFormBean isfb : entry.getValue()) {
                    pmrfb.setPname(isfb.getpName());
                }
                pmClosedCount.put(entry.getKey(), entry.getValue().size());
                pmrfb.setProjectWiseissuesList(entry.getValue());
                pmClosedReport.add(pmrfb);
            }
            for (Map.Entry<Long, String> allpro : allProject.entrySet()) {
                if (!closedIssuesByProject.containsKey(allpro.getKey())) {
                    String pro[] = allpro.getValue().split("--");
                    PMReportFormBean pmrfb = new PMReportFormBean();
                    pmrfb.setPid(allpro.getKey());
                    pmrfb.setClosedCount(0);
                    pmrfb.setPmid(Integer.parseInt(pro[1])); //added pm id by muthuraja 
                    pmrfb.setProjectManager(member.get(pmrfb.getPmid()));
                    pmrfb.setPname(pro[0]);
                    pmClosedCount.put(allpro.getKey(), 0);
                    pmClosedReport.add(pmrfb);
                }
            }

            pmClosedCountOrder = GetProjectMembers.sortHashMapByNonStringValues(pmClosedCount, false);
            for (Map.Entry<Long, Integer> entry : pmClosedCountOrder.entrySet()) {
                for (PMReportFormBean pmrfb : pmClosedReport) {
                    if (entry.getKey().equals(pmrfb.getPid())) {
                        if (findFeedBack.containsKey(pmrfb.getPid())) {
                            String ratingFeedBack[] = findFeedBack.get(pmrfb.getPid()).split(",");
                            if (ratingFeedBack != null) {
                                pmrfb.setRating(ratingFeedBack[0]);
                                if (ratingFeedBack.length > 1) {
                                    if (ratingFeedBack[1] != null) {
                                        pmrfb.setFeedback(ratingFeedBack[1]);
                                    }
                                } else {
                                    pmrfb.setFeedback("");
                                }
                            }
                        } else {
                            pmrfb.setRating("N/A");
                            pmrfb.setFeedback("");
                        }
                        projectWiseClosedReport.add(pmrfb);
                    }
                }
            }
        } catch (Exception e) {
            logger.error(e.getMessage());
            e.printStackTrace();
        } finally {
            try {

                if (resultset != null) {
                    resultset.close();
                }
                if (statement != null) {
                    statement.close();
                }
                if (connection != null) {
                    connection.close();
                }
            } catch (Exception ex) {
                logger.error(ex.getMessage());
            }
        }
        return projectWiseClosedReport;
    }

    public Map<Long, String> findFeedback() {

        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        Map<Long, String> findFeedBack = new HashMap<Long, String>();
        try {
            /*----Edit by mukesh----*/
            SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy");
            SimpleDateFormat sdf1 = new SimpleDateFormat("dd-MMM-yyyy");
            Date enddd = sdf.parse(getEndDate());

            Date dateBefore = new Date(enddd.getTime() - 6 * 24 * 3600 * 1000);
            String starts = sdf1.format(dateBefore);
            String ends = sdf1.format(enddd);

            connection = MakeConnection.getConnection();
            statement = connection.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);
            resultset = statement.executeQuery("select rating,m.pid,feedback  from mom_for_client m WHERE m.HELD_ON = (SELECT MAX(m2.wrmday) FROM Apm_Wrm_Plan m2 WHERE (m2.wrmday between'" + starts + "' and '" + ends + "') and m.pid = m2.pid)");
            /*----Edit by mukesh----*/
            while (resultset.next()) {
                long pid = resultset.getLong("pid");
                String rating = resultset.getString("rating");
                String feedback = resultset.getString("feedback");

                if (rating == null) {
                    rating = "Good";
                }
                if (feedback == null) {
                    feedback = "";
                }
                findFeedBack.put(pid, rating + "," + feedback);
            }
            logger.info(findFeedBack);
        } catch (Exception e) {
            logger.info("findFeedback" + e.getMessage());
        } finally {
            try {

                if (resultset != null) {
                    resultset.close();
                }
                if (statement != null) {
                    statement.close();
                }
                if (connection != null) {
                    connection.close();
                }
            } catch (Exception ex) {
                logger.error(ex.getMessage());
            }
        }
        return findFeedBack;

    }

    private Map<Long, String> findFeedback(String start, String end) {

        Connection connection = null;
        Statement statement = null;
        ResultSet resultset = null;
        Map<Long, String> findFeedBack = new HashMap<Long, String>();
        try {
            SimpleDateFormat sdf = new SimpleDateFormat("dd-MMM-yy");
            SimpleDateFormat dateConversion = new SimpleDateFormat("yyyy-MM-dd");
            String starts = dateConversion.format(sdf.parse(start));
            String ends = dateConversion.format(sdf.parse(end));

            connection = MakeConnection.getConnection();
            statement = connection.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);
            resultset = statement.executeQuery("select rating,pid,feedback  from mom_for_client where to_char(HELD_ON,'yyyy-MM-dd') between '" + starts + "' and '" + ends + "'");
            /*----Edit by mukesh----*/
            while (resultset.next()) {
                long pid = resultset.getLong("pid");
                String rating = resultset.getString("rating");
                String feedback = resultset.getString("feedback");
                if (feedback == null) {
                    feedback = "";
                }

                findFeedBack.put(pid, rating + "," + feedback);
            }
            logger.info(findFeedBack);
        } catch (Exception e) {
            logger.info("findFeedback" + e.getMessage());
        } finally {
            try {

                if (resultset != null) {
                    resultset.close();
                }
                if (statement != null) {
                    statement.close();
                }
                if (connection != null) {
                    connection.close();
                }
            } catch (Exception ex) {
                logger.error(ex.getMessage());
            }
        }
        return findFeedBack;
    }

    public String getStartDate() {
        return startDate;
    }

    public void setStartDate(String startDate) {
        this.startDate = startDate;
    }

    public String getEndDate() {
        return endDate;
    }

    public void setEndDate(String endDate) {
        this.endDate = endDate;
    }

    public List<String> getModList() {
        return modList;
    }

    public void setModList(List<String> modList) {
        this.modList = modList;
    }

    public List<PMReportFormBean> getpWCIR() {
        return pWCIR;
    }

    public void setpWCIR(List<PMReportFormBean> pWCIR) {
        this.pWCIR = pWCIR;
    }

    public String getBestPName() {
        return bestPName;
    }

    public void setBestPName(String bestPName) {
        this.bestPName = bestPName;
    }

    public String getBestPManager() {
        return bestPManager;
    }

    public void setBestPManager(String bestPManager) {
        this.bestPManager = bestPManager;
    }

    public int getBranch() {
        return branch;
    }

    public void setBranch(int branch) {
        this.branch = branch;
    }

}
