<%-- 
    Document   : momView
    Created on : 30 Apr, 2015, 1:45:18 PM
    Author     : EMINENT
--%>
<%@page import="com.eminent.util.GetProjectManager"%>
<%@page import=" com.eminent.holidays.Holidays"%>
<%@page import="com.eminent.leaveUtil.LeaveUtil"%>
<%@page import="com.eminent.holidays.HolidaysUtil"%>
<%@page import="com.eminentlabs.mom.MoMUtil"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.*"%>
<%@page import="com.eminentlabs.mom.formbean.FineAmountBean"%>
<%@page import="java.util.Map"%>
<%@page import="com.eminentlabs.mom.formbean.ViewMomFormBean"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Cache-Control", "no-store");
    response.setDateHeader("Expires", 0);
    response.setHeader("Pragma", "no-cache");

    Logger logger = Logger.getLogger("momDetails");
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
    <link title=STYLE href="<%=request.getContextPath()%>/eminentech support files/main_ie.css?test=14" type="text/css" rel="STYLESHEET"/>
    <script type="text/javascript" src="<%= request.getContextPath()%>/javaScript/checkSubmit.js?test=5"></script>
    <script type="text/javascript"	src="<%= request.getContextPath()%>/eminentech support files/datetimepicker.js"></script>
    <link rel="stylesheet" href="//code.jquery.com/ui/1.11.4/themes/redmond/jquery-ui.css">
    <script src="//code.jquery.com/jquery-1.10.2.js"></script>
    <script src="//code.jquery.com/ui/1.11.4/jquery-ui.js"></script>
    <script src="<%=request.getContextPath()%>/javaScript/XMLHttpRequest.js" type="text/javascript"></script>
    <script type="text/javascript" src="<%= request.getContextPath()%>/javaScript/fileAttach.js?test=261020151625"></script>
    <script src="<%=request.getContextPath()%>/javaScript/jquery.tablesorter1.js" type="text/javascript"></script>
    <script src="<%=request.getContextPath()%>/javaScript/jquery.tablesorter.widgets.js" type="text/javascript"></script>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/select2/3.4.6/select2.min.css" rel="stylesheet">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/select2/3.4.6/select2.min.js"></script>
    <script src="<%=request.getContextPath()%>/javaScript/widget-filter-formatter-select2.js" type="text/javascript"></script>
    <script type="text/javascript" src="<%= request.getContextPath()%>/javaScript/tooltip.js"></script>


    <script type="text/javascript">
        function callProjectMom() {
            var pid = document.getElementById('pid').value;
            var momdate = document.getElementById('momdate').value;
            var momTeamType = document.getElementById('momTeamType').value;
            var branch = document.getElementById('branch').value;
            document.theFormz.action = "momView.jsp?pid=" + pid + "&momDate=" + momdate + "&momTeamType=" + momTeamType + "&branch=" + branch;
            document.theFormz.submit();
        }

    </script>
    <style type="text/css">
        .momp table, .momp td, .momp th 
        {
            border:1px solid #76B6E3;
            -moz-box-shadow:0px 0px 2px 1px #FFF;
            box-shadow: 0px 0px 2px 1px #FFF;
        }
        .momp tr{
            background-color:  #1072a1;
            color: white;
        }
        .momc table, .momc td, .momc th 
        {
            border:1px solid #70C860;
            -moz-box-shadow:0px 0px 2px 1px #FFF;
            box-shadow: 0px 0px 2px 1px #FFF;
        }
        .momc tr{
            background-color:  #22980c;
            color: white;
        }
        .momn table, .momn td, .momn th 
        {
            border:1px solid #88E3E5;
            -moz-box-shadow:0px 0px 2px 1px #FFF;
            box-shadow: 0px 0px 2px 1px #FFF;
        }
        .momn tr{
            background-color:  #00a2a5;
            color: white;
        }
        .mom table
        {
            border-collapse:collapse;
        }
        .mom table, .mom td, .mom th 
        {
            border:1px solid #B5CAF9;
            -moz-box-shadow:0px 0px 2px 1px #FFF;
            box-shadow: 0px 0px 2px 1px #FFF;
        }
        ul {
            list-style: none;
            margin:4px ;
            padding: 0 ;
        }
        ul li{
            margin-bottom: 2px;
        }
        a{
            text-decoration: none;
        }
        /* edit by mukesh*/
        .leave{
            padding: 4px 7px 8px 11px;
            z-index: 9999;
            -webkit-box-shadow: 0 0 5px #2765F8;
            box-shadow: 0 0 5px #2765F8;
            margin: 10px;
            font-weight: 500;
            font-size: 14px;
            line-height: 50px;
            border: 1px solid #BFEBF3;
        }
        /* edit by mukesh*/
        /*            td table tr:hover{
                        webkit-transform: scale(1.1, 1.1);
                        -moz-transform: scale(1.1, 1.1);
                        -ms-transform: scale(1.1, 1.1);
                        -o-transform: scale(1.1, 1.1);
                        transform: scale(1.1, 1.1);
                        border:1px solid #ccc;
                        padding:10px;
                        position: relative;
                    }*/
    </style>
</head>
<body class="home-bg">
       <div class="Ajax-loder">
    
            <div class="bg"></div>
    
            <img class="loading" src="<%=request.getContextPath()%>/images/276 (1).GIF"
                 alt="loading...." /></div>
    <%@ include file="../header.jsp"%>
    <jsp:useBean id="vmc" class="com.eminentlabs.mom.controller.ViewMomController"></jsp:useBean>
    <jsp:useBean id="mas" class="com.eminent.issue.formbean.MyAsignmentIssues" /> 
    <jsp:useBean id="mwd" class="com.eminent.branch.BranchController"></jsp:useBean>
    <jsp:useBean id="smmc" class="com.eminentlabs.mom.controller.SendMomMaintainController"></jsp:useBean>
    <%mwd.getAllBranchMap();%>
    <% String mail = (String) session.getAttribute("theName");
        int role = (Integer) session.getAttribute("Role");
        int assignedto = (Integer) session.getAttribute("userid_curr");
        int wrmSize = mas.wrmIssues().size();
        vmc.setAll(request);
        smmc.getLocationNBranch(vmc.getUserId());
        int c = GetProjectManager.checkProjectManager(String.valueOf(assignedto));%>
    <form name="theFormz" id="theFormz" method="get"  action="./momView.jsp" onsubmit="disableMomSubmit()">
        <div class="page-header">
            <span class='page-header-content1'> MOM 
                <select name="momTeamType" id="momTeamType" onchange="callProjectMom(this);">
                    <%for (Map.Entry<Integer, String> entry : vmc.getMomTypeList().entrySet()) {
                            if (vmc.getMomTeamType() == entry.getKey()) {
                    %>
                    <option value="<%=entry.getKey()%>" selected=""><%=entry.getValue()%></option>
                    <%} else {%>
                    <option value="<%=entry.getKey()%>"><%=entry.getValue()%></option>
                    <%}
                        }%>
                </select></span>
            <span class="page-header-content2">Minutes of Meeting on <input type="text" id="momdate" name="momdate" maxlength="10" size="10"
                                                                            value="<%=vmc.getMomDate()%>" readonly /><a
                                                                            href="javascript:NewCal('momdate','ddmmmyyyy','','','','past')"> <img
                        src="<%=request.getContextPath()%>/images/newhelp.gif" border="0"
                        width="16" height="16" alt="Pick a date"></a>


                <input type="submit" name="btnSubmit" id="btnSubmit" value="Submit"> </span>
            <span class="page-header-content3">
                <select name="pid" id="pid" onchange="callProjectMom(this);">
                    <option value="">All Projects</option>
                    <%for (Map.Entry<Integer, String> entry : vmc.getMomProjects().entrySet()) {
                            if (vmc.getProjectId() == entry.getKey()) {%>
                    <option value="<%=entry.getKey()%>" selected=""><%=entry.getValue()%></option>
                    <%} else {%><option value="<%=entry.getKey()%>"><%=entry.getValue()%></option>
                    <%}
                        }%>
                </select></span>
            <span class="page-header-content3">
                <select id="branch" name="branch" onchange="callProjectMom(this);" style="    padding: 8px;    border-radius: 6px;    border: 1px solid #CCC;">
                    <option value="">All Location</option>
                    <%if (!mwd.getBranchMap().isEmpty()) {
                            for (Map.Entry<Integer, String> entry : mwd.getBranchMap().entrySet()) {%>
                    <option value="<%=entry.getKey()%>" <%if (vmc.getBranch() == entry.getKey()) {%> selected=""<%}%>><%=entry.getValue()%></option>
                    <%}
                        }%>                                                
                </select>
            </span>
            <%
                if (vmc.getModList().contains(((Integer) vmc.getUserId()).toString())) {
            %>
            <span class="page-header-content4">
                <a href='<%=request.getContextPath()%>/MOM/momView.jsp?sync=true'> Sync It</a>
            </span>
            <%}%>
        </div>

    </form>
    <table  cellpadding="0" cellspacing="0" width="100%">

        <tr>
            <td style="height: 25px;">
                <a href="<%=request.getContextPath()%>/MOM/addTask.jsp"> Add Issue / Task</a>&nbsp;&nbsp;&nbsp;&nbsp;
                <a href="<%=request.getContextPath()%>/MOM/viewTask.jsp" style="cursor: pointer;">View Issue / Task</a> &nbsp;&nbsp;&nbsp;
                <%
                    if (role == 1 || c > 0) {
                %>
                <a href="<%=request.getContextPath()%>/MOM/plannedIssuesReport.jsp" style="cursor: pointer;">Planned Issue Report</a> &nbsp;&nbsp;&nbsp;

                <%}
                    if (smmc.getSendMomMaintenance() != null && smmc.getSendMomMaintenance().getUserId() != null && smmc.getSendMomMaintenance().getUserId().intValue() == vmc.getUserId()) {
                %>
                <a href="<%=request.getContextPath()%>/MOM/mom.jsp" style="cursor: pointer;">Send MOM</a> &nbsp;&nbsp;&nbsp;
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
                <a href="<%=request.getContextPath()%>/Reimbursement/reimbursementUpload.jsp" style="cursor: pointer; ">Reimbursement</a> &nbsp;&nbsp;&nbsp;
                <%
                    if (assignedto == 104 || mail.equals("accounts@eminentlabs.net")) {
                %>
                <a href="<%=request.getContextPath()%>/Reimbursement/reimbursementSearch.jsp" style="cursor: pointer;font-weight: bold; ">Reimbursement Search</a> &nbsp;&nbsp;&nbsp;

                <%}%>

                <%if (vmc.getModList().contains(((Integer) vmc.getUserId()).toString())) {%>                
                <a href="<%=request.getContextPath()%>/admin/project/monitoringReport.jsp">Monitoring Report</a
                <%}%>
            </td>
        </tr>
    </table> 
    <%if (vmc.getProjDetails() != null) {%>
    <table   style="width:100%;background-color: #C3D9FF;" >
        <tr >
            <td colspan='4'><b>Eminentlabs&trade; Project Status:</b></td>
        </tr></table><br/><table class="mom"   style="width:100%;border-collapse:collapse;margin-bottom: 20px;">
        <tr style="text-align:center; font-weight:bold;background-color:#C3D9FF;">
            <td class="mom">Project</td>
            <td class="mom">With PM</td>
            <td class="mom">With Customer Users for Input</td>
            <td class="mom">With Functional Consultants</td>
            <td class="mom">With Functional Consultants for Dev Inputs / Functional Realization</td>
            <td class="mom">With Development</td>
            <td class="mom">With Functional Consultants for Testing</td>
            <td class="mom">With Customer Users for UAT</td>
            <td class="mom">Total</td>
        </tr>
        <%
            for (int i = 0; i < vmc.getProjDetails().length; i++) {
                String color = "";
                if (vmc.getProjDetails()[i][11].equals(String.valueOf(vmc.getProjectId()))) {
                    color = "yellow";
                }
        %>
        <tr  style="background-color: <%=color%>;"> 
            <td class="mom"><%= vmc.getProjDetails()[i][0]%>(<font color="blue"><a href='/eTracker/MOM/projectWiseIssues.jsp?pId= <%= vmc.getProjDetails()[i][11]%> &projectMoMStatus=altogether'><%= vmc.getProjDetails()[i][1]%></font></a>)</td>
            <td class="mom" style="text-align:center;"><a href='/eTracker/MOM/projectWiseIssues.jsp?pId=<%= vmc.getProjDetails()[i][11]%>&projectMoMStatus=pmcount'><font color="Red"><%=vmc.getProjDetails()[i][2]%></font></a></td>
            <td class="mom" style="text-align:center;"><a href='/eTracker/MOM/projectWiseIssues.jsp?pId=<%= vmc.getProjDetails()[i][11]%>&projectMoMStatus=customercount'><%= vmc.getProjDetails()[i][3]%></a></td>
            <td class="mom" style="text-align:center;"><a href='/eTracker/MOM/projectWiseIssues.jsp?pId=<%= vmc.getProjDetails()[i][11]%>&projectMoMStatus=withfc'><%= vmc.getProjDetails()[i][4]%></a></td>
            <td style="text-align:center;"><a href='/eTracker/MOM/projectWiseIssues.jsp?pId=<%= vmc.getProjDetails()[i][11]%>&projectMoMStatus=qa-btc'><%= vmc.getProjDetails()[i][5]%><a></td>
                        <td style="text-align:center;"><a href='/eTracker/MOM/projectWiseIssues.jsp?pId=<%= vmc.getProjDetails()[i][11]%>&projectMoMStatus=withabap'><%= vmc.getProjDetails()[i][6]%></a></td>
                        <td style="text-align:center;"><a href='/eTracker/MOM/projectWiseIssues.jsp?pId=<%= vmc.getProjDetails()[i][11]%>&projectMoMStatus=qa-tce'><%= vmc.getProjDetails()[i][7]%></a></td>
                        <td style="text-align:center;"><a href='/eTracker/MOM/projectWiseIssues.jsp?pId<%= vmc.getProjDetails()[i][11]%>&projectMoMStatus=customeruat'><%= vmc.getProjDetails()[i][8]%></a></td>
                        <td style="text-align:center;background-color: <%= vmc.getProjDetails()[i][10]%>"><%= vmc.getProjDetails()[i][9]%></td></tr>
                        <%}%></table>
                        <%}
                            if (vmc.getMomDate().compareTo(vmc.getCurrentDate()) == 0) {%>
                        <div id="summaryRes"></div> 
                        <%}%>
                        
                            <form name="theForm" method="post"  action="./momView.jsp" onsubmit="disableMomSubmit()">

                        <table class="mom"  style="width:100%;border-collapse:collapse;">

                            <tr style="width:100%;background-color: #C3D9FF;">
                                <td style="width:10%" ><b>Name</b></td>
                                <td colspan="3">
                                    <table style="width: 100%;" ><tr>
                                            <Td  style="width: 4%;font-weight:bold;">Track</TD>
                                            <TD style="width: 32%;text-align:center;font-weight:bold;">Previous Day</TD>
                                            <TD style="width: 32%;text-align:center;font-weight:bold;">Today</TD>
                                            <TD style="width: 32%;text-align:center;font-weight:bold;">Next Day</TD>
                                        </tr></table>
                                </td> 
                            </tr>
                            <%int roleId = (Integer) session.getAttribute("Role");
                                for (ViewMomFormBean viewMomFormBean : vmc.getViewMomFormBeans()) {%>
                            <tr >
                                <td><%if (viewMomFormBean.getName() != null) {
                                        if (roleId == 1) {
                                    %><a href="<%=request.getContextPath()%>/MOM/viewTaskForUser.jsp?momUserId=<%=viewMomFormBean.getUserId()%>"><%=viewMomFormBean.getName()%></a>
                                    <%} else {%><%=viewMomFormBean.getName()%>
                                    <%}
                                        }%></td>
                                <td colspan="3"> 
                                    <table style="width:100%;" > <tbody><tr>
                                                <td style="width:4%;">Planned</td>
                                                <td style="width:32%;" ><ul ><%for (String task : viewMomFormBean.getPrevDayPlanTasks()) {%>
                                                        <li><%=task%></li>
                                                        <% }%></ul></td>
                                                <td style="width:32%;">
                                                    <%
                                                        /* edit by mukesh*/
                                                        if (viewMomFormBean.isLeaveToday()) { %>
                                                    <span class="leave">Approved Leave</span>
                                                    <%} %>                                                    
                                                        <ul><%
                                                        for (String task : viewMomFormBean.getCurrentDayPlanTasks()) {%>                                                          <li><%=task%></li>
                                                            <% }%>
                                                    </ul></td>
                                                <td style="width:32%;">
                                                    <%
                                                        if (viewMomFormBean.isLeaveNextday()) {
                                                    %>
                                                    <span  class="leave">Approved Leave</span>
                                                    <%}
                                                        /* edit by mukesh*/ %> 
                                                    <ul><%for (String task : viewMomFormBean.getNextDayPlanTasks()) {%>                                                            <li><%=task%></li>
                                                        <% }%></ul>
                                                </td>

                                            </tr>
                                            <tr>
                                                <td style="width:4%;">Actual</td>
                                                <td style="width:32%;"><ul><%for (String task : viewMomFormBean.getPrevDayActualTasks()) {%>
                                                        <li><%=task%></li>
                                                        <% }%></ul></td>
                                                <td style="width:32%;"><ul><%for (String task : viewMomFormBean.getCurrentDayActualTasks()) {%>
                                                        <li><%=task%></li>
                                                        <% }%></ul></td>
                                                <td style="width:32%;"><ul><%for (String task : viewMomFormBean.getNextDayActualTasks()) {%>
                                                        <li><%=task%></li>
                                                        <% }%></ul></td>

                                            </tr>
                                    </table>
                                </td>
                            </tr>
                            <%}
                            
                             if (vmc.getMomDate().compareTo(vmc.getCurrentDate()) == 0) {%>
                             <tr style="width:100%;text-align:center;">
                                 <td colspan='4'><input type="submit" id="submit" value="Submit"></td>
                            </tr>
                            <%}%>
                        </table>
                            </form>
                        <table border='0' style="width:100%;margin-top: 20px;">
                            <tr style="width:100%;background-color: #C3D9FF;">
                                <td colspan='4'><b>Eminentlabs&trade; Team Attendance:</b></td>
                            </tr>
                            <tr style='height:2px;'>
                                <td colspan='2'><b></b></td>
                            </tr>
                            <%        String attMomTime = "", attMomTimeb = "", stName = "", status = "", eName = "", name = "", teamAttendance = "<tr><td></td><td></td><td>";
                                boolean Mflag = true, Eflag = true;
                                for (int i = 0; i < vmc.getAttDetails().length; i++) {

                                    attMomTime = vmc.getAttDetails()[i][3];

                                    if (attMomTime.equalsIgnoreCase("Morning")) {
                                        if (Mflag == true) {%>
                            <tr style="background-color:#E8EEF7;"><td colspan="5" style="font-weight:bold;color:blue;">Morning :</td></tr>
                            <%  Mflag = false;
                                }
                                stName = vmc.getAttDetails()[i][0];
                                if (!stName.equalsIgnoreCase(name)) {%>

                            <tr><td colspan='2' id="<%= stName%> "><b> <%= stName%> </b></td><td><b>:</b></td><td>
                                    <% }
                                        if (vmc.getAttDetails()[i][2] != null) {%>
                                    <%= vmc.getAttDetails()[i][1] + "(" + vmc.getAttDetails()[i][2] + ")" + ", "%>
                                    <%} else {%>
                                    <%= vmc.getAttDetails()[i][1] + ", "%>
                                    <%}

                                        name = stName;
                                    } else if (attMomTime.equalsIgnoreCase("Evening")) {
                                        if (Eflag == true) {%>
                                </td></tr><tr style="background-color:#E8EEF7;"><td colspan="5" style="font-weight:bold;color:blue;">Evening :</td></tr>
                                <%  Eflag = false;
                                    }
                                    stName = vmc.getAttDetails()[i][0];
                                    if (!stName.equalsIgnoreCase(name)) {%>

                            <tr><td colspan='2' id="<%= stName%> "><b> <%= stName%> </b></td><td><b>:</b></td><td>
                                    <% }
                                        if (vmc.getAttDetails()[i][2] != null) {%>
                                    <%= vmc.getAttDetails()[i][1] + "(" + vmc.getAttDetails()[i][2] + ")" + ", "%>
                                    <%} else {%>
                                    <%= vmc.getAttDetails()[i][1] + ", "%>
                                    <%}

                                                name = stName;
                                            }

                                        }%>
                        </table>
                        <%if (!vmc.getFineAmtToday().isEmpty()) {%>
                        <table border='0' style="width:100%;">
                            <tr style="width:100%;background-color: #C3D9FF;">
                                <td style="width:35%;"><b>Name</b></td>
                                <td style="width:20%;"><b>Amount</b></td>
                                <td style="width:45%;"><b>Reason</b></td>
                            </tr>
                            <% int i = 0;
                                for (FineAmountBean fineAmt : vmc.getFineAmtToday()) {
                                    i++;%>
                            <tr <%if (i % 2 == 0) {%>style="background-color:#E8EEF7; "<%}%>><td><%=  fineAmt.getName()%> </td><td ><font style="color:  red;" ><%= fineAmt.getAmount()%></font></td><td><font style="color:  red;" ><%= fineAmt.getReason()%></font></td><td></tr>
                                    <%}%>
                        </table>
                        <%}%>
                        <a href="#" id="back-to-top" title="Back to top">&uarr;</a>
                        <div>
                            <%
                                List<String> issues = new ArrayList<String>();

                            %>
                        </div>
                        <div id="dialog" title="Basic dialog">

                        </div>
                        </body>
                        <script type="text/javascript">
                            $(document).on('click', '.issuedisplay', function () {
                                  $(".Ajax-loder").show();

                                var summaryType = $.trim($(this).attr('summaryType'));
                                var summaryTypeTitle = $.trim($(this).attr('heading'));
                                var summaryTableType = $.trim($(this).attr('summaryTableType'));
                                var teamType = $.trim($(this).attr('teamType'));
                                var pid = $.trim($(this).attr('pid'));
                                $.ajax({
                                    url: '<%=request.getContextPath()%>/MOM/summaryMomIssues.jsp',
                                    data: {summaryType: summaryType, summaryTableType: summaryTableType, pid: pid, teamType: teamType, random: Math.random(1, 10)},
                                    complete: function () {
                                         $(".Ajax-loder").hide();
                                    },
                                    async: true,
                                    type: 'POST',
                                    success: function (responseText, statusTxt, xhr) {
                                        if (statusTxt === "success") {

                                            $('#dialog').html(responseText);
                                            $("#dialog").dialog("open");
                                            $('.ui-dialog-title').html(summaryTypeTitle + " Issues");
                                        }
                                    }
                                });

                            });
                            $(".momp td, .momc td,.momn td,#searchTable tbody tr td").tooltip({
                                show: null,
                                position: {
                                    my: "left top",
                                    at: "left bottom"
                                },
                                open: function (event, ui) {
                                    ui.tooltip.animate({top: ui.tooltip.position().top + 10}, "fast");
                                }
                            });
                            if ($('#back-to-top').length) {
                                var scrollTrigger = 100, // px
                                        backToTop = function () {
                                            var scrollTop = $(window).scrollTop();
                                            if (scrollTop > scrollTrigger) {
                                                $('#back-to-top').addClass('show');
                                            } else {
                                                $('#back-to-top').removeClass('show');
                                            }
                                        };
                                backToTop();
                                $(window).on('scroll', function () {
                                    backToTop();
                                });
                                $('#back-to-top').on('click', function (e) {
                                    e.preventDefault();
                                    $('html,body').animate({
                                        scrollTop: 0
                                    }, 700);
                                });
                            }
                            $(function () {
                                $("#dialog").dialog({
                                    autoOpen: false,
                                    width: 1000,
                                    maxHeight: 500,
                                    show: {
                                        effect: "blind",
                                        duration: 1000
                                    },
                                    hide: {
                                        effect: "blind",
                                        duration: 1000
                                    }
                                });
                            });
                                $(".Ajax-loder").hide();
                            $(document).on('click', 'span.page-header-content4', function () {
                                //   $(".Ajax-loder").show();
                            });
                            (function () {
                                var hidden = "hidden";

                                // Standards:
                                if (hidden in document)
                                    document.addEventListener("visibilitychange", onchange);
                                else if ((hidden = "mozHidden") in document)
                                    document.addEventListener("mozvisibilitychange", onchange);
                                else if ((hidden = "webkitHidden") in document)
                                    document.addEventListener("webkitvisibilitychange", onchange);
                                else if ((hidden = "msHidden") in document)
                                    document.addEventListener("msvisibilitychange", onchange);
                                // IE 9 and lower:
                                else if ("onfocusin" in document)
                                    document.onfocusin = document.onfocusout = onchange;
                                // All others:
                                else
                                    window.onpageshow = window.onpagehide
                                            = window.onfocus = window.onblur = onchange;

                                function onchange(evt) {
                                    var v = "visible", h = "hidden",
                                            evtMap = {
                                                focus: v, focusin: v, pageshow: v, blur: h, focusout: h, pagehide: h
                                            };

                                    evt = evt || window.event;
                                    if (evt.type in evtMap)
                                        document.body.className = evtMap[evt.type];
                                    else
                                        document.body.className = this[hidden] ? "hidden" : "visible";
                                }

                                // set the initial state (but only if browser supports the Page Visibility API)
                                if (document[hidden] !== undefined)
                                    onchange({type: document[hidden] ? "blur" : "focus"});
                            })();

                            $(document).ready(function () {
                                var pid = document.getElementById('pid').value;
                                var momdate = document.getElementById('momdate').value;
                                var momTeamType = document.getElementById('momTeamType').value;
                                            var branch = document.getElementById('branch').value;

                                $.ajax({
                                    url: '<%=request.getContextPath()%>/MOM/summary.jsp',
                                    data: {pid: pid, momdate: momdate, momTeamType: momTeamType,branch:branch, random: Math.random(1, 10)},
                                    async: true,
                                    type: 'GET',
                                    success: function (responseText, statusTxt, xhr) {
                                        if (statusTxt === "success") {
                                            var result = $.trim(responseText);
                                            $("#summaryRes").html(result);
                                        }
                                    }
                                });
                            });
                            $(document).on('click', '#submit', function () {
                                  $(".Ajax-loder").show();
                                  });
                        </script>

                        </html>
