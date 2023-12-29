<%-- 
    Document   : viewTaskForUser
    Created on : Oct 9, 2013, 10:57:23 AM
    Author     : E0288
--%>

<%@page import="com.eminentlabs.mom.IssuesTask"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.eminent.util.GetProjectMembers"%>
<%@page import="java.util.HashMap"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="org.apache.log4j.Logger,java.text.SimpleDateFormat,java.util.Iterator,java.util.List,java.util.Calendar,java.util.GregorianCalendar,java.util.Date" %>
<%@page import="com.eminentlabs.mom.MoMUtil,com.eminentlabs.mom.MomUserTask,java.util.ResourceBundle,java.util.Arrays" %>
<!DOCTYPE html>

<%
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Cache-Control", "no-store");
    response.setDateHeader("Expires", 0);
    response.setHeader("Pragma", "no-cache");

    Logger logger = Logger.getLogger("viewTasksForUser");
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
        <script type="text/javascript" src="<%= request.getContextPath()%>/javaScript/checkSubmit.js"></script>
        <script type="text/javascript"	src="<%= request.getContextPath()%>/eminentech support files/datetimepicker.js"></script>
    </head>
    <%
        HashMap<Integer, String> member = GetProjectMembers.showUsers();
        Calendar c = new GregorianCalendar();
        Date date = c.getTime();
        SimpleDateFormat sdf = new SimpleDateFormat("dd-MMM-yyyy");
        String dateFor = sdf.format(date);
        int userId = (Integer) session.getAttribute("uid");
        if (request.getParameter("momUserId") != null) {
            String momUser = request.getParameter("momUserId");
            userId = MoMUtil.parseInteger(momUser, userId);
        }
        String username = member.get(userId);
        logger.info("username" + username);
        if (username == null || "".equals(username)) {
            userId = (Integer) session.getAttribute("uid");
            username = member.get(userId);
        }
        List task = null;
        int noOfPages = 0;
        List<Date> totalTask = MoMUtil.viewTaskSize(userId);
        int totalTasks = totalTask.size();
        noOfPages = totalTasks / 15;
        int r = totalTasks % 15;
        if (r > 0) {
            noOfPages = noOfPages + 1;
        }
        logger.info("noOfPages" + noOfPages);
        int pageStart = 0;
        int pageEnd = 29;

        if (pageEnd > totalTasks) {
            pageEnd = totalTasks - 1;
        }
        logger.info("pageStart" + pageStart + "pageEnd" + pageEnd);
        if (pageEnd >= 0) {
            task = MoMUtil.viewTaskBetweenTwoDates(userId, sdf.format(totalTask.get(pageStart)), sdf.format(totalTask.get(pageEnd)));
        }

        int assignedto = (Integer) session.getAttribute("userid_curr");
        HashMap<String,Integer> hm = dashboard.MaxIssue.getIssueCountForUser(String.valueOf(userId),String.valueOf(assignedto));
        ResourceBundle rb = ResourceBundle.getBundle("Resources");
        String mods = rb.getString("mom-mods");
        String noOfIds[] = mods.split(",");

        List<String> modList = Arrays.asList(noOfIds);
    %>
    <body>
        <%@ include file="../header.jsp"%>
        <form name="theForm"  action="./viewTaskDate.jsp" onsubmit="disableSubmit();">
            <table cellpadding="0" cellspacing="0" width="100%">
                <tr border="2" bgcolor="#C3D9FF">
                    <td style="font-weight: bold;width:30%;">MOM</td>
                    <td border="1" style="width: 30%;">
                        <font size="4" COLOR="#0000FF"><b>View Task On <input type="text" id="momdate" name="momdate" maxlength="10" size="10"
                                                                              value="<%=dateFor%>" readonly /><a
                                                                              href="javascript:NewCal('momdate','ddmmmyyyy')"> <img
                                    src="<%=request.getContextPath()%>/images/newhelp.gif" border="0"
                                    width="16" height="16" alt="Pick a date"></a></b></font>

                    </td>
                    <td><input type="submit" name="submit" id="submit" value="Submit"></td>
                </tr>
            </table>
        </form>
        <br/>
        <table cellpadding="0" cellspacing="0" width="100%">

            <tr>
                <td style="height: 25px;">
                    <a href="addTask.jsp"> Add Issue / Task</a>&nbsp;&nbsp;&nbsp;&nbsp;
                    <a href="viewTask.jsp" style="cursor: pointer;font-weight: bold;">View Issue / Task</a> &nbsp;&nbsp;&nbsp;

                    <%

                        if (modList.contains(((Integer) assignedto).toString())) {
                    %>
                    <a href="mom.jsp" style="cursor: pointer;">Send MOM</a> &nbsp;&nbsp;&nbsp;
                    <a href="weekPerformers.jsp" style="cursor: pointer;">Performance</a> &nbsp;&nbsp;&nbsp;
                    <a href="plannedIssuesReport.jsp" style="cursor: pointer;">Planned Issue Report</a> &nbsp;&nbsp;&nbsp;
                    <a href="<%=request.getContextPath()%>/MOM/feedBackCommand.jsp" style="cursor: pointer;">FeedBack</a> &nbsp;&nbsp;&nbsp;
                    <a href="<%=request.getContextPath()%>/MOM/projectWiseClosedReport.jsp" style="cursor: pointer;">PM'S Rank</a> &nbsp;&nbsp;&nbsp;
                    <%                 }
                    %>
                     <a href="<%=request.getContextPath()%>/admin/dashboard/userIssue.jsp?userId=<%=userId%>">All (<%= ( hm.get("altogether")) %>)</a>

                </td>
            </tr>
        </table>
        <br>
        <table cellpadding="0" cellspacing="0" width="100%">
            <%if (pageEnd >= 0) {%>
            <tr style="height: 30px;">
                <td align="left">This list shows last <%=pageEnd + 1%> days tasks created for <b><%=username%></b>. </td><td><b> <%=sdf.format(totalTask.get(pageStart))%></b> To <b><%=sdf.format(totalTask.get(pageEnd))%></b></td>
            </tr>
            <%}%>
        </table>

        <table width="100%">
            <tr  style="height: 21px;background-color:#C3D9FF; ">

                <td style="font-weight: bold;width: 10%;">Mom Date</td>
                <td style="font-weight: bold;width: 45%;">Planned</td>
                <td style="font-weight: bold;width: 45%;">Actual</td>   
            </tr>
            <%
                if (task == null) {
                    task = new ArrayList();
                }
                if (!task.isEmpty()) {%>
            <%

                int z = 0;
                String plan = "";
                String planDetail = "";
                MomUserTask userTask = null;
                String taskTotalForOneDate = "";
                Date momdate = null;
                String taskTotalForOneDateEve = "";
                String period = null, color = "white", start = null, end = null, startMonth = "", endMonth = "", startYear = "", endYear = "";

                for (Iterator reqIterator = task.iterator(); reqIterator.hasNext();) {

                    userTask = (MomUserTask) reqIterator.next();

                    if (momdate == null) {
                        momdate = userTask.getMomdate();
                        logger.info(momdate);
                    }
                    logger.info("userTask.getMomdate()" + momdate + userTask.getMomdate());

                    if (momdate.compareTo(userTask.getMomdate()) == 0) {
                        if (userTask.getTasktime().equalsIgnoreCase("Planned")) {
                            if (userTask.getType().equalsIgnoreCase("issue")) {
                                IssuesTask iTask=MoMUtil.getIssueDetails(userTask.getTask());
                            
                                String issueno = "";
                                String issueSubject = "";
                                String pName="";
                                if (userTask.getTask().length() > 12) {
                                    issueno = iTask.getIssueno().trim();
                                    pName=iTask.getProjectName();
                                    issueSubject = " # "+iTask.getStatus()+" : "+iTask.getSubject();
                                }
                               
                            if(issueno!=""){
                                taskTotalForOneDate = taskTotalForOneDate + "<li><a target=\"_blank\" title='"+pName+"' href="+request.getContextPath()+"/viewIssueDetails.jsp?issueid="+issueno+">"+issueno+"</a>" + issueSubject + "</li>";
                            }
                            }else{
                            taskTotalForOneDate = taskTotalForOneDate + "<li>" + userTask.getTask() + "</li>";
                            }
                        }
                    }
                    if (momdate.compareTo(userTask.getMomdate()) == 0) {
                        if (userTask.getTasktime().equalsIgnoreCase("Actual")) {
                            if (userTask.getType().equalsIgnoreCase("issue")) {
                                IssuesTask iTask=MoMUtil.getIssueDetails(userTask.getTask());
                            
                                String issueno = "";
                                String issueSubject = "";
                                String pName="";
                                if (userTask.getTask().length() > 12) {
                                    issueno = iTask.getIssueno().trim();
                                    pName=iTask.getProjectName();
                                    issueSubject = " # "+iTask.getStatus()+" : "+iTask.getSubject();
                                }
                               
                            if(issueno!=""){
                                String ratingColor=   MoMUtil.getColor(issueno, sdf.format(momdate));
                                taskTotalForOneDateEve = taskTotalForOneDateEve + "<li ><a target=\"_blank\" title='"+pName+"' href="+request.getContextPath()+"/viewIssueDetails.jsp?issueid="+issueno+"><font style=background-color:"+ratingColor+";"+">"+issueno+"</font></a>" + issueSubject + "</li>";

                            }
                            }else{
                            taskTotalForOneDateEve = taskTotalForOneDateEve + "<li>" + userTask.getTask() + "</li>";
                            }}
                    } else {
                        logger.info("z" + z + "+textdate" + taskTotalForOneDate + "-----------" + taskTotalForOneDateEve);
                        if (z == 0) {
                            color = "white";
                            z = 1;
                        } else {
                            color = "#E8EEF7";
                            z = 0;
                        }
            %>
            <tr bgcolor="<%=color%>">
                <td style="width: 8%;"><%=sdf.format(momdate)%></td>

                <td style="width: 46%;"><%=taskTotalForOneDate%></td>

                <td style="width: 46%;"> <%=taskTotalForOneDateEve%></td>

            </tr>
            <%          momdate = null;
                        taskTotalForOneDate = "";
                        taskTotalForOneDateEve = "";
                        momdate = userTask.getMomdate();
                        if (userTask.getTasktime().equalsIgnoreCase("Actual")) {
                            if (userTask.getType().equalsIgnoreCase("issue")) {
                                IssuesTask iTask=MoMUtil.getIssueDetails(userTask.getTask());
                            
                                String issueno = "";
                                String issueSubject = "";
                                String pName="";
                                if (userTask.getTask().length() > 12) {
                                    issueno = iTask.getIssueno().trim();
                                    pName=iTask.getProjectName();
                                    issueSubject = " # "+iTask.getStatus()+" : "+iTask.getSubject();
                                }
                               
                            if(issueno!=""){
                                String ratingColor=   MoMUtil.getColor(issueno, sdf.format(momdate));
                                taskTotalForOneDateEve = taskTotalForOneDateEve + "<li><a target=\"_blank\" title='"+pName+"' href="+request.getContextPath()+"/viewIssueDetails.jsp?issueid="+issueno+" style=background-color:"+ratingColor+">"+issueno+"</a>" + issueSubject + "</li>";

                            }
                            }else{
                            taskTotalForOneDateEve = taskTotalForOneDateEve + "<li>" + userTask.getTask() + "</li>";
                            }}
                        
                    }
                } if (momdate != null) {
                    if (z == 0) {
                        color = "white";
                        z = 1;
                    } else {
                        color = "#E8EEF7";
                        z = 0;
                    }
            %>
            <tr bgcolor="<%=color%>" >

                <td ><%=sdf.format(momdate)%></td>

                <td ><%=taskTotalForOneDate%></td>

                <td > <%=taskTotalForOneDateEve%></td>

            </tr>
            <%}%>


            <%} else {%>
            <tr><td colspan="10"> No tasks available for current week</td></tr>
            <%}%>
        </table>

    </body>
</html>

