<%-- 
    Document   : addProjectPlanIssue
    Created on : Jan 30, 2014, 11:49:28 AM
    Author     : E0288
--%>

<%@page import="java.util.Set"%>
<%@page import="com.eminentlabs.mom.ApmWrmPlan"%>
<%@page import="com.eminentlabs.dao.ModelDAO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.eminent.holidays.Holidays"%>
<%@page import="com.eminent.holidays.HolidaysUtil"%>
<%@page import="com.eminent.util.IssueDetails"%>
<%@page import="java.util.ResourceBundle"%>
<%@page import="com.eminentlabs.mom.MoMUtil"%>
<%@page import="org.apache.log4j.Logger"%>
<%@page import="com.eminent.issue.PlanStatus"%>
<%@page import="java.util.Arrays"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="java.util.GregorianCalendar"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.Calendar"%>
<%@page import="com.eminent.util.ProjectPlanUtil"%>
<%@page import="com.eminent.issue.ProjectPlannedIssue"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:useBean id="twm" class="com.eminentlabs.mom.TeamWiseMom"></jsp:useBean>

<%
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Cache-Control", "no-store");
    response.setDateHeader("Expires", 0);
    response.setHeader("Pragma", "no-cache");

    Logger logger = Logger.getLogger("addProjectPlannedIssue.jsp");
    String logoutcheck = (String) session.getAttribute("Name");
    if (logoutcheck == null) {
        logger.fatal("==============Session Expired===============");
%>
<jsp:forward page="../SessionExpired.jsp"></jsp:forward>
<%
    }

%>
<jsp:useBean id="mmc" class="com.eminentlabs.mom.controller.MomMaintananceController"/>
<%mmc.setSendMomAll(request);%>
<%
    Set<Integer> momusersList = mmc.getTotalUsers();
    SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy");
    String pId = request.getParameter("pId");
    String plannedFor = request.getParameter("plannedFor");

    logger.info(plannedFor);
    String planType = request.getParameter("planType");
    String issues[] = request.getParameterValues("pIssue");
    int userId = (Integer) session.getAttribute("userid_curr");
    String agreed = request.getParameter("agreed");
    Calendar c = new GregorianCalendar();
    Date currentDate = c.getTime();
    Date date = c.getTime();
    String dateFor = sdf.format(date);
    if (agreed == null) {
        List<String> newPlan = new ArrayList();
        if (issues != null) {
            newPlan = Arrays.asList(issues);
        }
        List<ApmWrmPlan> wrmPlanList = new ArrayList();
        wrmPlanList = twm.findByWRMDayAndPId(Long.valueOf(pId), date);
        List<String> wrmIssues = new ArrayList();
        List<String> wrmNewIssues = new ArrayList();
        List<ApmWrmPlan> wrmUpdate = new ArrayList();
        List<ApmWrmPlan> wrmUpdateAc = new ArrayList();
        for (ApmWrmPlan apmWrmPlan : wrmPlanList) {
            wrmIssues.add(apmWrmPlan.getIssueid());
        }
        for (ApmWrmPlan apmWrmPlan : wrmPlanList) {

            if (!newPlan.contains(apmWrmPlan.getIssueid())) {
                if (apmWrmPlan.getStatus().equals("Active")) {
                    wrmUpdate.add(apmWrmPlan);
                }

            } else {
                wrmUpdateAc.add(apmWrmPlan);
            }
        }
        if (plannedFor == null) {
            plannedFor = "Today";
        }
        if (planType == null) {
            planType = "Daily";
        }
        if (planType.equalsIgnoreCase("WRM")) {
            for (String issue : newPlan) {
                if (!wrmIssues.contains(issue)) {
                    wrmNewIssues.add(issue);
                }
            }

            MoMUtil.saveApmWrmPlan(wrmNewIssues, Long.valueOf(pId), userId);
            MoMUtil.update(wrmUpdate);
            MoMUtil.updateAc(wrmUpdateAc);
        } else {
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
            List<ProjectPlannedIssue> weekWisePlanIssue = ProjectPlanUtil.findByDayAndProjectId(date, Long.valueOf(pId));
            List<String> planIssues = new ArrayList();
            for (ProjectPlannedIssue ppi : weekWisePlanIssue) {

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
                        ProjectPlannedIssue projectPlannedIssue = new ProjectPlannedIssue(Long.valueOf(pId), issues[i], userId, date, currentDate, currentDate, PlanStatus.ACTIVE.getStatus());
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
        }
    } else {
        if (issues != null) {
            MoMUtil.saveAgreedIssues(Arrays.asList(issues), Long.valueOf(pId), userId, agreed);
        } else {
            MoMUtil.saveAgreedIssues(null, Long.valueOf(pId), userId, agreed);

        }
    }
%>
<jsp:forward page="/admin/dashboard/openIssueByProject.jsp">
    <jsp:param name="pid" value="<%=pId%>"></jsp:param>
    <jsp:param name="plannedFor" value="<%=plannedFor%>"></jsp:param>
    <jsp:param name="planDate" value="<%=dateFor%>"></jsp:param>
</jsp:forward>