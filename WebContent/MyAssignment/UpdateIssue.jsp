<%@page import="com.eminent.issue.formbean.UserPlannedIssues"%>
<%@page import="com.eminent.issue.dao.EscalationDAOImpl"%>
<%@page import="com.eminent.issue.dao.EscalationDAO"%>
<%@page import="com.eminent.issue.formbean.IssueFormBean"%>
<%@page import="com.eminent.examples.BpmTest"%>
<%@page import="java.util.Map"%>
<%@ page import="org.apache.log4j.*"%>
<%@ page import="java.sql.*,com.eminent.tqm.TestCasePlan"%>
<%@ page import="java.text.*,com.eminentlabs.erm.ERMUtil"%>
<%@ page import="java.util.HashMap,java.util.List,com.eminent.leaveUtil.*,com.eminent.timesheet.*"%>
<%@ page import="pack.eminent.encryption.*, com.eminent.util.*, dashboard.*, com.pack.*"%>
<%@ page import="com.eminentlabs.appraisal.AppraisalUtil"%>
<%@ page autoFlush="true" buffer="1094kb"%> 
<%@ include file = "/include files/cacheRemover.jsp" %>
<%
    Logger logger = Logger.getLogger("UpdateIssue");
    String logoutcheck = (String) session.getAttribute("Name");
    if (logoutcheck == null) {
        logger.fatal("=========================Session Expired======================");
%>
<jsp:forward page="../SessionExpired.jsp"></jsp:forward>
<%
        //response.sendRedirect(request.getContextPath()+"/SessionExpired.jsp");
    }

%>
<HTML>
    <head>
        <meta name="keywords" content="GST in SAP, SAP GST Accelerator, GST Success in SAP, GST India in SAP, GST SAP Success, GST Suvidha Provider, GST ASP GSP, GST, CGST,SGST, IGST, UGST,  SAP NW based Product Development, SAP Consulting, SAP Implementation, SAP Support Services, SAP Outsourcing, SAP Implementation India, SAP Implementation Bangalore, SAP Implementation Chennai, SAP Implementation Belgium, SAP Implementation Paris, SAP Implemtation Australia, SAP Implementation France, SAP Implementation Mumbai, SAP Implementation Kerala, SAP Implementation Belgaum, SAP Implementation Thailand, SAP Implementation Mexico, SAP Implementation America">
        <TITLE>eTracker&#153; - Eminentlabs&#153; CRM, APM, TQM,  ERM and  EPTS Solution</TITLE>
        <meta http-equiv="X-UA-Compatible" content="IE=Edge">
        <LINK title=STYLE href="<%= request.getContextPath()%>/eminentech support files/main_ie.css?test=261020151225" type="text/css" rel="STYLESHEET">
        <script type="text/javascript" src="<%= request.getContextPath()%>/javaScript/checkSubmit.js"></script>
        <script type="text/javascript" src="<%= request.getContextPath()%>/javaScript/tooltip.js"></script>
        <script src="<%=request.getContextPath()%>/javaScript/XMLHttpRequest.js" type="text/javascript"></script>
        <script type="text/javascript" src="<%= request.getContextPath()%>/javaScript/fileAttach.js?test=261020151625"></script>
        <script src="<%=request.getContextPath()%>/javaScript/jquery.js" type="text/javascript"></script>
        <script type="text/javascript">
            function refreshLeft() {
                parent.treeframe.location.reload();
            }
        </script>
    </head>


    <body class="home-bg" onload="refreshLeft();" >

        <!--      <div class="Ajax-loder">
        
                <div class="bg"></div>
        
                <img class="loading" src="<%=request.getContextPath()%>/images/276 (1).GIF"
                     alt="loading...." /></div>-->
        <%@ include file="../header.jsp"%>
        <jsp:useBean id="CRMIssue" class="com.pack.CRMIssueBean" />

        <jsp:useBean id="mas" class="com.eminent.issue.formbean.MyAsignmentIssues" /> 
        <%   int i = 0;
            String team = (String) session.getAttribute("team");
            int userId = (Integer) session.getAttribute("uid");
            EscalationDAO escalationDAO = new EscalationDAOImpl();
            List<String> escalationIssues = escalationDAO.escalationList(0);
            mas.setAll(request);
            List<String> wrmIssueList = mas.getWrmIssueList();
            List<String> wrmTouchedIssues = mas.getWrmTouchedIssues();

            String mail = (String) session.getAttribute("theName");
            String url = null;
            if (mail != null) {
                url = mail.substring(mail.indexOf("@") + 1, mail.length());
            }

        %>

        <form name="theForm" onsubmit="return fun(this);"  action="<%= request.getContextPath()%>/Issuesummaryview.jsp">
            <table cellpadding="0" cellspacing="0" width="100%">
                <tr  bgcolor="#E8EEF7">
                    <td align="left"><b> APM Issues </b></td>
                    <td align="right"><b>Enter the Issue Number:</b></td>
                    <td align="left"><input type="text" name="issueid" maxlength="12"
                                            size="15"></td>
                    <td><input type="submit" name="submit" id="submit" value="Search"></td>

                    <td width="25%" border="1" align="right">
                        <%if (!mas.getUrl().equalsIgnoreCase("eminentlabs.net")) {%>
                        <font size="2"
                          facerdanaial, etica, sans-serif">Export to <a
                              href="<%=request.getContextPath()%>/excelExport.jsp?export=MyAssignment"
                              target="_blank">Excel</a></font>
                        <%}%>
                    </td>
                </tr>

            </table>
        </form>
        <%
            try {

                if (mas.getUrl().equalsIgnoreCase("eminentlabs.net")) {
        %>
        <table width="100%" border="0">
            <tr height="10" >
                <td align="left" colspan="10"><a href="<%=request.getContextPath()%>/MyAssignment/UpdateIssue.jsp?assignmentType=backlog"><%if (mas.getAssignmentType().equalsIgnoreCase("backlog")) {%><b style="color: blue;">Backlog(<%=mas.getbCount()%>)</b><%} else {%>Backlog(<%=mas.getbCount()%>)<%}%></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <a href="<%=request.getContextPath()%>/MyAssignment/UpdateIssue.jsp?assignmentType=currentWeek"><%if (mas.getAssignmentType().equalsIgnoreCase("currentWeek")) {%><b style="color: blue;">Current Week(<%=mas.getCuCount()%>)</b><%} else {%>Current Week(<%=mas.getCuCount()%>)<%}%></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <a href="<%=request.getContextPath()%>/MyAssignment/UpdateIssue.jsp?assignmentType=nextWeek"><%if (mas.getAssignmentType().equalsIgnoreCase("nextWeek")) {%><b style="color: blue;">Next Week(<%=mas.getNxCount()%>)</b><%} else {%>Next Week(<%=mas.getNxCount()%>)<%}%></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <a href="<%=request.getContextPath()%>/MyAssignment/UpdateIssue.jsp?assignmentType=afterTwoWeeks"><%if (mas.getAssignmentType().equalsIgnoreCase("afterTwoWeeks")) {%><b style="color: blue;">After two weeks(<%=mas.getAtCount()%>)</b><%} else {%>After two weeks(<%=mas.getAtCount()%>)<%}%></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <a href="<%=request.getContextPath()%>/MyAssignmassignmentType=all"><%if (mas.getAssignmentType().equalsIgnoreCase("all")) {%><b style="color:blue;">All(<%=mas.getAlCount()%>)<%} else {%>All(<%=mas.getAlCount()%>)<%}%></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
               
                
                
                </td><td width="25%" border="1" align="right"><font size="2"
                                                                                                                                                                                                        face="Verdana, Arial, Helvetica, sans-serif">Export to <a
                                                                                                                                                                                                        href="<%=request.getContextPath()%>/excelExport.jsp?export=MyAssignment&assignmentType=<%=mas.getAssignmentType()%>"
                                                                                                                                                                                                        target="_blank">Excel</a></font></td>
            </tr>
        </table>
        <% }
        %>


        <table width="100%" border="0">
            <tr>
                <td style="width: 15%;">&nbsp;</td>
                <% if (mas.getUrl().equalsIgnoreCase("eminentlabs.net")) {%>
                          <% if (userId == 6332) {%>
                <TD align="right" width="8%"><a href="<%=request.getContextPath()%>/admin/project/gstLogs.jsp" style="cursor: pointer;font-weight: bold;">GST 3in1 Cockpit</a></TD>
                    <%}
                        if (mas.getResourceRequest() > 0) {%>
                <TD align="right" width="8%">You have <a href="<%=request.getContextPath()%>/ResourceRequest/viewResourceRequest.jsp "><%=mas.getResourceRequest()%></a> ERM Issues</TD>
                    <%}
                        if (mas.getNoOfTce() > 0) {%>
                <TD align="left" width="8%">You have <a href="<%=request.getContextPath()%>/MyAssignment/listTestCases.jsp"><%=mas.getNoOfTce()%></a> Test Cases</TD>
                    <%}
                        if (mas.getCrmIssues() > 0) {%>
                <TD align="right" width="8%">You have <a href="<%=request.getContextPath()%><%=mas.getFor_ward()%>"><%=mas.getCrmIssues()%></a> CRM Issues</TD>
                    <%}
                        if (mas.getNoOfRequests() > 0) {
                    %>
                <TD align="right" width="10%">You have <a href="<%=request.getContextPath()%>/UserProfile/editLeaveRequest.jsp "><%=mas.getNoOfRequests()%></a> Leave Request</TD>
                    <%
                        }
                        if (mas.getNoOfTimeSheet() > 0) {
                    %>
                <TD align="left" width="11%">You have <a href="<%=request.getContextPath()%>/MyTimeSheet/timeSheetList.jsp "><%=mas.getNoOfTimeSheet()%></a> TimeSheet Request</TD>
                    <%
                        }
                        if (mas.getAppraisalReq() > 0) {
                    %>
                <TD align="left" width="11%">You have <a href="<%=request.getContextPath()%>/MyAssignment/viewAppraisal.jsp "><%=mas.getAppraisalReq()%></a> Appraisal Request</TD>
                    <%
                        }
                        if (mas.getErmAssignment() > 0) {
                    %>
                <TD align="left" width="11%">You have <a href="<%=request.getContextPath()%>/ERM/assignedApplicants.jsp "><%=mas.getErmAssignment()%></a> Candidate </TD>
                    <%}
                        }%>
                <TD align="right" width="2%">Severity</TD>
                <TD align="right" width="1%" bgcolor="#FF0000">S1</TD>
                <TD align="right" width="1%" bgcolor="#DF7401">S2</TD>
                <TD align="right" width="1%" bgcolor="#F7FE2E">S3</TD>
                <TD align="right" width="1%" bgcolor="#04B45F">S4</TD>
            </tr>
        </table>
        <br/>
        <div class="tablecontent">
            <table width="100%" id="searchTable" class="tablesorter">
                <thead>
                    <tr bgcolor="#C3D9FF" height="21">                 
                        <th width="1%" TITLE="Severity" ><font><b>S</b></font></th>
                        <th width="10%"><font><b>Issue No</b></font></th>
                        <th width="2%" TITLE="Priority" class="filter-false"><font><b>P</b></font></th>
                        <th width="10%" class="filter-select filter-match" data-placeholder="Select a Project"><font><b>Project</b></font></th>
                        <th width="7%" class="filter-select filter-match" data-placeholder="Select a Module"><font><b>Module</b></font></th>
                        <th width="28%"><font><b>Subject</b></font></th>
                        <th width="9%" class="filter-select filter-match" data-placeholder="Select a Status"><font><b>Status</b></font></th>
                        <th width="8%" class="filter-false"><font><b>Due Date</b></font></th>
                        <th width="13%" class="filter-select filter-match" data-placeholder="Select Created By"><font><b>Created By</b></font></th>
                        <th width="8%" class="filter-false"><font><b>Refer</b></font></th>
                        <th width="5%" TITLE="In Days" ALIGN="center"><font><b>Age</b></font></th>

                    </tr>
                </thead>


                <tbody>
                    <%

                        String escalationColor = "";
                        for (IssueFormBean isfb : mas.getIssuesList()) {
                            escalationColor = "";
                            if (escalationIssues.contains(isfb.getIssueId())) {
                                escalationColor = "red";
                            }
                            if ((i % 2) != 0) {
                    %>
                    <tr class="zebralinealter" height="21">
                        <%} else {%>
                    <tr class="zebraline" height="21">
                        <%}
                            i++;%>

                        <td class="background" style="background: <%=isfb.getSeverity()%>">
                            <%for (UserPlannedIssues u : mas.getPlannedIssuesList()) {
                                    if (u.getIssueno().equals(isfb.getIssueId())) {%> <%=u.getSino()%> <%}
                                        }%>
                        </td>
                <input type="hidden" id="sorton" name="sorton"/>
                <input type="hidden" id="sort_method" name="sort_method"/>
                <td class="background"  title="<%=isfb.getType()%>"><a href="javascript:callissue('<%=isfb.getIssueId()%>')" style="visibility: visible"><%=isfb.getIssueId()%>

                    </a><%--<a href="<%=request.getContextPath()%>/MyAssignment/UpdateIssueview.jsp?issueid=z<%=isfb.getIssueId()%>">

                                <%=isfb.getIssueId()%></a>--%><%
                                    for (UserPlannedIssues u : mas.getPlannedIssuesList()) {
                                        if (u.getIssueno().equals(isfb.getIssueId())) {
                    %>
                    <img src="<%=request.getContextPath()%>/images/tick.png"  title="Customer Priority + Delivery Planned"  style="cursor: pointer;"/> 
                    <%
                            }
                        }%><%if (wrmIssueList.contains(isfb.getIssueId())) {
                    %>
                    <img src="<%=request.getContextPath()%>/images/exclamation.png"   title="WRM Planned Issue"  style="cursor: pointer;height: 9px;"/>
                    <%if (!wrmTouchedIssues.contains(isfb.getIssueId())) {%>
                    <img src="<%=request.getContextPath()%>/images/Bomb.png"  title="WRM Untouched"  style="cursor: pointer;vertical-align: middle;"/>
                    <% }
                        }%></td>
                <td class="background"  ><%=isfb.getPriority()%></td>
                <td class="background"   title="<%=isfb.getpName()%>"><%=isfb.getRedPName()%></td>
                <td class="background"  width="7%" title="<%=isfb.getmName()%>"><%=isfb.getRedMName()%></td>
                <td class="background"   id="<%=isfb.getIssueId()%>tab" onmouseover="xstooltip_show('<%=isfb.getIssueId()%>', '<%=isfb.getIssueId()%>tab', 289, 49);" onmouseout="xstooltip_hide('<%=isfb.getIssueId()%>');" ><FONT color="<%=escalationColor%>"><%=isfb.getSubject()%></FONT><div class="issuetooltip" id="<%=isfb.getIssueId()%>"><%= isfb.getDescription()%></div></td>
                <td class="background"  onclick="showPrint('<%=isfb.getIssueId()%>');" style="cursor: pointer;"><%=isfb.getStatus()%></td>
                <td class="background"  title="Last Modified On <%=isfb.getModifiedOn()%>"><font
                        face="Verdana, Arial, Helvetica, sans-serif" size="1" color="<%=isfb.getDueDateColor()%>"><%=isfb.getDueDate()%></td>
                <td class="background"  title="Assignedby <%=isfb.getLastAssigneeName()%> at <%=isfb.getLastModifiedOn()%>"><FONT color="<%=escalationColor%>"><%=isfb.getCreatedBy()%></FONT></td>
                    <%if (isfb.getRefer().equalsIgnoreCase("No Files")) {%>
                <td class="background" ><%=isfb.getRefer()%></td>
                <%} else {%>
                <td class="background" ><a onclick="viewFileAttachForIssue('<%=isfb.getIssueId()%>');" href="#"><%=isfb.getRefer()%></a></td>
                    <%}%>
                <td class="background"  title="<%=isfb.getAge()%>"><%=isfb.getLastAssigneeAge()%></td></tr>
                <%
                    }%>
            </table>

        </div>

        <%                           if (i > 0) {
            } else if (mas.getNoOfTimeSheet() > 0) {
        %>
        <jsp:forward page="/MyTimeSheet/timeSheetList.jsp"/>

        <%} else if (mas.getNoOfRequests() > 0) {
        %>

        <jsp:forward page="/UserProfile/editLeaveRequest.jsp"/>
        <%} else if (mas.getCrmIssues() > 0) {
        %>
        <jsp:forward page="<%=mas.getFor_ward()%>"/>
        <%} else if (mas.getNoOfTce() > 0) {
        %>
        <jsp:forward page="/MyAssignment/listTestCases.jsp"/>
        <%} else if (mas.getResourceRequest() > 0) {
        %>
        <jsp:forward page="/ResourceRequest/viewResourceRequest.jsp"/>
        <%} else if (mas.getErmAssignment() > 0) {
        %>
        <jsp:forward page="/ERM/assignedApplicants.jsp"/>
        <%} else {%>
        <jsp:forward page="/admin/dashboard/chartForUsers.jsp"/>
        <%}
            } catch (Exception e) {
                logger.error("Exception:" + e);
                logger.error(e.getMessage());
            }
        %>
    </TABLE>

    <SCRIPT language="JavaScript">

        /** Java Script Function For Trimming A String To Get Only The Required String Input */

        function trim(str) {
            while (str.charAt(str.length - 1) === " ")
                str = str.substring(0, str.length - 1);
            while (str.charAt(0) === " ")
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
                    if (str.charAt(i) === pattern.charAt(j)) {
                        pos = 1;
                        break;
                    }
                i++;
            } while (pos === 1 && i < str.length)
            if (pos === 0)
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
                if (bag.indexOf(c) === -1)
                    returnString += c;
            }
            return returnString;
        }

        function daysInFebruary(year)
        {
            return (((year % 4 === 0) && ((!(year % 100 === 0)) || (year % 400 === 0))) ? 29 : 28);
        }
        function DaysArray(n)
        {
            for (var i = 1; i <= n; i++)
            {
                this[i] = 31;
                if (i === 4 || i === 6 || i === 9 || i === 11) {
                    this[i] = 30;
                }
                if (i === 2) {
                    this[i] = 29;
                }
            }
            return this;
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

            if (!isPositiveInteger(trim(theForm.issueid.value))) {
                alert('Enter Issue NO in proper format like EDDMMYYYY001');
                document.theForm.issueid.value = "";
                theForm.issueid.focus();
                return false;
            }

            if (!isDate(trim(theForm.issueid.value))) {
                document.theForm.issueid.value = "";
                theForm.issueid.focus();
                return false;
            }
            if ((trim(theForm.issueid.value).length) < 12) {
                alert('Size of the Issue No should be 12 characters ');
                document.theForm.issueid.value = "";
                theForm.issueid.focus();
                return false;
            }
            if ((trim(theForm.issueid.value).length) > 12) {
                alert('Size of the Issue No should be 12 characters ');
                document.theForm.issueid.value = "";
                theForm.issueid.focus();
                return false;
            }

            if ((theForm.issueid.value === null) || (theForm.issueid.value === ""))
            {
                alert("Please Enter the Issue Number");
                theForm.issueid.focus();
                return false;
            }
            if (isDate(theForm.issueid.value) === false) {
                return false;
            }
            disableSubmit();
            return true;
        }

        /** Function To Set Focus On The First Name Field In The Form */

        function setFocus() {
            document.theForm.issueid.focus();
        }

        window.onload = setFocus;</SCRIPT>
    <SCRIPT type="text/javascript" 	src="https://ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>


    <script type="text/javascript">
        
        function showPrint(issueid) {
            window.open("<%=request.getContextPath()%>/viewIssueDetails.jsp?issueid=" + issueid);
        }

        function callissue(issueid) {
            var team = '<%=team%>';
            var mail = '<%=url%>';
            var d = new Date();
            var n = d.getHours();
            var sorton;
            var sort_method;
            var headerSortDown = $('.tablesorter-headerAsc').text();
            var headerSortUp = $(".tablesorter-headerDesc").text();
            if (headerSortDown.length > 0) {
                sorton = headerSortDown;
                sort_method = "headerSortDown";
            } else if (headerSortUp.length > 0) {
                sorton = headerSortUp;
                sort_method = "headerSortUp";
            }

            document.getElementById("sorton").value = sorton;
            document.getElementById("sort_method").value = sort_method;

            if (mail === 'eminentlabs.net') {
                if (n > 8 && n < 18) {
                    var res;
                    $.ajax({url: '<%=request.getContextPath()%>/admin/project/checkPlannedSeq.jsp',
                        data: {issueid: issueid, random: Math.random(1, 10)},
                        async: true,
                        type: 'GET',
                        success: function (data) {
                            res = $.trim(data);
                        }, complete: function () {
                            if (res === '') {
                                if (team === 'BASIS') {
                                   var  result;
                                    $.ajax({url: '<%=request.getContextPath()%>/admin/project/checkMonitoringIssue.jsp',
                                        data: {issueid: issueid, random: Math.random(1, 10)},
                                        async: true,
                                        type: 'GET',
                                        success: function (data) {
                                            result = $.trim(data);
                                        }, complete: function () {
                                            if (result === '0') {
                                                location.href = '<%=request.getContextPath()%>/MyAssignment/UpdateIssueview.jsp?issueid=' + issueid + '&sorton=' + sorton + '&sort_method=' + sort_method + '&userin=MyAssignment&planSeq=yes';
                                            } else {
                                                var resulta = result.split('-');
                                                location.href = '<%=request.getContextPath()%>/admin/project/updateParameter.jsp?pid=' + resulta[0] + '&companyCode=' + resulta[1];
                                            }
                                        }
                                    });
                                } else {
                                    location.href = '<%=request.getContextPath()%>/MyAssignment/UpdateIssueview.jsp?issueid=' + issueid + '&sorton=' + sorton + '&sort_method=' + sort_method + '&userin=MyAssignment&planSeq=yes';
                                }
                            } else {
                                alert(res);
                            }
                        }
                    });
                } else {
                    location.href = '<%=request.getContextPath()%>/MyAssignment/UpdateIssueview.jsp?issueid=' + issueid + '&sorton=' + sorton + '&sort_method=' + sort_method + '&userin=MyAssignment&planSeq=yes';

                }

            } else {
                location.href = '<%=request.getContextPath()%>/MyAssignment/UpdateIssueview.jsp?issueid=' + issueid + '&sorton=' + sorton + '&sort_method=' + sort_method + '&userin=MyAssignment&planSeq=yes';
            }
        }

    </script>
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
</BODY>
<script src="<%=request.getContextPath()%>/javaScript/jquery.tablesorter1.js" type="text/javascript"></script>
<script src="<%=request.getContextPath()%>/javaScript/jquery.tablesorter.widgets.js" type="text/javascript"></script>    
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/theme.blue1.css?test=3">
<script type="text/javascript">

                    /*  $(document).ready(function () {
                     $('.tablecontent').jscroll({
                     padding: 20,
                     loadingHtml: '<img class="imgloader" src="<%=request.getContextPath()%>/images/ajax-loader_1.gif"/>',
                     contentLoader: '.tablecontent #searchTable tbody tr:last',
                     nextSelector: 'a.jscroll-next:last'
                     });
                     });
                     
                     */
                    $.tablesorter.addParser({
                        id: "ddMMMyy",
                        is: function (s) {
                            return false;
                        },
                        format: function (s, table) {
                            var from = s.split("-");
                            var year = "20" + from[2];
                            var mon = from[1];
                            var month = new Date(Date.parse(mon + " 1," + year)).getMonth();
                            return new Date(year, month, from[0]).getTime() || '';
                        },
                        type: "numeric"
                    });

                    $(document).ready(function () {

                        $("#searchTable").tablesorter({
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
                                }, filter_formatter: {
                                    6: function ($cell, indx) {
                                        return $.tablesorter.filterFormatter.select2($cell, indx, {
                                            match: false // exact match only
                                        });
                                    }
                                }

                            }

                        });

                    });



</script>
</HTML>



