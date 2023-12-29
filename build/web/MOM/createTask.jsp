<%-- 
    Document   : createTask
    Created on : Jan 9, 2013, 11:12:49 AM
    Author     : Tamilvelan
--%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="org.apache.log4j.Logger,java.text.SimpleDateFormat,java.util.Calendar,java.util.GregorianCalendar,java.util.Date" %>
<%@page import="com.eminentlabs.mom.MoMUtil" %>
<!DOCTYPE html>

<%
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Cache-Control", "no-store");
    response.setDateHeader("Expires", 0);
    response.setHeader("Pragma", "no-cache");

    Logger logger = Logger.getLogger("createTask");
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
    </head>
    <%
        Calendar c = new GregorianCalendar();
        Date date = c.getTime();
        SimpleDateFormat sdf = new SimpleDateFormat("dd-MMM-yyyy");
        String dateFor = sdf.format(date);
        SimpleDateFormat time = new SimpleDateFormat("HH");
        String timeFor = time.format(date);
        int current_time = Integer.parseInt(timeFor);
        logger.info("Current Time-->" + current_time);
        String taskTime = "Planned";
        if (current_time > 14) {
            taskTime = "Actual";
        }
        int userId = (Integer) session.getAttribute("uid");
        String taskUser = request.getParameter("taskUser");
        if (taskUser != null) {
            userId = Integer.parseInt(taskUser);
        }
        String actualIssue[] = request.getParameterValues("actualIssue");
        String issue[] = request.getParameterValues("issue");
        String task[] = request.getParameterValues("task");
        MoMUtil.deleteTodayTask(dateFor, userId, taskTime, "All");
        boolean issueCountFlag = MoMUtil.uniqueMOMIssueCount(dateFor, "Count", taskTime, userId);
        if (issueCountFlag == false) {
            String issueCount = MoMUtil.createIssueCountTask(userId);
            MoMUtil.createTask(userId, issueCount, userId, "Count", taskTime);
        }
                    if(taskTime.equalsIgnoreCase("Planned")){
                        String prevIssues="";
                        List<String> pIssueList=null;
                        if(prevIssues.length()>12){
                        pIssueList=MoMUtil.prevDayIssueList(userId,prevIssues);
                        if(!pIssueList.isEmpty()){
                        for(String issu:pIssueList){
                                MoMUtil.createTask(userId, issu, userId, "Issue", taskTime);
                            }
                        }
                        }
                       }
        if (actualIssue != null) {
            logger.info("No of Issues to be created-->" + actualIssue.length);

            for (int i = 0; i < actualIssue.length; i++) {
                try {
                    if (!actualIssue[i].equals("null")) {
                        logger.info("Issue to be created-->" + actualIssue[i]);
                        MoMUtil.createTask(userId, actualIssue[i], userId, "Issue", taskTime);
                    }
                } catch (Exception e) {
                    logger.error(e.getMessage());
                }
            }
        }
        if (issue != null) {
            logger.info("No of Issues to be created-->" + issue.length);
            for (int i = 0; i < issue.length; i++) {
                try {
                    if (!issue[i].equals("null")) {
                        logger.info("Issue to be created-->" + issue[i]);
                        MoMUtil.createTask(userId, issue[i], userId, "Issue", taskTime);
                    }
                } catch (Exception e) {
                    logger.error(e.getMessage());
                }
            }
        }
        if (task != null) {
            logger.info("No of Task to be created-->" + task.length);
            for (int k = 0; k < task.length; k++) {
                try {
                    logger.info("Task to be created-->" + task[k]);
                    if (!task[k].equals("null")) {
                        MoMUtil.createTask(userId, task[k], userId, "Task", taskTime);
                    }
                } catch (Exception e) {
                    logger.error(e.getMessage());
                }
            }
        }
    %>
    <jsp:forward page="viewTask.jsp"/>

</html>
