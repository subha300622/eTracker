<%-- 
    Document   : myERMDashBoard
    Created on : Feb 17, 2014, 2:10:40 PM
    Author     : E0288
--%>

<%@page import="com.eminent.tqm.TestCasePlan"%>
<%@page import="com.eminentlabs.appraisal.AppraisalUtil"%>
<%@page import="com.eminent.timesheet.CreateTimeSheet"%>
<%@page import="com.eminent.leaveUtil.LeaveUtil"%>
<%@page import="pack.eminent.encryption.MakeConnection"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.util.Map"%>
<%@page import="com.eminentlabs.erm.ERMUtil"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <meta name="keywords" content="GST in SAP, SAP GST Accelerator, GST Success in SAP, GST India in SAP, GST SAP Success, GST Suvidha Provider, GST ASP GSP, GST, CGST,SGST, IGST, UGST,  SAP NW based Product Development, SAP Consulting, SAP Implementation, SAP Support Services, SAP Outsourcing, SAP Implementation India, SAP Implementation Bangalore, SAP Implementation Chennai, SAP Implementation Belgium, SAP Implementation Paris, SAP Implemtation Australia, SAP Implementation France, SAP Implementation Mumbai, SAP Implementation Kerala, SAP Implementation Belgaum, SAP Implementation Thailand, SAP Implementation Mexico, SAP Implementation America">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>eTracker&#153; - Eminentlabs&#153; CRM, APM, TQM,  ERM and  EPTS
        Solution</title>
    <LINK title=STYLE
          href="<%= request.getContextPath()%>/eminentech support files/main_ie.css"
          type="text/css" rel=STYLESHEET>
    <script type="text/javascript" src="<%=request.getContextPath()%>/fusion/fusioncharts.js?version=30032016"></script>
</head>
<body>
    <%@ include file="/header.jsp"%>
    <table cellpadding="0" cellspacing="0" width="100%">
        <tr bgColor="#C3D9FF">
            <td bgcolor="#C3D9FF" align="left" width="100%"><font
                    size="4" COLOR="#0000FF"><b>My Dashboard </b></font></td>
        </tr>
    </table>
    <jsp:useBean id="ResourceRequest" class="com.eminent.resource.ResourceRequestBean" />
    <jsp:useBean id="CRMIssue" class="com.pack.CRMIssueBean" /> 
    <%
        Integer user = (Integer) session.getAttribute("userid_curr");

        Connection connection = null;
        connection = MakeConnection.getConnection();

    %>
    <table width="100%" >
        <tr height="10">

            <%                        int resourceRequest = ResourceRequest.getResourceRequestNo(connection, user);
                String leaveDetails[][] = LeaveUtil.waitingForApproval(user);
                int noOfRequests = leaveDetails.length;
                List l = CreateTimeSheet.GetTimeSheet(user);
                int noOfTimeSheet = l.size();
                int ermAssignment = ERMUtil.getAssignedApplicantCount(user);
                int appraisalReq = AppraisalUtil.getNoOfAppraisalRequest(user);

                // List tce          =   TestCasePlan.listUserExecutionCountJDBC(user);
                int noOfTce = TestCasePlan.listUserExecutionCountJDBC(user);
                if (resourceRequest > 0) {%>
            <TD align="left" width="10%">You have <a href="<%=request.getContextPath()%>/ResourceRequest/viewResourceRequest.jsp "><%=resourceRequest%></a> ERM Issues</TD>
                <%}
                    if (noOfTce > 0) {%>
            <TD align="left" width="10%">You have <a href="<%=request.getContextPath()%>/MyAssignment/listTestCases.jsp?userId=<%=user%>"><%=noOfTce%></a> Test Cases</TD>
                <%}

                    if (noOfRequests > 0) {
                %>
            <TD align="left" width="10%">You have <a href="<%=request.getContextPath()%>/UserProfile/editLeaveRequest.jsp?userId=<%=user%>"><%=noOfRequests%></a> Leave Requests</TD>
                <%
                    }
                    if (noOfTimeSheet > 0) {
                %>
            <TD align="left" width="10%">You have <a href="<%=request.getContextPath()%>/MyTimeSheet/timeSheetList.jsp?userId=<%=user%> "><%=noOfTimeSheet%></a> TimeSheet Requests</TD>
                <%
                    }
                    if (appraisalReq > 0) {
                %>
            <TD align="left" width="11%">You have <a href="<%=request.getContextPath()%>/MyAssignment/viewAppraisal.jsp "><%=appraisalReq%></a> Appraisal Request</TD>
                <%
                    }
                    if (ermAssignment > 0) {
                %>
            <TD align="left" width="11%">You have <a href="<%=request.getContextPath()%>/ERM/assignedApplicants.jsp "><%=ermAssignment%></a> Candidate </TD>
                <%
                    }

                %>


        </tr>
    </table>

    <%            Map<Integer, Integer> applicantByStatus = ERMUtil.getAssignedApplicantByStaus(user);
        Map<Integer, String> applicantByStatuses = ERMUtil.ermApplicantStatus();
        if (applicantByStatus.size() == 0) {
    %>
    <table width="100%" height="60%" border="0" cellpadding="0"
           align="center">
        <tr>
            <td>
        <center>There are no issues</center>
    </td>
</tr>
</table>
<%
} else {
%>

<script type="text/javascript">
    FusionCharts.ready(function () {
        var ageGroupChart = new FusionCharts({
            type: 'pie3d',
            renderAt: 'chart-container2',
            width: '850',
            height: '500',
            dataFormat: 'json',
            dataSource: {
                "chart": {
                    "caption": "ERM status wise dashboard",
//                                    "paletteColors": "#0075c2,#1aaf5d,#f2c500,#f45b00,#8e0000",
                    "bgColor": "#ffffff",
                    "use3DLighting": "0",
                    "showShadow": "0",
                    "pieslicedepth": "30",
                    "enableSmartLabels": "0",
                    "startingAngle": "0",
                    "showPercentValues": "1",
                    "showPercentInTooltip": "0",
                    "decimals": "1",
                    "captionFontSize": "14",
                    "subcaptionFontSize": "14",
                    "subcaptionFontBold": "0",
                    "toolTipColor": "#ffffff",
                    "toolTipBorderThickness": "0",
                    "toolTipBgColor": "#000000",
                    "toolTipBgAlpha": "80",
                    "toolTipBorderRadius": "2",
                    "toolTipPadding": "5",
                    "showHoverEffect": "1",
                    "showLegend": "1",
                    "legendBgColor": "#ffffff",
                    "legendBorderAlpha": '0',
                    "legendShadow": '0',
                    "legendItemFontSize": '10',
                    "legendPosition": "RIGHT",
                    "exportEnabled": "1",
                    "legendItemFontColor": '#666666'
                },
                "data": [
    <%
        for (Map.Entry<Integer, Integer> entry : applicantByStatus.entrySet()) {
    %>
                    {
                        "label": "<%=applicantByStatuses.get(entry.getKey())%>",
                        "value": "<%= entry.getValue()%>",
                        "link": '<%= request.getContextPath()%>/ERM/assignedApplicants.jsp?applicantStatus=<%=entry.getKey()%>'
                                            },
    <%}%>
                                        ]
                                    }
                                }
                                );
                                ageGroupChart.render();
                            });</script>
<!--  Displaying pie chart for the project -->
<div id="chart-container2" class="chartarea">FusionCharts XT will load here!</div>
<%
    }


%>
<script src="//code.jquery.com/jquery-1.10.2.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/fusion/fusiontrailremover.js"></script>
</body>
</html>
