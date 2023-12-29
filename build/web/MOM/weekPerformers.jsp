<%-- 
    Document   : weeklyperformers
    Created on : May 29, 2014, 8:53:26 AM
    Author     : RN.Khans
--%>

<%@page import="java.util.Map"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.Calendar"%>
<%@page import="com.eminentlabs.mom.TeamAverage"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.Collection"%>
<%@page import="com.eminentlabs.mom.IssuesTask"%>
<%@page import="com.eminentlabs.mom.WeekPerformersBean"%>
<%@page import="org.apache.log4j.Logger"%>
<%@page import="com.eminentlabs.mom.WeeklyPerformers" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<%
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Cache-Control", "no-store");
    response.setDateHeader("Expires", 0);
    response.setHeader("Pragma", "no-cache");

    Logger logger = Logger.getLogger("weekPerformer");
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
    <script type="text/javascript" src="<%= request.getContextPath()%>/javaScript/slide.js"></script>
    <script type="text/javascript" src="<%= request.getContextPath()%>/javaScript/jquery.js"></script>
    <script type="text/javascript" src="<%= request.getContextPath()%>/javaScript/checkSubmit.js"></script>
    <script language=javascript src="<%= request.getContextPath()%>/eminentech support files/datetimepicker.js"></script>


    <script type="text/javascript">
        function openCompetitors() {

            var total = document.getElementById('competitors').value;
            var result = total.split(",");
            for (var i = 0; i < result.length; i++) {
                if (result[i] !== "") {
                    var hei = document.getElementById('crm' + result[i]).style.height;
                    if (hei !== '0px') {
                        collapse('crm' + result[i], 150);
                        collapse('crm' + result[i], 150);
                    } else {
                        collapse('crm' + result[i], 150);
                    }

                }
            }
            for (var i = 0; i < result.length; i++) {
                if (result[i] !== "") {

                    collapse('crm' + result[i], 150);

                }
            }

        }
        function teamHide(str) {
            var paramGen = 'teamUsers' + str;

            if (document.getElementById(paramGen) !== null) {
                var total = document.getElementById(paramGen).value;
                var result = total.split(",");
                for (var j = 0; j < result.length; j++) {
                    if (result[j] !== "") {
                        if (document.getElementById('crm' + result[j]) !== null) {
                            var hei = document.getElementById('crm' + result[j]).style.height;
                            if (hei !== '0px') {
                                collapse('crm' + result[j], 150);
                            }
                        }
                    }
                }
            }
            $("." + str).toggle();

        }
        function collapseallteams(keys) {
            var key = keys.split(",");

            for (var i = 0; i < keys.length; i++) {
                teamHide(key[i]);
            }
        }
        function trim(str)
        {
            while (str.charAt(str.length - 1) === " ")
                str = str.substring(0, str.length - 1);
            while (str.charAt(0) === " ")
                str = str.substring(1, str.length);
            return str;
        }
        function isDate(str)
        {
            var pattern = "0123456789-";
            var i = 0;
            do
            {
                var pos = 0;
                for (var j = 0; j < pattern.length; j++)
                    if (str.charAt(i) === pattern.charAt(j))
                    {
                        pos = 1;
                        break;
                    }
                i++;
            } while (pos === 1 && i < str.length)
            if (pos === 0)
                return false;
            return true;
        }
        function checkClosedCount(str, userid) {
            var closedcount = document.getElementsByName(str);

            var closednewCount = new Number();
            for (var i = 0; i < closedcount.length; i++) {
                if (closedcount[i].checked === true) {
                    closednewCount++;
                }
            }
            var uniq = userid + 'ClosedIssuePer';


            var closerper = document.getElementById(uniq);
            var total = document.getElementById(userid + 'TotalIssue');
            var totalCount = new Number(total.innerHTML);
            var closer = document.getElementById(userid + 'ClosedIssue');
            var per = (closednewCount / totalCount) * 100;



            closer.innerHTML = "";
            closer.innerHTML = closednewCount;
            closerper.innerHTML = "";
            closerper.innerHTML = Math.ceil(per);

        }
        function setDPDuration() {
            if (trim(document.theForm.fromdate.value) === '')
            {
                alert("Please Enter the From Date ");
                document.theForm.fromdate.focus();
                return false;
            }
            if (!isDate(trim(theForm.fromdate.value)))
            {
                alert('Please enter the valid From Date');
                document.theForm.fromdate.value = "";
                theForm.fromdate.focus();
                return false;
            }
            if (trim(document.theForm.todate.value) === '')
            {
                alert("Please Enter the To Date ");
                document.theForm.todate.focus();
                return false;
            }
            if (!isDate(trim(theForm.todate.value)))
            {
                alert('Please enter the valid To Date');
                document.theForm.todate.value = "";
                theForm.todate.focus();
                return false;
            }
            var str = document.theForm.fromdate.value;

            var first = str.indexOf("-");
            var last = str.lastIndexOf("-");
            var year = str.substring(last + 1, last + 5);
            var month = str.substring(first + 1, last);
            var date = str.substring(0, first);
            var form_date = new Date(year, month - 1, date);

            var str1 = document.theForm.todate.value;

            var first = str1.indexOf("-");
            var last = str1.lastIndexOf("-");
            var year = str1.substring(last + 1, last + 5);
            var month = str1.substring(first + 1, last);
            var date = str1.substring(0, first);
            var form_date1 = new Date(year, month - 1, date);

            if (form_date1 < form_date) {
                alert('To Date cannot be less than From Date');
                document.theForm.todate.value = "";
                theForm.todate.focus();
                return false;
            }
            disableSubmit();

        }

    </script>

</head>
<body>
    <%@ include file="../header.jsp"%>
    <jsp:useBean id="week" class="com.eminentlabs.mom.WeeklyPerformers"/>
    <jsp:useBean id="mas" class="com.eminent.issue.formbean.MyAsignmentIssues" /> 
    <jsp:useBean id="mwd" class="com.eminent.branch.BranchController"></jsp:useBean>
    <jsp:useBean id="smmc" class="com.eminentlabs.mom.controller.SendMomMaintainController"></jsp:useBean>
    <%mwd.getAllBranchMap();%>
    <%
        int wrmSize = mas.wrmIssues().size();
        week.newSetAll(request);
   int assignedto = (Integer) session.getAttribute("userid_curr");
         smmc.getLocationNBranch(assignedto);%>
    <div id="weekPerformer">
        <table cellpadding="0" cellspacing="0" width="100%">
            <tr border="2" bgcolor="#C3D9FF">
                <td border="1" align="left" width="70%">
                    <font size="4" COLOR="#0000FF"><b>Performance</b></font>
                </td>
            </tr>
            <tr>
                <td style="height: 25px;">
                    <a href="addTask.jsp" style="cursor: pointer;">Add Issue / Task</a> &nbsp;&nbsp;&nbsp;
                    <a href="viewTask.jsp" style="cursor: pointer;">View Issue / Task</a> &nbsp;&nbsp;&nbsp;
                    <%if (smmc.getSendMomMaintenance() != null && smmc.getSendMomMaintenance().getUserId() != null && smmc.getSendMomMaintenance().getUserId().intValue() == assignedto) {
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
                    <%                              if (week.getPerformerid() != 0) {%>
                    <a href="<%=request.getContextPath()%>/MOM/weekPerformers.jsp?performerid=<%=week.getPerformerid()%>" style="cursor: pointer;font-weight: bold;">My Plan/Actual </a> &nbsp;&nbsp;&nbsp;
                    <%}%>
                    <a href="<%=request.getContextPath()%>/MOM/weekPerformers.jsp" style="cursor: pointer; ">Team Performance</a> &nbsp;&nbsp;&nbsp;
                    <a href="<%=request.getContextPath()%>/MOM/bestPMNTeam.jsp" style="cursor: pointer;">Best PM/Team</a> &nbsp;&nbsp;&nbsp;
                    <a href="<%=request.getContextPath()%>/MOM/dueDateReport.jsp" style="cursor: pointer; ">DDR</a> &nbsp;&nbsp;&nbsp;
                    <a href="<%=request.getContextPath()%>/MOM/wrmIssues.jsp" style="cursor: pointer; ">WRM Issues (<%=wrmSize%>)</a> &nbsp;&nbsp;&nbsp;

                </td>
            </tr>
        </table>

        <form name="theForm" onsubmit='return setDPDuration(this);' action="weekPerformers.jsp" method="post">
            <table bgcolor="E8EEF7"  style="width: 100%;">
                <tr >
                    <td style="font-weight: bold;width: 24%;">Select Duration : </td>
                    <td style="width: 5%;"><B>From</B></td>
                    <td style="width: 15%;">
                        <input type="text" id="fromdate" name="fromdate" value="<%=week.getStartMM()%>" maxlength="10" size="10" readonly  /><a href="javascript:NewCal('fromdate','ddMMyyyy')"> <img src="<%=request.getContextPath()%>/images/newhelp.gif" border="0" width="16" height="16" alt="Pick a date"></a>
                    </td>
                    <td style="width: 2%;text-align: right;"><B>To</B></td>
                    <td style="width: 20%;">
                        <input type="text" id="todate" name="todate" value="<%=week.getEndMM()%>"  maxlength="10" size="10" readonly  /><a href="javascript:NewCal('todate','ddMMyyyy')"> <img src="<%=request.getContextPath()%>/images/newhelp.gif" border="0" width="16" height="16" alt="Pick a date"></a></td>
                    <td>  <select id="branch" name="branch" >
                            <option value="">All Location</option>
                            <%if (!mwd.getBranchMap().isEmpty()) {
                                for (Map.Entry<Integer, String> entry : mwd.getBranchMap().entrySet()) {%>
                            <option value="<%=entry.getKey()%>" <%if (week.getBranch() == entry.getKey()) {%> selected=""<%}%>><%=entry.getValue()%></option>
                            <%}
                            }%>                                                
                        </select>
                    </td>
                    <td><input type="hidden" name="performerid" id="performerid" value="<%=week.getPerformerid()%>"><input type="submit" name="submit" id="submit" value="Search"></td>
                </tr>
            </table>
        </form>

        <%if (week.getWinners() != "") {%>
        <p align="left" style="width: 50%;">Between <b><%=week.getStartMM()%> to <%=week.getEndMM()%> </b>  Winner is <font style="font-weight: bold;color: green;"><%=week.getWinners()%> </font>Team  </p>
            <%}
            %>
        <p> This list shows team wise performance evaluation for the period <b><%=week.getStartMM()%></b> to <b><%=week.getEndMM()%></b> </p> 

        <form name="weeklyperformance" id="weekPerformance" method="post" action="saveResults.jsp" onsubmit="leaveCancelSubmit();">
            <div align="left">
                <table style="width: 73%;">
                    <tr bgcolor="#C3D9FF" style="height: 21px;font-weight: bold;" >
                        <td style="width: 25%;text-align: center;">Team Name</td>
                        <td style="width: 12%;text-align: center;" title="MyAssignments">Issues Count</td>
                        <td style="width: 12%;text-align: center;">Plan Count</td>
                        <td style="width: 12%;text-align: center;">Closed Count</td>
                        <td style="width: 12%;text-align: center;"> % Closed</td>
                    </tr>
                </table>
                <% int teamSize = 1;
                    for (TeamAverage team : week.getTeamAverages()) {
                        teamSize++;
                %>
                <%if (week.getPerformerid() != 0) {%>
                <table style="width: 73%;" class="<%=team.getTeam()%>" >
                    <tr  style="height: 18px;font-weight: bold;background-color: #C3D9FF;" >
                        <td colspan="4"><%=team.getTeam()%> </td>
                    </tr>
                </table>
                <%}%>
                <% int size = 1;
                    for (WeekPerformersBean userBean : team.getTeamWiseUsers()) {
                        size++;
                %>

                <%
                        if (size % 2 != 0) {%>
                <table class="<%=team.getTeam()%>" style="width: 73%;"><tr style="height: 23px;" bgcolor="#E8EEF7" >
                        <%} else {%>
                    <table class="<%=team.getTeam()%>" style="width: 73%;"><tr style="height: 23px;" bgcolor="white" >
                            <%}%>
                            <td style="width: 25%;text-align: left;" ><a href="javascript:void(0);" class="trigger" onclick="collapse('crm<%=userBean.getUserId()%>', 150);
                                        return true;"><%=userBean.getName()%></a></td>
                            <td style="width: 12%;text-align: center;" ><%=userBean.getMyAssignmentCount()%></td>
                            <td style="width: 12%;text-align: center;" id='<%=userBean.getUserId()%>TotalIssue'><%=userBean.getPlannedCount()%></td>
                            <td style="width: 12%;text-align: center;" id='<%=userBean.getUserId()%>ClosedIssue'><%=userBean.getClosedCount()%></td>
                            <td style="width: 12%;text-align: center;" id='<%=userBean.getUserId()%>ClosedIssuePer'><%=userBean.getAverage()%></td>                           
                        </tr>
                    </table>

                    <div id="crm<%=userBean.getUserId()%>" class="hide_me" >
                        <div class="scroll">
                            <table class="days" style="width: 100%;border-collapse:collapse;" >
                                <tr  bgcolor="#C3D9FF" style="height: 21px;font-weight: bold;" >
                                    <td style="width: 45%;">Planned</td>
                                    <td style="width: 45%;">Actual</td>
                                </tr>
                                <tr>
                                    <td>
                                        <ol>
                                            <%for (IssuesTask planned : userBean.getPlannedList()) {%>
                                            <li>
                                                <a target=\"_blank\" title='<%=planned.getProjectName()%>' style='background-color: <%=planned.getColor()%>;' href="<%=request.getContextPath()%>/viewIssueDetails.jsp?issueid=<%=planned.getIssueno()%>">
                                                    <%=planned.getIssueno()%></a> # <%=planned.getStatus()%> : <%=planned.getSubject()%>
                                            </li>
                                            <%}%>
                                        </ol>
                                    </td>
                                    <td>  
                                        <ol>
                                            <%for (IssuesTask actual : userBean.getActualList()) {
                                                    String idgen = "issueid" + userBean.getUserId();
                                            %>                                       
                                            <li>
                                                <%
                                                    if (actual.getCheckBox().equalsIgnoreCase("yes")) {
                                                        if (actual.getCheckParam().equalsIgnoreCase("true")) {

                                                %>
                                                <input type="checkbox" name="<%=idgen%>" checked="true" value="<%=actual.getIssueno()%>" onclick="checkClosedCount('<%=idgen%>', '<%=userBean.getUserId()%>');"/>
                                                <a target=\"_blank\" title='<%=actual.getProjectName()%>' style='background-color: <%=actual.getColor()%>;' href="<%=request.getContextPath()%>/viewIssueDetails.jsp?issueid=<%=actual.getIssueno()%>">
                                                    <%=actual.getIssueno()%></a> # <%=actual.getStatus()%> : <%=actual.getSubject()%>
                                                    <%} else {%>
                                                <input type="checkbox" name="<%=idgen%>"  value="<%=actual.getIssueno()%>" onclick="checkClosedCount('<%=idgen%>', '<%=userBean.getUserId()%>');"/>
                                                <a target=\"_blank\" title='<%=actual.getProjectName()%>' style='background-color: <%=actual.getColor()%>;' href="<%=request.getContextPath()%>/viewIssueDetails.jsp?issueid=<%=actual.getIssueno()%>">
                                                    <%=actual.getIssueno()%></a> # <%=actual.getStatus()%> : <%=actual.getSubject()%>

                                                <%}%>
                                                <% } else {%>
                                                <a target=\"_blank\" title='<%=actual.getProjectName()%>' style='background-color: <%=actual.getColor()%>;' href="<%=request.getContextPath()%>/viewIssueDetails.jsp?issueid=<%=actual.getIssueno()%>">
                                                    <%=actual.getIssueno()%></a> # <%=actual.getStatus()%> : <%=actual.getSubject()%>
                                                    <%}%>
                                            </li>
                                            <%}%>
                                        </ol>
                                    </td>         
                                </tr> 
                            </table>
                        </div>
                    </div>
                    <%}%>

                    <%if (week.getPerformerid() == 0) {%>
                    <%if (teamSize % 2 != 0) {%>
                    <table style="width: 73%;"><tr  style="height: 18px;"bgcolor="#E8EEF7" >
                            <%} else {%>
                        <table style="width: 73%;"><tr  style="height: 18px;"bgcolor="white" >
                                <%}%>

                                <td style="width: 25%;font-weight: bold;color:blue;" >
                                    <input type="hidden" name="teamUsers<%=team.getTeam()%>" id="teamUsers<%=team.getTeam()%>" value="<%=team.getTeamUserIds()%>">
                                    <%-- radio button enabled for mom-mods users only  by muthuraja  --%>
                                    <%if (smmc.getSendMomMaintenance() != null && smmc.getSendMomMaintenance().getUserId() != null && smmc.getSendMomMaintenance().getUserId().intValue() == assignedto) {
                    %>
                                    <% if (team.getTeam().equalsIgnoreCase(week.getWinners())) {%>
                                    <input type="radio" id="teamName" name="teamName" value="<%=team.getTeam()%>" checked="true" >
                                    <%} else {%>
                                    <input type="radio" id="teamName" name="teamName" value="<%=team.getTeam()%>">
                                    <%}
                                    %>
                                    <%}
                                    %>

                                    <span onclick="teamHide('<%=team.getTeam()%>')" style="cursor: pointer;"><%=team.getTeam()%> Team Average</span>
                                </td>

                                <td style="width: 12%;text-align: center;font-weight: bold;" ><%=team.getTeamIssueCount()%></td>
                                <td style="width: 12%;text-align: center;font-weight: bold;" id='<%=team.getTeamUserIds()%>planAvg'><%=team.getTeamPlanAvg()%></td>
                                <td style="width: 12%;text-align: center;font-weight: bold;" id='<%=team.getTeamUserIds()%>closeAvg'><%=team.getTeamCloseAvg()%></td>
                                <td style="width: 12%;text-align: center;font-weight: bold;" id='<%=team.getTeamUserIds()%>perAvg'>
                                    <%if (!team.getTeamPerAvg().equalsIgnoreCase("0")) {%>
                                    <%=team.getTeamPerAvg()%>
                                    <%} else {%>
                                    N/A
                                    <%}%>
                                </td>
                            </tr>
                        </table>
                        <%}%>
                        </div>       

                        <%}%> 
                        <%if (week.getPerformerid() == 0) {%>
                        <input type="hidden" name="fromDate" id="fromDate" value="<%=week.getStartMM()%>">
                        <input type="hidden" name="toDate" id="toDate" value="<%=week.getEndMM()%>">
                        <input type="hidden" name="competitors" id="competitors" value="<%=week.getCompetitors()%>">
                        <br/>
                        <%-- submit button enabled for mom-mods users only  by muthuraja  --%>
                        <%if (smmc.getSendMomMaintenance() != null && smmc.getSendMomMaintenance().getUserId() != null && smmc.getSendMomMaintenance().getUserId().intValue() == assignedto) {
                    %>
                        <div style="text-align: center;width: 75%; ">
                            <input type="hidden" name="branch" value="<%=week.getBranch()%>">
                            <input type="submit" name="submit1" id="submit1" value="Submit" onclick='return checkWinnerTeam(this);'">
                        </div>
                        <%}
                                }%> 
                        </form>
                        </body>


                        <script type="text/javascript">
                            function checkWinnerTeam() {
                                var r = document.getElementsByName("teamName");
                                var c = -1;

                                for (var i = 0; i < r.length; i++) {
                                    if (r[i].checked) {
                                        c = i;
                                    }
                                }
                                if (c == -1) {
                                    alert("Please select the winner team.");
                                    return false;
                                }
                            }

                        </script>

                        <style type="text/css">
                            .days table
                            {
                                border-collapse:collapse;
                            }
                            .days table, .days td, .days th 
                            {
                                border:1px solid lightblue;
                            }
                            .scroll {
                                min-height: 20px;
                                max-height: 600px;
                                overflow: auto;
                            }

                        </style>

                        <script type="text/javascript">
                            <%if (week.getPerformerid() == 0) {
                                    Collection tset = week.getTeamWise().keySet();
                                    Iterator tite = tset.iterator();
                                    while (tite.hasNext()) {
                                        String key = (String) tite.next();
                            %>
                                teamHide('<%=key%>');
                            <% }
                                }
                            %>
                        </script>

                        </html>
