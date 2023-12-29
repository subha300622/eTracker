/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eminentlabs.mom.controller;

import com.eminentlabs.mom.MoMUtil;
import com.eminent.holidays.Holidays;
import com.eminent.holidays.HolidaysUtil;
import com.eminent.issue.PlanStatus;
import com.eminent.issue.ProjectPlannedIssue;
import com.eminent.issue.dao.EscalationDAO;
import com.eminent.issue.dao.EscalationDAOImpl;
import com.eminent.issue.formbean.PlannedIssueReport;
import com.eminent.scheduler.controller.NextDayScheduler;
import com.eminent.util.GetProjectMembers;
import com.eminent.util.ProjectPlanUtil;
import com.eminentlabs.dao.HibernateFactory;
import com.eminentlabs.mom.FineUtil;
import com.eminentlabs.mom.IssuesTask;
import static com.eminentlabs.mom.MoMUtil.nextDay;
import static com.eminentlabs.mom.MoMUtil.subtractDay;
import com.eminentlabs.mom.MomMaintanance;
import com.eminentlabs.mom.MomUserTask;
import com.eminentlabs.mom.formbean.FineAmountBean;
import com.eminentlabs.mom.formbean.MomDaySummationFormbean;
import com.eminentlabs.mom.formbean.UserwizeMoM;
import com.eminentlabs.mom.formbean.ViewMomFormBean;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.LinkedHashSet;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.ResourceBundle;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.hibernate.Query;
import org.hibernate.Session;
import pack.eminent.encryption.MakeConnection;

/**
 *
 * @author EMINENT
 */
public class ViewMomController {

    static org.apache.log4j.Logger logger = null;

    static {
        logger = org.apache.log4j.Logger.getLogger(ViewMomController.class.getName());
    }
    private String momDate;
    private String currentDate;
    private int projectId;
    private int momTeamType, branch;
    private String keys;
    String momTimeForBoth = "'Morning'," + "'Evening'";
    List<ViewMomFormBean> viewMomFormBeans = new ArrayList<ViewMomFormBean>();
    Map<Integer, String> momProjects = new LinkedHashMap< Integer, String>();
    private String attDetails[][];
    private String projDetails[][];
    String leaveDate[][];
    private static ResourceBundle rb = null;
    private int userId;
    List<FineAmountBean> fineAmtToday = new ArrayList<FineAmountBean>();
    MomDaySummationFormbean previousDaySummationFormbean = new MomDaySummationFormbean();
    MomDaySummationFormbean momDaySummationFormbean = new MomDaySummationFormbean();
    MomDaySummationFormbean nextDaySummationFormbean = new MomDaySummationFormbean();
    Map<Integer, String> momTypeList = new LinkedHashMap<Integer, String>();
    List<MomMaintanance> momUsers = new ArrayList<MomMaintanance>();

    static {
        rb = ResourceBundle.getBundle("Resources");
    }
    String mods = rb.getString("mom-mods");
    String noOfIds[] = mods.split(",");

    List<String> modList = Arrays.asList(noOfIds);

    public void setAll(HttpServletRequest request) {
        Calendar cal = Calendar.getInstance();
        cal.setTime(new Date());
        Long start = cal.getTimeInMillis();
        MomMaintananceController mmc = new MomMaintananceController();
        cal.setTime(new Date());
        Long startTime = cal.getTimeInMillis();
        EscalationDAO escalationDAO = new EscalationDAOImpl();

        List<MomMaintanance> mmList = mmc.findAll();
        Map<Integer, Set<Integer>> branchwiseUsers = GetProjectMembers.getUsersByBranch();

        cal.setTime(new Date());
        Long endtime = cal.getTimeInMillis();
        if ((endtime - startTime) > 30) {
            logger.info("ViewMom maintenance **********setAll***** mmc.findAll() *********End*******= " + endtime + "  total time :" + (endtime - startTime) + " ms");
        }
        Map<Integer, List<MomMaintanance>> mmcSplit = mmc.splitLists(mmList);
        momTypeList = momTypeMaintanance();
        Map<String, Map<String, String>> closedIssueMapByDate = new HashMap<String, Map<String, String>>();

        DateFormat sdf = new SimpleDateFormat("dd-MMM-yyyy");
        Calendar c = new GregorianCalendar();
        Date date = c.getTime();
        currentDate = sdf.format(date);
        HttpSession session = request.getSession();
        userId = (Integer) session.getAttribute("userid_curr");
        MomMaintanance mm = mmc.findByList(mmList, userId);
        int roleId = (Integer) session.getAttribute("Role");
        session.setAttribute("forwardpage", "/MOM/momView.jsp");
        String sync = request.getParameter("sync");
        String pissues[] = request.getParameterValues("pissues");

        if (sync != null) {
            if (sync.equalsIgnoreCase("true")) {
                NextDayScheduler nds = new NextDayScheduler();
                nds.executeme();
            }
        }

        session.getAttribute("Role");
        String pid = request.getParameter("pid");
        SendMomMaintainController smmc = new SendMomMaintainController();
        smmc.getLocationNBranch(userId);
        int userid = smmc.getSendMomMaintenance().getUserId() == null ? 0 : smmc.getSendMomMaintenance().getUserId();

        if (pid != null) {
            if ("".equals(pid)) {
                pid = null;
            } else {
                projectId = MoMUtil.parseInteger(pid, 0);
            }
        }
        String branchId = request.getParameter("branch");
        if (branchId != null) {
            if ("".equals(branchId)) {
                branchId = null;
            } else {
                branch = MoMUtil.parseInteger(branchId, 0);
            }
        } else {
            branch = smmc.getSendMomMaintenance().getBranchId() == null ? (Integer) session.getAttribute("branch") : smmc.getSendMomMaintenance().getBranchId();
        }
        momDate = request.getParameter("momdate");
        String momTeamsType = request.getParameter("momTeamType");
        if (mm == null) {
            if (momTeamsType == null) {
                momTeamType = smmc.getSendMomMaintenance().getMomType() == null ? 0 : smmc.getSendMomMaintenance().getMomType();
            } else {
                momTeamType = MoMUtil.parseInteger(momTeamsType, momTeamType);
            }

        } else {
            if (momTeamsType == null) {
                momTeamType = smmc.getSendMomMaintenance().getMomType() == null ? mm.getTeam() : smmc.getSendMomMaintenance().getMomType();
            } else {
                if ("".equals(momTeamsType)) {

                } else {
                    momTeamType = mm.getTeam();
                    momTeamType = MoMUtil.parseInteger(momTeamsType, momTeamType);
                }
            }
        }

        if (momTeamType == 0) {
            momUsers = mmcSplit.get(1);
            momUsers.addAll(mmcSplit.get(2));
            momUsers.addAll(mmcSplit.get(3));
        } else if (momTeamType == 1) {
            momUsers = mmcSplit.get(1);
        } else if (momTeamType == 2 || momTeamType == 3) {
            momUsers = mmcSplit.get(2);
            momUsers.addAll(mmcSplit.get(3));
            momTeamType = 2;
        } else {
            momUsers.addAll(mmList);
        }

        List<Integer> userIds = new ArrayList<Integer>();

        if (branchId != null) {
            List<MomMaintanance> momUsersa = new ArrayList<MomMaintanance>();
            Set<Integer> users = branchwiseUsers.get(branch);
            if (users == null) {
                momUsers.clear();
            } else {
                for (MomMaintanance mmce : momUsers) {
                    for (Integer user : users) {
                        if (user == mmce.getUserid()) {
                            userIds.add(mmce.getUserid());
                            momUsersa.add(mmce);
                        }
                    }
                }
                momUsers.clear();
                momUsers.addAll(momUsersa);
            }
        } else {
            for (MomMaintanance mmce : momUsers) {
                userIds.add(mmce.getUserid());
            }
        }

        keys = "";
        Map<Integer, List<MomMaintanance>> needTeams = mmc.splitLists(momUsers);
        for (Integer key : needTeams.keySet()) {
            keys = keys + key + ",";
        }
        keys = keys.substring(0, keys.length() - 1);

        logger.info("momTeamType=--==-==--=" + momTeamType);
        if (momDate != null) {
            try {
                Date momDateFormat = sdf.parse(momDate);
                momDate = sdf.format(momDateFormat);
            } catch (ParseException ex) {
                Logger.getLogger(ViewMomController.class.getName()).log(Level.SEVERE, null, ex);
            }
        } else {
            momDate = sdf.format(date);
        }
        momProjects = MoMUtil.getProjects();

        try {
            List<String> esclatesIssues = escalationDAO.AllEscalations(projectId);
            Date requestDate = sdf.parse(momDate);
            Date previousDay = MoMUtil.previousDay(requestDate);
            Date nextWorkDay = MoMUtil.nextDay(requestDate);
            fineAmtToday = FineUtil.getFineAmtForDate(momDate, keys);
            boolean flag = true;
            while (flag == true) {
                List<Holidays> holidaysList = HolidaysUtil.findByHolidayDate(nextWorkDay);
                if (!holidaysList.isEmpty()) {
                    nextWorkDay = MoMUtil.nextDay(nextWorkDay);
                } else {
                    flag = false;
                }
            }
            flag = true;
            while (flag == true) {
                List<Holidays> holidaysList = HolidaysUtil.findByHolidayDate(nextWorkDay);
                if (!holidaysList.isEmpty()) {
                    previousDay = MoMUtil.previousDay(previousDay);
                } else {
                    flag = false;
                }
            }
            if (request.getMethod().equalsIgnoreCase("post") && pissues != null) {
                List<String> issues = Arrays.asList(pissues);
                List<MomUserTask> unplanTaskByUserList = new ArrayList<MomUserTask>();
                List<ProjectPlannedIssue> dayWisePlan = ProjectPlanUtil.findByDay(nextWorkDay);
                String[][] todayTaskDetails = MoMUtil.getTodayMOMDetail(sdf.format(nextWorkDay), "1,2,3");
                for (ProjectPlannedIssue ppi : dayWisePlan) {
                    if (!issues.contains(ppi.getIssueId())) {
                        ppi.setStatus(PlanStatus.INACTIVE.getStatus());
                        ppi.setModifiedOn(requestDate);
                        ProjectPlanUtil.updateProjectPlanIssue(ppi);
                    }
                }

                for (MomMaintanance mmce : momUsers) {
                    List<String> plannedIssues = new LinkedList<String>();
                    List<String> userPlannedIssues = new LinkedList<String>();
                    String[] userIdPlanned = request.getParameterValues(mmce.getUserid() + "PlannedIssues");
                    for (int j = 0; j < todayTaskDetails.length; j++) {
                        int momuser = MoMUtil.parseInteger(todayTaskDetails[j][0], 0);
                        if (momuser == mmce.getUserid()) {
                            if (todayTaskDetails[j][1].equalsIgnoreCase("Issue")) {
                                if (issues.contains(todayTaskDetails[j][2].substring(0, 12))) {
                                    plannedIssues.add(todayTaskDetails[j][2].substring(0, 12));
                                } else {
                                    MomUserTask momuserTask = new MomUserTask();
                                    momuserTask.setMomdate(nextWorkDay);
                                    momuserTask.setUserid(mmce.getUserid());
                                    momuserTask.setTask(todayTaskDetails[j][2].substring(0, 12));
                                    momuserTask.setType("Issue");
                                    unplanTaskByUserList.add(momuserTask);
                                }
                            }
                        }
                    }
                }

                if (unplanTaskByUserList.size() > 0) {
                    new MoMUtil().unplanTaskByIssueAndUserId(unplanTaskByUserList);
                }
            }
            //edit by mukesh leaveDate and getter setter 
            leaveDate = getLeavenext(momDate, sdf.format(nextWorkDay));
            List<String> nextdayprojectPlan = ProjectPlanUtil.findByPlannedOn(nextWorkDay);
            // String taskDetails[][] = getMOMDetail(momDate, pid, keys, branch);
            Map<Integer, List<UserwizeMoM>> userwisetask = getNewMOMDetail(momDate, pid, keys, branch);

            if (momDate.compareTo(currentDate) == 0 && roleId == 1) {
                projDetails = MoMUtil.getProjectsFornewMOM();
            }

            attDetails = MoMUtil.getMOMAttendance(momDate, momTimeForBoth, keys, branch);
            Map<String, String> issueList = new LinkedHashMap<>();

            Map<String, String> closedIssueOnToday = new HashMap<String, String>();
            if (closedIssueMapByDate.containsKey(momDate)) {
                closedIssueOnToday = closedIssueMapByDate.get(momDate);
            } else {
                closedIssueOnToday = MoMUtil.closedIssuesOnDate(momDate);
                closedIssueMapByDate.put(momDate, closedIssueOnToday);
            }
            Map<String, String> prevClosedIssueOnToday = new LinkedHashMap<String, String>();
            String[][] actalUpdatedIssues = getCurrentActuals(new ArrayList(), requestDate, pid);
            List<IssuesTask> wrmIssues = new ArrayList<IssuesTask>();
            wrmIssues = momWrmIssues(pid, momDate);
//            List<IssuesTask> wrmPlanIssues = new ArrayList<IssuesTask>();
//            wrmPlanIssues = MoMUtil.momWrmIssuesByPlan(pid, momDate);
            List<String> wrmIssueNos = MoMUtil.convertIssueNo(wrmIssues);

            List<String> todayprojectPlan = ProjectPlanUtil.findByPlannedOn(requestDate);
            String name = "", plan = "", type = "";
            int preMomuserId = 0;
            String status = "";
            String issueno = "";
            String issueSubject = "";
            String pName = "";
            String color = "", escColor = "", ratingColor = "";
            pName = "";
            for (Map.Entry<Integer, List<UserwizeMoM>> uEntry : userwisetask.entrySet()) {
                ViewMomFormBean vmfb = new ViewMomFormBean();
                vmfb.setUserId(uEntry.getKey());
                List<String> previousPlan = new LinkedList<>();
                List<String> todayPlan = new LinkedList<>();
                List<String> nextPlan = new LinkedList<>();
                for (UserwizeMoM umm : uEntry.getValue()) {
                    color = "";
                    escColor = "";
                    ratingColor = "";
                    status = "";
                    vmfb.setName(umm.getName());
                    vmfb.setLeaveToday(todayleave(uEntry.getKey(), requestDate));
                    vmfb.setLeaveNextday(nextleave(uEntry.getKey(), nextWorkDay));
                    if (requestDate.compareTo(sdf.parse(umm.getPlannedDate())) > 0) { // previous date
                        if (closedIssueMapByDate.containsKey(umm.getPlannedDate())) {
                            prevClosedIssueOnToday = closedIssueMapByDate.get(umm.getPlannedDate());
                        } else {
                            prevClosedIssueOnToday = MoMUtil.closedIssuesOnDate(umm.getPlannedDate());
                            closedIssueMapByDate.put(umm.getPlannedDate(), closedIssueOnToday);
                        }
                        if (umm.getTime().equalsIgnoreCase("Planned")) {
                            if (umm.getType().equalsIgnoreCase("count")) {
                                vmfb.getPrevDayPlanTasks().add(umm.getTask());
                            } else if (umm.getType().equalsIgnoreCase("Issue")) {
                                IssuesTask it = MoMUtil.getIssueDetails(umm.getTask());
                                previousPlan.add(it.getIssueno());
                                if (esclatesIssues.contains(it.getIssueno())) {
                                    escColor = "red";
                                }
                                if (prevClosedIssueOnToday.containsKey(it.getIssueno())) {
                                    ratingColor = prevClosedIssueOnToday.get(it.getIssueno());
                                }

                                if (wrmIssueNos.contains(it.getIssueno())) {
                                    vmfb.getPrevDayPlanTasks().add((umm.getSino() == 0 ? "" : (umm.getSino() + ".")) + "<font style='color:" + escColor + ";'><a href=\"../viewIssueDetails.jsp?issueid=" + it.getIssueno() + "\" title='" + it.getProjectName() + "' target='_blank'> <font style=background-color:" + ratingColor + ";>" + it.getIssueno() + " </font></a> # " + it.getStatus() + " :  " + it.getSubject() + "<img src='/eTracker/images/exclamation.png'   title='WRM Planned Issue'  style='cursor: pointer;height: 9px;'/>&nbsp;<img src='/eTracker/images/tick.png'  title='Customer Priority + Delivery Planned'  style='cursor: pointer;'/></font><br/>");
                                } else {
                                    vmfb.getPrevDayPlanTasks().add((umm.getSino() == 0 ? "" : (umm.getSino() + ".")) + "<font style='color:" + escColor + ";'><a href=\"../viewIssueDetails.jsp?issueid=" + it.getIssueno() + "\" title='" + it.getProjectName() + "' target='_blank'> <font style=background-color:" + ratingColor + ";>" + it.getIssueno() + " </font> </a># " + it.getStatus() + " :   " + it.getSubject() + "<img src='/eTracker/images/tick.png'  title='Customer Priority + Delivery Planned'  style='cursor: pointer;'/></font><br/>");
                                }
                            } else { // previous day planned task                                                        
                                vmfb.getPrevDayPlanTasks().add(umm.getTask() + "<img src='/eTracker/images/tick.png'  title='Customer Priority + Delivery Planned'  style='cursor: pointer;'/>");
                            }
                        } else {
                            if (umm.getType().equalsIgnoreCase("count")) {
                                vmfb.getPrevDayActualTasks().add(umm.getTask());
                            } else if (umm.getType().equalsIgnoreCase("issue")) {
                                IssuesTask it = MoMUtil.getIssueDetails(umm.getTask());
                                if (esclatesIssues.contains(it.getIssueno())) {
                                    escColor = "red";
                                }
                                if (prevClosedIssueOnToday.containsKey(it.getIssueno())) {
                                    ratingColor = prevClosedIssueOnToday.get(it.getIssueno());
                                }
                                if (previousPlan.contains(it.getIssueno())) {
                                    if (wrmIssueNos.contains(it.getIssueno())) {
                                        vmfb.getPrevDayActualTasks().add("<font style='color:" + escColor + ";'><a href=\"../viewIssueDetails.jsp?issueid=" + it.getIssueno() + "\" title='" + it.getProjectName() + "' target='_blank'> <font style=background-color:" + ratingColor + ";>" + it.getIssueno() + " </font></a> # " + it.getStatus() + " :  " + it.getSubject() + "<img src='/eTracker/images/exclamation.png'   title='WRM Planned Issue'  style='cursor: pointer;height: 9px;'/>&nbsp;<img src='/eTracker/images/tick.png'  title='Customer Priority + Delivery Planned'  style='cursor: pointer;'/></font><br/>");
                                    } else {
                                        vmfb.getPrevDayActualTasks().add("<font style='color:" + escColor + ";'><a href=\"../viewIssueDetails.jsp?issueid=" + it.getIssueno() + "\" title='" + it.getProjectName() + "' target='_blank'> <font style=background-color:" + ratingColor + ";>" + it.getIssueno() + " </font> </a># " + it.getStatus() + " :   " + it.getSubject() + "<img src='/eTracker/images/tick.png'  title='Customer Priority + Delivery Planned'  style='cursor: pointer;'/></font><br/>");
                                    }
                                } else {
                                    if (wrmIssueNos.contains(it.getIssueno())) {
                                        vmfb.getPrevDayActualTasks().add("<font style='color:" + escColor + ";'><a href=\"../viewIssueDetails.jsp?issueid=" + it.getIssueno() + "\" title='" + it.getProjectName() + "' target='_blank'> <font style=background-color:" + ratingColor + ";>" + it.getIssueno() + " </font></a> # " + it.getStatus() + " :  " + it.getSubject() + "<img src='/eTracker/images/exclamation.png'   title='WRM Planned Issue'  style='cursor: pointer;height: 9px;'/></font><br/>");
                                    } else {
                                        vmfb.getPrevDayActualTasks().add("<font style='color:" + escColor + ";'><a href=\"../viewIssueDetails.jsp?issueid=" + it.getIssueno() + "\" title='" + it.getProjectName() + "' target='_blank'> <font style=background-color:" + ratingColor + ";>" + it.getIssueno() + " </font> </a># " + it.getStatus() + " :   " + it.getSubject() + "</font><br/>");
                                    }
                                }
                            } else {
                                vmfb.getPrevDayActualTasks().add(umm.getTask() + "<img src='/eTracker/images/tick.png'  title='Customer Priority + Delivery Planned'  style='cursor: pointer;'/>");
                            }
                        }
                    } else if (requestDate.compareTo(sdf.parse(umm.getPlannedDate())) == 0) { // current date
                        if (umm.getTime().equalsIgnoreCase("Planned")) {
                            if (umm.getType().equalsIgnoreCase("count")) {
                                vmfb.getCurrentDayPlanTasks().add(umm.getTask());
                            } else if (umm.getType().equalsIgnoreCase("Issue")) {
                                IssuesTask it = MoMUtil.getIssueDetails(umm.getTask());
                                todayPlan.add(it.getIssueno());
                                if (esclatesIssues.contains(it.getIssueno())) {
                                    escColor = "red";
                                }
                                if (closedIssueOnToday.containsKey(it.getIssueno())) {
                                    ratingColor = closedIssueOnToday.get(it.getIssueno());
                                }
                                if (todayprojectPlan.contains(it.getIssueno())) {
                                    if (wrmIssueNos.contains(it.getIssueno())) {
                                        vmfb.getCurrentDayPlanTasks().add((umm.getSino() == 0 ? "" : (umm.getSino() + ".")) + "<font style='color:" + escColor + ";'><a href=\"../viewIssueDetails.jsp?issueid=" + it.getIssueno() + "\" title='" + it.getProjectName() + "' target='_blank'> <font style=background-color:" + ratingColor + ";>" + it.getIssueno() + " </font></a> # " + it.getStatus() + " :  " + it.getSubject() + "<img src='/eTracker/images/exclamation.png'   title='WRM Planned Issue'  style='cursor: pointer;height: 9px;'/>&nbsp;<img src='/eTracker/images/tick.png'  title='Customer Priority + Delivery Planned'  style='cursor: pointer;'/></font><br/>");
                                    } else {
                                        vmfb.getCurrentDayPlanTasks().add((umm.getSino() == 0 ? "" : (umm.getSino() + ".")) + "<font style='color:" + escColor + ";'><a href=\"../viewIssueDetails.jsp?issueid=" + it.getIssueno() + "\" title='" + it.getProjectName() + "' target='_blank'> <font style=background-color:" + ratingColor + ";>" + it.getIssueno() + " </font> </a># " + it.getStatus() + " :   " + it.getSubject() + "<img src='/eTracker/images/tick.png'  title='Customer Priority + Delivery Planned'  style='cursor: pointer;'/></font><br/>");
                                    }
                                }
                            } else {
                                vmfb.getCurrentDayPlanTasks().add(umm.getTask() + "<img src='/eTracker/images/tick.png'  title='Customer Priority + Delivery Planned'  style='cursor: pointer;'/>");
                            }
                        } else {
                            if (umm.getType().equalsIgnoreCase("count")) {
                                vmfb.getCurrentDayActualTasks().add(umm.getTask());
                            } else if (umm.getType().equalsIgnoreCase("issue")) {
                                IssuesTask it = MoMUtil.getIssueDetails(umm.getTask());
                                if (esclatesIssues.contains(it.getIssueno())) {
                                    escColor = "red";
                                }
                                if (closedIssueOnToday.containsKey(it.getIssueno())) {
                                    ratingColor = closedIssueOnToday.get(it.getIssueno());
                                }
                                if (todayPlan.contains(it.getIssueno())) {

                                    if (wrmIssueNos.contains(it.getIssueno())) {
                                        vmfb.getCurrentDayActualTasks().add("<font style='color:" + escColor + ";'><a href=\"../viewIssueDetails.jsp?issueid=" + it.getIssueno() + "\" title='" + it.getProjectName() + "' target='_blank'> <font style=background-color:" + ratingColor + ";>" + it.getIssueno() + " </font></a> # " + it.getStatus() + " :  " + it.getSubject() + "<img src='/eTracker/images/exclamation.png'   title='WRM Planned Issue'  style='cursor: pointer;height: 9px;'/>&nbsp;<img src='/eTracker/images/tick.png'  title='Customer Priority + Delivery Planned'  style='cursor: pointer;'/></font><br/>");
                                    } else {
                                        vmfb.getCurrentDayActualTasks().add("<font style='color:" + escColor + ";'><a href=\"../viewIssueDetails.jsp?issueid=" + it.getIssueno() + "\" title='" + it.getProjectName() + "' target='_blank'> <font style=background-color:" + ratingColor + ";>" + it.getIssueno() + " </font> </a># " + it.getStatus() + " :   " + it.getSubject() + "<img src='/eTracker/images/tick.png'  title='Customer Priority + Delivery Planned'  style='cursor: pointer;'/></font><br/>");
                                    }

                                } else {
                                    if (wrmIssueNos.contains(it.getIssueno())) {
                                        vmfb.getCurrentDayActualTasks().add("<font style='color:" + escColor + ";'><a href=\"../viewIssueDetails.jsp?issueid=" + it.getIssueno() + "\" title='" + it.getProjectName() + "' target='_blank'> <font style=background-color:" + ratingColor + ";>" + it.getIssueno() + " </font></a> # " + it.getStatus() + " :  " + it.getSubject() + "<img src='/eTracker/images/exclamation.png'   title='WRM Planned Issue'  style='cursor: pointer;height: 9px;'/></font><br/>");
                                    } else {
                                        vmfb.getCurrentDayActualTasks().add("<font style='color:" + escColor + ";'><a href=\"../viewIssueDetails.jsp?issueid=" + it.getIssueno() + "\" title='" + it.getProjectName() + "' target='_blank'> <font style=background-color:" + ratingColor + ";>" + it.getIssueno() + " </font> </a># " + it.getStatus() + " :   " + it.getSubject() + "</font><br/>");
                                    }
                                }
                            } else {
                                vmfb.getCurrentDayActualTasks().add(umm.getTask() + "<img src='/eTracker/images/tick.png'  title='Customer Priority + Delivery Planned'  style='cursor: pointer;'/>");
                            }
                        }
                    } else if (requestDate.compareTo(sdf.parse(umm.getPlannedDate())) < 0) { // next date

                        if (umm.getTime().equalsIgnoreCase("Planned")) {
                            if (umm.getType().equalsIgnoreCase("count")) {
                                vmfb.getNextDayPlanTasks().add(umm.getTask());
                            } else if (umm.getType().equalsIgnoreCase("Issue")) {
                                IssuesTask it = MoMUtil.getIssueDetails(umm.getTask());
                                nextPlan.add(it.getIssueno());
                                if (esclatesIssues.contains(it.getIssueno())) {
                                    escColor = "red";
                                }
                                if (nextdayprojectPlan.contains(it.getIssueno())) {
                                    if (momDate.compareTo(currentDate) == 0 && userId == userid) {
                                        if (wrmIssueNos.contains(it.getIssueno())) {
                                            vmfb.getNextDayPlanTasks().add((umm.getSino() == 0 ? "" : (umm.getSino() + ".")) + "<input type='checkbox'  name='pissues'   value='" + it.getIssueno() + "' checked='true'><input type='hidden' name='" + vmfb.getUserId() + "PlannedIssues' value='" + it.getIssueno() + "'/><font style='color:" + escColor + ";'><a href=\"../viewIssueDetails.jsp?issueid=" + it.getIssueno() + "\" target='_blank' title='" + it.getProjectName() + "' style='text-decoration:none;'><font style=background-color:" + color + ";text-decoration:none;>" + it.getIssueno() + "</font></a># " + it.getStatus() + " :  " + it.getSubject() + " <img src='/eTracker/images/exclamation.png'   title='WRM Planned Issue'  style='cursor: pointer;height: 9px;'/>&nbsp;<img src='/eTracker/images/tick.png'  title='Customer Priority + Delivery Planned'  style='cursor: pointer;'/></font><br/>");
                                        } else {
                                            vmfb.getNextDayPlanTasks().add((umm.getSino() == 0 ? "" : (umm.getSino() + ".")) + "<input type='checkbox'  name='pissues'   value='" + it.getIssueno() + "' checked='true'><input type='hidden' name='" + vmfb.getUserId() + "PlannedIssues' value='" + it.getIssueno() + "'/><font style='color:" + escColor + ";'><a href=\"../viewIssueDetails.jsp?issueid=" + it.getIssueno() + "\" target='_blank' title='" + it.getProjectName() + "' style='text-decoration:none;'><font style=background-color:" + color + ";text-decoration:none;>" + it.getIssueno() + "</font></a># " + it.getStatus() + " :  " + it.getSubject() + " <img src='/eTracker/images/tick.png'  title='Customer Priority + Delivery Planned'  style='cursor: pointer;'/></font><br/>");
                                        }
                                    } else {
                                        if (wrmIssueNos.contains(it.getIssueno())) {
                                            vmfb.getNextDayPlanTasks().add((umm.getSino() == 0 ? "" : (umm.getSino() + ".")) + "<font style='color:" + escColor + ";'><a href=\"../viewIssueDetails.jsp?issueid=" + it.getIssueno() + "\" title='" + it.getProjectName() + "' target='_blank'> <font style=background-color:" + ratingColor + ";>" + it.getIssueno() + " </font></a> # " + it.getStatus() + " :  " + it.getSubject() + "<img src='/eTracker/images/exclamation.png'   title='WRM Planned Issue'  style='cursor: pointer;height: 9px;'/>&nbsp;<img src='/eTracker/images/tick.png'  title='Customer Priority + Delivery Planned'  style='cursor: pointer;'/></font><br/>");
                                        } else {
                                            vmfb.getNextDayPlanTasks().add((umm.getSino() == 0 ? "" : (umm.getSino() + ".")) + "<font style='color:" + escColor + ";'><a href=\"../viewIssueDetails.jsp?issueid=" + it.getIssueno() + "\" title='" + it.getProjectName() + "' target='_blank'> <font style=background-color:" + ratingColor + ";>" + it.getIssueno() + " </font> </a># " + it.getStatus() + " :   " + it.getSubject() + "<img src='/eTracker/images/tick.png'  title='Customer Priority + Delivery Planned'  style='cursor: pointer;'/></font><br/>");
                                        }
                                    }
                                }
                            } else {
                                vmfb.getNextDayPlanTasks().add(umm.getTask() + "<img src='/eTracker/images/tick.png'  title='Customer Priority + Delivery Planned'  style='cursor: pointer;'/>");
                            }
                        } else {
                            if (umm.getType().equalsIgnoreCase("count")) {
                                vmfb.getNextDayActualTasks().add(umm.getTask());
                            } else if (umm.getType().equalsIgnoreCase("Issue")) {
                                IssuesTask it = MoMUtil.getIssueDetails(umm.getTask());
                                if (esclatesIssues.contains(it.getIssueno())) {
                                    escColor = "red";
                                }
                                if (nextPlan.contains(it.getIssueno())) {
                                    if (wrmIssueNos.contains(it.getIssueno())) {
                                        vmfb.getNextDayActualTasks().add("<font style='color:" + escColor + ";'><a href=\"../viewIssueDetails.jsp?issueid=" + it.getIssueno() + "\" title='" + it.getProjectName() + "' target='_blank'> <font style=background-color:" + ratingColor + ";>" + it.getIssueno() + " </font></a> # " + it.getStatus() + " :  " + it.getSubject() + "<img src='/eTracker/images/exclamation.png'   title='WRM Planned Issue'  style='cursor: pointer;height: 9px;'/>&nbsp;<img src='/eTracker/images/tick.png'  title='Customer Priority + Delivery Planned'  style='cursor: pointer;'/></font><br/>");
                                    } else {
                                        vmfb.getNextDayActualTasks().add("<font style='color:" + escColor + ";'><a href=\"../viewIssueDetails.jsp?issueid=" + it.getIssueno() + "\" title='" + it.getProjectName() + "' target='_blank'> <font style=background-color:" + ratingColor + ";>" + it.getIssueno() + " </font> </a># " + it.getStatus() + " :   " + it.getSubject() + "<img src='/eTracker/images/tick.png'  title='Customer Priority + Delivery Planned'  style='cursor: pointer;'/></font><br/>");
                                    }
                                } else {
                                    if (wrmIssueNos.contains(it.getIssueno())) {
                                        vmfb.getNextDayActualTasks().add("<font style='color:" + escColor + ";'><a href=\"../viewIssueDetails.jsp?issueid=" + it.getIssueno() + "\" title='" + it.getProjectName() + "' target='_blank'> <font style=background-color:" + ratingColor + ";>" + it.getIssueno() + " </font></a> # " + it.getStatus() + " :  " + it.getSubject() + "<img src='/eTracker/images/exclamation.png'   title='WRM Planned Issue'  style='cursor: pointer;height: 9px;'/></font><br/>");
                                    } else {
                                        vmfb.getNextDayActualTasks().add("<font style='color:" + escColor + ";'><a href=\"../viewIssueDetails.jsp?issueid=" + it.getIssueno() + "\" title='" + it.getProjectName() + "' target='_blank'> <font style=background-color:" + ratingColor + ";>" + it.getIssueno() + " </font> </a># " + it.getStatus() + " :   " + it.getSubject() + "</font><br/>");
                                    }
                                }
                            } else {
                                vmfb.getNextDayActualTasks().add(umm.getTask() + "<img src='/eTracker/images/exclamation.png'   title='WRM Planned Issue'  style='cursor: pointer;height: 9px;'/>+ \"<img src='/eTracker/images/exclamation.png'   title='WRM Planned Issue'  style='cursor: pointer;height: 9px;'/>");
                            }
                        }
                    }
                }
                if (vmfb.getCurrentDayActualTasks().isEmpty()) {
                    issueList = MoMUtil.actalUpdatedIssues(vmfb.getUserId(), actalUpdatedIssues, momDate);
                    if (!issueList.isEmpty()) {
                        vmfb.getCurrentDayActualTasks().add("<b>Actual Updated Issues</b>");
                    }
                    for (Map.Entry<String, String> entry : issueList.entrySet()) {
                        String totalTask = entry.getKey() + entry.getValue();
                        IssuesTask iTask = MoMUtil.getIssueDetails(totalTask);
                        issueno = "";
                        issueSubject = "";
                        pName = "";
                        escColor = "";
                        if (totalTask.length() > 12) {
                            issueno = iTask.getIssueno().trim();
                            pName = iTask.getProjectName();
                            if (esclatesIssues.contains(issueno)) {
                                escColor = "red";
                                issueSubject = "# " + iTask.getStatus() + " :  " + iTask.getSubject().replace(":#D2691E", "#FF0000");;
                            } else {
                                issueSubject = "# " + iTask.getStatus() + " :  " + iTask.getSubject();
                            }
                        }
                        ratingColor = "";
                        if (closedIssueOnToday.containsKey(issueno)) {
                            ratingColor = closedIssueOnToday.get(issueno);
                        }
                        if (todayPlan.contains(iTask.getIssueno())) {
                            if (wrmIssueNos.contains(iTask.getIssueno())) {
                                vmfb.getCurrentDayActualTasks().add("<font style='color:" + escColor + ";'><a href=\"../viewIssueDetails.jsp?issueid=" + iTask.getIssueno() + "\" title='" + iTask.getProjectName() + "' target='_blank'> <font style=background-color:" + ratingColor + ";>" + iTask.getIssueno() + " </font></a> # " + iTask.getStatus() + " :  " + iTask.getSubject() + "<img src='/eTracker/images/exclamation.png'   title='WRM Planned Issue'  style='cursor: pointer;height: 9px;'/>&nbsp;<img src='/eTracker/images/tick.png'  title='Customer Priority + Delivery Planned'  style='cursor: pointer;'/></font><br/>");
                            } else {
                                vmfb.getCurrentDayActualTasks().add("<font style='color:" + escColor + ";'><a href=\"../viewIssueDetails.jsp?issueid=" + iTask.getIssueno() + "\" title='" + iTask.getProjectName() + "' target='_blank'> <font style=background-color:" + ratingColor + ";>" + iTask.getIssueno() + " </font> </a># " + iTask.getStatus() + " :   " + iTask.getSubject() + "<img src='/eTracker/images/tick.png'  title='Customer Priority + Delivery Planned'  style='cursor: pointer;'/></font><br/>");
                            }
                        } else {
                            if (wrmIssueNos.contains(iTask.getIssueno())) {
                                vmfb.getCurrentDayActualTasks().add("<font style='color:" + escColor + ";'><a href=\"../viewIssueDetails.jsp?issueid=" + iTask.getIssueno() + "\" title='" + iTask.getProjectName() + "' target='_blank'> <font style=background-color:" + ratingColor + ";>" + iTask.getIssueno() + " </font></a> # " + iTask.getStatus() + " :  " + iTask.getSubject() + "<img src='/eTracker/images/exclamation.png'   title='WRM Planned Issue'  style='cursor: pointer;height: 9px;'/></font><br/>");
                            } else {
                                vmfb.getCurrentDayActualTasks().add("<font style='color:" + escColor + ";'><a href=\"../viewIssueDetails.jsp?issueid=" + iTask.getIssueno() + "\" title='" + iTask.getProjectName() + "' target='_blank'> <font style=background-color:" + ratingColor + ";>" + iTask.getIssueno() + " </font> </a># " + iTask.getStatus() + " :   " + iTask.getSubject() + "</font><br/>");
                            }
                        }
                    }
                }
                // Next day planned issue is empty - need to show WRM planned for that user in grey mode
                if (vmfb.getNextDayPlanTasks().isEmpty()) {
                    List<IssuesTask> wrmplannedissue = MoMUtil.momWrmIssuesByUser(vmfb.getUserId(), wrmIssues);
                    for (IssuesTask iTask : wrmplannedissue) {
                        vmfb.getNextDayPlanTasks().add("<font style='color:#ccc;'><a style='color:#ccc;' href=\"../viewIssueDetails.jsp?issueid=" + iTask.getIssueno() + "\" title='" + iTask.getProjectName() + "' target='_blank'> <font style=background-color:" + ratingColor + ";>" + iTask.getIssueno() + " </font></a> # " + iTask.getStatus() + " :  " + iTask.getSubject() + "<img src='/eTracker/images/exclamation.png'   title='WRM Planned Issue'  style='cursor: pointer;height: 9px;opacity:0.3;filter: alpha(opacity=30);'/></font><br/>");
                    }
                }
                viewMomFormBeans.add(vmfb);
            }

        } catch (ParseException ex) {
            Logger.getLogger(ViewMomController.class
                    .getName()).log(Level.SEVERE, null, ex);
        }
        Calendar ca = new GregorianCalendar();
        Date datea = ca.getTime();
        logger.info("end" + datea);

        cal.setTime(new Date());
        Long end = cal.getTimeInMillis();
        logger.info("ViewMom maintenance **********setAll**************End*******= " + end + "  total time :" + (end - start) + " ms");

    }

    public static String[][] getMOMDetail(String dateFor, String pid, String teamType, int branch) {
        DateFormat sdf = new SimpleDateFormat("dd-MMM-yyyy");

        Date requestDate = null;
        try {
            requestDate = sdf.parse(dateFor);
        } catch (ParseException ex) {
            Logger.getLogger(ViewMomController.class.getName()).log(Level.SEVERE, null, ex);
        }
        Date nextWorkDay = MoMUtil.nextDay(requestDate);

        boolean flag = true;
        while (flag == true) {
            List<Holidays> holidaysList = HolidaysUtil.findByHolidayDate(nextWorkDay);
            if (!holidaysList.isEmpty()) {
                nextWorkDay = MoMUtil.nextDay(nextWorkDay);
            } else {
                flag = false;
            }
        }
        String nextDate = sdf.format(nextWorkDay);
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultset = null;
        String name = null, task = null;
        String projectDetails[][] = null;
        int rowcount = 0, count = 0;
        try {
            connection = MakeConnection.getConnection();

            String projectQuery = "select m.NAME, m.TASK, m.TASKTIME, m.TYPE, m.CREATEDBY, m.USERID, to_char(m.MOMDATE,'DD-Mon-YYYY'), m.MOMTASKID,mm.sino from (Select s.firstname ||' ' ||SUBSTR(s.lastname ,1 , 1) as name,t.task,t.tasktime,t.type,t.createdBy,t.userid,to_char(t.momdate,'DD-Mon-YYYY'),momdate,t.momtaskid,substr(task,0,12)as issueid  from mom_user_task t,users s where  t.userid=s.userid and(  (t.USERID,t.momdate) in (SELECT userid, momdate  FROM (Select userid,momdate, rank() over ( partition by userid order by momdate desc) rank  from mom_user_detail where (status='Present' OR status='Client Meeting') and userid in (select userid from mom_maintanance where team in(" + teamType + ")) and momdate < to_date('" + dateFor + "','DD-Mon-YYYY') and   momtime in ('Morning','Evening') group by userid,momdate order by userid,momdate desc ) where rank = 1 ) ) and t.userid in(select userid from mom_user_task where momdate = to_date('" + dateFor + "','DD-Mon-YYYY')) and type='Issue'  union Select s.firstname ||' ' ||SUBSTR(s.lastname ,1 , 1) as name,t.task,t.tasktime,t.type,t.createdBy,t.userid,to_char(t.momdate,'DD-Mon-YYYY') ,momdate,momtaskid,substr(task,0,12)as issueid from mom_user_task t,users s where  t.userid=s.userid  and (momdate=to_date('" + nextDate + "','DD-Mon-YYYY') OR momdate=to_date( '" + dateFor + "','DD-Mon-YYYY')) and t.userid in(select userid from mom_user_task where  momdate = to_date('" + dateFor + "','DD-Mon-YYYY'))  and type='Issue' and t.userid in (select userid from mom_maintanance where team in(" + teamType + "))   ) m,issue i,MOM_MAINTANANCE mm where i.issueid=m.issueid and i.pid=" + pid + "   and  mm.userId=m.userId order by mm.team,mm.userId,mm.sino,momdate,TASKTIME desc,m.type,momtaskid";
            if (branch > 0) {
                projectQuery = "select m.NAME, m.TASK, m.TASKTIME, m.TYPE, m.CREATEDBY, m.USERID, to_char(m.MOMDATE,'DD-Mon-YYYY'), m.MOMTASKID,mm.sino from (Select s.firstname ||' ' ||SUBSTR(s.lastname ,1 , 1) as name,t.task,t.tasktime,t.type,t.createdBy,t.userid,to_char(t.momdate,'DD-Mon-YYYY'),momdate,t.momtaskid,substr(task,0,12)as issueid  from mom_user_task t,users s where  t.userid=s.userid and s.branch_id=" + branch + " and(  (t.USERID,t.momdate) in (SELECT userid, momdate  FROM (Select userid,momdate, rank() over ( partition by userid order by momdate desc) rank  from mom_user_detail where (status='Present' OR status='Client Meeting') and userid in (select userid from mom_maintanance where team in(" + teamType + ")) and momdate < to_date('" + dateFor + "','DD-Mon-YYYY') and   momtime in ('Morning','Evening') group by userid,momdate order by userid,momdate desc ) where rank = 1 ) ) and t.userid in(select userid from mom_user_task where momdate = to_date('" + dateFor + "','DD-Mon-YYYY')) and type='Issue'  union Select s.firstname ||' ' ||SUBSTR(s.lastname ,1 , 1) as name,t.task,t.tasktime,t.type,t.createdBy,t.userid,to_char(t.momdate,'DD-Mon-YYYY') ,momdate,momtaskid,substr(task,0,12)as issueid  from mom_user_task t,users s where  t.userid=s.userid  and s.branch_id=" + branch + " and (momdate=to_date('" + nextDate + "','DD-Mon-YYYY') OR momdate=to_date( '" + dateFor + "','DD-Mon-YYYY')) and t.userid in(select userid from mom_user_task where  momdate = to_date('" + dateFor + "','DD-Mon-YYYY'))  and type='Issue' and t.userid in (select userid from mom_maintanance where team in(" + teamType + "))   ) m,issue i,MOM_MAINTANANCE mm where i.issueid=m.issueid and i.pid=" + pid + "   and  mm.userId=m.userId order by mm.team,mm.userId,mm.sino,momdate,TASKTIME desc,m.type,momtaskid";
            }
            if (pid == null) {
                projectQuery = "select NAME,TASK,TASKTIME,TYPE,CREATEDBY,op.USERID,TEXTMOMDATE,MOMDATE,MOMTASKID,op.sino  from (Select s.firstname ||' ' ||SUBSTR(s.lastname ,1 , 1) as name,t.task,t.tasktime,t.type,t.createdBy,t.userid,to_char(t.momdate,'DD-Mon-YYYY')as textmomdate ,momdate,t.momtaskid,t.SINO from mom_user_task t,users s where  t.userid=s.userid and(  (t.USERID,t.momdate) in (SELECT userid, momdate  FROM (Select userid,momdate, rank() over ( partition by userid order by momdate desc) rank  from mom_user_detail where (status='Present' OR status='Client Meeting') and userid in (select userid from mom_maintanance where team in(" + teamType + ")) and momdate < to_date('" + dateFor + "','DD-Mon-YYYY') and   momtime in ('Morning','Evening') group by userid,momdate order by userid,momdate desc ) where rank = 1 ) ) and t.userid in(select userid from mom_user_task where momdate = to_date('" + dateFor + "','DD-Mon-YYYY'))  union Select s.firstname ||' ' ||SUBSTR(s.lastname ,1 , 1) as name,t.task,t.tasktime,t.type,t.createdBy,t.userid,to_char(t.momdate,'DD-Mon-YYYY') ,momdate,momtaskid,t.SINO from mom_user_task t,users s where  t.userid=s.userid and (momdate=to_date('" + nextDate + "','DD-Mon-YYYY') OR momdate=to_date( '" + dateFor + "','DD-Mon-YYYY')) and t.userid in(select userid from mom_user_task where momdate = to_date('" + dateFor + "','DD-Mon-YYYY')) and t.userid in (select userid from mom_maintanance  where team in(" + teamType + "))  ) op,MOM_MAINTANANCE mm where mm.userId=op.userId order by mm.team,mm.sino,momdate,type,op.sino,TASKTIME desc,momtaskid";
                if (branch > 0) {
                    projectQuery = "select NAME,TASK,TASKTIME,TYPE,CREATEDBY,op.USERID,TEXTMOMDATE,MOMDATE,MOMTASKID,op.sino  from (Select s.firstname ||' ' ||SUBSTR(s.lastname ,1 , 1) as name,t.task,t.tasktime,t.type,t.createdBy,t.userid,to_char(t.momdate,'DD-Mon-YYYY')as textmomdate ,momdate,t.momtaskid,t.SINO from mom_user_task t,users s where  t.userid=s.userid  and s.branch_id=" + branch + " and(  (t.USERID,t.momdate) in (SELECT userid, momdate  FROM (Select userid,momdate, rank() over ( partition by userid order by momdate desc) rank  from mom_user_detail where (status='Present' OR status='Client Meeting') and userid in (select userid from mom_maintanance where team in(" + teamType + ")) and momdate < to_date('" + dateFor + "','DD-Mon-YYYY') and   momtime in ('Morning','Evening')  group by userid,momdate order by userid,momdate desc ) where rank = 1 ) ) and t.userid in(select userid from mom_user_task where momdate = to_date('" + dateFor + "','DD-Mon-YYYY'))  union Select s.firstname ||' ' ||SUBSTR(s.lastname ,1 , 1) as name,t.task,t.tasktime,t.type,t.createdBy,t.userid,to_char(t.momdate,'DD-Mon-YYYY') ,momdate,momtaskid,t.SINO from mom_user_task t,users s where  t.userid=s.userid and s.branch_id=" + branch + " and (momdate=to_date('" + nextDate + "','DD-Mon-YYYY') OR momdate=to_date( '" + dateFor + "','DD-Mon-YYYY')) and t.userid in(select userid from mom_user_task where momdate = to_date('" + dateFor + "','DD-Mon-YYYY')) and t.userid in (select userid from mom_maintanance  where team in(" + teamType + "))  ) op,MOM_MAINTANANCE mm where mm.userId=op.userId order by mm.team,mm.sino,momdate,op.sino,TASKTIME desc,type,momtaskid";
                }
            }
            preparedStatement = connection.prepareStatement(projectQuery, ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            resultset = preparedStatement.executeQuery(projectQuery);
            resultset.last();
            rowcount = resultset.getRow();

            projectDetails = new String[rowcount][9];
            resultset.beforeFirst();
            while (resultset.next()) {
                name = resultset.getString(1);
                task = resultset.getString(2);
                projectDetails[count][0] = name;
                projectDetails[count][1] = task;
                projectDetails[count][2] = resultset.getString(3);
                projectDetails[count][3] = resultset.getString(4);
                projectDetails[count][4] = resultset.getString(5);
                projectDetails[count][5] = resultset.getString(6);
                projectDetails[count][6] = resultset.getString(6);
                projectDetails[count][7] = resultset.getString(7);
                projectDetails[count][8] = resultset.getString(10);
                count++;
            }
        } catch (Exception e) {
            e.printStackTrace();
            logger.error(e.getMessage());
        } finally {
            try {

                if (resultset != null) {
                    resultset.close();
                }
                if (preparedStatement != null) {
                    preparedStatement.close();
                }
                if (connection != null) {
                    connection.close();
                }
            } catch (Exception ex) {
                logger.error(ex.getMessage());
            }
        }
        return projectDetails;
    }

    public static Map<Integer, List<UserwizeMoM>> getNewMOMDetail(String dateFor, String pid, String teamType, int branch) {
        Map<Integer, List<UserwizeMoM>> userwize = new LinkedHashMap();
        DateFormat sdf = new SimpleDateFormat("dd-MMM-yyyy");

        Date requestDate = null;
        try {
            requestDate = sdf.parse(dateFor);
        } catch (ParseException ex) {
            Logger.getLogger(ViewMomController.class.getName()).log(Level.SEVERE, null, ex);
        }
        Date nextWorkDay = MoMUtil.nextDay(requestDate);

        boolean flag = true;
        while (flag == true) {
            List<Holidays> holidaysList = HolidaysUtil.findByHolidayDate(nextWorkDay);
            if (!holidaysList.isEmpty()) {
                nextWorkDay = MoMUtil.nextDay(nextWorkDay);
            } else {
                flag = false;
            }
        }
        String nextDate = sdf.format(nextWorkDay);
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultset = null;

        int rowcount = 0, count = 0;

        try {
            connection = MakeConnection.getConnection();

            String projectQuery = "select m.NAME, m.TASK, m.TASKTIME, m.TYPE, m.CREATEDBY, m.USERID, to_char(m.MOMDATE,'DD-Mon-YYYY'), m.MOMTASKID,m.sino,m.sino from (Select s.firstname ||' ' ||SUBSTR(s.lastname ,1 , 1) as name,t.task,t.tasktime,t.type,t.createdBy,t.userid,to_char(t.momdate,'DD-Mon-YYYY'),momdate,t.momtaskid,substr(task,0,12)as issueid,t.sino  from mom_user_task t,users s where  t.userid=s.userid and(  (t.USERID,t.momdate) in (SELECT userid, momdate  FROM (Select userid,momdate, rank() over ( partition by userid order by momdate desc) rank  from mom_user_detail where (status='Present' OR status='Client Meeting') and userid in (select userid from mom_maintanance where team in(" + teamType + ")) and momdate < to_date('" + dateFor + "','DD-Mon-YYYY') and   momtime in ('Morning','Evening') group by userid,momdate order by userid,momdate desc ) where rank = 1 ) ) and t.userid in(select userid from mom_user_task where momdate = to_date('" + dateFor + "','DD-Mon-YYYY')) and type='Issue'  union Select s.firstname ||' ' ||SUBSTR(s.lastname ,1 , 1) as name,t.task,t.tasktime,t.type,t.createdBy,t.userid,to_char(t.momdate,'DD-Mon-YYYY') ,momdate,momtaskid,substr(task,0,12)as issueid,t.sino from mom_user_task t,users s where  t.userid=s.userid  and (momdate=to_date('" + nextDate + "','DD-Mon-YYYY') OR momdate=to_date( '" + dateFor + "','DD-Mon-YYYY')) and t.userid in(select userid from mom_user_task where  momdate = to_date('" + dateFor + "','DD-Mon-YYYY'))  and type='Issue' and t.userid in (select userid from mom_maintanance where team in(" + teamType + "))   ) m,issue i,MOM_MAINTANANCE mm where i.issueid=m.issueid and i.pid=" + pid + "   and  mm.userId=m.userId order by mm.team,mm.sino,m.sino,momdate,m.type,TASKTIME desc,momtaskid";
            if (branch > 0) {
                projectQuery = "select m.NAME, m.TASK, m.TASKTIME, m.TYPE, m.CREATEDBY, m.USERID, to_char(m.MOMDATE,'DD-Mon-YYYY'), m.MOMTASKID,m.sino,m.sino from (Select s.firstname ||' ' ||SUBSTR(s.lastname ,1 , 1) as name,t.task,t.tasktime,t.type,t.createdBy,t.userid,to_char(t.momdate,'DD-Mon-YYYY'),momdate,t.momtaskid,substr(task,0,12)as issueid,t.sino  from mom_user_task t,users s where  t.userid=s.userid and s.branch_id=" + branch + " and(  (t.USERID,t.momdate) in (SELECT userid, momdate  FROM (Select userid,momdate, rank() over ( partition by userid order by momdate desc) rank  from mom_user_detail where (status='Present' OR status='Client Meeting') and userid in (select userid from mom_maintanance where team in(" + teamType + ")) and momdate < to_date('" + dateFor + "','DD-Mon-YYYY') and   momtime in ('Morning','Evening') group by userid,momdate order by userid,momdate desc ) where rank = 1 ) ) and t.userid in(select userid from mom_user_task where momdate = to_date('" + dateFor + "','DD-Mon-YYYY')) and type='Issue'  union Select s.firstname ||' ' ||SUBSTR(s.lastname ,1 , 1) as name,t.task,t.tasktime,t.type,t.createdBy,t.userid,to_char(t.momdate,'DD-Mon-YYYY') ,momdate,momtaskid,substr(task,0,12)as issueid,t.sino  from mom_user_task t,users s where  t.userid=s.userid  and s.branch_id=" + branch + " and (momdate=to_date('" + nextDate + "','DD-Mon-YYYY') OR momdate=to_date( '" + dateFor + "','DD-Mon-YYYY')) and t.userid in(select userid from mom_user_task where  momdate = to_date('" + dateFor + "','DD-Mon-YYYY'))  and type='Issue' and t.userid in (select userid from mom_maintanance where team in(" + teamType + "))   ) m,issue i,MOM_MAINTANANCE mm where i.issueid=m.issueid and i.pid=" + pid + "   and  mm.userId=m.userId order by mm.team,mm.sino,m.sino,momdate,m.type,TASKTIME desc,momtaskid";
            }
            if (pid == null) {
                projectQuery = "select NAME,TASK,TASKTIME,TYPE,CREATEDBY,op.USERID,TEXTMOMDATE,MOMDATE,MOMTASKID,op.sino  from (Select s.firstname ||' ' ||SUBSTR(s.lastname ,1 , 1) as name,t.task,t.tasktime,t.type,t.createdBy,t.userid,to_char(t.momdate,'DD-Mon-YYYY')as textmomdate ,momdate,t.momtaskid,t.SINO from mom_user_task t,users s where  t.userid=s.userid and(  (t.USERID,t.momdate) in (SELECT userid, momdate  FROM (Select userid,momdate, rank() over ( partition by userid order by momdate desc) rank  from mom_user_detail where (status='Present' OR status='Client Meeting') and userid in (select userid from mom_maintanance where team in(" + teamType + ")) and momdate < to_date('" + dateFor + "','DD-Mon-YYYY') and   momtime in ('Morning','Evening') group by userid,momdate order by userid,momdate desc ) where rank = 1 ) ) and t.userid in(select userid from mom_user_task where momdate = to_date('" + dateFor + "','DD-Mon-YYYY'))  union Select s.firstname ||' ' ||SUBSTR(s.lastname ,1 , 1) as name,t.task,t.tasktime,t.type,t.createdBy,t.userid,to_char(t.momdate,'DD-Mon-YYYY') ,momdate,momtaskid,t.SINO from mom_user_task t,users s where  t.userid=s.userid and (momdate=to_date('" + nextDate + "','DD-Mon-YYYY') OR momdate=to_date( '" + dateFor + "','DD-Mon-YYYY')) and t.userid in(select userid from mom_user_task where momdate = to_date('" + dateFor + "','DD-Mon-YYYY')) and t.userid in (select userid from mom_maintanance  where team in(" + teamType + "))  ) op,MOM_MAINTANANCE mm where mm.userId=op.userId order by mm.team,mm.sino,momdate,type,op.sino,TASKTIME desc,momtaskid";
                if (branch > 0) {
                    projectQuery = "select NAME,TASK,TASKTIME,TYPE,CREATEDBY,op.USERID,TEXTMOMDATE,MOMDATE,MOMTASKID,op.sino  from (Select s.firstname ||' ' ||SUBSTR(s.lastname ,1 , 1) as name,t.task,t.tasktime,t.type,t.createdBy,t.userid,to_char(t.momdate,'DD-Mon-YYYY')as textmomdate ,momdate,t.momtaskid,t.SINO from mom_user_task t,users s where  t.userid=s.userid  and s.branch_id=" + branch + " and(  (t.USERID,t.momdate) in (SELECT userid, momdate  FROM (Select userid,momdate, rank() over ( partition by userid order by momdate desc) rank  from mom_user_detail where (status='Present' OR status='Client Meeting') and userid in (select userid from mom_maintanance where team in(" + teamType + ")) and momdate < to_date('" + dateFor + "','DD-Mon-YYYY') and   momtime in ('Morning','Evening')  group by userid,momdate order by userid,momdate desc ) where rank = 1 ) ) and t.userid in(select userid from mom_user_task where momdate = to_date('" + dateFor + "','DD-Mon-YYYY'))  union Select s.firstname ||' ' ||SUBSTR(s.lastname ,1 , 1) as name,t.task,t.tasktime,t.type,t.createdBy,t.userid,to_char(t.momdate,'DD-Mon-YYYY') ,momdate,momtaskid,t.SINO from mom_user_task t,users s where  t.userid=s.userid and s.branch_id=" + branch + " and (momdate=to_date('" + nextDate + "','DD-Mon-YYYY') OR momdate=to_date( '" + dateFor + "','DD-Mon-YYYY')) and t.userid in(select userid from mom_user_task where momdate = to_date('" + dateFor + "','DD-Mon-YYYY')) and t.userid in (select userid from mom_maintanance  where team in(" + teamType + "))  ) op,MOM_MAINTANANCE mm where mm.userId=op.userId order by mm.team,mm.sino,momdate,type,op.sino,TASKTIME desc,momtaskid";
                }
            }
            logger.info(projectQuery);
            preparedStatement = connection.prepareStatement(projectQuery, ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            resultset = preparedStatement.executeQuery(projectQuery);
            while (resultset.next()) {
                List<UserwizeMoM> user = userwize.get(resultset.getInt(6));
                if (user == null) {
                    user = new LinkedList<>();
                }

                UserwizeMoM umm = new UserwizeMoM();
                umm.setUserid(resultset.getInt(6));
                umm.setName(resultset.getString(1));
                umm.setPlannedDate(resultset.getString(7));

                umm.setSino(resultset.getInt(10));
                umm.setTask(resultset.getString(2));
                umm.setTime(resultset.getString(3));
                umm.setType(resultset.getString(4));
                user.add(umm);
                userwize.put(resultset.getInt(6), user);

            }
        } catch (Exception e) {
            e.printStackTrace();
            logger.error(e.getMessage());
        } finally {
            try {

                if (resultset != null) {
                    resultset.close();
                }
                if (preparedStatement != null) {
                    preparedStatement.close();
                }
                if (connection != null) {
                    connection.close();
                }
            } catch (Exception ex) {
                logger.error(ex.getMessage());
            }
        }
        return userwize;

    }

    public static List<String> momWrmIssuesID(String pid, String dateFor) {

        Session session = null;
        List<String> issues = new ArrayList<String>();
        try {
            session = HibernateFactory.getCurrentSession();
            String sqlQuery = "";
            if (pid == null) {
                sqlQuery = "select i.issueid from issue i,issuestatus s,WRMPERIOD w,project p,Apm_Wrm_Plan ap,(select MAX(wrmday) as wrmday,pid from Apm_Wrm_Plan where wrmday <= to_date('12-May-2016','DD-Mon-YY') group by pid) apm where i.PID=w.pid and ap.pid=i.pid and ap.pid=p.pid  and i.issueid=s.issueid and p.status='Work in progress' and pmanager <>104 and to_char(ap.plannedon,'DD-Mon-YYYY')=apm.wrmday and ap.pid=apm.pid and ap.issueid=i.issueid and ap.status='Active' and s.status!='Closed'";

            } else {
                sqlQuery = "select i.issueid from from issue i,issuestatus s,WRMPERIOD w,project p,Apm_Wrm_Plan ap,(select MAX(wrmday) as maxwrday from Apm_Wrm_Plan where pid = " + pid + " and wrmday <= to_date('" + dateFor + "','DD-MON-YY') ) where i.PID=w.pid and ap.pid=i.pid and ap.pid=p.pid and i.pid=" + pid + " and i.issueid=s.issueid and p.status='Work in progress' and pmanager <>104 and to_char(ap.plannedon,'DD-Mon-YYYY') = maxwrday   and ap.issueid=i.issueid and ap.status='Active' and s.status!='Closed' ";
            }
            Query query = session.createSQLQuery(sqlQuery);
            Iterator iterator = query.list().iterator();
            while (iterator.hasNext()) {
                String row = (String) iterator.next();
                issues.add(row);
            }
        } catch (Exception e) {
            logger.error("isssue type cast " + e.getMessage());
        } finally {
            if (session != null) {
                if (session.isOpen()) {
                    try {
                        session.close();
                    } catch (Exception e) {
                        logger.error(e.getMessage());

                    }
                }
            }
        }
        return issues;
    }

    public static List<IssuesTask> momWrmIssues(String pid, String dateFor) {
        Session session = null;
        List<IssuesTask> issues = new ArrayList<IssuesTask>();
        try {
            session = HibernateFactory.getCurrentSession();
            String sqlQuery = "";
            if (pid == null) {
                //  sqlQuery = "select i.issueid,pname || ' v'|| version as pname,subject,assignedto,s.status from issue i,issuestatus s,WRMPERIOD w,project p,Apm_Wrm_Plan ap where i.PID=w.pid and ap.pid=i.pid and ap.pid=p.pid  and i.issueid=s.issueid and p.status='Work in progress' and pmanager <>104 and (to_char(ap.plannedon,'DD-Mon-YYYY'),ap.pid) in (select MAX(wrmday),pid from Apm_Wrm_Plan where wrmday <= to_date('" + dateFor + "','DD-Mon-YY') group by pid) and ap.issueid=i.issueid and ap.status='Active' and s.status!='Closed' ";
                sqlQuery = "select i.issueid,pname || ' v'|| version as pname,subject,assignedto,s.status from issue i,issuestatus s,WRMPERIOD w,project p,Apm_Wrm_Plan ap,(select MAX(wrmday) as wrmday,pid from Apm_Wrm_Plan where wrmday <= to_date('" + dateFor + "','DD-Mon-YY') group by pid) apm where i.PID=w.pid and ap.pid=i.pid and ap.pid=p.pid  and i.issueid=s.issueid and p.status='Work in progress' and pmanager <>104 and to_char(ap.plannedon,'DD-Mon-YYYY')=apm.wrmday and ap.pid=apm.pid and ap.issueid=i.issueid and ap.status='Active' and s.status!='Closed' ";

            } else {
                sqlQuery = "select i.issueid,pname || ' v'|| version as pname,subject,assignedto,s.status from issue i,issuestatus s,WRMPERIOD w,project p,Apm_Wrm_Plan ap,(select MAX(wrmday) as maxwrday from Apm_Wrm_Plan where pid = " + pid + " and wrmday <= to_date('" + dateFor + "','DD-MON-YY') ) where i.PID=w.pid and ap.pid=i.pid and ap.pid=p.pid and i.pid=" + pid + " and i.issueid=s.issueid and p.status='Work in progress' and pmanager <>104 and to_char(ap.plannedon,'DD-Mon-YYYY') = maxwrday   and ap.issueid=i.issueid and ap.status='Active' and s.status!='Closed' ";
            }

            Query query = session.createSQLQuery(sqlQuery);
            Iterator iterator = query.list().iterator();
            while (iterator.hasNext()) {
                Object[] row = (Object[]) iterator.next();
                IssuesTask issuesTask = new IssuesTask();
                for (int col = 0; col < row.length; col++) {
                    if (col == 0) {
                        issuesTask.setIssueno((String) row[col]);
                    } else if (col == 1) {
                        issuesTask.setProjectName(row[col].toString());
                    } else if (col == 4) {
                        issuesTask.setStatus(row[col].toString());
                    } else if (col == 3) {
                        issuesTask.setAssignedTo(Integer.valueOf(row[col].toString()));
                    } else if (col == 2) {
                        issuesTask.setSubject(row[col].toString());
                    }

                }
                issues.add(issuesTask);
            }
        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            if (session != null) {
                if (session.isOpen()) {
                    try {
                        session.close();
                    } catch (Exception e) {
                        logger.error(e.getMessage());

                    }
                }
            }
        }
        return issues;
    }

    public static List<String> momTotalWrmIssues(String dateFor) {
        Session session = null;
        List<String> issues = new ArrayList<String>();
        try {
            session = HibernateFactory.getCurrentSession();
            String sqlQuery = "select i.issueid from issue i, WRMPERIOD w,project p,Apm_Wrm_Plan ap where i.PID=w.pid and ap.pid=i.pid and ap.pid=p.pid  and p.status='Work in progress' and pmanager <>104 and (to_char(ap.plannedon,'DD-Mon-YYYY'),ap.pid) in (select MAX(wrmday),pid from Apm_Wrm_Plan where wrmday <= to_date('" + dateFor + "','DD-Mon-YY') group by pid) and ap.issueid=i.issueid and ap.status='Active' ";

            Query query = session.createSQLQuery(sqlQuery);
            issues = query.list();

        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            if (session != null) {
                if (session.isOpen()) {
                    try {
                        session.close();
                    } catch (Exception e) {
                        logger.error(e.getMessage());

                    }
                }
            }
        }
        return issues;
    }

    public static String[][] getCurrentActuals(List<String> pIssueList, Date previousDate, String pid) {

        SimpleDateFormat sdf = new SimpleDateFormat("dd-MMM-yyyy");
        String[][] issueList = null;

        String today = sdf.format(previousDate);

        Date nextDay = nextDay(previousDate);
        String tommorow = sdf.format(nextDay);
        ResultSet rs = null;
        Connection conn = null;
        PreparedStatement pstmt = null;
        try {
            logger.info("preDay" + today + ", today" + tommorow);
            conn = MakeConnection.getConnection();
            if (pid == null) {
                String query = "select Distinct(i.issueid) as issueid ,i.subject as subject,ist.status as status, CONCAT(CONCAT(p.pname,' v'),p.version) as pfullname ,ic.COMMENT_DATE,to_char(i.due_date,'dd-Mon-yyyy') as duedate,commentedby from issuecomments ic,issue i ,issuestatus ist,project p  where ic.comment_date > ? and ic.comment_date < ?  and comments not like 'Due date is realigned because of issue#%' and  ic.issueid=i.issueid and ist.issueid=i.issueid and i.pid=p.pid order by commentedby,ic.COMMENT_DATE";
                pstmt = conn.prepareStatement(query, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
                pstmt.setString(1, today);
                pstmt.setString(2, tommorow);
            } else {

                String query = "select Distinct(i.issueid) as issueid ,i.subject as subject,ist.status as status, CONCAT(CONCAT(p.pname,' v'),p.version) as pfullname ,ic.COMMENT_DATE,to_char(i.due_date,'dd-Mon-yyyy') as duedate,commentedby from issuecomments ic,issue i ,issuestatus ist,project p  where ic.comment_date > ? and ic.comment_date < ? and i.pid=?  and comments not like 'Due date is realigned because of issue#%' and  ic.issueid=i.issueid and ist.issueid=i.issueid and  i.pid=p.pid order by commentedby,ic.COMMENT_DATE";

                pstmt = conn.prepareStatement(query, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
                pstmt.setString(1, today);
                pstmt.setString(2, tommorow);
                pstmt.setString(3, pid);
            }
            rs = pstmt.executeQuery();
            rs.last();
            int rowcount = rs.getRow();
            rs.beforeFirst();
            issueList = new String[rowcount][3];
            int k = 0;
            while (rs.next()) {
                String issueid = rs.getString("issueid");
                String pfullname = rs.getString("pfullname");
                String status = rs.getString("status");
                String subject = rs.getString("subject");
                String duedate = rs.getString("duedate");
                String commentedby = rs.getString("commentedby");
                Date duDate = sdf.parse(duedate);

                Date currentDate = sdf.parse(today);
                currentDate = subtractDay(currentDate);
                String statusSubject = "";

                if (duDate.compareTo(currentDate) < 0) {
                    statusSubject = " # <font color='Red'>" + status + "</font> : " + subject;
                } else {
                    statusSubject = " # " + status + " : " + subject;
                }
                issueList[k][0] = issueid + ":" + pfullname;
                issueList[k][1] = statusSubject;
                issueList[k][2] = commentedby;
                k++;
            }
        } catch (Exception e) {
            logger.info("getCurrentActuals" + e.getMessage());
        } finally {
            try {
                rs.close();
                pstmt.close();
                conn.close();
            } catch (SQLException e) {
                logger.error(e.getMessage());
            }
        }
        return issueList;
    }

    public void callProccedureSummaryCount(Connection con, String date, String teamType, int adminId) {
        CallableStatement stmt = null;
        try {
            String sql = "{call PROC_SUMMARYCOUNT(?,?,?)}";
            stmt = con.prepareCall(sql);
            stmt.setString(1, date);
            stmt.setString(2, teamType);
            stmt.setInt(3, adminId);
            stmt.execute();
        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            try {
                stmt.close();
            } catch (Exception e) {
                logger.error(e.getMessage());
            }
        }
    }

    public MomDaySummationFormbean summaryCount(String date, List<String> issuesList, String teamType) {
        Calendar calend = Calendar.getInstance();
        calend.setTime(new Date());
        long starttime = calend.getTimeInMillis();

        ResultSet rs = null;
        Connection conn = null;
        Statement stmt = null;
        MomDaySummationFormbean mdsf = new MomDaySummationFormbean();
        String extended = "";
        if (projectId != 0) {
            extended = "and i.pid=" + projectId;
        }
        int adminId = GetProjectMembers.getAdminID();
        List<String> issueList = new ArrayList<String>();
        List<String> adhocissueList = new ArrayList<String>();
        try {
            conn = MakeConnection.getConnection();
            String query = "select distinct(i.issueid),ist.status,u.email,ic.comment_date from (select issueid, status, commentedby, commentedto,comment_date from issuecomments where to_char(comment_date,'dd-Mon-YYYY') ='" + date + "' and status<>'Unconfirmed')ic,issue i ,issuestatus ist,project p,users u,users us, MOM_Maintanance mmt where  ic.issueid=i.issueid and ist.issueid=i.issueid and i.pid=p.pid and u.userid=i.assignedto and us.userid=ic.CommentedBy and mmt.userid=ic.CommentedBy and mmt.team in (" + teamType + " ) And pmanager <> " + adminId + " " + extended;
            stmt = conn.createStatement();
            rs = stmt.executeQuery(query);

            while (rs.next()) {
                String issueid = rs.getString("issueid");
                if (issuesList.contains(issueid)) {
                    if (!issueList.contains(issueid)) {
                        issueList.add(issueid);
                        String status = rs.getString("status");
                        if (status.equalsIgnoreCase("Closed")) {
                            mdsf.setClosed(mdsf.getClosed() + 1);
                        } else {
                            String email = rs.getString("email");
                            if (email.endsWith("eminentlabs.net")) {
                                mdsf.setNotWithCustomer(mdsf.getNotWithCustomer() + 1);
                            } else {
                                mdsf.setWithCustomer(mdsf.getWithCustomer() + 1);
                            }
                        }

                    }
                } else {
                    if (!adhocissueList.contains(issueid)) {
                        adhocissueList.add(issueid);
                    }
                }
                mdsf.setIssueList(issueList);
            }
            mdsf.setAdhoc(adhocissueList.size());

        } catch (Exception e) {
            logger.info("getCurrentActuals" + e.getMessage());
        } finally {
            try {
                rs.close();
                stmt.close();
                conn.close();
            } catch (SQLException e) {
                logger.error(e.getMessage());
            }
        }
        return mdsf;
    }

    public static List<String> todayPlannedIssues(String plannedDate, String pid, String team) {
        Calendar cal = Calendar.getInstance();
        ResultSet rs = null;
        Connection conn = null;
        PreparedStatement pstmt = null;
        List<String> issueList = new ArrayList<String>();
        try {
            conn = MakeConnection.getConnection();
            String query = "";
            if (pid == null) {
                query = "select issue from (select Distinct(SUBSTR(task,0,12)) as issue from mom_user_task t, MOM_MAINTANANCE mm where mm.userid=t.userid and mm.team in(" + team + ") and type='Issue' and tasktime='Planned' and momdate = '" + plannedDate + "'),PROJECT_PLANNED_ISSUE p where p.issueid=issue and p.status='Active' and p.plannedon = '" + plannedDate + "' order by sino ";
            } else {
                query = "select issue from (select Distinct(SUBSTR(task,0,12)) as issue from mom_user_task t, MOM_MAINTANANCE mm where mm.userid=t.userid and mm.team in(" + team + ") and type='Issue' and tasktime='Planned' and momdate = '" + plannedDate + "')m ,issue i,PROJECT_PLANNED_ISSUE p where i.issueid=issue and p.status='Active' and p.issueid=issue and p.plannedon = '" + plannedDate + "'  and i.pid=" + pid + " order by sino ";
            }
            pstmt = conn.prepareStatement(query, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                if (rs.getString("issue") != null) {
                    issueList.add(rs.getString("issue"));
                }
            }
        } catch (Exception e) {
            logger.info("todayPlannedIssues" + e.getMessage());
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
        cal.setTime(new Date());
        return issueList;
    }

    public static MomDaySummationFormbean wrmSeggregation(MomDaySummationFormbean mdsf) {
        ResultSet rs = null;
        Connection conn = null;
        PreparedStatement pstmt = null;
        String totalissuenos = "";
        for (String issue : mdsf.getWrmIssueList()) {
            totalissuenos = totalissuenos + "'" + issue.trim() + "',";
        }
        if (totalissuenos.contains(",")) {
            totalissuenos = totalissuenos.substring(0, totalissuenos.length() - 1);
        }
        try {
            conn = MakeConnection.getConnection();
            String query = "select count(email) from issue i,issuestatus s, users u where u.userid=i.assignedto and s.issueid=i.issueid and i.issueid in(" + totalissuenos + ") and email like'%eminentlabs.net' and s.status!='Closed'";
            logger.info(query);
            pstmt = conn.prepareStatement(query, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                mdsf.setWrmWithUs(rs.getInt(1));
            }
            mdsf.setWrmWithCustomers(mdsf.getWrmIssueList().size() - mdsf.getWrmWithUs());

        } catch (Exception e) {
            logger.info("todayPlannedIssues" + e.getMessage());
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
        return mdsf;
    }

// Edit by mukesh for show the Leave Status
    public static String[][] getLeavenext(String startDate, String endDate) {
        String[][] leavenext = null;
        Connection connection = null;
        ResultSet getLeaveRS = null;
        PreparedStatement getLeavePS = null;
        String userid = null;
        DateFormat sdf = new SimpleDateFormat("dd-MMM-yyyy");
        String todate = null;
        String fromdate = null;
        int count = 0;
        int rowcount = 0;
        try {
            connection = MakeConnection.getConnection();
            getLeavePS = connection.prepareStatement("select  REQUESTEDBY,fromdate , todate from Leave where  APPROVAL=1 and fromdate <= '" + endDate + "' and todate>='" + startDate + "' order by todate desc ", ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            getLeaveRS = getLeavePS.executeQuery();
            getLeaveRS.last();
            rowcount = getLeaveRS.getRow();
            getLeaveRS.beforeFirst();
            leavenext = new String[rowcount][3];
            while (getLeaveRS.next()) {
                userid = getLeaveRS.getString(1);
                todate = sdf.format(getLeaveRS.getDate("todate"));
                fromdate = sdf.format(getLeaveRS.getDate("fromdate"));
                leavenext[count][0] = userid;
                leavenext[count][1] = todate;
                leavenext[count][2] = fromdate;
                count++;
            }
        } catch (Exception e) {
            logger.error(e.getMessage());
        } finally {
            try {
                if (getLeaveRS != null) {
                    getLeaveRS.close();
                }
            } catch (Exception ex) {
                logger.error("Error while getting Leave Details" + ex.getMessage());
            }
            try {
                if (getLeavePS != null) {
                    getLeavePS.close();
                }
            } catch (Exception ex) {
                logger.error("Error while getting Leave Details" + ex.getMessage());
            }
            try {
                if (connection != null) {
                    connection.close();
                    logger.info("Connection Closed");
                    if (connection.isClosed()) {
                        logger.info("Closed");
                    } else {
                        logger.info("Not Closed");
                    }
                }
            } catch (Exception ex) {
                logger.error("Error while getting Leave Details" + ex.getMessage());
            }
        }
        return leavenext;
    }

    public boolean todayleave(int uid, Date requestDate) {
        boolean b = false;
        try {
            DateFormat sdf = new SimpleDateFormat("dd-MMM-yyyy");
            for (int i = 0; i < leaveDate.length; i++) {
                int user = Integer.parseInt(leaveDate[i][0]);
                if (user == uid) {
                    Date fd = sdf.parse(leaveDate[i][2]);
                    Date ed = sdf.parse(leaveDate[i][1]);
                    if (fd.compareTo(requestDate) <= 0 && ed.compareTo(requestDate) >= 0) {
                        b = true;
                        break;
                    }
                }
            }
        } catch (Exception e) {
            logger.info("todyaleave exception" + e.getMessage());
        }
        return b;
    }

    public boolean nextleave(int uid, Date nextWorkDay) {
        boolean b = false;
        try {
            DateFormat sdf = new SimpleDateFormat("dd-MMM-yyyy");
            for (int i = 0; i < leaveDate.length; i++) {
                int user = Integer.parseInt(leaveDate[i][0]);
                if (user == uid) {
                    Date ed = sdf.parse(leaveDate[i][1]);
                    if (ed.compareTo(nextWorkDay) >= 0) {
                        b = true;
                        break;
                    }
                }
            }
        } catch (Exception e) {
            logger.info("Next Day leave exception" + e.getMessage());
        }
        return b;
    }

    // Edit by mukesh 
    public String getMomDate() {
        return momDate;
    }

    public void setMomDate(String momDate) {
        this.momDate = momDate;
    }

    public int getProjectId() {
        return projectId;
    }

    public void setProjectId(int projectId) {
        this.projectId = projectId;
    }

    public int getMomTeamType() {
        return momTeamType;
    }

    public void setMomTeamType(int momTeamType) {
        this.momTeamType = momTeamType;
    }

    public Map<Integer, String> getMomTypeList() {
        return momTypeList;
    }

    public void setMomTypeList(Map<Integer, String> momTypeList) {
        this.momTypeList = momTypeList;
    }

    public List<ViewMomFormBean> getViewMomFormBeans() {
        return viewMomFormBeans;
    }

    public void setViewMomFormBeans(List<ViewMomFormBean> viewMomFormBeans) {
        this.viewMomFormBeans = viewMomFormBeans;
    }

    public Map<Integer, String> getMomProjects() {
        return momProjects;
    }

    public void setMomProjects(Map<Integer, String> momProjects) {
        this.momProjects = momProjects;
    }

    public String[][] getAttDetails() {
        return attDetails;
    }

    public void setAttDetails(String[][] attDetails) {
        this.attDetails = attDetails;
    }

    public List<String> getModList() {
        return modList;
    }

    public void setModList(List<String> modList) {
        this.modList = modList;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public List<FineAmountBean> getFineAmtToday() {
        return fineAmtToday;
    }

    public void setFineAmtToday(List<FineAmountBean> fineAmtToday) {
        this.fineAmtToday = fineAmtToday;
    }

    public String[][] getProjDetails() {
        return projDetails;
    }

    public void setProjDetails(String[][] projDetails) {
        this.projDetails = projDetails;
    }

    public String getCurrentDate() {
        return currentDate;
    }

    public void setCurrentDate(String currentDate) {
        this.currentDate = currentDate;
    }

    public MomDaySummationFormbean getPreviousDaySummationFormbean() {
        return previousDaySummationFormbean;
    }

    public void setPreviousDaySummationFormbean(MomDaySummationFormbean previousDaySummationFormbean) {
        this.previousDaySummationFormbean = previousDaySummationFormbean;
    }

    public MomDaySummationFormbean getMomDaySummationFormbean() {
        return momDaySummationFormbean;
    }

    public void setMomDaySummationFormbean(MomDaySummationFormbean momDaySummationFormbean) {
        this.momDaySummationFormbean = momDaySummationFormbean;
    }

    public MomDaySummationFormbean getNextDaySummationFormbean() {
        return nextDaySummationFormbean;
    }

    public void setNextDaySummationFormbean(MomDaySummationFormbean nextDaySummationFormbean) {
        this.nextDaySummationFormbean = nextDaySummationFormbean;
    }

    public String getKeys() {
        return keys;
    }

    public void setKeys(String keys) {
        this.keys = keys;
    }

    public String[][] getLeaveDate() {
        return leaveDate;
    }

    public void setLeaveDate(String[][] leaveDate) {
        this.leaveDate = leaveDate;
    }

    public int getBranch() {
        return branch;
    }

    public void setBranch(int branch) {
        this.branch = branch;
    }

    public Map<Integer, String> momTypeMaintanance() {
        Map<Integer, String> userType = new LinkedHashMap<Integer, String>();
        userType.put(0, "All");
        userType.put(1, "Technical");
        userType.put(2, "Functional");
        return userType;
    }

    public void updateSummaryCount(HttpServletRequest request) throws ParseException {
        MomMaintananceController mmc = new MomMaintananceController();
        List<MomMaintanance> mmList = mmc.findAll();
        Map<Integer, List<MomMaintanance>> mmcSplit = mmc.splitLists(mmList);
        momTypeList = momTypeMaintanance();
        Map<Integer, Set<Integer>> branchwiseUsers = GetProjectMembers.getUsersByBranch();
        DateFormat sdf = new SimpleDateFormat("dd-MMM-yyyy");
        Calendar c = new GregorianCalendar();
        Date date = c.getTime();
        currentDate = sdf.format(date);
        HttpSession session = request.getSession();
        userId = (Integer) session.getAttribute("userid_curr");
        MomMaintanance mm = mmc.findByList(mmList, userId);
        session.getAttribute("Role");
        String pid = request.getParameter("pid");
        String branchId = request.getParameter("branch");
        if (pid != null) {
            if ("".equals(pid)) {
                pid = null;
            } else {
                projectId = MoMUtil.parseInteger(pid, 0);
            }
        }
        momDate = request.getParameter("momdate");
        String momTeamsType = request.getParameter("momTeamType");
        if (mm == null) {
            if (momTeamsType == null) {
                momTeamType = 0;
            } else {
                momTeamType = MoMUtil.parseInteger(momTeamsType, momTeamType);
            }

        } else {
            if (momTeamsType == null) {
                momTeamType = mm.getTeam();
            } else {
                if ("".equals(momTeamsType)) {

                } else {
                    momTeamType = mm.getTeam();
                    momTeamType = MoMUtil.parseInteger(momTeamsType, momTeamType);
                }
            }
        }
        if (branchId != null) {
            if ("".equals(branchId)) {
                branchId = null;
            } else {
                branch = MoMUtil.parseInteger(branchId, 0);
            }
        }
        if (momTeamType == 0) {
            momUsers = mmcSplit.get(1);
            momUsers.addAll(mmcSplit.get(2));
            momUsers.addAll(mmcSplit.get(3));
        } else if (momTeamType == 1) {
            momUsers = mmcSplit.get(1);
        } else if (momTeamType == 2 || momTeamType == 3) {
            momUsers = mmcSplit.get(2);
            momUsers.addAll(mmcSplit.get(3));
            momTeamType = 2;
        } else {
            momUsers.addAll(mmList);
        }

        List<Integer> userIds = new ArrayList<Integer>();
        if (branchId != null) {
            List<MomMaintanance> momUsersa = new ArrayList<MomMaintanance>();
            Set<Integer> users = branchwiseUsers.get(branch);
            if (users == null) {
                momUsers.clear();
            } else {
                for (MomMaintanance mmce : momUsers) {
                    for (Integer user : users) {
                        if (user == mmce.getUserid()) {
                            userIds.add(mmce.getUserid());
                            momUsersa.add(mmce);
                        }
                    }
                }
                momUsers.clear();
                momUsers.addAll(momUsersa);
            }
        } else {
            for (MomMaintanance mmce : momUsers) {
                userIds.add(mmce.getUserid());
            }
        }
        keys = "";
        Map<Integer, List<MomMaintanance>> needTeams = mmc.splitLists(momUsers);
        for (Integer key : needTeams.keySet()) {
            keys = keys + key + ",";
        }
        keys = keys.substring(0, keys.length() - 1);

        if (momDate != null) {
            try {
                Date momDateFormat = sdf.parse(momDate);
                momDate = sdf.format(momDateFormat);
            } catch (ParseException ex) {
                Logger.getLogger(ViewMomController.class.getName()).log(Level.SEVERE, null, ex);
            }
        } else {
            momDate = sdf.format(date);
        }

        try {
            Date requestDate = sdf.parse(momDate);
            Date previousDay = MoMUtil.previousDay(requestDate);
            Date nextWorkDay = MoMUtil.nextDay(requestDate);
            boolean flag = true;
            while (flag == true) {
                List<Holidays> holidaysList = HolidaysUtil.findByHolidayDate(nextWorkDay);
                if (!holidaysList.isEmpty()) {
                    nextWorkDay = MoMUtil.nextDay(nextWorkDay);
                } else {
                    flag = false;
                }
            }
            List<String> momDateIssueList = todayPlannedIssues(momDate, pid, keys);

            List<String> prevDateIssueList = todayPlannedIssues(sdf.format(previousDay), pid, keys);

            List<String> nextDateIssueList = todayPlannedIssues(sdf.format(nextWorkDay), pid, keys);

            List<IssuesTask> wrmIssues = new ArrayList<IssuesTask>();

            wrmIssues = momWrmIssues(pid, momDate);

            List<String> wrmIssueNos = MoMUtil.convertIssueNo(wrmIssues);
            PlannedIssueReport pir = new PlannedIssueReport();
            int wrmPPlanned = pir.intersection(prevDateIssueList, wrmIssueNos).size();

            boolean summarFlag = false;
            Date current = sdf.parse(sdf.format(new Date()));
            if (sdf.parse(momDate).compareTo(current) > 0 || sdf.parse(momDate).compareTo(current) == 0) {
                summarFlag = true;
            }
            if (summarFlag == true) {
                previousDaySummationFormbean = summaryCount(sdf.format(previousDay), prevDateIssueList, keys);
            }

            previousDaySummationFormbean.setWrmPlanned(wrmPPlanned);
            previousDaySummationFormbean.setNonWrmPlanned(prevDateIssueList.size() - wrmPPlanned);
            previousDaySummationFormbean.setMomDate(sdf.format(previousDay));
            previousDaySummationFormbean.setWrmCount(wrmIssues.size());
            if (!prevDateIssueList.isEmpty()) {
                if (previousDaySummationFormbean.getIssueList() != null) {
                    prevDateIssueList.removeAll(previousDaySummationFormbean.getIssueList());
                }
            }
            previousDaySummationFormbean.setNotUpdated(prevDateIssueList.size());
            previousDaySummationFormbean.setWrmIssueList(wrmIssueNos);

            previousDaySummationFormbean = wrmSeggregation(previousDaySummationFormbean);

            int wrmPlanned = pir.intersection(momDateIssueList, wrmIssueNos).size();
            if (summarFlag == true) {
                momDaySummationFormbean = summaryCount(momDate, momDateIssueList, keys);
            }
            momDaySummationFormbean.setWrmPlanned(wrmPlanned);
            momDaySummationFormbean.setNonWrmPlanned(momDateIssueList.size() - wrmPlanned);
            momDaySummationFormbean.setMomDate(momDate);
            momDaySummationFormbean.setWrmCount(wrmIssues.size());
            if (!momDateIssueList.isEmpty()) {
                if (momDaySummationFormbean.getIssueList() != null) {
                    momDateIssueList.removeAll(momDaySummationFormbean.getIssueList());
                }
            }
            momDaySummationFormbean.setNotUpdated(momDateIssueList.size());
            momDaySummationFormbean.setWrmIssueList(wrmIssueNos);
            momDaySummationFormbean = wrmSeggregation(momDaySummationFormbean);
            int wrmNPlanned = pir.intersection(nextDateIssueList, wrmIssueNos).size();
            if (nextDateIssueList.isEmpty()) {

            } else {
                if (summarFlag == true) {
                    //nextDaySummationFormbean = summaryCount(sdf.format(nextWorkDay), nextDateIssueList, keys);
                }
            }

            nextDaySummationFormbean.setWrmPlanned(wrmNPlanned);
            nextDaySummationFormbean.setNonWrmPlanned(nextDateIssueList.size() - wrmNPlanned);
            nextDaySummationFormbean.setMomDate(sdf.format(nextWorkDay));
            nextDaySummationFormbean.setWrmCount(wrmIssues.size());

            nextDaySummationFormbean.setWrmIssueList(wrmIssueNos);
            nextDaySummationFormbean = wrmSeggregation(nextDaySummationFormbean);

        } catch (ParseException ex) {
            Logger.getLogger(ViewMomController.class
                    .getName()).log(Level.SEVERE, null, ex);
        }
    }

}
