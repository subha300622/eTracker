/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eminent.issue.formbean;

import com.eminent.issue.PlanStatus;
import com.eminent.issue.ProjectPlannedIssue;
import com.eminent.util.GetAge;
import com.eminent.util.GetProjectMembers;
import com.eminent.util.IssueDetails;
import com.eminent.util.ProjectPlanUtil;
import com.eminentlabs.mom.IssuesTask;
import com.eminentlabs.mom.MoMUtil;
import com.eminentlabs.mom.MomUserTask;
import com.eminentlabs.mom.controller.MomMaintananceController;
import com.eminentlabs.mom.controller.ViewMomController;
import dashboard.CheckDate;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.LinkedHashMap;
import java.util.LinkedHashSet;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.ResourceBundle;
import java.util.Set;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.apache.log4j.Logger;
import pack.eminent.encryption.MakeConnection;

/**
 *
 * @author E0288
 */
public class PlannedIssueReport {

    static Logger logger = null;

    static {
        logger = Logger.getLogger("PlannedIssueReport");

    }
    private String plannedDate;
    ResourceBundle rb = ResourceBundle.getBundle("Resources");
    String mods = rb.getString("mom-mods");
    String noOfIds[] = mods.split(",");
    List<String> modList = Arrays.asList(noOfIds);
    List<String> plannedIssuesList = new ArrayList<String>();
    List<String> momplannedIssuesList = new ArrayList<String>();
    List<String> momAndplannedIssuesList = new ArrayList<String>();
    List<IssueFormBean> issuesList = new LinkedList<IssueFormBean>();
    Set<String> projectsList = new LinkedHashSet<String>();
    Map<Integer, String> usersList = new LinkedHashMap<Integer, String>();
    List<IssueCountFormBean> countList = new ArrayList<IssueCountFormBean>();
    Map<String, List<String>> wrmIssuesByPid = new HashMap<String, List<String>>();
    Map<Integer, List<IssueFormBean>> userwise = new HashMap<Integer, List<IssueFormBean>>();

    public void planIssueReport(HttpServletRequest request) throws ParseException {
        HttpSession session = request.getSession();
        session.setAttribute("forwardpage", "/MOM/plannedIssuesReport.jsp");
        List<IssuesTask> wrmIssues = new ArrayList<IssuesTask>();

        Calendar cal = Calendar.getInstance();
        Date date = cal.getTime();
        SimpleDateFormat sdf = new SimpleDateFormat("dd-MMM-yyyy");
        plannedDate = sdf.format(date);
        String momdate = request.getParameter("momdate");
        if (momdate != null) {
            date = sdf.parse(momdate);
            cal.setTime(date);
            plannedDate = sdf.format(date);
        }
        momplannedIssuesList = MoMUtil.todayPlannedIssues(plannedDate);
        Date plannedOn = cal.getTime();
        plannedIssuesList = ProjectPlanUtil.findByPlannedOn(plannedOn);
        momAndplannedIssuesList = intersection(momplannedIssuesList, plannedIssuesList);
        logger.info(plannedIssuesList);
        // issuesList = getIssuesDetail(momAndplannedIssuesList);
        issuesList = getUserWisePlannedIssuesDetail();
        try {
            //Map<Long, String> allWIPProjects = maintainWRMDay.projectList();
            Map<Integer, String> projects = MoMUtil.getProjects();
            Map<String, List<IssueFormBean>> projectwise = new HashMap<String, List<IssueFormBean>>();
            for (IssueFormBean issue : issuesList) {
                List<IssueFormBean> list = projectwise.get(issue.getpName());
                if (list == null) {
                    list = new ArrayList<>();
                    projectwise.put(issue.getpName(), list);
                }
                list.add(issue);
            }
            List<String> plannedIssueList;
            for (Map.Entry<Integer, String> entry : projects.entrySet()) {
                IssueCountFormBean issueCountFormBean = new IssueCountFormBean();
                plannedIssueList = new ArrayList<String>();
                issueCountFormBean.setProjectId(entry.getKey());
                issueCountFormBean.setProjectName(entry.getValue());
                issueCountFormBean.setOpenIssuesCount(IssueDetails.openIssuesByProject(issueCountFormBean.getProjectId() + "").length);
                wrmIssues = ViewMomController.momWrmIssues(issueCountFormBean.getProjectId() + "", plannedDate);
                List<String> wrmIssueNos = MoMUtil.convertIssueNo(wrmIssues);

                if (projectwise.containsKey(entry.getValue())) {
                    for (IssueFormBean ifb : projectwise.get(entry.getValue())) {
                        if (plannedIssuesList.contains(ifb.getIssueId()) && momplannedIssuesList.contains(ifb.getIssueId())) {
                            plannedIssueList.add(ifb.getIssueId());
                        }
                        if (!plannedIssuesList.contains(ifb.getIssueId()) && momplannedIssuesList.contains(ifb.getIssueId())) {
                            plannedIssueList.add(ifb.getIssueId());
                        }
                    }
                    wrmIssuesByPid.put(entry.getValue(), wrmIssueNos);
                }

                issueCountFormBean.setPlannedIssuesCount(plannedIssueList.size());
                issueCountFormBean.setWrmIssuesCount(wrmIssueNos.size());
                issueCountFormBean.setWrmPlannedIssuesCount(intersection(plannedIssueList, wrmIssueNos).size());
                issueCountFormBean.setNonWrmPlannedIssuesCount(issueCountFormBean.getPlannedIssuesCount() - issueCountFormBean.getWrmPlannedIssuesCount());
                countList.add(issueCountFormBean);
            }
            Collections.sort(countList, new Comparator<IssueCountFormBean>() {
                @Override
                public int compare(IssueCountFormBean t1, IssueCountFormBean t2) {
                    return t1.getProjectName().compareTo(t2.getProjectName());
                }
            }
            );
        } catch (Exception e) {
            logger.error(e.getMessage());
        }
    }

    public void userplanIssueReport(HttpServletRequest request) throws ParseException {
        HttpSession session = request.getSession();
        session.setAttribute("forwardpage", "/MOM/plannedIssuesReport.jsp");
        MomMaintananceController mmc = new MomMaintananceController();
        Calendar cal = Calendar.getInstance();
        Date date = cal.getTime();
        Date currentDate = cal.getTime();
        SimpleDateFormat sdf = new SimpleDateFormat("dd-MMM-yyyy");
        plannedDate = sdf.format(date);
        String momdate = request.getParameter("momdate");
        Connection dbConnection = null;
        Statement tsc_callableStatement = null;
        String status = "", sql = "";
        int i = 1;
        if (momdate != null) {
            date = sdf.parse(momdate);
            cal.setTime(date);
            plannedDate = sdf.format(date);
        }
        Date plannedOn = cal.getTime();

        try {
            if (request.getMethod().equalsIgnoreCase("post")) {
                dbConnection = MakeConnection.getConnection();
                dbConnection.setAutoCommit(false);
                tsc_callableStatement = dbConnection.createStatement();
                String userId[] = request.getParameterValues("userId");
                String[][] todayTaskDetails = MoMUtil.getTodayMOMDetail(sdf.format(plannedOn), "1,2,3");

                    List<MomUserTask> unplanTaskByUserList = new ArrayList<MomUserTask>();
                    if (userId != null) {
                        for (String user : userId) {
                            i = 0;
                            List<String> plannedIssues = new LinkedList<String>();
                            List<String> userPlannedIssues = new LinkedList<String>();
                            String[] userIdPlanned = request.getParameterValues(user + "PlannedIssues");
                            for (int j = 0; j < todayTaskDetails.length; j++) {
                                int momuser = MoMUtil.parseInteger(todayTaskDetails[j][0], 0);
                                if (momuser == MoMUtil.parseInteger(user, 0)) {
                                    if (todayTaskDetails[j][1].equalsIgnoreCase("Issue")) {
                                        plannedIssues.add(todayTaskDetails[j][2].substring(0, 12));
                                    }
                                }
                            }

                            if (userIdPlanned != null) {
                                userPlannedIssues = Arrays.asList(userIdPlanned);
                                for (String issue : userIdPlanned) {
                                    i++;//                            
                                   
                                    sql = "update mom_user_task  set sino=" + i + " where TASK like '%" + issue + "%' and MOMDATE  ='" + sdf.format(plannedOn) + "' and USERID=" + user + "";
                                    tsc_callableStatement.executeUpdate(sql);
                                }
                            }

                            plannedIssues.removeAll(userPlannedIssues);
                            for (String unplannedIssue : plannedIssues) {
                                MomUserTask momuserTask = new MomUserTask();
                                momuserTask.setMomdate(plannedOn);
                                momuserTask.setUserid(MoMUtil.parseInteger(user, 0));
                                momuserTask.setTask(unplannedIssue);
                                momuserTask.setType("Issue");
                                unplanTaskByUserList.add(momuserTask);
                            }

                        }
                        dbConnection.commit();
                        dbConnection.setAutoCommit(true);
                      
                        if (unplanTaskByUserList.size() > 0) {
                            new MoMUtil().unplanTaskByIssueAndUserId(unplanTaskByUserList);
                        }
                    }
            }
            issuesList = getUserWisePlannedIssuesDetail();
            Map<Integer, Integer> myAssignCount = GetProjectMembers.getAllMyAssignIssueCount();
            MyAsignmentIssues mas = new MyAsignmentIssues();
            List<String> wrmIssues = mas.wrmIssues();
            Map<Integer, List<String>> atcualIssues = MoMUtil.atcualIssuesOnDate(plannedDate);
            //Map<Long, String> allWIPProjects = maintainWRMDay.projectList();
            usersList = mmc.findAllMomMembers();
            for (IssueFormBean issue : issuesList) {
                List<IssueFormBean> list = userwise.get(issue.getAssigntoId());
                if (list == null) {
                    list = new LinkedList<>();
                    userwise.put(issue.getAssigntoId(), list);
                }
                list.add(issue);
//                Collections.sort(list, new Comparator<IssueFormBean>() {
//                    @Override
//                    public int compare(IssueFormBean t1, IssueFormBean t2) {
//                        return t1.getSino().compareTo(t2.getSino());
//                    }
//                }
//                );
            }

            int count = 0, actual = 0, wrmActual = 0;
            for (Map.Entry<Integer, String> entry : usersList.entrySet()) {
                count = 0;
                actual = 0;
                wrmActual = 0;
                IssueCountFormBean issueCountFormBean = new IssueCountFormBean();
                issueCountFormBean.setProjectId(entry.getKey());
                issueCountFormBean.setProjectName(entry.getValue());
                if (myAssignCount.containsKey(entry.getKey())) {
                    issueCountFormBean.setOpenIssuesCount(myAssignCount.get(entry.getKey()));
                }
                if (userwise.containsKey(entry.getKey())) {
                    for (IssueFormBean ifb : userwise.get(entry.getKey())) {
                        if (wrmIssues.contains(ifb.getIssueId())) {
                            count++;
                        }
                    }
                }

                if (userwise.containsKey(entry.getKey())) {
                    issueCountFormBean.setPlannedIssuesCount(userwise.get(entry.getKey()).size());
                } else {
                    issueCountFormBean.setPlannedIssuesCount(0);
                }
                if (atcualIssues.containsKey(entry.getKey()) && userwise.containsKey(entry.getKey())) {
                    for (String issue : atcualIssues.get(entry.getKey())) {
                        for (IssueFormBean ifb : userwise.get(entry.getKey())) {
                            if (ifb.getIssueId().equalsIgnoreCase(issue)) {
                                actual++;
                                if (wrmIssues.contains(issue)) {
                                    wrmActual++;
                                }
                            }
                        }
                    }
                    issueCountFormBean.setNonWrmActualIssuesCount(actual - wrmActual);
                    issueCountFormBean.setWrmActualIssuesCount(wrmActual);
                } else {
                    issueCountFormBean.setNonWrmActualIssuesCount(0);
                    issueCountFormBean.setWrmActualIssuesCount(0);
                }

                issueCountFormBean.setWrmPlannedIssuesCount(count);
                issueCountFormBean.setNonWrmPlannedIssuesCount(issueCountFormBean.getPlannedIssuesCount() - issueCountFormBean.getWrmPlannedIssuesCount());
                countList.add(issueCountFormBean);
            }

        } catch (Exception e) {
            e.printStackTrace();
            logger.error(e.getMessage());
        } finally {
            try {

                if (tsc_callableStatement != null) {
                    tsc_callableStatement.close();
                    logger.info("tsc_callableStatement closed");
                }

                if (dbConnection != null) {
                    dbConnection.close();
                    logger.info("dbConnection closed");
                }

            } catch (SQLException e) {
                logger.error(e.getMessage());

            }
        }
    }

    public List<IssueFormBean> getIssuesDetail(List<String> issues) {
        SimpleDateFormat sdf = new SimpleDateFormat("dd-MMM-yy");
        SimpleDateFormat dateConversion = new SimpleDateFormat("yyyy-MM-dd");

        Connection connection = null;
        PreparedStatement ps = null;
        ResultSet resultSet = null;
        String extededQuery = "", sql = "";
        String totalissuenos = "";
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
        try {
            if (!"".equals(extededQuery)) {
                Map<String, Integer> lastAsigneeAgeList = new HashMap<String, Integer>();
                Map<String, Integer> fileCountList = new HashMap<String, Integer>();
                if (totalissuenos.contains(",")) {
                    totalissuenos = totalissuenos.substring(0, totalissuenos.length() - 1);
                    lastAsigneeAgeList = GetAge.issuelastAsigneeAge(totalissuenos);
                    fileCountList = IssueDetails.displayFilesCount(totalissuenos);
                }
                if (plannedDate == null) {
                    sql = "select i.issueid,  CONCAT(pname ,CONCAT(' v',version)) as project, type, s.status, subject, description, priority, severity, createdby, createdon, assignedto, modifiedon, due_date,rating,feedback,module,ceil(to_number(sysdate-to_date(createdon)))as age  from issue i,issuestatus s,project p,modules m where i.issueid = s.issueid and i.module_id=m.moduleid and  i.pid = p.pid and (" + extededQuery + ")    order by pname, due_date asc, modifiedon asc, type asc, priority asc, severity asc, createdon asc";

                } else {
                    sql = "select i.issueid,  CONCAT(pname ,CONCAT(' v',version)) as project, type, s.status, subject, description, priority, severity, createdby, i.createdon, assignedto, i.modifiedon, due_date,rating,feedback,module,ceil(to_number(sysdate-to_date(i.createdon)))as age,sino   from issue i,issuestatus s,project p,modules m,PROJECT_PLANNED_ISSUE  pi  where i.issueid = s.issueid and i.module_id=m.moduleid and  i.pid = p.pid and i.issueid = pi.issueid and (" + extededQuery + ")  and pi.PLANNEDON='" + plannedDate + "'   order by pname, due_date asc, i.modifiedon asc, type asc, priority asc, severity asc, i.createdon asc";

                }
                connection = MakeConnection.getConnection();
                ps = connection.prepareStatement(sql, ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);

                resultSet = ps.executeQuery();
                while (resultSet.next()) {
                    IssueFormBean isfb = new IssueFormBean();

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
                    if (resultSet.getString("createdby") != null) {
                        isfb.setCreatedBy(member.get(Integer.valueOf(resultSet.getString("createdby"))));
                    }
                    if (resultSet.getString("assignedto") != null) {
                        isfb.setAssigntoId(Integer.valueOf(resultSet.getString("assignedto")));
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
                    if (plannedDate != null) {
                        isfb.setSino(resultSet.getInt("sino"));

                    }
                    issuesList.add(isfb);
                    projectsList.add(resultSet.getString("project"));
                }
            }
        } catch (Exception e) {
            logger.error(e.getMessage());
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
        return issuesList;
    }

    public List<IssueFormBean> getUserWisePlannedIssuesDetail() {
        SimpleDateFormat sdf = new SimpleDateFormat("dd-MMM-yy");
        SimpleDateFormat dateConversion = new SimpleDateFormat("yyyy-MM-dd");

        Connection connection = null;
        PreparedStatement ps = null;
        ResultSet resultSet = null;
        String extededQuery = "", sql = "";

        HashMap<Integer, String> member = GetProjectMembers.showUsersSName();
        try {
            Map<String, Integer> lastAsigneeAgeList = new HashMap<String, Integer>();
            Map<String, Integer> fileCountList = new HashMap<String, Integer>();

            if (plannedDate == null) {
                sql = "select i.issueid,CONCAT(pname ,CONCAT(' v',version)) as project, i.type, s.status, subject, description, priority, severity, i.createdby, i.createdon, \n"
                        + "mt.userid, i.modifiedon, due_date,rating,feedback,module,ceil(to_number(sysdate-to_date(i.createdon)))as age,mt.sino  from\n"
                        + "mom_user_task mt, issue i,issuestatus s,project p,modules m,PROJECT_PLANNED_ISSUE  pi  where pi.issueid = SUBSTR(task,0,12) and i.issueid = SUBSTR(task,0,12)\n"
                        + " and  i.issueid = s.issueid and i.module_id=m.moduleid and  i.pid = p.pid and mt.type='Issue' and tasktime='Planned'\n"
                        + " and to_char(momdate,'dd-Mon-yyyy') = to_char(SYSDATE,'dd-Mon-yyyy') and to_char(PLANNEDON,'dd-MON-yy') = to_char(SYSDATE,'dd-MON-yy') and pi.STATUS='Active'\n"
                        + "order by mt.userId,mt.sino";
            } else {
                sql = "select i.issueid,CONCAT(pname ,CONCAT(' v',version)) as project, i.type, s.status, subject, description, priority, severity, i.createdby, i.createdon, \n"
                        + "mt.userid, i.modifiedon, due_date,rating,feedback,module,ceil(to_number(sysdate-to_date(i.createdon)))as age,mt.sino  from\n"
                        + "mom_user_task mt, issue i,issuestatus s,project p,modules m,PROJECT_PLANNED_ISSUE  pi  where pi.issueid = SUBSTR(task,0,12) and i.issueid = SUBSTR(task,0,12)\n"
                        + "and  i.issueid = s.issueid and i.module_id=m.moduleid and  i.pid = p.pid and mt.type='Issue' and tasktime='Planned'\n"
                        + " and to_char(momdate,'dd-Mon-YYYY') = '" + plannedDate + "' and to_char(PLANNEDON,'dd-Mon-YYYY') = '" + plannedDate + "'  and pi.STATUS='Active' order by mt.userId,mt.sino";

            }
            connection = MakeConnection.getConnection();
            ps = connection.prepareStatement(sql, ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);

            resultSet = ps.executeQuery();
            String totalissuenos = "";
            while (resultSet.next()) {
                totalissuenos = totalissuenos + "'" + resultSet.getString("issueid").trim() + "',";
            }
            if (totalissuenos.contains(",")) {
                totalissuenos = totalissuenos.substring(0, totalissuenos.length() - 1);
                lastAsigneeAgeList = GetAge.issuelastAsigneeAge(totalissuenos);
                fileCountList = IssueDetails.displayFilesCount(totalissuenos);
            }
            resultSet.beforeFirst();
            while (resultSet.next()) {
                IssueFormBean isfb = new IssueFormBean();

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
                if (resultSet.getString("createdby") != null) {
                    isfb.setCreatedBy(member.get(Integer.valueOf(resultSet.getString("createdby"))));
                }
                if (resultSet.getString("userid") != null) {
                    isfb.setAssigntoId(Integer.valueOf(resultSet.getString("userid")));
                    isfb.setAssignto(member.get(Integer.valueOf(resultSet.getString("userid"))));
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
                if (plannedDate != null) {
                    isfb.setSino(resultSet.getInt("sino"));

                }
                issuesList.add(isfb);
                projectsList.add(resultSet.getString("project"));
            }

        } catch (Exception e) {
            logger.error(e.getMessage());
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
        return issuesList;
    }

    public List<IssueFormBean> getPlannedIssuesReportDetail(List<String> issues) {
        SimpleDateFormat sdf = new SimpleDateFormat("dd-MMM-yy");
        SimpleDateFormat dateConversion = new SimpleDateFormat("yyyy-MM-dd");
        List<IssuesTask> wrmIssues = new ArrayList<IssuesTask>();
        Connection connection = null;
        PreparedStatement ps = null;
        ResultSet resultSet = null;
        String extededQuery = "";
        String totalissuenos = "";
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
        try {
            if (!"".equals(extededQuery)) {
                Map<String, Integer> lastAsigneeAgeList = new HashMap<String, Integer>();
                Map<String, Integer> fileCountList = new HashMap<String, Integer>();
                if (totalissuenos.contains(",")) {
                    totalissuenos = totalissuenos.substring(0, totalissuenos.length() - 1);
                    lastAsigneeAgeList = GetAge.issuelastAsigneeAge(totalissuenos);
                    fileCountList = IssueDetails.displayFilesCount(totalissuenos);
                }
                String sql = "select i.issueid,p.pid as projId,CONCAT(pname ,CONCAT(' v',version)) as project, type, s.status, subject, description, priority, severity, createdby, createdon, assignedto, modifiedon, due_date,rating,feedback,module,ceil(to_number(sysdate-to_date(createdon)))as age  from issue i,issuestatus s,project p,modules m where i.issueid = s.issueid and i.module_id=m.moduleid and  i.pid = p.pid and (" + extededQuery + ")    order by pname, due_date asc, modifiedon asc, type asc, priority asc, severity asc, createdon asc";
                connection = MakeConnection.getConnection();
                logger.info(sql);
                ps = connection.prepareStatement(sql, ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);

                resultSet = ps.executeQuery();
                while (resultSet.next()) {
                    IssueFormBean isfb = new IssueFormBean();

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
                    projectsList.add(resultSet.getString("project"));
                }

            }

            //Map<Long, String> allWIPProjects = maintainWRMDay.projectList();
            Map<Integer, String> projects = MoMUtil.getProjects();
            Map<String, List<IssueFormBean>> projectwise = new HashMap<String, List<IssueFormBean>>();
            for (IssueFormBean issue : issuesList) {
                List<IssueFormBean> list = projectwise.get(issue.getpName());
                if (list == null) {
                    list = new ArrayList<>();
                    projectwise.put(issue.getpName(), list);
                }
                list.add(issue);
            }
            List<String> plannedIssueList;
            for (Map.Entry<Integer, String> entry : projects.entrySet()) {
                IssueCountFormBean issueCountFormBean = new IssueCountFormBean();
                plannedIssueList = new ArrayList<String>();
                issueCountFormBean.setProjectId(entry.getKey());
                issueCountFormBean.setProjectName(entry.getValue());
                issueCountFormBean.setOpenIssuesCount(IssueDetails.openIssuesByProject(issueCountFormBean.getProjectId() + "").length);
                wrmIssues = ViewMomController.momWrmIssues(issueCountFormBean.getProjectId() + "", plannedDate);
                List<String> wrmIssueNos = MoMUtil.convertIssueNo(wrmIssues);

                if (projectwise.containsKey(entry.getValue())) {
                    for (IssueFormBean ifb : projectwise.get(entry.getValue())) {
                        if (plannedIssuesList.contains(ifb.getIssueId()) && momplannedIssuesList.contains(ifb.getIssueId())) {
                            plannedIssueList.add(ifb.getIssueId());
                        }
                        if (!plannedIssuesList.contains(ifb.getIssueId()) && momplannedIssuesList.contains(ifb.getIssueId())) {
                            plannedIssueList.add(ifb.getIssueId());
                        }
                    }
                    wrmIssuesByPid.put(entry.getValue(), wrmIssueNos);
                }

                issueCountFormBean.setPlannedIssuesCount(plannedIssueList.size());
                issueCountFormBean.setWrmIssuesCount(wrmIssueNos.size());
                issueCountFormBean.setWrmPlannedIssuesCount(intersection(plannedIssueList, wrmIssueNos).size());
                issueCountFormBean.setNonWrmPlannedIssuesCount(issueCountFormBean.getPlannedIssuesCount() - issueCountFormBean.getWrmPlannedIssuesCount());
                countList.add(issueCountFormBean);
            }
            Collections.sort(countList, new Comparator<IssueCountFormBean>() {
                @Override
                public int compare(IssueCountFormBean t1, IssueCountFormBean t2) {
                    return t1.getProjectName().compareTo(t2.getProjectName());
                }
            }
            );
        } catch (Exception e) {
            logger.error(e.getMessage());
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
        return issuesList;
    }
    //    public static String projectIssue(List<IssueFormBean> issuesList) {
    //        String bgcolor = "";
    //        for( issuesList)
    //        return bgcolor;
    //    }

    public static String severityColor(String sev) {
        String bgcolor = "";
        String s1 = "S1- Fatal";
        String s2 = "S2- Critical";
        String s3 = "S3- Important";
        String s4 = "S4- Minor";
        if (sev.equals(s1)) {
            bgcolor = "#FF0000";
        } else if (sev.equals(s2)) {
            bgcolor = "#FF9900";
        } else if (sev.equals(s3)) {
            bgcolor = "#FFFF00";
        } else if (sev.equals(s4)) {
            bgcolor = "#00FF40";
        }
        return bgcolor;
    }

    public String getPlannedDate() {
        return plannedDate;
    }

    public void setPlannedDate(String plannedDate) {
        this.plannedDate = plannedDate;
    }

    public List<String> getPlannedIssuesList() {
        return plannedIssuesList;
    }

    public void setPlannedIssuesList(List<String> plannedIssuesList) {
        this.plannedIssuesList = plannedIssuesList;
    }

    public List<String> getMomplannedIssuesList() {
        return momplannedIssuesList;
    }

    public void setMomplannedIssuesList(List<String> momplannedIssuesList) {
        this.momplannedIssuesList = momplannedIssuesList;
    }

    public List<IssueFormBean> getIssuesList() {
        return issuesList;
    }

    public void setIssuesList(List<IssueFormBean> issuesList) {
        this.issuesList = issuesList;
    }

    public Set<String> getProjectsList() {
        return projectsList;
    }

    public void setProjectsList(Set<String> projectsList) {
        this.projectsList = projectsList;
    }

    public List<String> getModList() {
        return modList;
    }

    public void setModList(List<String> modList) {
        this.modList = modList;
    }

    public List<IssueCountFormBean> getCountList() {
        return countList;
    }

    public void setCountList(List<IssueCountFormBean> countList) {
        this.countList = countList;
    }

    public Map<String, List<String>> getWrmIssuesByPid() {
        return wrmIssuesByPid;
    }

    public void setWrmIssuesByPid(Map<String, List<String>> wrmIssuesByPid) {
        this.wrmIssuesByPid = wrmIssuesByPid;
    }

    public <T> List<T> union(List<T> list1, List<T> list2) {
        Set<T> set = new HashSet<T>();

        set.addAll(list1);
        set.addAll(list2);

        return new ArrayList<T>(set);
    }

    public <T> List<T> intersection(List<T> list1, List<T> list2) {
        List<T> list = new ArrayList<T>();

        for (T t : list1) {
            if (list2.contains(t)) {
                list.add(t);
            }
        }

        return list;
    }

    public Map<Integer, String> getUsersList() {
        return usersList;
    }

    public void setUsersList(Map<Integer, String> usersList) {
        this.usersList = usersList;
    }

    public Map<Integer, List<IssueFormBean>> getUserwise() {
        return userwise;
    }

    public void setUserwise(Map<Integer, List<IssueFormBean>> userwise) {
        this.userwise = userwise;
    }

}
