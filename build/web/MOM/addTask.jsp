<%-- 
    Document   : addTask
    Created on : Jan 9, 2013, 11:08:35 AM
    Author     : Tamilvelan
--%>
<%@page import="com.eminentlabs.mom.IssuesTask"%>
<%@page import="java.sql.*"%>
<%@page import="com.eminentlabs.mom.MoMUtil"%>
<%@page import="com.eminentlabs.mom.MomUserTask"%>
<%@page import="java.util.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.ResourceBundle,java.util.Arrays,java.util.List,org.apache.log4j.Logger,java.text.SimpleDateFormat,java.util.Calendar,java.util.GregorianCalendar,java.util.Date" %>
<!DOCTYPE html>

<%
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Cache-Control", "no-store");
    response.setDateHeader("Expires", 0);
    response.setHeader("Pragma", "no-cache");

    Logger logger = Logger.getLogger("addTask");
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
        <script type="text/javascript" src="<%= request.getContextPath()%>/javaScript/task.js"></script>
        <script type="text/javascript" src="<%= request.getContextPath()%>/javaScript/checkSubmit.js"></script>
        <script type="text/javascript" src="<%= request.getContextPath()%>/javaScript/jquery.js"></script>
        <script  type="text/javascript" src="<%= request.getContextPath()%>/javaScript/XMLHttpRequest.js"></script>
        <script type="text/javascript">
            function trim(str) {
                while (str.charAt(str.length - 1) === " ")
                    str = str.substring(0, str.length - 1);
                while (str.charAt(0) === " ")
                    str = str.substring(1, str.length);
                return str;
            }
            function checkIssue() {
                var issues = document.getElementsByName("issue");
                for (var i = 0; i < issues.length; i++) {
                    issueid = issues[i].value;
                    if (issueid !== "") {
                        xmlhttp = createRequest();
                        if (xmlhttp !== null) {
                            xmlhttp.open("GET", "<%= request.getContextPath()%>/MOM/checkIssueMOM.jsp?issueid=" + issueid, false);
                            xmlhttp.onreadystatechange = checkIssueto;
                            xmlhttp.send(null);
                        }
                        function checkIssueto() {
                            if (xmlhttp.readyState === 4 && xmlhttp.status === 200) {
                                var response = xmlhttp.responseText;
                                if (trim(response) !== "") {
                                    alert(response);
                                    issues[i].value = "";
                                    issues[i].focus();
                                }
                            }
                        }
                    }
                }
            }
        </script>
    </head>
    <%

        int assignedto = (Integer) session.getAttribute("userid_curr");
        Calendar c = new GregorianCalendar();
        Date date = c.getTime();
        SimpleDateFormat sdf = new SimpleDateFormat("dd-MMM-yyyy");
        String dateFor = sdf.format(date);
        SimpleDateFormat time = new SimpleDateFormat("HH");
        String timeFor = time.format(date);
        int current_time = Integer.parseInt(timeFor);
        String tasktime = "Planned";
        if (current_time > 14) {
            tasktime = "Actual";
        }
        String previousDay = MoMUtil.lastMomUserDay(assignedto, dateFor);
        logger.info("previousDay" + previousDay);
        ResourceBundle rb = ResourceBundle.getBundle("Resources");
        String mods = rb.getString("mom-mods");
        String noOfIds[] = mods.split(",");
        Map<String, String> todayPAIssueList = new LinkedHashMap<String, String>();
        Map<String, String> todayPAIssueTaskList = new LinkedHashMap<String, String>();
        Map<String, String> issueList = MoMUtil.getActuals(assignedto);
        Map<String, String> plannIssueList = MoMUtil.getPlannedForAddTask(assignedto);
        Map<String, String> todayACIssueList = new LinkedHashMap<String, String>();
        Map<String, String> todayACIssueTaskList = new LinkedHashMap<String, String>();
        Set<String> todayPATaskList = new LinkedHashSet<String>();
        Set<String> todayACTaskList = new LinkedHashSet<String>();
        Map<String, String> prevDayIssues = new LinkedHashMap<String, String>();
        Map<String, String> prevDayIssueTasks = new LinkedHashMap<String, String>();
        String prevIssues = "";
        List pIssueList = new ArrayList();
        if (prevIssues.length() > 12) {
            pIssueList = MoMUtil.prevDayIssueList(assignedto, prevIssues);
        }
        List<String> modList = Arrays.asList(noOfIds);
    %>
    <body>
        <%@ include file="../header.jsp"%>
        <jsp:useBean id="mas" class="com.eminent.issue.formbean.MyAsignmentIssues" /> 
    <jsp:useBean id="vmc" class="com.eminentlabs.mom.controller.SendMomMaintainController"></jsp:useBean>

    <% vmc.getLocationNBranch(assignedto);
       int wrmSize= mas.wrmIssues().size();
    %>
        <table cellpadding="0" cellspacing="0" width="100%">
            <tr border="2" bgcolor="#C3D9FF">
                <td border="1" align="left" width="70%">
                    <font size="4" COLOR="#0000FF"><b>Add Task for <%=dateFor%></b></font>
                    <!--                     <select id="taskfor" name="taskfor">
                                            <option value="Planned">Planned</option>
                                            <option value="Actual">Actual</option>
                                        </select>-->
                </td>

            </tr>
            <tr>
                <td style="height: 25px;">
                    <input type="button"  id="addissue" value="Add Issue" style="cursor: pointer;background-color: #4169E1;color: white;font-weight: bold;" onclick="javascript:addIssueMom();"> &nbsp;&nbsp;&nbsp;
                    <input type="button" id="addtask" value="Add Task" style="cursor: pointer;background-color: #4169E1;color: white;font-weight: bold;" onclick="javascript:addTask();"> &nbsp;&nbsp;&nbsp;
                    <a href="viewTask.jsp" style="cursor: pointer;">View Issue / Task</a> &nbsp;&nbsp;&nbsp;

                   <%
                   if (vmc.getSendMomMaintenance().getUserId()!=null && vmc.getSendMomMaintenance().getUserId().intValue() == assignedto) {
                %>
                <a href="<%=request.getContextPath()%>/MOM/mom.jsp" style="cursor: pointer;">Send MOM</a> &nbsp;&nbsp;&nbsp;
                <a href="<%=request.getContextPath()%>/MOM/plannedIssuesReport.jsp" style="cursor: pointer;">Planned Issue Report</a> &nbsp;&nbsp;&nbsp;
                <a href="<%=request.getContextPath()%>/MOM/feedBackCommand.jsp" style="cursor: pointer;">FeedBack</a> &nbsp;&nbsp;&nbsp;
                <a title="Fine Management" href="<%=request.getContextPath()%>/MOM/addFineAmtForUser.jsp" style="cursor: pointer;">Fine Mgmt</a> &nbsp;&nbsp;
                <a href="<%=request.getContextPath()%>/MOM/projectWiseClosedReport.jsp" style="cursor: pointer;">PM'S Rank</a> &nbsp;&nbsp;&nbsp;
                <%                 } else {
                %>
                <a href="<%=request.getContextPath()%>/MOM/fineAmtReort.jsp" style="cursor: pointer;">Fine Amount </a> &nbsp;&nbsp;&nbsp;
                <a href="<%=request.getContextPath()%>/MOM/fineReport.jsp" style="cursor: pointer;">Fine Report</a> &nbsp;&nbsp;&nbsp;
                <%}%>
                <a href="weekPerformers.jsp" style="cursor: pointer;">Team Performance</a> &nbsp;&nbsp;&nbsp;
                <a href="<%=request.getContextPath()%>/MOM/bestPMNTeam.jsp" style="cursor: pointer;">Best PM/Team</a> &nbsp;&nbsp;&nbsp;
                <a href="<%=request.getContextPath()%>/MOM/dueDateReport.jsp" style="cursor: pointer; ">DDR</a> &nbsp;&nbsp;&nbsp;
                <a href="<%=request.getContextPath()%>/MOM/wrmIssues.jsp" style="cursor: pointer; ">WRM Issues (<%=wrmSize%>)</a> &nbsp;&nbsp;&nbsp;
                </td>
            </tr>
        </table>
        <br>
        <%

            if (previousDay.equals("") || previousDay == null) {
            } else {
                String plan = "", planDetail = "";
                try {
                    int i = 0;
                    plan = "";
                    planDetail = "";
                    MomUserTask userTask = null;
                    List task = MoMUtil.viewTask(assignedto, previousDay);


                    boolean flag = true;
                    int noOfTask = task.size();
                    String period = null, color = "white", start = null, end = null, startMonth = "", endMonth = "", startYear = "", endYear = "";
                    for (Iterator reqIterator = task.iterator(); reqIterator.hasNext(); i++) {
                        if ((i % 2) != 0) {
                            color = "#E8EEF7";
                        } else {
                            color = "white";
                        }
                        userTask = (MomUserTask) reqIterator.next();
                        plan = userTask.getTasktime();

                        if (!plan.equalsIgnoreCase(planDetail)) {
                            planDetail = plan;
                        } else {
                            planDetail = "";
                        }
                        if (userTask.getTask() != null) {
        %>
<!--            <tr bgcolor="<%=color%>">-->


        <table style="width: 100%; background-color:#E8EEF7; "><tr ><td style="width: 12%;">
                    <% if (flag == true) {
                            flag = false;%>
                    <b>Previous Day :</b>
                    <%}%></td>
                <td  colspan="4" style="width:5%;" ><b><%=planDetail%></b></td> 
                        <%if (userTask.getType().equalsIgnoreCase("issue")) {

                                IssuesTask iTask = MoMUtil.getIssueDetails(userTask.getTask());

                                String issueno = "";
                                String issueSubject = "";
                                String pName = "";
                                String ratingColor = "";
                                if (userTask.getTask().length() > 12) {
                                    issueno = iTask.getIssueno().trim();
                                    pName = iTask.getProjectName();
                                    issueSubject = "# " + iTask.getStatus() + " : " + iTask.getSubject();
                                }
                                if (userTask.getTasktime().equalsIgnoreCase("Planned")) {
                                    if (pIssueList.contains(issueno)) {
                                        prevDayIssues.put(issueno, issueSubject);
                                        prevDayIssueTasks.put(issueno + ":" + pName, issueSubject);
                                    }
                                }
                                if (issueno != null) {
                                    if (userTask.getTasktime().equalsIgnoreCase("Actual")) {
                                        ratingColor = MoMUtil.getColor(issueno, sdf.format(userTask.getMomdate()));
                                    }
                        %>
                <td colspan="4"><a target="_blank" title="<%=pName%>" href="<%=request.getContextPath()%>/viewIssueDetails.jsp?issueid=<%=issueno%>"><font style=background-color:<%=ratingColor%>;"><%=issueno%></font></a> <%=issueSubject%></td>

                <%}
                } else {%>
                <td colspan="4"><%=userTask.getTask()%></td>
                <%}%>
            </tr></table>


        <%}%> 

        <%
                planDetail = plan;
            }%><%
                    } catch (Exception e) {
                    }

                }
                try {
                    String plan = "", planDetail = "";
                    int i = 0;
                    plan = "";
                    planDetail = "";
                    MomUserTask userTask = null;
                    List task = MoMUtil.viewTask(assignedto, dateFor);
                    boolean flag = true;
                    int noOfTask = task.size();
                    String period = null, color = "white", start = null, end = null, startMonth = "", endMonth = "", startYear = "", endYear = "";
                    for (Iterator reqIterator = task.iterator(); reqIterator.hasNext(); i++) {
                        if ((i % 2) != 0) {
                            color = "#E8EEF7";
                        } else {
                            color = "white";
                        }
                        userTask = (MomUserTask) reqIterator.next();
                        plan = userTask.getTasktime();

                        if (!plan.equalsIgnoreCase(planDetail)) {
                            planDetail = plan;
                        } else {
                            planDetail = "";
                        }
                        if (userTask.getTask() != null) {
        %>
<!--            <tr bgcolor="<%=color%>">-->


        <table style="width: 100%; "><tr >

                <td style="width: 12%;">
                    <% if (flag == true) {
                            flag = false;%>
                    <b>Today :</b>
                    <%}%></td>
                <td  colspan="10" style="width:5%;"><b><%=planDetail%></b></td> 
                        <%if (userTask.getType().equalsIgnoreCase("issue")) {

                                IssuesTask iTask = MoMUtil.getIssueDetails(userTask.getTask());

                                String issueno = "";
                                String issueSubject = "";

                                String pName = "";
                                String ratingColor = "";
                                if (userTask.getTask().length() > 12) {
                                    issueno = iTask.getIssueno().trim();
                                    pName = iTask.getProjectName().trim();

                                    issueSubject = "#" + iTask.getStatus() + ":" + iTask.getSubject();

                                    if (userTask.getTasktime().equalsIgnoreCase("Planned")) {
                                        todayPAIssueList.put(issueno, issueSubject);
                                        todayPAIssueTaskList.put(issueno + " : " + pName, issueSubject);

                                    } else {
                                        ratingColor = MoMUtil.getColor(issueno, dateFor);
                                        todayACIssueList.put(issueno, issueSubject);
                                        todayACIssueTaskList.put(issueno + ":" + pName, issueSubject);
                                    }
                                }
                                if (issueno != "") {%>
                <td colspan="4"><a target="_blank" title="<%=pName%>" href="<%=request.getContextPath()%>/viewIssueDetails.jsp?issueid=<%=issueno%>"><font style=background-color:<%=ratingColor%>;"><%=issueno%></font></a> # <%=iTask.getStatus()%> : <%=iTask.getSubject()%></td>

                <%}
                } else {
                    if (userTask.getTasktime().equalsIgnoreCase("Planned")) {
                        if (!userTask.getType().equalsIgnoreCase("Count")) {
                            todayPATaskList.add(userTask.getTask());
                        }
                    } else {
                        if (!userTask.getType().equalsIgnoreCase("Count")) {
                            todayACTaskList.add(userTask.getTask());
                        }
                    }
                %>
                <td colspan="4"><%=userTask.getTask()%></td>
                <%}%>
            </tr></table>


        <%}%> 

        <%
                planDetail = plan;
            }%><%
                } catch (Exception e) {
                }


        %>



        <form name="theForm" id="theForm" method="post" action="createTask.jsp" onsubmit="return fun(this);">
            <br>

            <%
                if (tasktime.equalsIgnoreCase("Planned")) {
                    if (!plannIssueList.isEmpty()) {%>
            <table><tr><td colspan="5" style="font-weight: bold;">Plan your today's work with the below issues :</td></tr>
                <%

                    for (Map.Entry<String, String> entry : plannIssueList.entrySet()) {
                        String issueTask = entry.getKey() + entry.getValue();
                        if (issueTask.length() > 12) {
                            IssuesTask issuesTask = MoMUtil.getIssueDetails(issueTask);
                            String issueno = issuesTask.getIssueno();
                            String pName = issuesTask.getProjectName();
                            String status = issuesTask.getStatus();
                            String subject = issuesTask.getSubject();
                            if (todayPAIssueList.containsKey(issueno)) {
                                if (!prevDayIssues.containsKey(issueno)) {
                %>
                <tr><td ><input type="hidden"  name="actualIssue"   value="<%=issueno%>" /> <input type="checkbox"  name="actualIssue"  disabled=""  value="<%=issueno%>" checked=""  style="vertical-align: middle;"/></td><td>  <a target="_blank" title="<%=pName%>" href="<%=request.getContextPath()%>/viewIssueDetails.jsp?issueid=<%=issueno%>"><%=issueno%></a> # <%=status%> : <%=subject%></td></tr>
                        <%
                                todayPAIssueList.remove(issueno);
                                todayPAIssueTaskList.remove(entry.getKey());
                            }

                        } else {
                            if (!prevDayIssues.containsKey(issueno)) {
                        %>
                <tr><td ><input type="checkbox"  name="actualIssue"   value="<%=issueno%>"  style="vertical-align: middle;"/></td><td>  <a target="_blank" title="<%=pName%>" href="<%=request.getContextPath()%>/viewIssueDetails.jsp?issueid=<%=issueno%>"><%=issueno%></a> # <%=status%> : <%=subject%></td></tr>
                        <% }
                                    }
                                }
                            }

                            logger.info(todayPAIssueTaskList);
                            for (Map.Entry<String, String> entry : todayPAIssueTaskList.entrySet()) {
                                String issueTask = entry.getKey() + entry.getValue();
                                if (issueTask.length() > 12) {
                                    IssuesTask issuesTask = MoMUtil.getIssueDetails(issueTask);
                                    String issueno = issuesTask.getIssueno();
                                    String pName = issuesTask.getProjectName();
                                    String status = issuesTask.getStatus();
                                    String subject = issuesTask.getSubject();


                           if (!prevDayIssues.containsKey(issueno)) {%>
                <tr><td ><input type="checkbox"  name="actualIssue"  value="<%=issueno%>"  style="vertical-align: middle;" checked/></td><td>  <a target="_blank" title="<%=pName%>"  href="<%=request.getContextPath()%>/viewIssueDetails.jsp?issueid=<%=issueno%>"><%=issueno%></a>  <%=entry.getValue()%></td></tr>
                        <%} else {%>
                <tr><td ><input type="checkbox"  name="actualIssue"   value="<%=issueno%>" checked="" disabled="true" readonly="true"  style="vertical-align: middle;"/></td><td>  <a target="_blank"  title="<%=pName%>" href="<%=request.getContextPath()%>/viewIssueDetails.jsp?issueid=<%=issueno%>"><%=issueno%></a> # <%=status%> : <%=subject%></td></tr>
                        <%}
                 }
             }
             for (String pTask : todayPATaskList) {%>
                <tr><td ><input type="checkbox"  name="task"   value="<%=pTask%>"  style="vertical-align: middle;" checked/></td><td><%=pTask%></td></tr>
                        <%}
                        %>
            </table>
            <%}
                }

                if (!issueList.isEmpty()) {%>
            <table><tr><td colspan="5" style="font-weight: bold;">Actual updated issues :</td></tr>
                <%for (Map.Entry<String, String> entry : issueList.entrySet()) {

                        String issueTask = entry.getKey() + entry.getValue();
                        if (issueTask.length() > 12) {
                            IssuesTask issuesTask = MoMUtil.getIssueDetails(issueTask);
                            String issueno = issuesTask.getIssueno();
                            String pName = issuesTask.getProjectName();
                            String status = issuesTask.getStatus();
                            String subject = issuesTask.getSubject();
                            String ratingColor = MoMUtil.getColor(issueno, dateFor);

                %>
                <tr><td >
                        <%if (tasktime.equalsIgnoreCase("Actual")) {%>
                        <input type="checkbox"  name="actualIssue"  value="<%=issueno%>" checked  style="vertical-align: middle;"/>
                        <%}
                            todayACIssueList.remove(issueno);
                            todayACIssueTaskList.remove(entry.getKey());%>
                    </td><td>  <a target="_blank" title="<%=pName%>" href="<%=request.getContextPath()%>/viewIssueDetails.jsp?issueid=<%=issueno%>"><font style=background-color:<%=ratingColor%>;"><%=issueno%></font></a> # <%=status%> : <%=subject%></td></tr>     

                <%}
                    }
                    for (Map.Entry<String, String> entry : todayACIssueTaskList.entrySet()) {

                        String issueTask = entry.getKey() + entry.getValue();
                        if (issueTask.length() > 12) {
                            IssuesTask issuesTask = MoMUtil.getIssueDetails(issueTask);
                            String issueno = issuesTask.getIssueno();
                            String pName = issuesTask.getProjectName();
                            String status = issuesTask.getStatus();
                            String subject = issuesTask.getSubject();
                            String ratingColor = MoMUtil.getColor(entry.getKey(), dateFor);


                %>
                <tr><td ><input type="checkbox"  name="actualIssue"   value="<%=issueno%>"  style="vertical-align: middle;" checked/></td><td>  <a target="_blank" title="<%=pName%>"  href="<%=request.getContextPath()%>/viewIssueDetails.jsp?issueid=<%=issueno%>"><font style=background-color:<%=ratingColor%>;"><%=issueno%></font></a> # <%=status%> : <%=subject%></td></tr>
                        <%}
                            }
                            for (String aTask : todayACTaskList) {%>
                <tr><td ><input type="checkbox"  name="task"   value="<%=aTask%>"  style="vertical-align: middle;" checked/></td><td><%=aTask%></td></tr>
                        <%}%>
            </table>
            <%}%>
            <table width="100%"  id="userissue" bgcolor="#E8EEF7" cellspacing="2" cellpadding="2" align="center">
                <tr id="id0">
                    <td width='25px' style="font-weight: bold;">Sl. N</td>
                    <td style="font-weight: bold;">Issue Id</td>
                </tr>

            </table>
            <table width="100%" border="0" id="usertask" bgcolor="#E8EEF7" cellspacing="2" cellpadding="2" align="center">
                <tr id="id0" >
                    <td width='25px' style="font-weight: bold;">Sl. N</td>
                    <td style="font-weight: bold;">Tasks</td>
                </tr>

            </table>
            <table> 
                <tr>
                    <td width='25px'><input type="submit" name="submit" id="submit" value="Submit"/></td>

                </tr>
            </table>
        </form>
        <SCRIPT language="JavaScript">

<!--

            /** Java Script Function For Trimming A String To Get Only The Required String Input */

            function trim(str) {
                while (str.charAt(str.length - 1) == " ")
                    str = str.substring(0, str.length - 1);
                while (str.charAt(0) == " ")
                    str = str.substring(1, str.length);
                return str;
            }

            /** Function To Check Whether There Is Any Integer Present In The Form Input From The User */

            function isPositiveInteger(str) {
                var pattern = "E1234567890"
                var i = 0;
                do {
                    var pos = 0;
                    for (var j = 0; j < pattern.length; j++)
                        if (str.charAt(i) == pattern.charAt(j)) {
                            pos = 1;
                            break;
                        }
                    i++;
                }
                while (pos == 1 && i < str.length)
                if (pos == 0)
                    return false;
                return true;
            }
            var dtCh = "/";
            var minYear = 1900;
            var maxYear = 2100;

            function isInteger(s) {
                var i;
                for (i = 0; i < s.length; i++)
                {
                    var c = s.charAt(i);
                    if (((c < "0") || (c > "9")))
                        return false;
                }
                return true;
            }

            function stripCharsInBag(s, bag)
            {
                var i;
                var returnString = "";
                for (i = 0; i < s.length; i++)
                {
                    var c = s.charAt(i);
                    if (bag.indexOf(c) == -1)
                        returnString += c;
                }
                return returnString;
            }

            function daysInFebruary(year)
            {
                return (((year % 4 == 0) && ((!(year % 100 == 0)) || (year % 400 == 0))) ? 29 : 28);
            }
            function DaysArray(n)
            {
                for (var i = 1; i <= n; i++)
                {
                    this[i] = 31
                    if (i == 4 || i == 6 || i == 9 || i == 11) {
                        this[i] = 30
                    }
                    if (i == 2) {
                        this[i] = 29
                    }
                }
                return this
            }

            function isDate(dtStr)
            {
                var daysInMonth = DaysArray(12);
                var pos1 = dtStr.indexOf(dtCh);
                var pos2 = dtStr.indexOf(dtCh, pos1 + 1);
                var strMonth = dtStr.substring(3, 5);
                var strDay = dtStr.substring(1, 3);
                var strYear = dtStr.substring(5, 9);
                strYr = strYear;
                if (strDay.charAt(0) === "0" && strDay.length > 1)
                    strDay = strDay.substring(1);
                if (strMonth.charAt(0) === "0" && strMonth.length > 1)
                    strMonth = strMonth.substring(1);
                for (var i = 1; i <= 3; i++)
                {
                    if (strYr.charAt(0) === "0" && strYr.length > 1)
                        strYr = strYr.substring(1);
                }
                month = parseInt(strMonth);
                day = parseInt(strDay);
                year = parseInt(strYr);
                if (strMonth.length < 1 || month < 1 || month > 12)
                {
                    alert("Please enter a valid Month in the Issue No(EDDMMYYYY001)");
                    return false;
                }
                if (strDay.length < 1 || day < 1 || day > 31 || (month === 2 && day > daysInFebruary(year)) || day > daysInMonth[month])
                {
                    alert("Please enter a valid Day  in the Issue No(EDDMMYYYY001)");
                    return false;
                }
                if (strYear.length !== 4 || year === 0 || year < minYear || year > maxYear)
                {
                    alert("Please enter a valid Year in the Issue No(EDDMMYYYY001)");
                    return false;
                }
                var today = new Date;
                if (parseInt(today.getFullYear()) < year)
                {
                    window.alert("Enter the valid Year in the Issue No(EDDMMYYYY001) ");
                    return false;
                }
                if (parseInt(today.getFullYear()) === year)
                {
                    //           alert(parseInt(today.getMonth())+1+"here"+month)
                    if (month > (parseInt(today.getMonth()) + 1))
                    {
                        window.alert("Enter the valid Month in the Issue No(EDDMMYYYY001) ");
                        return false;
                    }
                    if (month === (parseInt(today.getMonth()) + 1))
                    {
                        //alert(day+"here"+parseInt(today.getDate()));
                        if (day > parseInt(today.getDate()))
                        {
                            window.alert("Enter the valid Day in the Issue No(EDDMMYYYY001) ");
                            return false;
                        }
                    }
                }
                return true;
            }

            /** Function To Validate The Input Form Data */

            function fun(theForm) {

                /** This Loop Checks Whether There Is Any Integer Present In The Company Field */
                var func = document.getElementsByName("issue");
                var taskBox = document.getElementsByName("task");
                for (var i = 0; i < func.length; i++) {
                    if (!isPositiveInteger(trim(func[i].value))) {
                        alert('Enter Issue NO in proper format like EDDMMYYYY001');
                        func[i].value = "";
                        func[i].focus();
                        return false;
                    }

                    if (!isDate(trim(func[i].value))) {
                        func[i].value = "";
                        func[i].focus();
                        return false;
                    }
                    if ((trim(func[i].value).length) < 12) {
                        alert('Size of the Issue No should be 12 characters ');
                        func[i].value = "";
                        func[i].focus();
                        return false;
                    }
                    if ((trim(func[i].value).length) > 12) {
                        alert('Size of the Issue No should be 12 characters ');
                        func[i].value = "";
                        func[i].focus();
                        return false;
                    }

                    if ((func[i].value === null) || (func[i].value === ""))
                    {
                        alert("Please Enter the Issue Number");
                        func[i].focus();
                        return false;
                    }
                    if (isDate(func[i].value) === false) {
                        return false;
                    }
                    //                    for(var r=0;i<func.length;r++){
                    //                        if(r!=i){
                    //                        if(func[r].value==func[r].value){
                    //                            alert("Repetion  tasks occured");
                    //                            return false
                    //                        }
                    //                        
                    //                    }
                    function setFocus() {
                        func[i].focus();
                    }
                }
                for (var j = 0; j < taskBox.length; j++) {
                    if (trim(taskBox[j].value) === "") {
                        alert('Please enter your task');
                        taskBox[j].focus();
                        return false;
                    }
                }
                monitorSubmit();
            }
            /** Function To Set Focus On The First Name Field In The Form */




            //-->

        </SCRIPT>
    </body>
</html>
