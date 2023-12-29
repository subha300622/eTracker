<%-- 
    Document   : createMOM
    Created on : Jan 2, 2013, 9:40:00 AM
    Author     : Tamilvelan
--%>

<%@page import="java.util.LinkedList"%>
<%@page import="com.eminentlabs.mom.MomFeedback"%>
<%@page import="java.util.ArrayList"%>
<%@page import="org.apache.log4j.Logger"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.Arrays"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ResourceBundle"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.eminentlabs.mom.MoMUtil,java.util.Calendar,java.util.GregorianCalendar,java.text.SimpleDateFormat,java.util.Date" %>
<!DOCTYPE html>
<%
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Cache-Control", "no-store");
    response.setDateHeader("Expires", 0);
    response.setHeader("Pragma", "no-cache");
    
    Logger logger = Logger.getLogger("createMOM");
    String logoutcheck = (String) session.getAttribute("Name");
    if (logoutcheck == null) {
        logger.fatal("==============Session Expired===============");
%>
<jsp:forward page="../SessionExpired.jsp"></jsp:forward>
<%        
    }

%>
<html>
    <meta name="keywords" content="GST in SAP, SAP GST Accelerator, GST Success in SAP, GST India in SAP, GST SAP Success, GST Suvidha Provider, GST ASP GSP, GST, CGST,SGST, IGST, UGST,  SAP NW based Product Development, SAP Consulting, SAP Implementation, SAP Support Services, SAP Outsourcing, SAP Implementation India, SAP Implementation Bangalore, SAP Implementation Chennai, SAP Implementation Belgium, SAP Implementation Paris, SAP Implemtation Australia, SAP Implementation France, SAP Implementation Mumbai, SAP Implementation Kerala, SAP Implementation Belgaum, SAP Implementation Thailand, SAP Implementation Mexico, SAP Implementation America">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>eTracker&#153; - Eminentlabs&#153; CRM, APM, TQM,  ERM and  EPTS Solution</title>
        <link title=STYLE href="<%=request.getContextPath()%>/eminentech support files/main_ie.css" type="text/css" rel="STYLESHEET"/>
        <script type="text/javascript" src="<%= request.getContextPath()%>/javaScript/checkSubmit.js"/>
            <link rel="stylesheet" href="<%=request.getContextPath()%>/css/theme.blue1.css?test=150720161404">
    <script src="<%= request.getContextPath()%>/javaScript/jquery.js" type="text/javascript" />
    <script src="<%= request.getContextPath()%>/javaScript/jquery-1.10.2.js"></script>
    <script src="<%=request.getContextPath()%>/javaScript/jquery.js" type="text/javascript"></script>
    <script src="<%=request.getContextPath()%>/javaScript/jquery.tablesorter.min.js" type="text/javascript"></script>
    <script src="<%=request.getContextPath()%>/javaScript/jquery-ui.min.js"></script>
    <script src="<%=request.getContextPath()%>/javaScript/jquery.tablesorter1.js" type="text/javascript"></script>
    </head>
    <body>
        <jsp:useBean id="mmc" class="com.eminentlabs.mom.controller.MomMaintananceController"/>
        <%
            
            mmc.setSendMomAll(request);

          
            mmc.SetSendMomFeedBack(request, mmc.getTotalUsers());
            /*
             Calendar c = new GregorianCalendar();
             Date date = c.getTime();
             SimpleDateFormat sdf = new SimpleDateFormat("dd-MMM-yyyy");
             String dateFor = sdf.format(date);
             SimpleDateFormat sdfs = new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss");
             SimpleDateFormat time = new SimpleDateFormat("HH");
             String timeFor = time.format(date);
             int current_time = Integer.parseInt(timeFor);

             String startTime = request.getParameter("startTime");
             String momTeamsType = request.getParameter("momTeamType");
             String allowUnPlan = request.getParameter("allowUnPlan");
             int momTeamType = MoMUtil.parseInteger(momTeamsType, 0);
             String teamType = momTeamsType;
             if (momTeamType == 0) {
             teamType = "1,2,3";
             } else if (momTeamType == 2) {
             teamType = "2,3";
             }

             int userId = (Integer) session.getAttribute("uid");
             String[][] todayTaskDetails = null;
             String tasktime = "Planned";
             String momTime = "Morning";
             if (current_time > 14) {
             momTime = "Evening";
             tasktime = "Actual";
             } else {
             todayTaskDetails = MoMUtil.getTodayMOMDetail(dateFor, teamType);
             }
             Date momstartTime = sdfs.parse(startTime);
             String chairPerson = request.getParameter("chairPerson");
             int cpId = MoMUtil.parseInteger(chairPerson, 0);
             logger.info("chairPerson" + chairPerson + "," + momTeamType);
             if (cpId != 0) {
             MomFeedback momFeedback = MoMUtil.uniqueMomFeedBack(momTime, date, momTeamType);
             if (momFeedback == null) {
             MoMUtil.createMOMFeedBack(userId, cpId, momTime, momstartTime, date, null, momTeamType);
             }
             }

             for (Integer momuserid : mmc.getTotalUsers()) {
             String status = request.getParameter(momuserid + "status");
             String comments = request.getParameter(momuserid + "comments");
             String[] issues = request.getParameterValues(momuserid + "issue");
             String[] momPlanIssues = request.getParameterValues(momuserid + "momPlanIssue");
             String momPlantask[] = request.getParameterValues(momuserid + "momPlantask");

             try {
             if (status != null) {
             if (status.equalsIgnoreCase("Present")) {
             boolean issueCountFlag = MoMUtil.uniqueMOMIssueCount(dateFor, "Count", tasktime, momuserid);
             if (issueCountFlag == false) {
             String issueCount = MoMUtil.createIssueCountTask(momuserid);
             MoMUtil.createTask(momuserid, issueCount, userId, "Count", tasktime);
             }
             MoMUtil.createMOMDetails(userId, momuserid, status, momTime, comments);
             if (issues != null) {
             for (int j = 0; j < issues.length; j++) {
             MoMUtil.createTask(momuserid, issues[j], userId, "Issue", tasktime);
             }
             }
             } else {
             MoMUtil.createMOMDetails(userId, momuserid, status, momTime, comments);
             }
             if (tasktime.equalsIgnoreCase("Planned") && allowUnPlan.equalsIgnoreCase("true")) {
             List<String> plannedIssues = new LinkedList<String>();
             List<String> momPlannedIssues = new LinkedList<String>();
             List<String> plannedTasks = new LinkedList<String>();
             List<String> momPlannedTasks = new LinkedList<String>();

             if (momPlanIssues != null) {
             momPlannedIssues = Arrays.asList(momPlanIssues);
             }
             if (momPlantask != null) {
             momPlannedTasks = Arrays.asList(momPlantask);
             }
             for (int i = 0; i < todayTaskDetails.length; i++) {
             int momuser = MoMUtil.parseInteger(todayTaskDetails[i][0], 0);
             if (momuser == momuserid) {
             if (todayTaskDetails[i][1].equalsIgnoreCase("Issue")) {
             plannedIssues.add(todayTaskDetails[i][2].substring(0, 12));
             }
             if (todayTaskDetails[i][1].equalsIgnoreCase("Task")) {
             plannedTasks.add(todayTaskDetails[i][3]);
             }
             }
             }

             plannedIssues.removeAll(momPlannedIssues);
             plannedTasks.removeAll(momPlannedTasks);
             for (String unplannedIssue : plannedIssues) {
             MoMUtil.deleteTaskByIssueAndUserId(dateFor, unplannedIssue, momuserid);
             }

             for (String unplanTask : plannedTasks) {
             try {
             MoMUtil.deleteTaskByTask(unplanTask);
             } catch (Exception e) {
             logger.error(e.getMessage());
             }
             }
             }
             }
             } catch (Exception e) {
             logger.error(e.getMessage());
             }
             }*/
        %>
        <jsp:forward page="feedBackCommand.jsp"></jsp:forward>
    </body>
</html>
