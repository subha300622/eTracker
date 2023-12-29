/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eminent.issue.formbean;

import com.eminent.util.GetAge;
import com.eminent.util.GetProjectMembers;
import com.eminent.util.IssueDetails;
import com.eminent.util.ProjectPlanUtil;
import com.eminentlabs.mom.IssuesTask;
import com.eminentlabs.mom.MoMUtil;
import com.eminentlabs.mom.controller.ViewMomController;
import dashboard.CheckDate;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;
import javax.servlet.http.HttpServletRequest;
import org.apache.log4j.Logger;
import pack.eminent.encryption.MakeConnection;

/**
 *
 * @author Muthu
 */
public class PlannedIssueSummary {

    static Logger logger = null;

    static {
        logger = Logger.getLogger("PlannedIssueSummary");

    }
    private String plannedDate;
    private String pid;
    private int projectId;
    private String countType;
    List<IssueFormBean> issuesList = new ArrayList<IssueFormBean>();
    List<String> wrmIssueList = new ArrayList<String>();

    public void summary(HttpServletRequest request) {
        List<String> plannedIssuesList = new ArrayList<String>();
        List<String> momplannedIssuesList = new ArrayList<String>();
        List<String> momAndplannedIssuesList = new ArrayList<String>();
        List<String> plannedIssueList = new ArrayList<String>();

        List<String> wrmPlannedIssueList = new ArrayList<String>();
        List<String> nonWRMPlannedIssueList = new ArrayList<String>();

        try {
            plannedDate = request.getParameter("plannedDate");
            pid = request.getParameter("pid");
            countType = request.getParameter("countType");

            if (pid != null) {
                if ("".equals(pid)) {
                    pid = null;
                } else {
                    projectId = MoMUtil.parseInteger(pid, 0);
                }
            }
            Calendar cal = Calendar.getInstance();
            Date date = cal.getTime();
            SimpleDateFormat sdf = new SimpleDateFormat("dd-MMM-yyyy");
            if (plannedDate != null) {
                date = sdf.parse(plannedDate);
                cal.setTime(date);
                plannedDate = sdf.format(date);
            }
            Date plannedOn = cal.getTime();
            momplannedIssuesList = MoMUtil.plannedIssuesByPidAndPlannedDate(projectId, plannedDate);

            if (pid == null) {
                plannedIssuesList = ProjectPlanUtil.findByPlannedOn(plannedOn);
            } else {
                plannedIssuesList = ProjectPlanUtil.findIssuesByDayAndProjectId(plannedOn, MoMUtil.parseLong(pid, 0l));

            }
            momAndplannedIssuesList = union(momplannedIssuesList, plannedIssuesList);

            for (String plannedIssue : momAndplannedIssuesList) {
                if (plannedIssuesList.contains(plannedIssue) && momplannedIssuesList.contains(plannedIssue)) {
                    plannedIssueList.add(plannedIssue);
                }
                if (!plannedIssuesList.contains(plannedIssue) && momplannedIssuesList.contains(plannedIssue)) {
                    plannedIssueList.add(plannedIssue);
                }
            }
            List<IssuesTask> wrmIssues = ViewMomController.momWrmIssues(pid, plannedDate);
            wrmIssueList = MoMUtil.convertIssueNo(wrmIssues);
            if (countType.equalsIgnoreCase("WI")) {
                executeme(wrmIssueList);
            } else if (countType.equalsIgnoreCase("WPI") || countType.equalsIgnoreCase("totWPI")) {
                for (String plannedIssue : plannedIssueList) {
                    if (wrmIssueList.contains(plannedIssue)) {
                        wrmPlannedIssueList.add(plannedIssue);
                    }
                }
                executeme(wrmPlannedIssueList);
            } else if (countType.equalsIgnoreCase("NWPI") || countType.equalsIgnoreCase("totNWPI")) {
                for (String plannedIssue : plannedIssueList) {
                    if (wrmIssueList.contains(plannedIssue)) {
                    } else {
                        nonWRMPlannedIssueList.add(plannedIssue);
                    }
                }
                executeme(nonWRMPlannedIssueList);
            } else if (countType.equalsIgnoreCase("PI") || countType.equalsIgnoreCase("totPI")) {
                executeme(plannedIssueList);
            } else {

            }
        } catch (Exception e) {
            e.printStackTrace();
        }

    }

    public void executeme(List<String> issues) {
        SimpleDateFormat sdf = new SimpleDateFormat("dd-MMM-yy");
        SimpleDateFormat dateConversion = new SimpleDateFormat("yyyy-MM-dd");
        Connection connection = null;
        PreparedStatement ps = null;
        ResultSet resultSet = null;
        String extededQuery = "";
        String totalissuenos = "";
        String projectIds = "";
        for (String issue : issues) {
            if ("".equals(extededQuery)) {
                extededQuery = " i.issueid ='" + issue.trim() + "'";
            } else {
                extededQuery = extededQuery + "OR i.issueid ='" + issue.trim() + "'";
            }
            totalissuenos = totalissuenos + "'" + issue.trim() + "',";
        }
        extededQuery = extededQuery.trim();

        HashMap<Integer, String> member = GetProjectMembers.showUsersSName();
        Map<Integer, String> projects = MoMUtil.getProjects();
        for (Map.Entry<Integer, String> entry : projects.entrySet()) {
            projectIds = projectIds + "'" + entry.getKey() + "'" + ",";
        }
        try {
            if (!"".equals(extededQuery)) {
                Map<String, Integer> lastAsigneeAgeList = new HashMap<String, Integer>();
                Map<String, Integer> fileCountList = new HashMap<String, Integer>();
                if (totalissuenos.contains(",")) {
                    totalissuenos = totalissuenos.substring(0, totalissuenos.length() - 1);
                    lastAsigneeAgeList = GetAge.issuelastAsigneeAge(totalissuenos);
                    fileCountList = IssueDetails.displayFilesCount(totalissuenos);
                }
                if (projectIds.contains(",")) {
                    projectIds = projectIds.substring(0, projectIds.length() - 1);
                }
                String sql = "select i.issueid,p.pid as projId,CONCAT(pname ,CONCAT(' v',version)) as project, type, s.status, subject, description, priority, severity, createdby, createdon, assignedto, modifiedon, due_date,rating,feedback,module,ceil(to_number(sysdate-to_date(createdon)))as age  from issue i,issuestatus s,project p,modules m where i.issueid = s.issueid and i.module_id=m.moduleid and  i.pid = p.pid and (" + extededQuery + ")  and p.pid in ("+projectIds+")  order by pname, due_date asc, modifiedon asc, type asc, priority asc, severity asc, createdon asc";
                connection = MakeConnection.getConnection();
                
                logger.info(sql);
                ps = connection.prepareStatement(sql, ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);

                resultSet = ps.executeQuery();
                while (resultSet.next()) {
                    IssueFormBean isfb = new IssueFormBean();

                    isfb.setSeverity(PlannedIssueReport.severityColor(resultSet.getString("severity")));
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
                    if (resultSet.getString("createdby") != null) {
                        isfb.setCreatedBy(member.get(Integer.valueOf(resultSet.getString("createdby"))));
                    }
                    if (resultSet.getString("assignedto") != null) {
                        isfb.setAssignto(member.get(Integer.valueOf(resultSet.getString("assignedto"))));
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
                    isfb.setAge(resultSet.getInt("age"));
                    isfb.setLastAssigneeAge(lastAsigneeAge);
                    isfb.setRating(resultSet.getString("rating"));
                    isfb.setpId(resultSet.getInt("projId"));
                    issuesList.add(isfb);
                }
            }
        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            try {

                if (resultSet != null) {
                    resultSet.close();
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

    static <K, V extends Comparable<? super V>>
            List<Map.Entry<K, V>> entriesSortedByValues(Map<K, V> map) {

        List<Map.Entry<K, V>> sortedEntries = new ArrayList<Map.Entry<K, V>>(map.entrySet());

        Collections.sort(sortedEntries,
                new Comparator<Map.Entry<K, V>>() {
                    @Override
                    public int compare(Map.Entry<K, V> e1, Map.Entry<K, V> e2) {
                        return e2.getValue().compareTo(e1.getValue());
                    }
                }
        );

        return sortedEntries;
    }

    public String getPlannedDate() {
        return plannedDate;
    }

    public void setPlannedDate(String plannedDate) {
        this.plannedDate = plannedDate;
    }

    public String getPid() {
        return pid;
    }

    public void setPid(String pid) {
        this.pid = pid;
    }

    public String getCountType() {
        return countType;
    }

    public void setCountType(String countType) {
        this.countType = countType;
    }

    public List<IssueFormBean> getIssuesList() {
        return issuesList;
    }

    public void setIssuesList(List<IssueFormBean> issuesList) {
        this.issuesList = issuesList;
    }

    public <T> List<T> union(List<T> list1, List<T> list2) {
        Set<T> set = new HashSet<T>();

        set.addAll(list1);
        set.addAll(list2);

        return new ArrayList<T>(set);
    }

    public List<String> getWrmIssueList() {
        return wrmIssueList;
    }

    public void setWrmIssueList(List<String> wrmIssueList) {
        this.wrmIssueList = wrmIssueList;
    }

}
