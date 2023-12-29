<%-- 
    Document   : newjsp
    Created on : 12 Feb, 2016, 4:51:45 PM
    Author     : admin
--%>
<%@page import="com.eminent.util.GetProjectMembers"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<%
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Cache-Control", "no-store");
    response.setDateHeader("Expires", 0);
    response.setHeader("Pragma", "no-cache");

    Logger logger = Logger.getLogger("ServerLog");
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
        <meta http-equiv="X-UA-Compatible" content="IE=Edge">
        <link title=STYLE href="<%=request.getContextPath()%>/eminentech support files/main_ie.css?test=17" type="text/css" rel="STYLESHEET"/>
        <link rel="stylesheet" href="<%=request.getContextPath()%>/css/theme.blue.css?test=3">
        <title>Server log</title>
    </head>
    <body>
        <%@ include file="../header.jsp"%>
        <% int assignedto = (Integer) session.getAttribute("userid_curr");
            String userid = Integer.toString(assignedto);
            String pid = "10043";
            String project = "eTracker:3.0";
            boolean projectAccess = GetProjectMembers.isAssigned(userid, pid);
            if (projectAccess == true) {
        %>
        <!-- edit by mukesh-->
        <div style="height: 21px;background-color: #C3D9FE;font-weight: bold;padding: 1px;margin-top: 12px;"><span>Server Log</span>
            <span style="margin-left: 80%; text-align: center;"> 
                <font size="2" face="Verdana, Arial, Helvetica, sans-serif"><a href="<%=request.getContextPath()%>/UserProfile/exportToNotePad.jsp?export=all" target="_blank">Download</a> |<a href="<%=request.getContextPath()%>/UserProfile/exportLogbydate.jsp" >Download All</a></font></span></div>
        <!-- edit by mukesh-->
        <table style="width: 100%;">
            <tr>
                <td>
                <td>
                    <a href="<%=request.getContextPath()%>/UserBPM/dashboardForCompany.jsp?pid=<%=pid%>">Business Process Map Dashboard View</a>&nbsp;&nbsp;&nbsp;

                    <a href="<%=request.getContextPath()%>/admin/dashboard/modulewiseChart.jsp?project=<%=project%>">Module-wise Dashboard</a>&nbsp;&nbsp;&nbsp;


                    <a href="<%=request.getContextPath()%>/admin/dashboard/TestCasesChart.jsp?project=<%=pid%>">View Test Coverage</a>&nbsp;&nbsp;&nbsp;
                    <a href="<%=request.getContextPath()%>/UserProject/listProjectTestPlan.jsp?pid=<%=pid%>">View Test Plans</a>&nbsp;&nbsp;&nbsp;

                    <a href="<%=request.getContextPath()%>/admin/dashboard/projectPerformanceChart.jsp?pid=<%=pid%>">View Project Performance</a>&nbsp;&nbsp;&nbsp;
                    <a href="<%=request.getContextPath()%>/admin/dashboard/openIssueByProject.jsp?pid=<%=pid%>">View Issues</a>&nbsp;&nbsp;&nbsp;
                    <a href="<%=request.getContextPath()%>/MOM/momProjectTeamWise.jsp?pid=<%=pid%>" title="Weekly Review MoM">WRM</a>&nbsp;&nbsp;&nbsp; 

                    <a href="<%=request.getContextPath()%>/UserProfile/userException.jsp">Server Log</a>&nbsp;&nbsp;&nbsp;&nbsp;
      <a href="<%=request.getContextPath()%>/CreateIssue/uploadIssues.jsp?pid=<%=pid%>" >Upload Issues</a>&nbsp;&nbsp;&nbsp; 
                </td>

            </tr></table>

        <jsp:useBean id="serverlog" class="pack.eminent.encryption.GetServerLog"></jsp:useBean>
        <%

            serverlog.setAll(request);
        %>

        <div class="mid-count" >
            <div class="innertext"><%=serverlog.getLogtext()%></div>
        </div> 
        <%} else {%>
        <div style="color: red">you are not authorized to view this page</div>
        <%}%>
    </body>
</html>
