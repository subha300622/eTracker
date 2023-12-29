<%-- 
    Document   : wrmIssues
    Created on : 12 May, 2015, 4:48:52 PM
    Author     : EMINENT
--%>

<%@page import="com.eminent.util.IssueDetails"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.Arrays"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ResourceBundle"%>
<%@page import="org.apache.log4j.Logger"%>
<%@page import="com.eminent.issue.formbean.IssueFormBean"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    Logger logger = Logger.getLogger("wrmIssues");
    String logoutcheck = (String) session.getAttribute("Name");
    if (logoutcheck == null) {
        logger.fatal("=========================Session Expired======================");
%>
<jsp:forward page="../SessionExpired.jsp"></jsp:forward>
<%
        //response.sendRedirect(request.getContextPath()+"/SessionExpired.jsp");
    }

%>
<html>
    <meta name="keywords" content="GST in SAP, SAP GST Accelerator, GST Success in SAP, GST India in SAP, GST SAP Success, GST Suvidha Provider, GST ASP GSP, GST, CGST,SGST, IGST, UGST,  SAP NW based Product Development, SAP Consulting, SAP Implementation, SAP Support Services, SAP Outsourcing, SAP Implementation India, SAP Implementation Bangalore, SAP Implementation Chennai, SAP Implementation Belgium, SAP Implementation Paris, SAP Implemtation Australia, SAP Implementation France, SAP Implementation Mumbai, SAP Implementation Kerala, SAP Implementation Belgaum, SAP Implementation Thailand, SAP Implementation Mexico, SAP Implementation America">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>eTracker&#153; - Eminentlabs&#153; CRM, APM, TQM,  ERM and  EPTS Solution</title>
    <meta http-equiv="X-UA-Compatible" content="IE=Edge">

    <LINK title=STYLE href="<%= request.getContextPath()%>/eminentech support files/main_ie.css?test=261020151225" type="text/css" rel="STYLESHEET">
    <script src="<%=request.getContextPath()%>/javaScript/XMLHttpRequest.js" type="text/javascript"></script>
    <script type="text/javascript" src="<%= request.getContextPath()%>/javaScript/fileAttach.js?test=261020151625"></script>
    <link rel="stylesheet" href="//code.jquery.com/ui/1.11.4/themes/redmond/jquery-ui.css">
    <script src="//code.jquery.com/jquery-1.10.2.js"></script>
    <script src="<%=request.getContextPath()%>/javaScript/jquery.multiple.select.js"></script>

    <script src="//code.jquery.com/ui/1.11.4/jquery-ui.js"></script>
    <script src="<%=request.getContextPath()%>/javaScript/jquery.tablesorter1.js" type="text/javascript"></script>
    <script src="<%=request.getContextPath()%>/javaScript/jquery.tablesorter.widgets.js" type="text/javascript"></script>    
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/theme.blue1.css?test=3">
    <link href="<%=request.getContextPath()%>/multiple-select.css?test=2" rel="stylesheet"/>
    <script type="text/javascript" src="<%= request.getContextPath()%>/javaScript/tooltip.js"></script>
    <script type="text/javascript" src="<%= request.getContextPath()%>/javaScript/checkSubmit.js"></script>


    <script type="text/javascript">
        function showPrint(issueid) {
            window.open("<%=request.getContextPath()%>/viewIssueDetails.jsp?issueid=" + issueid);
        }
        $.tablesorter.addParser({
            id: "ddMMMyy",
            is: function(s) {
                return false;
            },
            format: function(s, table) {
                var from = s.split("-");
                var year = "20" + from[2];
                var mon = from[1];
                var month = new Date(Date.parse(mon + " 1," + year)).getMonth();
                return new Date(year, month, from[0]).getTime() || '';
            },
            type: "numeric"
        });
        $(function() {

            // call the tablesorter plugin
            $("#filtersort, #filtersort1, #filtersort2, #filtersort3").tablesorter({
                theme: 'blue',
                // hidden filter input/selects will resize the columns, so try to minimize the change
                widthFixed: true,
                // initialize zebra striping and filter widgets
                widgets: ["zebra", "filter"],
                headers: {7: {// <-- replace 6 with the zero-based index of your column
                        sorter: 'ddMMMyy'
                    }},
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
                    }

                }

            });
        });

        function callProjectPlan()
        {
            var plannedForParam = $.trim($("#plannedForParam").val());
            var count = 0;
            var plannedFor = document.getElementById("plannedFor").value;
            if (plannedFor == "") {
                count++;
            } else if (plannedForParam.length == 0 && (plannedFor == 'Today')) {
                count++;
            } else if (plannedForParam == plannedFor) {
                count++;
            }
            if (count == 0) {
                if (document.getElementById("plannedFor") !== null) {
                    var plannedFor = document.getElementById("plannedFor").value;

                    document.wrmForm.action = '/eTracker/MOM/wrmIssues.jsp?plannedFor=' + plannedFor;
                } else {
                    document.wrmForm.action = '/eTracker/MOM/wrmIssues.jsp?plannedFor=' + plannedFor;
                }
                document.wrmForm.submit();
            } else {
                return false;
            }
        }

    </script>
</head>
<body>
    <%ResourceBundle rb = ResourceBundle.getBundle("Resources");
        String mods = rb.getString("mom-mods");
        String noOfIds[] = mods.split(",");
        List<String> modList = Arrays.asList(noOfIds);
    %>
    <%@ include file="../header.jsp"%>
    <div style="width: 100%;background-color: #C3D9FE;font-weight: bold;">WRM Issues </div>
    <jsp:useBean id="wic" class="com.eminentlabs.wrm.controller.WrmIssuesController"></jsp:useBean>
    <jsp:useBean id="mas" class="com.eminent.issue.formbean.MyAsignmentIssues" /> 
    <jsp:useBean id="smmc" class="com.eminentlabs.mom.controller.SendMomMaintainController"></jsp:useBean>
    <%
        int wrmSize = mas.wrmIssues().size();
    %><%wic.setAll(request);%>
    <%int assignedto = (Integer) session.getAttribute("userid_curr");
        String team = (String) session.getAttribute("team");
        String mail = (String) session.getAttribute("theName");
        String url = null;
        if (mail != null) {
            url = mail.substring(mail.indexOf("@") + 1, mail.length());
        }
        smmc.getLocationNBranch(assignedto);%>
    <table cellpadding="0" cellspacing="0" width="100%">

        <tr>
            <td style="height: 25px;">
                <a href="<%=request.getContextPath()%>/MOM/addTask.jsp"> Add Issue / Task</a>&nbsp;&nbsp;&nbsp;&nbsp;
                <a href="<%=request.getContextPath()%>/MOM/viewTask.jsp" style="cursor: pointer;">View Issue / Task</a> &nbsp;&nbsp;&nbsp;
                <%if (smmc.getSendMomMaintenance() != null && smmc.getSendMomMaintenance().getUserId() != null && smmc.getSendMomMaintenance().getUserId().intValue() == assignedto) {
                %>
                <a href="<%=request.getContextPath()%>/MOM/mom.jsp" style="cursor: pointer; ">Send MOM</a> &nbsp;&nbsp;&nbsp;
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
                <a href="<%=request.getContextPath()%>/MOM/wrmIssues.jsp" style="cursor: pointer;font-weight: bold; ">WRM Issues (<%=wrmSize%>)</a> &nbsp;&nbsp;&nbsp;
                <a href="<%=request.getContextPath()%>/Reimbursement/reimbursementUpload.jsp" style="cursor: pointer; ">Reimbursement</a> &nbsp;&nbsp;&nbsp;
            </td>
        </tr>
    </table>
    <form name="wrmForm" id="wrmForm" method="post" action="<%=request.getContextPath()%>/MOM/wrmIssues.jsp" onsubmit="return check();">
        <%if (wic.getTechnicalHead().contains(assignedto)) {%>
        <input type="hidden" name="plannedForParam" id="plannedForParam" value="<%=wic.getPlannedFor()%>"/>
        <div style="  width: 100%;display: block; padding-bottom: 10px"> 
            <select name="plannedFor" id="plannedFor" onchange="callProjectPlan();" style="margin-top: 6px;padding: 4px; border-radius: 6px;  border: 1px solid #CCC; ">
                <option value="">Select-One</option>
                <%for (String plannedFor : IssueDetails.plannedForList()) {
                        if (wic.getPlannedFor().equalsIgnoreCase(plannedFor)) {
                %>
                <option value="<%=plannedFor%>" selected><%=plannedFor%></option>
                <%} else {%>
                <option value="<%=plannedFor%>" ><%=plannedFor%></option>
                <%}
                    }%>
            </select>
            <select name="pIds" id="pIds" multiple="" data-placeholder="Select Projects">
                <%for (Map.Entry<Integer, String> entry : wic.getMomProjects().entrySet()) {
                        if (wic.getPids().contains(entry.getKey())) {%>
                <option value="<%=entry.getKey()%>" selected=""><%=entry.getValue()%></option>
                <%} else {%>


                <option value="<%=entry.getKey()%>"><%=entry.getValue()%></option>
                <% }
                    }%>
            </select>

        </div>
        <div class="clear"></div>
        <%}%>
        <div class="tablecontent" id="accordion" style="width: 100%;">
            <h3 style="font-weight: bold;color: blue;">WRM Issues UnTouched by ESPL (<%=wic.getWrmUnTouchedByEspl().size()%>)</h3>
            <TABLE width="100%" class="tablesorter" id="filtersort" style="padding: -2px;">
                <thead>
                    <TR bgcolor="#C3D9FF">
                        <td width="1%" class="filter-false" TITLE="Severity"><font><b>S</b></font></td>
                        <td width="11%"><font><b>Issue No</b></font></td>
                        <td width="2%" class="filter-false"  TITLE="Priority"><font><b>P</b></font></td>
                        <td width="10%" class="filter-select filter-match" data-placeholder="Select a Project"><font><b>Project</b></font></td>
                        <td width="7%" class="filter-select filter-match" data-placeholder="Select a Module"><font><b>Module</b></font></td>
                        <td width="25%" ><font><b>Subject</b></font></td>
                        <td width="12%" class="filter-select filter-match" data-placeholder="Select a Status"><font><b>Status</b></font></td>
                        <td width="8%" class="filter-false"><font><b>Due Date</b></font></td>
                        <td width="13%" class="filter-select filter-match" data-placeholder="Select AssignTo"><font><b>Assigned To</b></font></td>
                        <td width="9%" class="filter-false"><font><b>Refer</b></font></td>
                        <td width="2%" TITLE="In Days"  data-placeholder="Try >10"><font><b>Age</b></font></td>
                    </TR>
                </thead>
                <tbody>
                    <%int i = 0;
                        for (IssueFormBean isfb : wic.getWrmUnTouchedByEspl()) {
                            if ((i % 2) != 0) {
                    %>
                    <tr class="zebralinealter" height="21">
                        <%} else {%>
                    <tr class="zebraline" height="21">
                        <%}
                            i++;%>

                        <td   style="background-color :<%=isfb.getSeverity()%>;">&nbsp;</td>
                        <td class="background" title="<%=isfb.getType()%>"><input type="hidden" name="<%=isfb.getIssueId()%>assignedTo" value="<%=isfb.getAssigntoId()%>"/><%if (wic.getPlannedIssues().contains(isfb.getIssueId())) {
                                if (wic.getTechnicalHead().contains(assignedto)) {%>
                            <input type="checkbox" name="<%=isfb.getpId()%>pIssue" value="<%=isfb.getIssueId()%>" checked=""  style="vertical-align: middle;">
                            <%}%>
                            <a  href="javascript:callissue('<%=isfb.getIssueId()%>')" style="visibility: visible">

                                <%=isfb.getIssueId()%></a>
                            <img src="<%=request.getContextPath()%>/images/tick.png"  title="Customer Priority + Delivery Planned"  style="cursor: pointer;"/>
                            <%
                            } else {
                                if (wic.getTechnicalHead().contains(assignedto)) {%>
                            <input type="checkbox" name="<%=isfb.getpId()%>pIssue" value="<%=isfb.getIssueId()%>"   style="vertical-align: middle;">
                            <%}%>
                            <a  href="javascript:callissue('<%=isfb.getIssueId()%>')" style="visibility: visible">

                                <%=isfb.getIssueId()%></a>
                            <%}%><img src="<%=request.getContextPath()%>/images/Bomb.png"  title="WRM Untouched"  style="cursor: pointer;vertical-align: middle;"/></td>
                        <td class="background"><%=isfb.getPriority()%></td>
                        <td class="background" title="<%=isfb.getpName()%>"><%=isfb.getRedPName()%></td>
                        <td class="background" width="7%" title="<%=isfb.getmName()%>"><%=isfb.getRedMName()%></td>
                        <td class="background" id="<%=isfb.getIssueId()%>tab" onmouseover="xstooltip_show('<%=isfb.getIssueId()%>', '<%=isfb.getIssueId()%>tab', 289, 49);" onmouseout="xstooltip_hide('<%=isfb.getIssueId()%>');" ><%=isfb.getSubject()%><div class="issuetooltip" id="<%=isfb.getIssueId()%>"><%= isfb.getDescription()%></div></td>
                        <td class="background" style="cursor: pointer;" onclick="showPrint('<%=isfb.getIssueId()%>')"><%=isfb.getStatus()%></td>
                        <td class="background" title="Last Modified On <%=isfb.getModifiedOn()%>"><font
                                face="Verdana, Arial, Helvetica, sans-serif" size="1" color="<%=isfb.getDueDateColor()%>"><%=isfb.getDueDate()%></td>
                        <td class="background" title=" <%=isfb.getCreatedBy()%> "><%=isfb.getAssignto()%></td>
                        <%if (isfb.getRefer().equalsIgnoreCase("No Files")) {%>
                        <td class="background" ><%=isfb.getRefer()%></td>
                        <%} else {%>
                        <td class="background" ><a onclick="viewFileAttachForIssue('<%=isfb.getIssueId()%>');" href="#"><%=isfb.getRefer()%></a></td>
                            <%}%>
                        <td class="background" title="<%=isfb.getAge()%>"><%=isfb.getLastAssigneeAge()%></td></tr>

                    <%
                        }%>
            </table>
            <h3 style="font-weight: bold;color: blue;">WRM Issues UnTouched by Customer (<%=wic.getWrmUnTouchedByCustomer().size()%>)</h3>
            <TABLE width="100%" class="tablesorter" id="filtersort1">
                <thead>
                    <TR bgcolor="#C3D9FF">
                        <td width="1%" class="filter-false" TITLE="Severity"><font><b>S</b></font></td>
                        <td width="11%"><font><b>Issue No</b></font></td>
                        <td width="2%" class="filter-false"  TITLE="Priority"><font><b>P</b></font></td>
                        <td width="10%" class="filter-select filter-match" data-placeholder="Select a Project"><font><b>Project</b></font></td>
                        <td width="7%" class="filter-select filter-match" data-placeholder="Select a Module"><font><b>Module</b></font></td>
                        <td width="25%" ><font><b>Subject</b></font></td>
                        <td width="12%" class="filter-select filter-match" data-placeholder="Select a Status"><font><b>Status</b></font></td>
                        <td width="8%" class="filter-false"><font><b>Due Date</b></font></td>
                        <td width="13%" class="filter-select filter-match" data-placeholder="Select AssignTo"><font><b>Assigned To</b></font></td>
                        <td width="9%" class="filter-false"><font><b>Refer</b></font></td>
                        <td width="2%" TITLE="In Days"  data-placeholder="Try >10"><font><b>Age</b></font></td>
                    </TR>
                </thead>
                <tbody>
                    <% i = 0;
                        for (IssueFormBean isfb : wic.getWrmUnTouchedByCustomer()) {
                            if ((i % 2) != 0) {
                    %>
                    <tr class="zebralinealter" height="21">
                        <%} else {%>
                    <tr class="zebraline" height="21">
                        <%}
                            i++;%>

                        <td   style="background-color :<%=isfb.getSeverity()%>;">&nbsp;</td>
                        <td class="background" title="<%=isfb.getType()%>"><input type="hidden" name="<%=isfb.getIssueId()%>assignedTo" value="<%=isfb.getAssigntoId()%>"/>

                            <%if (wic.getPlannedIssues().contains(isfb.getIssueId())) {
                                    if (wic.getTechnicalHead().contains(assignedto)) {
                            %>
                            <input type="checkbox" name="<%=isfb.getpId()%>pIssue" value="<%=isfb.getIssueId()%>" checked=""  style="vertical-align: middle;">
                            <%}%>
                            <a  href="javascript:callissue('<%=isfb.getIssueId()%>')" style="visibility: visible"><%=isfb.getIssueId()%></a>
                            <img src="<%=request.getContextPath()%>/images/tick.png"  title="Customer Priority + Delivery Planned"  style="cursor: pointer;"/>
                            <%
                            } else {
                                if (wic.getTechnicalHead().contains(assignedto)) {%>
                            <input type="checkbox" name="<%=isfb.getpId()%>pIssue" value="<%=isfb.getIssueId()%>"   style="vertical-align: middle;">
                            <%}%>
                            <a  href="javascript:callissue('<%=isfb.getIssueId()%>')" style="visibility: visible"><%=isfb.getIssueId()%></a>
                            <%}%>
                            <img src="<%=request.getContextPath()%>/images/Bomb.png"  title="WRM Untouched"  style="cursor: pointer;vertical-align: middle;"/></td>
                        <td class="background"><%=isfb.getPriority()%></td>
                        <td class="background" title="<%=isfb.getpName()%>"><%=isfb.getRedPName()%></td>
                        <td class="background" width="7%" title="<%=isfb.getmName()%>"><%=isfb.getRedMName()%></td>
                        <td class="background" id="<%=isfb.getIssueId()%>tab" onmouseover="xstooltip_show('<%=isfb.getIssueId()%>', '<%=isfb.getIssueId()%>tab', 289, 49);" onmouseout="xstooltip_hide('<%=isfb.getIssueId()%>');" ><%=isfb.getSubject()%><div class="issuetooltip" id="<%=isfb.getIssueId()%>"><%= isfb.getDescription()%></div></td>
                        <td class="background" style="cursor: pointer;" onclick="showPrint('<%=isfb.getIssueId()%>')"><%=isfb.getStatus()%></td>
                        <td class="background" title="Last Modified On <%=isfb.getModifiedOn()%>"><font
                                face="Verdana, Arial, Helvetica, sans-serif" size="1" color="<%=isfb.getDueDateColor()%>"><%=isfb.getDueDate()%></td>
                        <td class="background" title=" <%=isfb.getCreatedBy()%> "><%=isfb.getAssignto()%></td>
                        <%if (isfb.getRefer().equalsIgnoreCase("No Files")) {%>
                        <td class="background" ><%=isfb.getRefer()%></td>
                        <%} else {%>
                        <td class="background" ><a onclick="viewFileAttachForIssue('<%=isfb.getIssueId()%>');" href="#"><%=isfb.getRefer()%></a></td>
                            <%}%>
                        <td class="background" title="<%=isfb.getAge()%>"><%=isfb.getLastAssigneeAge()%></td></tr>

                    <%
                        }%>
            </table>
            <h3 style="font-weight: bold;color: blue;">WRM Issues Updated by ESPL (<%=(wic.getWrmTouchedByEspl().size())%>)</h3>
            <TABLE width="100%" class="tablesorter" id="filtersort2">
                <thead>
                    <TR bgcolor="#C3D9FF">
                        <td width="1%" class="filter-false" TITLE="Severity"><font><b>S</b></font></td>
                        <td width="11%"><font><b>Issue No</b></font></td>
                        <td width="2%" class="filter-false"  TITLE="Priority"><font><b>P</b></font></td>
                        <td width="10%" class="filter-select filter-match" data-placeholder="Select a Project"><font><b>Project</b></font></td>
                        <td width="7%" class="filter-select filter-match" data-placeholder="Select a Module"><font><b>Module</b></font></td>
                        <td width="25%" ><font><b>Subject</b></font></td>
                        <td width="12%" class="filter-select filter-match" data-placeholder="Select a Status"><font><b>Status</b></font></td>
                        <td width="8%" class="filter-false"><font><b>Due Date</b></font></td>
                        <td width="13%" class="filter-select filter-match" data-placeholder="Select AssignTo"><font><b>Assigned To</b></font></td>
                        <td width="9%" class="filter-false"><font><b>Refer</b></font></td>
                        <td width="2%" TITLE="In Days"  data-placeholder="Try >10"><font><b>Age</b></font></td>
                    </TR>
                </thead>
                <tbody>
                    <% i = 0;
                        for (IssueFormBean isfb : wic.getWrmTouchedByEspl()) {
                            if ((i % 2) != 0) {
                    %>
                    <tr class="zebralinealter" height="21">
                        <%} else {%>
                    <tr class="zebraline" height="21">
                        <%}
                            i++;%>

                        <td style="background-color :<%=isfb.getSeverity()%>;">&nbsp;</td>
                        <td class="background" title="<%=isfb.getType()%>"><input type="hidden" name="<%=isfb.getIssueId()%>assignedTo" value="<%=isfb.getAssigntoId()%>"/><%if (wic.getPlannedIssues().contains(isfb.getIssueId())) {
                                if (wic.getTechnicalHead().contains(assignedto)) {%>
                            <input type="checkbox" name="<%=isfb.getpId()%>pIssue" value="<%=isfb.getIssueId()%>" checked=""  style="vertical-align: middle;">
                            <%}%>
                            <a  href="javascript:callissue('<%=isfb.getIssueId()%>')" style="visibility: visible">

                                <%=isfb.getIssueId()%></a>
                            <img src="<%=request.getContextPath()%>/images/tick.png"  title="Customer Priority + Delivery Planned"  style="cursor: pointer;"/>
                            <%
                            } else {
                                if (wic.getTechnicalHead().contains(assignedto)) {%>
                            <input type="checkbox" name="<%=isfb.getpId()%>pIssue" value="<%=isfb.getIssueId()%>"   style="vertical-align: middle;">
                            <%}%>
                            <a  href="javascript:callissue('<%=isfb.getIssueId()%>')" style="visibility: visible">

                                <%=isfb.getIssueId()%></a>
                                <%}%>

                        </td>
                        <td class="background"><%=isfb.getPriority()%></td>
                        <td class="background" title="<%=isfb.getpName()%>"><%=isfb.getRedPName()%></td>
                        <td class="background" width="7%" title="<%=isfb.getmName()%>"><%=isfb.getRedMName()%></td>
                        <td class="background" id="<%=isfb.getIssueId()%>tab" onmouseover="xstooltip_show('<%=isfb.getIssueId()%>', '<%=isfb.getIssueId()%>tab', 289, 49);" onmouseout="xstooltip_hide('<%=isfb.getIssueId()%>');" ><%=isfb.getSubject()%><div class="issuetooltip" id="<%=isfb.getIssueId()%>"><%= isfb.getDescription()%></div></td>
                        <td class="background" style="cursor: pointer;" onclick="showPrint('<%=isfb.getIssueId()%>')"><%=isfb.getStatus()%></td>
                        <td class="background" title="Last Modified On <%=isfb.getModifiedOn()%>"><font
                                face="Verdana, Arial, Helvetica, sans-serif" size="1" color="<%=isfb.getDueDateColor()%>"><%=isfb.getDueDate()%></td>
                        <td class="background" title=" <%=isfb.getCreatedBy()%> "><%=isfb.getAssignto()%></td>
                        <%if (isfb.getRefer().equalsIgnoreCase("No Files")) {%>
                        <td class="background" ><%=isfb.getRefer()%></td>
                        <%} else {%>
                        <td class="background" ><a onclick="viewFileAttachForIssue('<%=isfb.getIssueId()%>');" href="#"><%=isfb.getRefer()%></a></td>
                            <%}%>
                        <td class="background" title="<%=isfb.getAge()%>"><%=isfb.getLastAssigneeAge()%></td></tr>

                    <%
                        }%>
            </table>
            <h3 style="font-weight: bold;color: blue;">WRM Issues Updated by Clients (<%=(wic.getWrmTouchedByCustomer().size())%>)</h3>
            <TABLE width="100%" class="tablesorter" id="filtersort3">
                <thead>
                    <TR bgcolor="#C3D9FF">
                        <td width="1%" class="filter-false" TITLE="Severity"><font><b>S</b></font></td>
                        <td width="11%"><font><b>Issue No</b></font></td>
                        <td width="2%" class="filter-false"  TITLE="Priority"><font><b>P</b></font></td>
                        <td width="10%" class="filter-select filter-match" data-placeholder="Select a Project"><font><b>Project</b></font></td>
                        <td width="7%" class="filter-select filter-match" data-placeholder="Select a Module"><font><b>Module</b></font></td>
                        <td width="25%" ><font><b>Subject</b></font></td>
                        <td width="12%" class="filter-select filter-match" data-placeholder="Select a Status"><font><b>Status</b></font></td>
                        <td width="8%" class="filter-false"><font><b>Due Date</b></font></td>
                        <td width="13%" class="filter-select filter-match" data-placeholder="Select AssignTo"><font><b>Assigned To</b></font></td>
                        <td width="9%" class="filter-false"><font><b>Refer</b></font></td>
                        <td width="2%" TITLE="In Days"  data-placeholder="Try >10"><font><b>Age</b></font></td>
                    </TR>
                </thead>
                <tbody>
                    <% i = 0;
                        for (IssueFormBean isfb : wic.getWrmTouchedByCustomer()) {
                            if ((i % 2) != 0) {
                    %>
                    <tr class="zebralinealter" height="21">
                        <%} else {%>
                    <tr class="zebraline" height="21">
                        <%}
                            i++;%>

                        <td   style="background-color :<%=isfb.getSeverity()%>;">&nbsp;</td>
                        <td class="background" title="<%=isfb.getType()%>"><input type="hidden" name="<%=isfb.getIssueId()%>assignedTo" value="<%=isfb.getAssigntoId()%>"/><%if (wic.getPlannedIssues().contains(isfb.getIssueId())) {
                                if (wic.getTechnicalHead().contains(assignedto)) {%>
                            <input type="checkbox" name="<%=isfb.getpId()%>pIssue" value="<%=isfb.getIssueId()%>" checked=""  style="vertical-align: middle;">
                            <%}%><a href="<%=request.getContextPath()%>/MyAssignment/UpdateIssueview.jsp?issueid=<%=isfb.getIssueId()%>">

                                <%=isfb.getIssueId()%></a>
                            <img src="<%=request.getContextPath()%>/images/tick.png"  title="Customer Priority + Delivery Planned"  style="cursor: pointer;"/>
                            <%
                            } else {
                                if (wic.getTechnicalHead().contains(assignedto)) {%>
                            <input type="checkbox" name="<%=isfb.getpId()%>pIssue" value="<%=isfb.getIssueId()%>"   style="vertical-align: middle;"><a href="<%=request.getContextPath()%>/MyAssignment/UpdateIssueview.jsp?issueid=<%=isfb.getIssueId()%>">
                                <%}%>
                                <%=isfb.getIssueId()%></a>
                                <%}%>
                        </td>
                        <td class="background"><%=isfb.getPriority()%></td>
                        <td class="background" title="<%=isfb.getpName()%>"><%=isfb.getRedPName()%></td>
                        <td class="background" width="7%" title="<%=isfb.getmName()%>"><%=isfb.getRedMName()%></td>
                        <td class="background" id="<%=isfb.getIssueId()%>tab" onmouseover="xstooltip_show('<%=isfb.getIssueId()%>', '<%=isfb.getIssueId()%>tab', 289, 49);" onmouseout="xstooltip_hide('<%=isfb.getIssueId()%>');" ><%=isfb.getSubject()%><div class="issuetooltip" id="<%=isfb.getIssueId()%>"><%= isfb.getDescription()%></div></td>
                        <td class="background" style="cursor: pointer;" onclick="showPrint('<%=isfb.getIssueId()%>')"><%=isfb.getStatus()%></td>
                        <td class="background" title="Last Modified On <%=isfb.getModifiedOn()%>"><font
                                face="Verdana, Arial, Helvetica, sans-serif" size="1" color="<%=isfb.getDueDateColor()%>"><%=isfb.getDueDate()%></td>
                        <td class="background" title=" <%=isfb.getCreatedBy()%> "><%=isfb.getAssignto()%></td>
                        <%if (isfb.getRefer().equalsIgnoreCase("No Files")) {%>
                        <td class="background" ><%=isfb.getRefer()%></td>
                        <%} else {%>
                        <td class="background" ><a onclick="viewFileAttachForIssue('<%=isfb.getIssueId()%>');" href="#"><%=isfb.getRefer()%></a></td>
                            <%}%>
                        <td class="background" title="<%=isfb.getAge()%>"><%=isfb.getLastAssigneeAge()%></td></tr>

                    <%
                        }%>
            </table>
        </div>
        <%if (wic.getTechnicalHead().contains(assignedto)) {%>
        <div style="text-align: center;padding:10px; "><input type="submit" id="btnSubmit" name="btnSubmit" value="Submit" /></div>
            <%}%>
    </form>
    <div id="MDAVpopup" class="popup">
        <h3 class="popupHeading">View Attached Files</h3>
        <div>
            <div class="clear"></div>
            <div class="tableshow">
                <div id="IssuePopupFiles">

                </div>
                <button class="custom-popup-close" onclick="closeIssuePopup();" type="button">close</button>

            </div>
        </div>
    </div>

    <script type="text/javascript">
        $('#pIds').multipleSelect({
            filter: true,
            maxHeight: 150

        }
        );
        $(function() {
            $("#accordion").accordion({
                collapsible: true,
                heightStyle: "content"

            });
        });
        function callProjectPlan()
        {
            var plannedForParam = $.trim($("#plannedForParam").val());
            var count = 0;
            var plannedFor = document.getElementById("plannedFor").value;
            if (plannedFor == "") {
                count++;
            } else if (plannedForParam.length == 0 && (plannedFor == 'Today')) {
                count++;
            } else if (plannedForParam == plannedFor) {
                count++;
            }
            if (count == 0) {
                if (document.getElementById("plannedFor") !== null) {
                    var plannedFor = document.getElementById("plannedFor").value;
                    document.wrmForm.action = '/eTracker/MOM/wrmIssues.jsp?plannedFor=' + plannedFor;
                } else {
                    document.wrmForm.action = '/eTracker/MOM/wrmIssues.jsp?plannedFor=' + plannedFor;
                }
                document.wrmForm.submit();
            } else {
                return false;
            }
        }
        function check()
        {
            var plannedFor = $.trim($("#plannedFor").val());
            if (plannedFor.length == 0) {
                alert('Please select planning for');
                return false;
            }
            var pIds = $.trim($("#pIds").val());
            if (pIds.length == 0) {
                alert('Select atlease one project');
                return false;
            }
            disableMomSubmit();
        }
        function callissue(issueid) {
            var team = '<%=team%>';
            var mail = '<%=url%>';
            var d = new Date();
            var n = d.getHours();
            if (mail === 'eminentlabs.net') {
                if (n > 8 && n < 18) {
                    var result;
                    $.ajax({url: '<%=request.getContextPath()%>/admin/project/checkPlannedSeq.jsp',
                        data: {issueid: issueid, random: Math.random(1, 10)},
                        async: true,
                        type: 'GET',
                        success: function(data) {
                            result = $.trim(data);
                        }, complete: function() {
                            if (result === '') {
                                location.href = '<%=request.getContextPath()%>/MyAssignment/UpdateIssueview.jsp?planSeq=yes&issueid=' + issueid;
                            } else {
                                alert(result);
                            }
                        }
                    });
                } else {
                    location.href = '<%=request.getContextPath()%>/MyAssignment/UpdateIssueview.jsp?planSeq=yes&issueid=' + issueid;

                }
            } else {
                location.href = '<%=request.getContextPath()%>/MyAssignment/UpdateIssueview.jsp?planSeq=yes&issueid=' + issueid;

            }
        }
    </script>
</body>
</html>
