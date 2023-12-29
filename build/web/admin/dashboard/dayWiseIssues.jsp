<%-- 
    Document   : dayWiseIssues
    Created on : Jun 18, 2014, 3:12:42 PM
    Author     : E0288
--%>

<%@page import="com.eminent.issue.formbean.IssueFormBean"%>
<%@page import="com.eminent.issue.controller.ModuleIssuesChart"%>
<%@page import="com.eminent.issue.controller.AgeWiseIssues"%>
<%@page import="java.util.Map"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<!DOCTYPE html>
<%
    Logger logger = Logger.getLogger("ageWiseIssues");
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
        <script type="text/javascript" src="<%= request.getContextPath()%>/javaScript/checkSubmit.js"></script>
        <script type="text/javascript" src="<%= request.getContextPath()%>/javaScript/tooltip.js"></script>
<LINK title=STYLE href="<%= request.getContextPath()%>/eminentech support files/main_ie.css?test=261020151225" type="text/css" rel="STYLESHEET">
<script src="<%=request.getContextPath()%>/javaScript/XMLHttpRequest.js" type="text/javascript"></script>
<script type="text/javascript" src="<%= request.getContextPath()%>/javaScript/fileAttach.js"></script>
        <script type="text/javascript">
            function GetMonDays(month,Year)//Get number of days in a month
            {
                var DaysInMonth = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
                if (IsLeapYear(Year))
                {
                    DaysInMonth[1] = 29;
                }
                return DaysInMonth[month];
            }
            

            function IsLeapYear(Year)
            {
                if ((Year % 4) == 0)
                {
                    if ((Year % 100 == 0) && (Year % 400) != 0)
                    {
                        return false;
                    }
                    else
                    {
                        return true;
                    }
                }
                else
                {
                    return false;
                }
            }
            function validate() {
                var month = document.getElementById("month").value;
                var year = document.getElementById("year").value;
                var days = GetMonDays(month, year);
                var chartDate = document.getElementById("chartDate").value;
                if (new Number(chartDate) > days) {
                    alert('Please select valid day');
                    return false;
                }
                disableSubmit();
            }

        </script>
    </head>
    <body>
        <%@ include file="/header.jsp"%>
        <%
            int roleId = (Integer) session.getAttribute("Role");
            if (roleId == 1) {
        %> 
        <jsp:useBean id="tcir" class="com.eminent.issue.TeamClosedIssueReport"></jsp:useBean>
        <jsp:useBean id="dwc" class="com.eminent.issue.controller.DaywiseChart"></jsp:useBean>
        <%dwc.setAll(request);%>
        <form name="theForm" id="theForm" method="post" action="dayWiseIssues.jsp" onsubmit="return validate();">    
            <table cellpadding="0" cellspacing="0" width="100%">
                <tr bgcolor="#C3D9FF">
                    <td align="left" width="52%"><font size="4" COLOR="#0000FF"><b><%=dwc.getChartType()%> Issues for </b></font><FONT SIZE="3" COLOR="#0000FF"></FONT>
                        <select name="month" id="month">
                            <%for (Map.Entry<Integer, String> month : tcir.getMonths().entrySet()) {
                                    if (month.getKey() == dwc.getMonth()) {%>
                            <option value="<%=month.getKey()%>" selected=""><%=month.getValue()%></option>
                            <%} else {%>
                            <option value="<%=month.getKey()%>"><%=month.getValue()%></option>
                            <%}
                                }%>
                        </select>
                        <select name='year' id='year' >

                            <%for (Integer year : tcir.getYears()) {%>
                            <%if (year == dwc.getYear()) {%>
                            <option value="<%=year%>" selected=""><%=year%></option>
                            <%} else {%>   
                            <option value="<%=year%>"><%=year%></option>
                            <%}
                                }%>
                        </select>
                        <select name='chartDate' id='chartDate'>

                            <%for (int i = 1; i <= 31; i++) {
                                    String val = String.valueOf(i);
                                    if (i < 10) {
                                        val = "0" + val;
                                    }
                                    if (val.equals(dwc.getChartDate())) {%>
                            <option value="<%=val%>" selected=""><%=val%></option>
                            <%} else {%>   
                            <option value="<%=val%>"><%=val%></option>
                            <%}
                                }%>
                        </select>
                        <select name='chartType' id='chartType' >

                            <%for (String type : ModuleIssuesChart.getChartTypeList()) {%>
                            <%if (type.equals(dwc.getChartType())) {%>
                            <option value="<%=type%>" selected=""><%=type%></option>
                            <%} else {%>   
                            <option value="<%=type%>"><%=type%></option>
                            <%}
                                }%>
                        </select>
                        <input type="submit" id="submit" value="Submit" ></td>
<td style="text-align: right;"><a href="<%= request.getContextPath() %>/admin/user/apmPerformance.jsp">APM Performance</a>&nbsp;&nbsp;&nbsp;<a href="<%= request.getContextPath() %>/admin/dashboard/ageWiseIssueChart.jsp?month=<%=dwc.getMonth()%>&year=<%=dwc.getYear()%>">Age Wise</a>&nbsp;&nbsp;&nbsp;<a href="<%= request.getContextPath() %>/admin/dashboard/moduleWorkedIssuesChart.jsp?month=<%=dwc.getMonth()%>&year=<%=dwc.getYear()%>">Module Wise</a>&nbsp;&nbsp;&nbsp;<a  href="<%= request.getContextPath()%>/admin/dashboard/dueDateChangeWise.jsp?month=<%=dwc.getMonth()%>&year=<%=dwc.getYear()%>">DueDate Wise</a>&nbsp;&nbsp;&nbsp;<a style="font-weight: bold;" href="<%= request.getContextPath()%>/admin/dashboard/dayWiseChart.jsp?month=<%=dwc.getMonth()%>&year=<%=dwc.getYear()%>">Day Wise</a></td>
                </tr>
            </table>
        </form>
        <div style="width: 100%;">The below list shows <%=dwc.getIssuesList().size()%> <b><%=dwc.getChartType()%></b>  issues for <b><%=dwc.getChartDate()%>-<%=tcir.getMonths().get(dwc.getMonth())%>-<%=dwc.getYear()%></b> </div>
        <table width="100%" height="23"  >
            <TR bgcolor="#C3D9FF" height="21">
                <td style="background-color: #C3D9FF;" width="1%" TITLE="Severity"><font><b>S</b></font></td>
                <td width="11%"><font><b>Issue No</b></font></td>
                <td width="2%" TITLE="Priority"><font><b>P</b></font></td>
                <td width="7%"><font><b>Project</b></font></td>
                <td width="7%"><font><b>Module</b></font></td>
                <td width="28%"><font><b>Subject</b></font></td>
                <td width="11%"><font><b>Status</b></font></td>
                <td width="10%"><font><b>Due Date</b></font></td>
                <td width="11%"><font><b>AssignedTo</b></font></td>
                <td width="8%"><font><b>Refer</b></font></td>
                <td width="4%" TITLE="In Days"><font><b>Age</b></font></td>

            </TR>
            <%int i = 0;
                for (IssueFormBean isfb : dwc.getIssuesList()) {
                    if ((i % 2) != 0) {
            %>
            <tr bgcolor="#E8EEF7" height="21">
                <%} else {%>
            <tr bgcolor="white" height="21">
                <%                    }
                    i++;%>
                <td width="1%" bgcolor="<%=isfb.getSeverity()%>"></td>
                <td width="11%" title="<%=isfb.getType()%>"><a href="${pageContext.servletContext.contextPath}/Issuesummaryview.jsp?issueid=<%=isfb.getIssueId()%>"><%=isfb.getIssueId()%></a></td>
                <td width="3%"><%=isfb.getPriority()%></td>
                <td width="12%" title="<%=isfb.getpName()%>"><%=isfb.getRedPName()%></td>
                <td width="7%" title="<%=isfb.getmName()%>"><%=isfb.getRedMName()%></td>
                <td width="7%" id="<%=isfb.getIssueId()%>tab" onmouseover="xstooltip_show('<%=isfb.getIssueId()%>', '<%=isfb.getIssueId()%>tab', 289, 49);" onmouseout="xstooltip_hide('<%=isfb.getIssueId()%>');" ><div class="issuetooltip" id="<%=isfb.getIssueId()%>"><%= isfb.getDescription()%></div><%=isfb.getSubject()%></td>
                <td width="9%" bgcolor="<%=isfb.getRatingColor()%>" title="<%=isfb.getFeedback()%>"> <%=isfb.getStatus()%></td>
                <td width="9%" title="Last Modified On <%=isfb.getModifiedOn()%>"><font
                        face="Verdana, Arial, Helvetica, sans-serif" size="1" color="<%=isfb.getDueDateColor()%>"><%=isfb.getDueDate()%></td>
                <td width="10%" title="Created By <%=isfb.getCreatedBy()%>"><%=isfb.getAssignto()%></td>
                <%if (isfb.getRefer().equalsIgnoreCase("No Files")) {%>
                <td width="7%"><%=isfb.getRefer()%></td>
                <%} else {%>
                <td width="7%"><a onclick="viewFileAttachForIssue('<%=isfb.getIssueId()%>');" href="#"><%=isfb.getRefer()%></a></td>
                    <%}%>
                <td width="5%" title="<%=isfb.getLastAssigneeAge()%>"><%=isfb.getAge()%></td></tr>
                <%}%>
        </table>
         <%} else {%>
        <BR>
        <table align="center">
            <tr align="center" ><td><font color="red">You are not authorised to access this page.</font></td></tr>
        </table>
        <%}%>
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
    </body>
</html>
