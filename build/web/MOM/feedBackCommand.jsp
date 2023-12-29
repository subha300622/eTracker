<%-- 
    Document   : feedBackCommand
    Created on : Apr 1, 2014, 11:07:56 AM
    Author     : E0288
--%>

<%@page import="com.eminentlabs.mom.MoMUtil"%>
<%@page import="com.eminent.issue.controller.Escalation"%>
<%@page import="com.eminentlabs.mom.MomMaintanance"%>
<%@page import="com.eminentlabs.mom.formbean.FeedBackForm"%>
<%@page import="com.eminentlabs.mom.MomFeedback"%>
<%@page import="java.util.Map"%>
<%@page import="org.apache.log4j.Logger"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Cache-Control", "no-store");
    response.setDateHeader("Expires", 0);
    response.setHeader("Pragma", "no-cache");

    Logger logger = Logger.getLogger("feedBackCommand");
    String logoutcheck = (String) session.getAttribute("Name");
    if (logoutcheck == null) {
        logger.fatal("==============Session Expired===============");
%>
<jsp:forward page="../SessionExpired.jsp"></jsp:forward>
<%
    }

%>
<!DOCTYPE html>
<html>
    <meta name="keywords" content="GST in SAP, SAP GST Accelerator, GST Success in SAP, GST India in SAP, GST SAP Success, GST Suvidha Provider, GST ASP GSP, GST, CGST,SGST, IGST, UGST,  SAP NW based Product Development, SAP Consulting, SAP Implementation, SAP Support Services, SAP Outsourcing, SAP Implementation India, SAP Implementation Bangalore, SAP Implementation Chennai, SAP Implementation Belgium, SAP Implementation Paris, SAP Implemtation Australia, SAP Implementation France, SAP Implementation Mumbai, SAP Implementation Kerala, SAP Implementation Belgaum, SAP Implementation Thailand, SAP Implementation Mexico, SAP Implementation America">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>eTracker&#153; - Eminentlabs&#153; CRM, APM, TQM,  ERM and  EPTS Solution</title>
    <link title=STYLE href="<%=request.getContextPath()%>/eminentech support files/main_ie.css?version=03082015" type="text/css" rel="STYLESHEET"/>
    <script type="text/javascript" src="<%= request.getContextPath()%>/javaScript/checkSubmit.js"></script>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/theme.blue1.css?test=150720161404">
    <script src="<%= request.getContextPath()%>/javaScript/jquery.js" type="text/javascript" />
    <script src="<%= request.getContextPath()%>/javaScript/jquery-1.10.2.js"></script>
    <script src="<%=request.getContextPath()%>/javaScript/jquery.js" type="text/javascript"></script>
    <script src="<%=request.getContextPath()%>/javaScript/jquery.tablesorter.min.js" type="text/javascript"></script>
    <script src="<%=request.getContextPath()%>/javaScript/jquery-ui.min.js"></script>
    <script src="<%=request.getContextPath()%>/javaScript/jquery.tablesorter1.js" type="text/javascript"></script>
    <script type="text/javascript">
        function  fun() {
            var startH = document.getElementById("startH").value;
            var startM = document.getElementById("startM").value;
            var startS = document.getElementById("startS").value;
            var endH = document.getElementById("endH").value;
            var endM = document.getElementById("endM").value;
            var endS = document.getElementById("endS").value;
            var feedBackComment = document.getElementById("feedBackComment").value;
            if (startH > endH) {
                alert('start time must be less than end time');
                document.theForm.endH.focus();
                return false;
            } else {
                if (startH === endH) {
                    if (startM > endM) {
                        alert('start time must be less than end time');
                        document.theForm.endM.focus();
                        return false;
                    } else {
                        if (startM === endM) {
                            if (startS >= endS) {
                                alert('start time must be less than end time');
                                document.theForm.endS.focus();
                                return false;
                            }
                        }
                    }
                }
            }

            if (feedBackComment === "") {
                alert('Please enter feedback');
                document.theForm.feedBackComment.focus();
                return false;
            }
            monitorSubmit();
        }
        function callProjectMom() {
            var momTeamType = document.getElementById('momTeamType').value;
            var branch = document.getElementById('branch').value;
            window.location = "feedBackCommand.jsp?momTeamType=" + momTeamType + "&branch=" + branch;
        }

        $("#searchTable").tablesorter({
            widgets: ['zebra'],
            widgetOptions: {
                zebra: ["zebraline", "zebralinealter"]
            },
            // change the multi sort key from the default shift to alt button 
            sortMultiSortKey: 'altKey',
            headers: {
            }
        });
    </script>
    <style>
        th{
            color: black;
        }
    </style>
</head>

<body>
    <%@ include file="../header.jsp"%>
    <jsp:useBean id="fbc" class="com.eminentlabs.mom.FeedBackCommand"/>
    <jsp:useBean id="mas" class="com.eminent.issue.formbean.MyAsignmentIssues" /> 
    <jsp:useBean id="mwd" class="com.eminent.branch.BranchController"></jsp:useBean>
     <jsp:useBean id="smmc" class="com.eminentlabs.mom.controller.SendMomMaintainController"></jsp:useBean>
    <%mwd.getAllBranchMap();%>
    <%  int wrmSize = mas.wrmIssues().size();
        fbc.setAll(request);
        List<String> plannedissuenos = MoMUtil.todayPlannedIssues(fbc.getDateFor());
    int assignedto = (Integer) session.getAttribute("userid_curr");
         smmc.getLocationNBranch(assignedto);%>
    <table cellpadding="0" cellspacing="0" width="100%">
        <tr border="2" bgcolor="#C3D9FF" style="height: 21px;">
            <td border="1" align="left" width="70%">
                <font size="4" COLOR="#0000FF"><b>Feedback about Minutes of Meeting on <%=fbc.getDateFor()%></b></font>
                <select id="branch" name="branch" onchange="callProjectMom(this);" style="    padding: 8px;    border-radius: 6px;    border: 1px solid #CCC;">
                    <option value="">All Location</option>
                    <%if (!mwd.getBranchMap().isEmpty()) {
                            for (Map.Entry<Integer, String> entry : mwd.getBranchMap().entrySet()) {%>
                    <option value="<%=entry.getKey()%>" <%if (fbc.getBranch() == entry.getKey()) {%> selected=""<%}%>><%=entry.getValue()%></option>
                    <%}
                        }%>                                                
                </select>
                <select name="momTeamType" id="momTeamType" class="momTeamType" onchange="callProjectMom(this);">
                    <%for (Map.Entry<Integer, String> entry : fbc.getMomTypeList().entrySet()) {
                            if (fbc.getMomTeamType() == entry.getKey()) {
                    %>
                    <option value="<%=entry.getKey()%>" selected=""><%=entry.getValue()%></option>
                    <%} else {%>
                    <option value="<%=entry.getKey()%>"><%=entry.getValue()%></option>
                    <%}
                        }%>
                </select>
            </td>
        </tr>
    </table>
    <table cellpadding="0" cellspacing="0" width="100%">

        <tr>
            <td style="height: 25px;">
                <a href="addTask.jsp"> Add Issue / Task</a>&nbsp;&nbsp;&nbsp;&nbsp;
                <a href="viewTask.jsp" style="cursor: pointer;">View Issue / Task</a> &nbsp;&nbsp;&nbsp;
                <%if (smmc.getSendMomMaintenance() != null && smmc.getSendMomMaintenance().getUserId() != null && smmc.getSendMomMaintenance().getUserId().intValue() == assignedto) {
                %>
                <a href="<%=request.getContextPath()%>/MOM/mom.jsp" style="cursor: pointer;">Send MOM</a> &nbsp;&nbsp;&nbsp;
                <a href="<%=request.getContextPath()%>/MOM/plannedIssuesReport.jsp" style="cursor: pointer;">Planned Issue Report</a> &nbsp;&nbsp;&nbsp;
                <a href="<%=request.getContextPath()%>/MOM/feedBackCommand.jsp" style="cursor: pointer; font-weight: bold;">FeedBack</a> &nbsp;&nbsp;&nbsp;
                <a title="Fine Management" href="<%=request.getContextPath()%>/MOM/addFineAmtForUser.jsp" style="cursor: pointer;">Fine Mgmt</a> &nbsp;&nbsp;
                <a href="<%=request.getContextPath()%>/MOM/projectWiseClosedReport.jsp" style="cursor: pointer;">PM'S Rank</a> &nbsp;&nbsp;&nbsp;
                <%                 } else {
                %>
                <a href="<%=request.getContextPath()%>/MOM/fineAmtReort.jsp" style="cursor: pointer;">Fine Amount </a> &nbsp;&nbsp;&nbsp;
                <a href="<%=request.getContextPath()%>/MOM/fineReport.jsp" style="cursor: pointer;">Fine Report</a> &nbsp;&nbsp;&nbsp;
                <%}%>
                <a href="<%=request.getContextPath()%>/MOM/weekPerformers.jsp" style="cursor: pointer;">Team Performance</a> &nbsp;&nbsp;&nbsp;
                <a href="<%=request.getContextPath()%>/MOM/bestPMNTeam.jsp" style="cursor: pointer;">Best PM/Team</a> &nbsp;&nbsp;&nbsp;
                <a href="<%=request.getContextPath()%>/MOM/dueDateReport.jsp" style="cursor: pointer; ">DDR</a> &nbsp;&nbsp;&nbsp;
                <a href="<%=request.getContextPath()%>/MOM/wrmIssues.jsp" style="cursor: pointer; ">WRM Issues (<%=wrmSize%>)</a> &nbsp;&nbsp;&nbsp;
                <a href="<%=request.getContextPath()%>/Reimbursement/reimbursementUpload.jsp" style="cursor: pointer; ">Reimbursement</a> &nbsp;&nbsp;&nbsp;
            </td>
        </tr>
    </table>
    <br/>
    <%if (fbc.getMomFeedback() != null) {%>
    <form name="theForm" id="theForm" method="post" action="<%=request.getContextPath()%>/MOM/feedBackCommand.jsp" onsubmit="return fun();">

        <table style="background-color: #E8EEF7;width:100%;">
            <tr style="text-align: left;">
                <td style="font-weight: bold;width:16%;">Chair Person :</td>
                <td style="width:24%;"><select name="chairPerson" id="chairPerson">
                        <%
                            for (MomMaintanance mmtc : fbc.getMomUsers()) {
                                if (fbc.getMember().get(mmtc.getUserid()) != null) {
                                    if (mmtc.getUserid() == fbc.getChairPerson()) {%>
                        <option value="<%=mmtc.getUserid()%>" selected><%=fbc.getMember().get(mmtc.getUserid())%></option>
                        <%} else {
                        %>
                        <option value="<%=mmtc.getUserid()%>"><%=fbc.getMember().get(mmtc.getUserid())%></option>
                        <%}
                                }
                            }%>

                    </select></td>
                <td>  <div>  <div class="windowlabel"><label  style="font-weight: bold;float: left">Start Time:</label></div>
                        <div class="windowtime"><select name="startH" id="startH" >
                                <%int k = 0, p = 24;
                                    if (fbc.getCurrent_time() > 14) {
                                        k = 15;
                                    } else {
                                        p = 15;
                                    }

                                    for (int i = k; i < p; i++) {
                                        String val = String.valueOf(i);
                                        if (i < 10) {
                                            val = "0" + val;
                                        }
                                        if (fbc.getStartTimeH().equals(val)) {%>
                                <option value="<%=val%>" selected><%=val%></option>
                                <% } else {
                                %>
                                <option value="<%=val%>"><%=val%></option>
                                <%}
                                    }%>
                            </select><select name="startM" id="startM" >
                                <%for (int i = 0; i < 60; i++) {
                                        String val = String.valueOf(i);
                                        if (i < 10) {
                                            val = "0" + val;
                                        }
                                        if (fbc.getStartTimeM().equals(val)) {%>
                                <option value="<%=val%>" selected><%=val%></option>
                                <% } else {
                                %>
                                <option value="<%=val%>"><%=val%></option>
                                <%}
                                    }%>
                            </select><select name="startS" id="startS" >
                                <%for (int i = 0; i < 60; i++) {
                                        String val = String.valueOf(i);
                                        if (i < 10) {
                                            val = "0" + val;
                                        }
                                        if (fbc.getStartTimeS().equals(val)) {%>
                                <option value="<%=val%>" selected><%=val%></option>
                                <% } else {
                                %>
                                <option value="<%=val%>"><%=val%></option>
                                <%}
                                    }%>
                            </select></div> </div></td>
                <td>  <div>  <div  class="windowlabel" style="font-weight: bold;float: left">End Time: </div>
                        <div class="windowtime"><select name="endH" id="endH">
                                <% int l = 0, j = 24;
                                    if (fbc.getCurrent_time() > 14) {
                                        l = 15;
                                    } else {
                                        j = 15;
                                    }

                                    for (int i = l; i < j; i++) {
                                        String val = String.valueOf(i);
                                        if (i < 10) {
                                            val = "0" + val;
                                        }
                                        if (fbc.getEndTimeH().equals(val)) {%>
                                <option value="<%=val%>" selected><%=val%></option>
                                <% } else {
                                %>
                                <option value="<%=val%>"><%=val%></option>
                                <%}
                                    }%>
                            </select><select name="endM" id="endM" >
                                <%for (int i = 0; i < 60; i++) {
                                        String val = String.valueOf(i);
                                        if (i < 10) {
                                            val = "0" + val;
                                        }
                                        if (fbc.getEndTimeM().equals(val)) {%>
                                <option value="<%=val%>" selected><%=val%></option>
                                <% } else {
                                %>
                                <option value="<%=val%>"><%=val%></option>
                                <%}
                                    }%>
                            </select><select name="endS" id="endS" >
                                <%for (int i = 0; i < 60; i++) {
                                        String val = String.valueOf(i);
                                        if (i < 10) {
                                            val = "0" + val;
                                        }
                                        if (fbc.getEndTimeS().equals(val)) {%>
                                <option value="<%=val%>" selected><%=val%></option>
                                <% } else {
                                %>
                                <option value="<%=val%>"><%=val%></option>
                                <%}
                                    }%>
                            </select></div></div></td>
            </tr>
            <tr>

                <td colspan="4">
                    <div class="tablecontent"><b style="color: blue">Escalated issues : <%=fbc.getEscalatdIssues().size()%></b>
                        <table width="100%" id="searchTable" class="tablesorter">
                            <thead>
                                <tr style="background-color: #C3D9FE;height: 21px;font-weight: bold;color: #000000">
                                    <th>Issue#</th>
                                    <th>Subject</th>
                                    <th class="filter-select filter-match" data-placeholder="Select a Assigned To">Assigned To</th>
                                    <th class="filter-select filter-match" data-placeholder="Select a PM">Project Manager</th>
                                    <th class="filter-select filter-match" data-placeholder="Select a DM">Delivery Manager</th>
                                    <th data-placeholder="Try >=, <=,=,!= ">Age</th>
                                    <th data-placeholder="Try >=, <=,=,!= ">#Days Escalated</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%int i = 0;
                                    for (Escalation e : fbc.getEscalatdIssues()) {
                                        if ((i % 2) != 0) {
                                %>
                                <tr bgcolor="#E8EEF7" height="21">
                                    <%} else {%>
                                <tr bgcolor="white" height="21">
                                    <%}
                                        i++;%>
                                    <td><A HREF="${pageContext.servletContext.contextPath}/viewIssueDetails.jsp?issueid=<%=e.getIssueId()%>" target="_blank"> <%=e.getIssueId()%></a></td>
                                    <td style="color: red"><%=e.getSubject()%>

                                        <%   if (plannedissuenos.contains(e.getIssueId())) {%>
                                        <img src="<%=request.getContextPath()%>/images/tick.png" alt="planned" title="Customer Priority + Delivery Planned"  style="cursor: pointer;"/>
                                        <%}%>
                                    </td>
                                    <td style="color: red"><%=e.getAssginedTo()%></td>
                                    <td><%=e.getPmanager()%></td>
                                    <td><%=e.getDmanager()%></td>
                                    <td style="text-align: right;"><%=e.getDays()%></td>
                                    <td style="text-align: right;"><%=e.getEscDays()%></td>
                                </tr>
                                <%}%>
                            </tbody>
                        </table>

                    </div>
                </td>
            </tr>
            <tr style="font-weight: bold;">
                <td style="width:13%;">FeedBack :</td>
                <td colspan="3"><textarea name="feedBackComment" id="feedBackComment" cols="90" rows="4" readonly=""><%if ("".equals(fbc.getFeedBack())) {
                        if (fbc.getMomTime().equalsIgnoreCase("Morning")) {%><%=fbc.getProjectSplit()%><%=fbc.getEscalationCount()%><%} else {%><%=fbc.consultantWiseUnTouched(fbc.getKeys())%><%=fbc.getEscalationCount()%><%}
                        } else {%><%=fbc.getFeedBack()%><%}%></textarea></td>
            </tr>
            <tr style="font-weight: bold;">
                <td style="width:13%;">Discussion :</td>
                <td colspan="3"><textarea name="discussionComment" id="discussionComment" cols="90" rows="4"><%=fbc.getDiscussion()%></textarea></td>
            </tr>
            <tr style="text-align: center;">
                <td colspan="4">
                    <input type="hidden" name="momTeamType"  value="<%=fbc.getMomTeamType()%>"/>
                    <input type="hidden" name="branch"  value="<%=fbc.getBranch()%>"/>
                    <input type="submit" name="submit" id="submit" value="Submit"/>
                    <input type="reset" name="reset" id="reset" value="Reset"/>
                </td></tr>
        </table>
    </form>
    <%} else {%>
    <div>So far <%=fbc.getMomTime()%> MoM is not submitted on today for <%=fbc.getMomTypeList().get(fbc.getMomTeamType())%> together/separately</div>
    <%}%>
    <br/>

    <div>The below list shows mom feedback given to the <%if (fbc.getMomTypeList().get(fbc.getMomTeamType()) != null) {%>
        <%=fbc.getMomTypeList().get(fbc.getMomTeamType())%>
        <%}%> Team</div>
    <table style="width: 100%;">
        <tr style="background-color: #C3D9FE;height: 21px;font-weight: bold;">
            <td style="width:6%;">Date</td>
            <td style="width:47%;">Morning Feedback</td>
            <td style="width:47%;">Evening Feedback</td>
        </tr>
        <%int i = 0;
            for (FeedBackForm momFeedBack : fbc.getMomFeedbacks()) {
                if ((i % 2) != 0) {
        %>
        <tr bgcolor="#E8EEF7" height="21">
            <%} else {%>
        <tr bgcolor="white" height="21">
            <%}
                i++;%>
            <td><%=momFeedBack.getMomdate()%></td>
            <td>
                <%if (momFeedBack.getMorningFeedBack() != null) {%>
                <%=momFeedBack.getMorningFeedBack()%>
                <%} else {%>
                NA
                <%}%>
            </td>
            <td>
                <%if (momFeedBack.getEveningFeedBack() != null) {%>
                <%=momFeedBack.getEveningFeedBack()%>
                <%} else {%>
                NA
                <%}%>
            </td>
        </tr>
        <%}%>

    </table>
    <%
        if (fbc.getRequestpag() == null && (fbc.getRowcount() / 16 == 0)) {
        } else if (fbc.getRequestpag() == null) {
    %>
    <table align=right>
        <tr>
            <td>First</td>
            <td>Prev</td>
            <td><a href=feedBackCommand.jsp?momTeamType=<%=fbc.getMomTeamType()%>&branch=<%=fbc.getBranch()%>&manipulation=3>Next</a></td>
            <td><a href=feedBackCommand.jsp?momTeamType=<%=fbc.getMomTeamType()%>&branch=<%=fbc.getBranch()%>&manipulation=4>Last</a></td>
        </tr>
    </table>
    <%        } else if (fbc.getRequestpag().equals("1")) {
    %>
    <table align=right>
        <tr>
            <td>First</td>
            <td>Prev</td>
            <td><a href=feedBackCommand.jsp?momTeamType=<%=fbc.getMomTeamType()%>&branch=<%=fbc.getBranch()%>&manipulation=3>Next</a></td>
            <td><a href=feedBackCommand.jsp?momTeamType=<%=fbc.getMomTeamType()%>&branch=<%=fbc.getBranch()%>&manipulation=4>Last</a></td>
        </tr>
    </table>
    <%        } else if (fbc.getRequestpag().equals("4")) {
    %>
    <table align=right>
        <tr>
            <td><a href=feedBackCommand.jsp?momTeamType=<%=fbc.getMomTeamType()%>&branch=<%=fbc.getBranch()%>&manipulation=1>First</a></td>
            <td><a href=feedBackCommand.jsp?momTeamType=<%=fbc.getMomTeamType()%>&branch=<%=fbc.getBranch()%>&manipulation=2>Prev</a></td>
            <td>Next</td>
            <td>Last</td>
        </tr>
    </table>
    <%        } else if (fbc.getRequestpag().equals("3") && fbc.getIssuenoto() == fbc.getRowcount()) {
    %>
    <table align=right>
        <tr>
            <td><a href=feedBackCommand.jsp?momTeamType=<%=fbc.getMomTeamType()%>&branch=<%=fbc.getBranch()%>&manipulation=1>First</a></td>
            <td><a href=feedBackCommand.jsp?momTeamType=<%=fbc.getMomTeamType()%>&branch=<%=fbc.getBranch()%>&manipulation=2>Prev</a></td>
            <td>Next</td>
            <td>Last</td>
        </tr>
    </table>
    <%        } else if (fbc.getRequestpag().equals("3")) {
    %>
    <table align=right>
        <tr>
            <td><a href=feedBackCommand.jsp?momTeamType=<%=fbc.getMomTeamType()%>&branch=<%=fbc.getBranch()%>&manipulation=1>First</a></td>
            <td><a href=feedBackCommand.jsp?momTeamType=<%=fbc.getMomTeamType()%>&branch=<%=fbc.getBranch()%>&manipulation=2>Prev</a></td>
            <td><a href=feedBackCommand.jsp?momTeamType=<%=fbc.getMomTeamType()%>&branch=<%=fbc.getBranch()%>&manipulation=3>Next</a></td>
            <td><a href=feedBackCommand.jsp?momTeamType=<%=fbc.getMomTeamType()%>&branch=<%=fbc.getBranch()%>&manipulation=4>Last</a></td>
        </tr>
    </table>
    <%        } else if (fbc.getRequestpag().equals("2") && fbc.getIssuenofrom() == 1) {
    %>
    <table align=right>
        <tr>
            <td>First</td>
            <td>Prev</td>
            <td><a href=feedBackCommand.jsp?momTeamType=<%=fbc.getMomTeamType()%>&branch=<%=fbc.getBranch()%>&manipulation=3>Next</a></td>
            <td><a href=feedBackCommand.jsp?momTeamType=<%=fbc.getMomTeamType()%>&branch=<%=fbc.getBranch()%>&manipulation=4>Last</a></td>
        </tr>
    </table>
    <%        } else if (fbc.getRequestpag().equals("2")) {
    %>
    <table align=right>
        <tr>
            <td><a href=feedBackCommand.jsp?momTeamType=<%=fbc.getMomTeamType()%>&branch=<%=fbc.getBranch()%>&manipulation=1>First</a></td>
            <td><a href=feedBackCommand.jsp?momTeamType=<%=fbc.getMomTeamType()%>&branch=<%=fbc.getBranch()%>&manipulation=2>Prev</a></td>
            <td><a href=feedBackCommand.jsp?momTeamType=<%=fbc.getMomTeamType()%>&branch=<%=fbc.getBranch()%>&manipulation=3>Next</a></td>
            <td><a href=feedBackCommand.jsp?momTeamType=<%=fbc.getMomTeamType()%>&branch=<%=fbc.getBranch()%>&manipulation=4>Last</a></td>
        </tr>
    </table>
    <%            }%>
    <script type="text/javascript" src="<%= request.getContextPath()%>/javaScript/jquery-1.10.2.js"></script>
    <SCRIPT type="text/javascript" 	src="https://ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>
    <link rel="stylesheet" href="<%= request.getContextPath()%>//css/jquery-ui.css"/>
    <script src="<%= request.getContextPath()%>/javaScript/jquery-ui.js"></script>
    <script src="<%=request.getContextPath()%>/javaScript/jquery.tablesorter1.js" type="text/javascript"></script>
    <script src="<%=request.getContextPath()%>/javaScript/jquery.tablesorter.widgets.js" type="text/javascript"></script>    
    <script src="<%=request.getContextPath()%>/javaScript/jquery.tablesorter.pager.js" type="text/javascript"></script>
    <script src="<%=request.getContextPath()%>/javaScript/pager-custom-controls.js" type="text/javascript"></script>
    <script type="text/javascript">
      
            $("#searchTable").tablesorter({
                theme: 'blue',
// hidden filter input/selects will resize the columns, so try to minimize the change
                widthFixed: true,
// initialize zebra striping and filter widgets
                widgets: ["zebra", "filter"],
                widgetOptions: {
                    // extra css class applied to the table row containing the filters & the inputs within that row
                    filter_cssFilter: 'tablesorter-filter',
                    // If there are child rows in the table (rows with class name from "cssChildRow" option)
                    // and this option is true and a match is found anywhere in the child row, then it will make that row
                    // visible; default is false
                    filter_childRows: false,
                    // if true, filters are collapsed initially, but can be revealed by hovering over the grey bar immediately
                    // below the header row. Additionally, tabbing through the document will open the filter row when an input gets focus
                    filter_hideFilters: false,
                    // Set this option to false to make the searches case sensitive
                    filter_ignoreCase: true,
                    // jQuery selector string of an element used to reset the filters
                    filter_reset: '.reset',
                    // Use the $.tablesorter.storage utility to save the most recent filters
                    filter_saveFilters: false,
                    // Delay in milliseconds before the filter widget starts searching; This option prevents searching for
                    // every character while typing and should make searching large tables faster.
                    filter_searchDelay: 300,
                    // Set this option to true to use the filter to find text from the start of the column
                    // So typing in "a" will find "albert" but not "frank", both have a's; default is false
                    filter_startsWith: false,
                    // if false, filters are collapsed initially, but can be revealed by hovering over the grey bar immediately
                    // below the header row. Additionally, tabbing through the document will open the filter row when an input gets focus
                    // Add select box to 4th column (zero-based index)
                    // each option has an associated function that returns a boolean
                    // function variables:
                    // e = exact text from cell
                    // n = normalized value returned by the column parser
                    // f = search filter input value
                    // i = column index
                    filter_functions: {
                    },
                    filter_formatter: {
                    }
                }
            });
       
    </script>
    <style>
        .tablesorter-blue tbody tr.odd > td {
            background-color: #E8EEF7;
        }
        .tablesorter-blue tbody tr.even > td {
            background-color: white;
        }
    </style>
</body>
<%
    String feedback = fbc.getLastFeedBack();
    String discussion = fbc.getDiscussion();
    if (feedback == null || feedback.isEmpty()) {
    } else {
%>


<script>
    $(document).ready(function () {

        var momtime = "<%=fbc.getMomTime()%>";
        var momteam = "<%=fbc.getMomTeamType()%>";
        var momstartTime = "<%=fbc.getStartTimeH()%>:<%=fbc.getStartTimeM()%>:<%=fbc.getStartTimeS()%>";
                var momEndTime = "<%=fbc.getEndTimeH()%>:<%=fbc.getEndTimeM()%>:<%=fbc.getEndTimeS()%>";
                        var chairperson = $("#chairPerson option:selected").text();
                        var feedback = "<%=feedback%>";
                        var discussion = "<%=discussion%>";
                        $.ajax({
                            url: "<%= request.getContextPath()%>/MOM/sendMailMom.jsp",
                            data: {sendmom: 'sendFeedBack', feedback: feedback, momtime: momtime, momteam: momteam, momstartTime: momstartTime, momEndTime: momEndTime, chairperson: chairperson, discussion: discussion, random: Math.random(1, 10)},
                            async: true,
                            type: 'Post',
                            success: function (responseText, statusTxt, xhr) {
                                if (statusTxt === "success") {
                                } else {
                                }
                            }
                        });
                    });
</script>
<%}%>

<%
    String fback = "";
    String lfeedback = "";
    if ("".equals(fbc.getFeedBack())) {
        if (fbc.getMomTime().equalsIgnoreCase("Morning")) {
            fback = fbc.getProjectSplit();
        } else {
            fback = fbc.consultantWiseUnTouched(fbc.getKeys());
        }
    } else {
        fback = fbc.getFeedBack();
    }
    if (fback != null || !fback.equalsIgnoreCase("")) {
        String lines[] = fback.split("\\n");
        lfeedback = "";
        for (String line : lines) {
            if (!line.isEmpty() || !line.equalsIgnoreCase("")) {
                lfeedback = lfeedback + line.trim() + " <br/>";
            }
        }
    }
%>
<script>
    $(document).ready(function () {
        var feedback = "<%=lfeedback%>";

        $.ajax({
            url: "<%= request.getContextPath()%>/MOM/sendMailMom.jsp",
            data: {sendmom: 'sendMom', feedback: feedback, random: Math.random(1, 10)},
            async: true,
            type: 'Post',
            success: function (responseText, statusTxt, xhr) {
                if (statusTxt === "success") {
                } else {
                }
            }
        });
    });
</script>

</html>
