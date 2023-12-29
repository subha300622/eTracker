package com.eminentlabs.mom;

import com.eminent.util.GetProjectMembers;
import com.eminentlabs.mom.controller.MomMaintananceController;
import com.eminentlabs.mom.controller.SendMomMaintainController;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Collection;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.ResourceBundle;
import java.util.Set;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.apache.log4j.Logger;

/**
 *
 * @author RN.Khans
 */
public class WeeklyPerformers {

    static Logger logger = null;

    static {
        logger = Logger.getLogger("WeekPerformers");
    }
    MomMaintananceController maintananceController = new MomMaintananceController();
    ResourceBundle rb = ResourceBundle.getBundle("Resources");
    String mods = rb.getString("mom-mods");
    String noOfIds[] = mods.split(",");
    List<String> modList = Arrays.asList(noOfIds);
    String momusers = maintananceController.allMomUsers();
    String noOfUsers[] = momusers.split(",");
    SimpleDateFormat sdf = new SimpleDateFormat("dd-MMM-yyyy");
    DateFormat sdfs = new SimpleDateFormat("dd-MM-yyyy");
    HashMap<Integer, String> member = GetProjectMembers.showUsers();
    Map<String, List<Integer>> teamWise = null; //
    Map<Integer, Integer> myAssignCount = GetProjectMembers.getAllMyAssignIssueCount();
    Map<Integer, List<String>> previousPlanClose = new HashMap<Integer, List<String>>();

    List totUsers = new ArrayList();

    private int assignedto, branch = 0;
    private int performerid = 0;
    private String startMM = "";
    private String endMM = "";
    private String startDate;
    private String endDate;
    private String winners = "";
    private String competitors = "";
    private String ClosedIssues = "";
    int winnerscount = 0;
    int closedCount;
    int plannedCount;
    Map weekClosedIssue;
    List<String> weekPlannedIssue;
    List<UsersPerformance> usersPerformances;
    List<WeekPerformersBean> userList = new ArrayList<WeekPerformersBean>();
    List<TeamAverage> teamAverages = new ArrayList<TeamAverage>();

    public void setAll(HttpServletRequest request) throws Exception {

        HttpSession session = request.getSession();
        assignedto = (Integer) session.getAttribute("userid_curr");
        if (request.getParameter("performerid") != null) {
            performerid = Integer.valueOf(request.getParameter("performerid"));
        }
        logger.info(performerid);
        Calendar c = Calendar.getInstance();
        c.set(Calendar.DAY_OF_WEEK, Calendar.SUNDAY);
        Calendar c1 = Calendar.getInstance();
        c1.setTime(c.getTime());
        c1.add(Calendar.DATE, -1);
        Date start = c1.getTime();
        c.set(Calendar.DAY_OF_WEEK, Calendar.FRIDAY);
        Date end = c.getTime();
        startDate = sdf.format(start);
        endDate = sdf.format(end);
        logger.info("startDate" + startDate + ", endDate" + endDate);
        if (request.getParameter("fromdate") != null) {
            startDate = request.getParameter("fromdate");
            startDate = com.pack.ChangeFormat.changeDateFormat(startDate);
            logger.info("---->" + startDate);
        }
        if (request.getParameter("todate") != null) {
            endDate = request.getParameter("todate");
            endDate = com.pack.ChangeFormat.changeDateFormat(endDate);
            logger.info("---->" + endDate);
        }
        startMM = sdfs.format(sdf.parse(startDate));
        endMM = sdfs.format(sdf.parse(endDate));
        java.sql.Date sdate = new java.sql.Date((sdf.parse(startDate)).getTime());
        java.sql.Date edate = new java.sql.Date(sdf.parse(endDate).getTime());
        usersPerformances = MoMUtil.findAllUsersPerformance(sdate, edate, branch);
        winnerscount = 0;
        for (UsersPerformance up : usersPerformances) {
            if (winnerscount == 0) {
                if (up.getPerformanceType().equalsIgnoreCase(PerformanceType.WINNER.getStatusCode())) {
                    if (!up.getTeam().equalsIgnoreCase("NA")) {
                        winners = up.getTeam();
                    }
                    winnerscount++;
                }
            }
        }
        if (performerid != 0) {
            noOfUsers = (String.valueOf(performerid)).split(",");
        }
        totUsers = Arrays.asList(noOfUsers);
        Calendar cal = Calendar.getInstance();
        cal.setTime(new Date());

        Long startTime = cal.getTimeInMillis();

        weekPlannedIssue = MoMUtil.weekPlannedIssue(startDate, endDate);
        cal.setTime(new Date());
        Long endtime = cal.getTimeInMillis();
        if ((endtime - startTime) > 30) {
            logger.info("ViewMom maintenance **********setAll***** mmc.findAll() *********End*******= " + endtime + "  total time :" + (endtime - startTime) + " ms");
        }

        cal.setTime(new Date());

        startTime = cal.getTimeInMillis();
        weekClosedIssue = MoMUtil.weekClosedIssue(startDate, endDate);
        cal.setTime(new Date());
        endtime = cal.getTimeInMillis();
        if ((endtime - startTime) > 30) {
            logger.info("ViewMom maintenance **********setAll***** mmc.findAll() *********End*******= " + endtime + "  total time :" + (endtime - startTime) + " ms");
        }
        Iterator it = weekClosedIssue.entrySet().iterator();
        while (it.hasNext()) {
            Map.Entry entry = (Map.Entry) it.next();
            ClosedIssues = ClosedIssues + entry.getKey() + ",";
        }
        if (ClosedIssues != "") {
            ClosedIssues = ClosedIssues.substring(0, ClosedIssues.length() - 1);
            logger.info(ClosedIssues);
            previousPlanClose = MoMUtil.addClosures(ClosedIssues);
        }
        Collection set = teamWise.keySet();
        Iterator ite = set.iterator();
        Map<String, String> closePer = new LinkedHashMap<String, String>();
        while (ite.hasNext()) {
            Set<String> plannedIssue = new HashSet<String>();
            Set<String> actualIssue = new HashSet<String>();
            TeamAverage teamAverage = new TeamAverage();
            List<WeekPerformersBean> teamWiseUsers = new ArrayList<WeekPerformersBean>();
            boolean checkTuser = true;
            int teamPlanAvg = 0;
            int teamCloseAvg = 0;
            int teamIssueCount = 0;
            String teamPerAvg = null;
            String teamUsers = "";
            int matched = 1;
            String key = (String) ite.next();
            List<Integer> users = (List<Integer>) teamWise.get(key);
            Object[] toUsers = users.toArray();
            int k = 1;
            for (int j = 0; j < toUsers.length; j++) {
                String tuid = toUsers[j].toString();
                if (totUsers.contains(tuid)) {
                    matched++;
                }
                teamUsers = teamUsers + tuid + ",";
            }
            for (int j = 0; j < toUsers.length; j++) {
                WeekPerformersBean userBean = new WeekPerformersBean();
                List<IssuesTask> plannedList = new ArrayList<IssuesTask>();
                List<IssuesTask> actualList = new ArrayList<IssuesTask>();
                String actualIssues[][];
                List<String> uniqueIssuesList = new ArrayList<String>();
                MomUserTask userTask = null;
                IssuesTask plannedTask = null;
                String tuid = toUsers[j].toString();
                userBean.setTeam(key);
                userBean.setUserId(tuid);
                userBean.setName(member.get(Integer.parseInt(tuid)));
                // adding for issues count for individual and team count

                if (totUsers.contains(tuid)) {
                    k++;

                    if (myAssignCount.containsKey(MoMUtil.parseInteger(tuid, 0))) {
                        userBean.setMyAssignmentCount(myAssignCount.get(MoMUtil.parseInteger(tuid, 0)));
                        teamIssueCount = teamIssueCount + userBean.getMyAssignmentCount();
                    }
                    if (checkTuser == true) {
                        checkTuser = false;
                    }
                    if (!weekPlannedIssue.isEmpty() || !previousPlanClose.isEmpty()) {
                        String issuenos = MoMUtil.getIssueByUser(weekPlannedIssue, tuid.toString());
                        String weekPerformers[] = MoMUtil.weekPerformer(tuid.toString(), weekPlannedIssue, weekClosedIssue);
                        int userid = Integer.parseInt(tuid.toString());
                        List<String> issueList = new ArrayList<String>();
                        int i = 0;
                        if (previousPlanClose.containsKey(userid)) {
                            List<String> issues = new ArrayList<String>(0);
                            issues = previousPlanClose.get(userid);
                            for (String is : issues) {
                                if (!weekPlannedIssue.contains(is + "," + userid)) {
                                    if (i == 0 && !"".equals(issuenos)) {
                                        issuenos = issuenos + ",'" + is + "',";
                                    } else {
                                        issuenos = issuenos + "'" + is + "',";
                                    }
                                    issueList.add(is);
                                    i++;
                                }
                            }
                        }
                        if (i > 0) {
                            if (issuenos.length() > 12) {
                                issuenos = issuenos.substring(0, issuenos.length() - 1);
                            }
                        }
                        List checkedIssuesList = new ArrayList();
                        for (UsersPerformance up : usersPerformances) {
                            int uId = up.getUserId();
                            if (uId == userid) {
                                if (up.getTasks() != null) {
                                    String checkdissues[] = up.getTasks().split(",");
                                    checkedIssuesList = Arrays.asList(checkdissues);
                                }
                            }
                        }
                        if (i > 0) {
                            weekPerformers[1] = String.valueOf(Integer.valueOf(weekPerformers[1]) + i);
                            weekPerformers[0] = String.valueOf(Integer.valueOf(weekPerformers[0]) + i);
                        }

                        if (usersPerformances.size() > 0) {
                            weekPerformers[0] = String.valueOf(checkedIssuesList.size());
                        }
                        closedCount = Integer.valueOf(weekPerformers[0]);
                        plannedCount = Integer.valueOf(weekPerformers[1]);
                        userBean.setPlannedCount(plannedCount);
                        userBean.setClosedCount(closedCount);
                        userBean.setAverage(dashboard.ArithOperation.calcPercentagewithDecimal(plannedCount, closedCount));
                        teamPlanAvg = teamPlanAvg + Integer.valueOf(weekPerformers[1]);
                        teamCloseAvg = teamCloseAvg + Integer.valueOf(weekPerformers[0]);
                        if (closedCount > 0) {
                            competitors = competitors + tuid + ",";
                        }
                        List task = MoMUtil.viewTaskBetweenTwoDates(userid, endDate, startDate);
                        if (task == null) {
                            task = new ArrayList();
                        }
                        if (!task.isEmpty() || i > 0) {
                            for (Iterator reqIterator = task.iterator(); reqIterator.hasNext();) {
                                userTask = (MomUserTask) reqIterator.next();
                                if (userTask.getTasktime().equalsIgnoreCase("Planned")) {
                                    if (userTask.getType().equalsIgnoreCase("issue")) {
                                        plannedTask = MoMUtil.getIssueDetails(userTask.getTask());
                                        if (!uniqueIssuesList.contains(plannedTask.getIssueno())) {
                                            uniqueIssuesList.add(plannedTask.getIssueno());
                                            plannedIssue.add(plannedTask.getIssueno());
                                            plannedList.add(plannedTask);
                                        }

                                    }
                                }
                            }

                            if (issuenos != "") {
                                actualIssues = MoMUtil.showIssuesDetails(issuenos, startDate, endDate);

                                for (int ai = 0; ai < actualIssues.length; ai++) {
                                    String color = "";

                                    if (weekClosedIssue.containsKey(actualIssues[ai][0])) {
                                        String rating = (String) weekClosedIssue.get(actualIssues[ai][0]);
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

                                        if (issueList.contains(actualIssues[ai][0])) {
                                            if (checkedIssuesList.contains(actualIssues[ai][0]) || usersPerformances.size() == 0) {

                                                IssuesTask actualtask = new IssuesTask();
                                                actualtask.setIssueno(actualIssues[ai][0]);
                                                actualtask.setStatus(actualIssues[ai][1]);
                                                actualtask.setSubject(actualIssues[ai][2]);
                                                actualtask.setProjectName(actualIssues[ai][3]);
                                                actualtask.setColor(color);
                                                actualtask.setCheckBox("yes");
                                                actualtask.setCheckParam("true");
                                                actualIssue.add(actualIssues[ai][0]);
                                                actualList.add(actualtask);

                                            } else {

                                                IssuesTask actualtask = new IssuesTask();
                                                actualtask.setIssueno(actualIssues[ai][0]);
                                                actualtask.setStatus(actualIssues[ai][1]);
                                                actualtask.setSubject(actualIssues[ai][2]);
                                                actualtask.setProjectName(actualIssues[ai][3]);
                                                actualtask.setColor(color);
                                                actualtask.setCheckBox("yes");
                                                actualtask.setCheckParam("false");
                                                //  actualIssue.add(actualIssues[ai][0]);
                                                actualList.add(actualtask);

                                            }
                                            IssuesTask preCloseIssue = new IssuesTask();
                                            preCloseIssue.setIssueno(actualIssues[ai][0]);
                                            preCloseIssue.setStatus(actualIssues[ai][1]);
                                            preCloseIssue.setSubject(actualIssues[ai][2]);
                                            preCloseIssue.setProjectName(actualIssues[ai][3]);
                                            preCloseIssue.setColor(color);
                                            plannedIssue.add(actualIssues[ai][0]);
                                            plannedList.add(preCloseIssue);

                                        } else {
                                            if (checkedIssuesList.contains(actualIssues[ai][0]) || usersPerformances.size() == 0) {

                                                IssuesTask actualtask = new IssuesTask();
                                                actualtask.setIssueno(actualIssues[ai][0]);
                                                actualtask.setStatus(actualIssues[ai][1]);
                                                actualtask.setSubject(actualIssues[ai][2]);
                                                actualtask.setProjectName(actualIssues[ai][3]);
                                                actualtask.setColor(color);
                                                actualtask.setCheckBox("yes");
                                                actualtask.setCheckParam("true");
                                                actualIssue.add(actualIssues[ai][0]);
                                                actualList.add(actualtask);
                                            } else {
                                                IssuesTask actualtask = new IssuesTask();
                                                actualtask.setIssueno(actualIssues[ai][0]);
                                                actualtask.setStatus(actualIssues[ai][1]);
                                                actualtask.setSubject(actualIssues[ai][2]);
                                                actualtask.setProjectName(actualIssues[ai][3]);
                                                actualtask.setColor(color);
                                                actualtask.setCheckBox("yes");
                                                actualtask.setCheckParam("false");
                                                //  actualIssue.add(actualIssues[ai][0]);
                                                actualList.add(actualtask);

                                            }
                                        }
                                    } else {

                                        IssuesTask actualtask = new IssuesTask();
                                        actualtask.setIssueno(actualIssues[ai][0]);
                                        actualtask.setStatus(actualIssues[ai][1]);
                                        actualtask.setSubject(actualIssues[ai][2]);
                                        actualtask.setProjectName(actualIssues[ai][3]);
                                        actualtask.setColor(color);
                                        actualtask.setCheckBox("no");
                                        // actualIssue.add(actualIssues[ai][0]);
                                        actualList.add(actualtask);
                                    }
                                }
                                userBean.setPlannedList(plannedList);
                                userBean.setActualList(actualList);
                            }
                            teamWiseUsers.add(userBean);
                            logger.info("competitors" + competitors);
                        }
                    }
                    if (matched == k) {
                        // NumberFormat nf = new DecimalFormat("#.##");
                        //  double planAvg = teamPlanAvg / (matched - 1);
                        teamPlanAvg = plannedIssue.size();
                        teamCloseAvg = actualIssue.size();
                        teamPerAvg = dashboard.ArithOperation.calcPercentage(teamPlanAvg, teamCloseAvg);
                        teamAverage.setTeam(key);
                        teamAverage.setTeamUserIds(teamUsers);
                        teamAverage.setTeamPlanAvg(teamPlanAvg);
                        teamAverage.setTeamCloseAvg(teamCloseAvg);
                        teamAverage.setTeamPerAvg(teamPerAvg);
                        teamAverage.setTeamWiseUsers(teamWiseUsers);
                        teamAverage.setTeamIssueCount(teamIssueCount);
                        teamAverages.add(teamAverage);
                    }
                }
            }
        }

        Collections.sort(teamAverages, new Comparator<TeamAverage>() {
            @Override
            public int compare(TeamAverage t1, TeamAverage t2) {

                if (t1.getTeamPerAvg().equalsIgnoreCase("N/A")) {
                    t1.setTeamPerAvg("0");
                }
                if (t2.getTeamPerAvg().equalsIgnoreCase("N/A")) {
                    t2.setTeamPerAvg("0");
                }
                Float avg1 = Float.valueOf(t1.getTeamPerAvg());
                Float avg2 = Float.valueOf(t2.getTeamPerAvg());
                return avg2.compareTo(avg1);
            }
        }
        );

    }   // request end  
/*edit by mukesh*/

    public void newSetAll(HttpServletRequest request) throws Exception {

        HttpSession session = request.getSession();
        assignedto = (Integer) session.getAttribute("userid_curr");
        if (request.getParameter("performerid") != null) {
            performerid = Integer.valueOf(request.getParameter("performerid"));
        }
        logger.info(performerid);
        Calendar c = Calendar.getInstance();
        c.set(Calendar.DAY_OF_WEEK, Calendar.SUNDAY);
        Calendar c1 = Calendar.getInstance();
        c1.setTime(c.getTime());
        c1.add(Calendar.DATE, -1);
        Date start = c1.getTime();
        c.set(Calendar.DAY_OF_WEEK, Calendar.FRIDAY);
        Date end = c.getTime();
        startDate = sdf.format(start);
        endDate = sdf.format(end);
        logger.info("startDate" + startDate + ", endDate" + endDate);
        if (request.getParameter("fromdate") != null) {
            startDate = request.getParameter("fromdate");
            startDate = com.pack.ChangeFormat.changeDateFormat(startDate);
            logger.info("---->" + startDate);
        }
        if (request.getParameter("todate") != null) {
            endDate = request.getParameter("todate");
            endDate = com.pack.ChangeFormat.changeDateFormat(endDate);
            logger.info("---->" + endDate);
        }

        String branchId = request.getParameter("branch");
        SendMomMaintainController smmc = new SendMomMaintainController();
        smmc.getLocationNBranch(assignedto);
        if (branchId != null) {
            if ("".equals(branchId)) {
                branchId = null;
            } else {
                branch = MoMUtil.parseInteger(branchId, 0);
            }
        } else {
            branch = smmc.getSendMomMaintenance().getBranchId() == null ? (Integer) session.getAttribute("branch") : smmc.getSendMomMaintenance().getBranchId();
        }
        teamWise = GetProjectMembers.getEminentUsersByTeam(branch);
        startMM = sdfs.format(sdf.parse(startDate));
        endMM = sdfs.format(sdf.parse(endDate));
        java.sql.Date sdate = new java.sql.Date((sdf.parse(startDate)).getTime());
        java.sql.Date edate = new java.sql.Date(sdf.parse(endDate).getTime());
        usersPerformances = MoMUtil.findAllUsersPerformance(sdate, edate, branch);
        winnerscount = 0;
        for (UsersPerformance up : usersPerformances) {
            if (winnerscount == 0) {
                if (up.getPerformanceType().equalsIgnoreCase(PerformanceType.WINNER.getStatusCode())) {
                    if (!up.getTeam().equalsIgnoreCase("NA")) {
                        winners = up.getTeam();
                    }
                    winnerscount++;
                }
            }
        }
        if (performerid != 0) {
            noOfUsers = (String.valueOf(performerid)).split(",");
        }
        totUsers = Arrays.asList(noOfUsers);
        Calendar cal = Calendar.getInstance();
        cal.setTime(new Date());

        Long startTime = cal.getTimeInMillis();

        weekPlannedIssue = MoMUtil.weekPlannedIssue(startDate, endDate);

        weekClosedIssue = MoMUtil.weekClosedIssue(startDate, endDate);

        Iterator it = weekClosedIssue.entrySet().iterator();
        while (it.hasNext()) {
            Map.Entry entry = (Map.Entry) it.next();
            ClosedIssues = ClosedIssues + entry.getKey() + ",";
        }
        if (ClosedIssues != "") {
            ClosedIssues = ClosedIssues.substring(0, ClosedIssues.length() - 1);
            logger.info(ClosedIssues);

            previousPlanClose = MoMUtil.addClosures(ClosedIssues);

        }

        Map<Integer, List<MomUserTask>> mapTask = MoMUtil.viewTaskBetweenTwoDate(endDate, startDate);

        cal.setTime(new Date());
        startTime = cal.getTimeInMillis();

        Date ext = sdf.parse(endDate);
        Calendar calender = Calendar.getInstance();
        calender.setTime(ext);
        calender.add(Calendar.DATE, 1);
        String enddated = sdf.format(calender.getTime());

        String actualIs[][] = MoMUtil.issuesDetails(startDate, enddated);
        cal.setTime(new Date());
        long endtime = cal.getTimeInMillis();

        Collection set = teamWise.keySet();
        Iterator ite = set.iterator();
        Map<String, String> closePer = new LinkedHashMap<String, String>();
        while (ite.hasNext()) {
            Set<String> plannedIssue = new HashSet<String>();
            Set<String> actualIssue = new HashSet<String>();
            TeamAverage teamAverage = new TeamAverage();
            List<WeekPerformersBean> teamWiseUsers = new ArrayList<WeekPerformersBean>();
            boolean checkTuser = true;
            int teamPlanAvg = 0;
            int teamCloseAvg = 0;
            int teamIssueCount = 0;
            String teamPerAvg = null;
            String teamUsers = "";
            int matched = 1;
            String key = (String) ite.next();
            List<Integer> users = (List<Integer>) teamWise.get(key);
            Object[] toUsers = users.toArray();
            int k = 1;
            for (int j = 0; j < toUsers.length; j++) {
                String tuid = toUsers[j].toString();
                if (totUsers.contains(tuid)) {
                    matched++;
                }
                teamUsers = teamUsers + tuid + ",";
            }

            for (int j = 0; j < toUsers.length; j++) {
                WeekPerformersBean userBean = new WeekPerformersBean();
                List<IssuesTask> plannedList = new ArrayList<IssuesTask>();
                List<IssuesTask> actualList = new ArrayList<IssuesTask>();
                String actualIssues[][];
                List<String> uniqueIssuesList = new ArrayList<String>();
                List<String> uniqueActualIssuesList = new ArrayList<String>();
                //  MomUserTask userTask = null;
                IssuesTask plannedTask = null;
                String tuid = toUsers[j].toString();
                userBean.setTeam(key);
                userBean.setUserId(tuid);
                userBean.setName(member.get(Integer.parseInt(tuid)));
                // adding for issues count for individual and team count

                if (totUsers.contains(tuid)) {
                    k++;
                    if (myAssignCount.containsKey(MoMUtil.parseInteger(tuid, 0))) {
                        userBean.setMyAssignmentCount(myAssignCount.get(MoMUtil.parseInteger(tuid, 0)));
                        teamIssueCount = teamIssueCount + userBean.getMyAssignmentCount();
                    }
                    if (checkTuser == true) {
                        checkTuser = false;
                    }
                    if (!weekPlannedIssue.isEmpty() || !previousPlanClose.isEmpty()) {
                        String issuenos = MoMUtil.getIssueByUser(weekPlannedIssue, tuid.toString());
                        String weekPerformers[] = MoMUtil.weekPerformer(tuid.toString(), weekPlannedIssue, weekClosedIssue);
                        int userid = Integer.parseInt(tuid.toString());
                        List<String> issueList = new ArrayList<String>();
                        int i = 0;
                        if (previousPlanClose.containsKey(userid)) {
                            List<String> issues = new ArrayList<String>(0);
                            issues = previousPlanClose.get(userid);
                            for (String is : issues) {
                                if (!weekPlannedIssue.contains(is + "," + userid)) {
                                    if (i == 0 && !"".equals(issuenos)) {
                                        issuenos = issuenos + ",'" + is + "',";
                                    } else {
                                        issuenos = issuenos + "'" + is + "',";
                                    }
                                    issueList.add(is);
                                    i++;
                                }
                            }
                        }
                        if (i > 0) {
                            if (issuenos.length() > 12) {
                                issuenos = issuenos.substring(0, issuenos.length() - 1);
                            }
                        }
                        List checkedIssuesList = new ArrayList();
                        for (UsersPerformance up : usersPerformances) {
                            int uId = up.getUserId();
                            if (uId == userid) {
                                if (up.getTasks() != null) {
                                    String checkdissues[] = up.getTasks().split(",");
                                    checkedIssuesList = Arrays.asList(checkdissues);
                                }
                            }
                        }
                        if (i > 0) {
                            weekPerformers[1] = String.valueOf(Integer.valueOf(weekPerformers[1]) + i);
                            weekPerformers[0] = String.valueOf(Integer.valueOf(weekPerformers[0]) + i);
                        }

                        if (usersPerformances.size() > 0) {
                            weekPerformers[0] = String.valueOf(checkedIssuesList.size());
                        }
                        closedCount = Integer.valueOf(weekPerformers[0]);
                        plannedCount = Integer.valueOf(weekPerformers[1]);
                        userBean.setPlannedCount(plannedCount);
                        userBean.setClosedCount(closedCount);
                        userBean.setAverage(dashboard.ArithOperation.calcPercentagewithDecimal(plannedCount, closedCount));
                        teamPlanAvg = teamPlanAvg + Integer.valueOf(weekPerformers[1]);
                        teamCloseAvg = teamCloseAvg + Integer.valueOf(weekPerformers[0]);
                        if (closedCount > 0) {
                            competitors = competitors + tuid + ",";
                        }
                        List<MomUserTask> task = new ArrayList<MomUserTask>();
                        if (mapTask == null || mapTask.isEmpty()) {

                        } else {
                            if (mapTask.get(userid) == null) {

                            } else {

                                task = mapTask.get(userid);
                            }
                        }

                        if (!task.isEmpty() || i > 0) {
                            Set<String> planned = MoMUtil.getIssueListByUser(weekPlannedIssue, tuid);
                            for (MomUserTask userTaska : task) {
                                if (userTaska.getTasktime().equalsIgnoreCase("Planned")) {
                                    if (userTaska.getType().equalsIgnoreCase("issue")) {
                                        plannedTask = MoMUtil.getIssueDetails(userTaska.getTask());
                                        if (planned.contains(plannedTask.getIssueno()) && !uniqueIssuesList.contains(plannedTask.getIssueno())) {
                                            uniqueIssuesList.add(plannedTask.getIssueno());
                                            plannedIssue.add(plannedTask.getIssueno());
                                            plannedList.add(plannedTask);
                                        }
                                    }
                                } else if (userTaska.getTasktime().equalsIgnoreCase("Actual")) {
                                    if (userTaska.getType().equalsIgnoreCase("issue")) {
                                        plannedTask = MoMUtil.getIssueDetails(userTaska.getTask());
                                        if (!uniqueActualIssuesList.contains(plannedTask.getIssueno())) {
                                            uniqueActualIssuesList.add(plannedTask.getIssueno());
                                        }
                                    }
                                }
                            }

                            if (issuenos != "") {
                                for (int ai = 0; ai < actualIs.length; ai++) {
                                    if (issuenos.contains(actualIs[ai][0])) {
                                        String color = "";

                                        if (weekClosedIssue.containsKey(actualIs[ai][0])) {
                                            String rating = (String) weekClosedIssue.get(actualIs[ai][0]);
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

                                            if (issueList.contains(actualIs[ai][0])) {
                                                if (checkedIssuesList.contains(actualIs[ai][0]) || usersPerformances.size() == 0) {

                                                    IssuesTask actualtask = new IssuesTask();
                                                    actualtask.setIssueno(actualIs[ai][0]);
                                                    actualtask.setStatus(actualIs[ai][1]);
                                                    actualtask.setSubject(actualIs[ai][2]);
                                                    actualtask.setProjectName(actualIs[ai][3]);
                                                    actualtask.setColor(color);
                                                    actualtask.setCheckBox("yes");
                                                    actualtask.setCheckParam("true");
                                                    actualIssue.add(actualIs[ai][0]);
                                                    actualList.add(actualtask);

                                                } else {

                                                    IssuesTask actualtask = new IssuesTask();
                                                    actualtask.setIssueno(actualIs[ai][0]);
                                                    actualtask.setStatus(actualIs[ai][1]);
                                                    actualtask.setSubject(actualIs[ai][2]);
                                                    actualtask.setProjectName(actualIs[ai][3]);
                                                    actualtask.setColor(color);
                                                    actualtask.setCheckBox("yes");
                                                    actualtask.setCheckParam("false");
                                                    //  actualIssue.add(actualIssues[ai][0]);
                                                    actualList.add(actualtask);

                                                }
                                                IssuesTask preCloseIssue = new IssuesTask();
                                                preCloseIssue.setIssueno(actualIs[ai][0]);
                                                preCloseIssue.setStatus(actualIs[ai][1]);
                                                preCloseIssue.setSubject(actualIs[ai][2]);
                                                preCloseIssue.setProjectName(actualIs[ai][3]);
                                                preCloseIssue.setColor(color);
                                                plannedIssue.add(actualIs[ai][0]);
                                                plannedList.add(preCloseIssue);

                                            } else {
                                                if (checkedIssuesList.contains(actualIs[ai][0]) || usersPerformances.size() == 0) {

                                                    IssuesTask actualtask = new IssuesTask();
                                                    actualtask.setIssueno(actualIs[ai][0]);
                                                    actualtask.setStatus(actualIs[ai][1]);
                                                    actualtask.setSubject(actualIs[ai][2]);
                                                    actualtask.setProjectName(actualIs[ai][3]);
                                                    actualtask.setColor(color);
                                                    actualtask.setCheckBox("yes");
                                                    actualtask.setCheckParam("true");
                                                    actualIssue.add(actualIs[ai][0]);
                                                    actualList.add(actualtask);
                                                } else {
                                                    IssuesTask actualtask = new IssuesTask();
                                                    actualtask.setIssueno(actualIs[ai][0]);
                                                    actualtask.setStatus(actualIs[ai][1]);
                                                    actualtask.setSubject(actualIs[ai][2]);
                                                    actualtask.setProjectName(actualIs[ai][3]);
                                                    actualtask.setColor(color);
                                                    actualtask.setCheckBox("yes");
                                                    actualtask.setCheckParam("false");
                                                    //  actualIssue.add(actualIssues[ai][0]);
                                                    actualList.add(actualtask);

                                                }
                                            }
                                        } else {
                                            if (uniqueActualIssuesList.contains(actualIs[ai][0])) {
                                                IssuesTask actualtask = new IssuesTask();
                                                actualtask.setIssueno(actualIs[ai][0]);
                                                actualtask.setStatus(actualIs[ai][1]);
                                                actualtask.setSubject(actualIs[ai][2]);
                                                actualtask.setProjectName(actualIs[ai][3]);
                                                actualtask.setColor(color);
                                                actualtask.setCheckBox("no");
                                                // actualIssue.add(actualIssues[ai][0]);
                                                actualList.add(actualtask);
                                            }
                                        }
                                    }
                                }
                                userBean.setPlannedList(plannedList);
                                userBean.setActualList(actualList);
                            }
                            teamWiseUsers.add(userBean);
                            logger.info("competitors" + competitors);
                        }
                    }
                    if (matched == k) {
                        // NumberFormat nf = new DecimalFormat("#.##");
                        //  double planAvg = teamPlanAvg / (matched - 1);
                        teamPlanAvg = plannedIssue.size();
                        teamCloseAvg = actualIssue.size();
                        teamPerAvg = dashboard.ArithOperation.calcPercentage(teamPlanAvg, teamCloseAvg);
                        teamAverage.setTeam(key);
                        teamAverage.setTeamUserIds(teamUsers);
                        teamAverage.setTeamPlanAvg(teamPlanAvg);
                        teamAverage.setTeamCloseAvg(teamCloseAvg);
                        teamAverage.setTeamPerAvg(teamPerAvg);
                        teamAverage.setTeamWiseUsers(teamWiseUsers);
                        teamAverage.setTeamIssueCount(teamIssueCount);
                        teamAverages.add(teamAverage);
                    }
                }
            }
        }
        Collections.sort(teamAverages, new Comparator<TeamAverage>() {
            @Override
            public int compare(TeamAverage t1, TeamAverage t2) {

                if (t1.getTeamPerAvg().equalsIgnoreCase("N/A")) {
                    t1.setTeamPerAvg("0");
                }
                if (t2.getTeamPerAvg().equalsIgnoreCase("N/A")) {
                    t2.setTeamPerAvg("0");
                }
                Float avg1 = Float.valueOf(t1.getTeamPerAvg());
                Float avg2 = Float.valueOf(t2.getTeamPerAvg());
                return avg2.compareTo(avg1);
            }
        }
        );

    }

    /*edit by mukesh*/
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

    public String getWinners() {
        return winners;
    }

    public void setWinners(String winners) {
        this.winners = winners;
    }

    public List<String> getModList() {
        return modList;
    }

    public void setModList(List<String> modList) {
        this.modList = modList;
    }

    public int getAssignedto() {
        return assignedto;
    }

    public void setAssignedto(int assignedto) {
        this.assignedto = assignedto;
    }

    public int getPerformerid() {
        return performerid;
    }

    public void setPerformerid(int performerid) {
        this.performerid = performerid;
    }

    public String getStartMM() {
        return startMM;
    }

    public void setStartMM(String startMM) {
        this.startMM = startMM;
    }

    public String getEndMM() {
        return endMM;
    }

    public void setEndMM(String endMM) {
        this.endMM = endMM;
    }

    public static Logger getLogger() {
        return logger;
    }

    public static void setLogger(Logger logger) {
        WeeklyPerformers.logger = logger;
    }

    public ResourceBundle getRb() {
        return rb;
    }

    public void setRb(ResourceBundle rb) {
        this.rb = rb;
    }

    public String getMods() {
        return mods;
    }

    public void setMods(String mods) {
        this.mods = mods;
    }

    public String[] getNoOfIds() {
        return noOfIds;
    }

    public void setNoOfIds(String[] noOfIds) {
        this.noOfIds = noOfIds;
    }

    public SimpleDateFormat getSdf() {
        return sdf;
    }

    public void setSdf(SimpleDateFormat sdf) {
        this.sdf = sdf;
    }

    public DateFormat getSdfs() {
        return sdfs;
    }

    public void setSdfs(DateFormat sdfs) {
        this.sdfs = sdfs;
    }

    public HashMap<Integer, String> getMember() {
        return member;
    }

    public void setMember(HashMap<Integer, String> member) {
        this.member = member;
    }

    public Map<String, List<Integer>> getTeamWise() {
        return teamWise;
    }

    public void setTeamWise(Map<String, List<Integer>> teamWise) {
        this.teamWise = teamWise;
    }

    public Map<Integer, List<String>> getPreviousPlanClose() {
        return previousPlanClose;
    }

    public void setPreviousPlanClose(Map<Integer, List<String>> previousPlanClose) {
        this.previousPlanClose = previousPlanClose;
    }

    public String getCompetitors() {
        return competitors;
    }

    public void setCompetitors(String competitors) {
        this.competitors = competitors;
    }

    public String getClosedIssues() {
        return ClosedIssues;
    }

    public void setClosedIssues(String ClosedIssues) {
        this.ClosedIssues = ClosedIssues;
    }

    public String getMomusers() {
        return momusers;
    }

    public void setMomusers(String momusers) {
        this.momusers = momusers;
    }

    public String[] getNoOfUsers() {
        return noOfUsers;
    }

    public void setNoOfUsers(String[] noOfUsers) {
        this.noOfUsers = noOfUsers;
    }

    public int getWinnerscount() {
        return winnerscount;
    }

    public void setWinnerscount(int winnerscount) {
        this.winnerscount = winnerscount;
    }

    public int getClosedCount() {
        return closedCount;
    }

    public void setClosedCount(int closedCount) {
        this.closedCount = closedCount;
    }

    public int getPlannedCount() {
        return plannedCount;
    }

    public void setPlannedCount(int plannedCount) {
        this.plannedCount = plannedCount;
    }

    public List<WeekPerformersBean> getUserList() {
        return userList;
    }

    public void setUserList(List<WeekPerformersBean> userList) {
        this.userList = userList;
    }

    public List<TeamAverage> getTeamAverages() {
        return teamAverages;
    }

    public void setTeamAverages(List<TeamAverage> teamAverages) {
        this.teamAverages = teamAverages;
    }

    public int getBranch() {
        return branch;
    }

    public void setBranch(int branch) {
        this.branch = branch;
    }

}
