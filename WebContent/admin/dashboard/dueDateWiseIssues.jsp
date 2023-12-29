<%-- 
    Document   : dueDateWiseIssues
    Created on : Jun 19, 2014, 3:54:30 PM
    Author     : E0288
--%>

<%@page import="com.eminent.issue.controller.ModuleIssuesChart"%>
<%@page import="java.util.Map"%>
<%@page import="com.eminent.issue.formbean.IssueFormBean"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    Logger logger = Logger.getLogger("dueDateWiseIssues");
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
        <script type="text/javascript" src="<%= request.getContextPath()%>/javaScript/tooltip.js"></script>
        <script type="text/javascript" src="<%= request.getContextPath()%>/javaScript/checkSubmit.js"></script>
<LINK title=STYLE href="<%= request.getContextPath()%>/eminentech support files/main_ie.css?test=261020151225" type="text/css" rel="STYLESHEET">
<script src="<%=request.getContextPath()%>/javaScript/XMLHttpRequest.js" type="text/javascript"></script>
<script type="text/javascript" src="<%= request.getContextPath()%>/javaScript/fileAttach.js"></script>        
    </head>
    <body>
        <%@ include file="/header.jsp"%>
        <%
            int roleId = (Integer) session.getAttribute("Role");
            if (roleId == 1) {
        %> 
        <jsp:useBean id="tcir" class="com.eminent.issue.TeamClosedIssueReport"></jsp:useBean>
        <jsp:useBean id="ddw" class="com.eminent.issue.controller.DueDateWise"></jsp:useBean>
        <% ddw.setAll(request);%>

        <form name="theForm" id="theForm" method="post" action="dueDateWiseIssues.jsp" onsubmit="disableSubmit();">
            <table cellpadding="0" cellspacing="0" width="100%">
                <tr bgcolor="#C3D9FF">
                    <td align="left" width="55%"><%=ddw.getNoOfChanges()%> Times Due date Changed <b><%=ddw.getChartType()%></b> Issues</b>
                        <select name="month" id="month">
                            <%for (Map.Entry<Integer, String> month : tcir.getMonths().entrySet()) {
                                    if (month.getKey() == ddw.getMonth()) {%>
                            <option value="<%=month.getKey()%>" selected=""><%=month.getValue()%></option>
                            <%} else {%>
                            <option value="<%=month.getKey()%>"><%=month.getValue()%></option>
                            <%}
                                }%>
                        </select>
                        <select name='year' id='year' >

                            <%for (Integer year : tcir.getYears()) {%>
                            <%if (year == ddw.getYear()) {%>
                            <option value="<%=year%>" selected=""><%=year%></option>
                            <%} else {%>   
                            <option value="<%=year%>"><%=year%></option>
                            <%}
                                }%>
                        </select>

                        <select name="noofChanges" id="noofChanges" >
                            <%for (Integer val : ddw.getDiffDueDateChanges()) {
                                    if (val.toString().equals(ddw.getNoOfChanges())) {%>
                            <option value="<%=val%>" selected><%=val%></option>
                            <% } else {
                            %>
                            <option value="<%=val%>"><%=val%></option>
                            <%}
                                }%>
                        </select>
                        <select name='chartType' id='chartType' >

                            <%for (String type : ModuleIssuesChart.getChartTypeList()) {%>
                            <%if (type.equals(ddw.getChartType())) {%>
                            <option value="<%=type%>" selected=""><%=type%></option>
                            <%} else {%>   
                            <option value="<%=type%>"><%=type%></option>
                            <%}
                                }%>
                        </select>
                        <input type="submit" id="submit" value="Submit" >
                    </td>
                    <td style="text-align: right;"><a  href="<%= request.getContextPath()%>/admin/user/apmPerformance.jsp">APM Performance</a>&nbsp;&nbsp;&nbsp;<a href="<%= request.getContextPath()%>/admin/dashboard/ageWiseIssueChart.jsp?month=<%=ddw.getMonth()%>&year=<%=ddw.getYear()%>">Age Wise</a>&nbsp;&nbsp;&nbsp;<a href="<%= request.getContextPath()%>/admin/dashboard/moduleWorkedIssuesChart.jsp?month=<%=ddw.getMonth()%>&year=<%=ddw.getYear()%>">Module Wise</a>&nbsp;&nbsp;&nbsp;<a style="font-weight: bold;"  href="<%= request.getContextPath()%>/admin/dashboard/dueDateChangeWise.jsp?month=<%=ddw.getMonth()%>&year=<%=ddw.getYear()%>">DueDate Wise</a>&nbsp;&nbsp;&nbsp;<a  href="<%= request.getContextPath()%>/admin/dashboard/dayWiseChart.jsp?month=<%=ddw.getMonth()%>&year=<%=ddw.getYear()%>">Day Wise</a></td>
                </tr>
            </table>
        </form>
        <br/>
        <div style="width: 100%;">The below list shows <%=ddw.getIssuesList().size()%>  closed issues with <%=ddw.getNoOfChanges()%> due date changes </div>
        <table width="100%" height="23">
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
                for (IssueFormBean isfb : ddw.getIssuesList()) {
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
                <td width="29%" id="<%=isfb.getIssueId()%>tab" onmouseover="xstooltip_show('<%=isfb.getIssueId()%>', '<%=isfb.getIssueId()%>tab', 289, 49);" onmouseout="xstooltip_hide('<%=isfb.getIssueId()%>');" ><div class="issuetooltip" id="<%=isfb.getIssueId()%>"><%= isfb.getDescription()%></div><%=isfb.getSubject()%></td>
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
