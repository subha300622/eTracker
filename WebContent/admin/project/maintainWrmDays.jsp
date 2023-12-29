<%-- 
    Document   : maintainWrmDays
    Created on : May 27, 2014, 12:34:55 PM
    Author     : E0288
--%>

<%@page import="com.eminent.issue.ApmWrmDay"%>
<%@page import="com.eminent.bpm.BpmPrintaccess"%>
<%@page import="java.util.Map"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    Logger logger = Logger.getLogger("maintainWrmDays");
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
    <title>eTracker&#153; - Eminentlabs&#153; CRM, APM, TQM,  ERM and  EPTS
        Solution</title>
    <LINK title=STYLE
          href="<%= request.getContextPath()%>/eminentech support files/main_ie.css"
          type="text/css" rel=STYLESHEET>
    <script type="text/javascript" src="<%= request.getContextPath()%>/javaScript/checkSubmit.js"></script>
    <script type="text/javascript">
        function fun() {



        }
    </script>
</head>
<%@ include file="/header.jsp"%>
<body>
    <br/>
    <jsp:useBean id="mwd" class="com.eminent.issue.controller.MaintainWRMDay"></jsp:useBean>
    <%mwd.setAll(request);%>
    <table cellpadding="0" cellspacing="0" width="100%" bgColor="#C3D9FF">
        <tr border="2">
            <td border="1" align="left" width="100%"><font size="4" COLOR="#0000FF"><b>Maintain WRM Days</b></font> <FONT SIZE="3" COLOR="#0000FF"> </FONT></td>
        </tr>
    </table>
    <br/>
    <table width="100%" border="0">
        <tr>
            <td><a
                    href="<%=request.getContextPath()%>/admin/project/createProject.jsp">Add
                    Project</a>&nbsp;&nbsp;&nbsp;
                <a href="<%=request.getContextPath()%>/admin/project/maintainDays.jsp">Maintain SLA</a>&nbsp;&nbsp;&nbsp;
                <a href="<%=request.getContextPath()%>/admin/project/treePrintAccess.jsp">Tree Print Access</a>&nbsp;&nbsp;&nbsp;
                <a href="<%=request.getContextPath()%>/admin/project/maintainWrmDays.jsp" style="font-weight: bold;">WRM Days</a>&nbsp;&nbsp;&nbsp;
                <a href="<%=request.getContextPath()%>/admin/project/apmTeam.jsp" >Team Maintenance</a>&nbsp;&nbsp;&nbsp;
                <a href="<%=request.getContextPath()%>/admin/project/moduleIssueSplit.jsp">Issue Analysis</a>&nbsp;&nbsp;&nbsp;
                <a href="<%=request.getContextPath()%>/admin/project/trDisplay.jsp" >TR Display</a>&nbsp;&nbsp;&nbsp;
                <a href="<%=request.getContextPath()%>/admin/project/manageTR.jsp" >TR Pattern</a>&nbsp;&nbsp;&nbsp;
                <a href="<%=request.getContextPath()%>/admin/project/uploadIssues.jsp" >Upload Issues</a>&nbsp;&nbsp;&nbsp;
                <a href="<%=request.getContextPath()%>/admin/project/viewAttachedImages.jsp" style="cursor: pointer;">View Attached Images</a>              &nbsp;&nbsp;&nbsp;
                <a href="<%=request.getContextPath()%>/admin/project/gstLogs.jsp" style="cursor: pointer;">GST 3in1 Cockpit</a>&nbsp;&nbsp;&nbsp;
                <a href="<%=request.getContextPath()%>/admin/dashboard/gnattChartAdmin.jsp" style="cursor: pointer;">Gantt Chart</a>
                <a href="<%=request.getContextPath()%>/admin/project/maintainSapSystems.jsp" style="cursor: pointer;">Maintain SAP Systems</a>
                <a href="<%=request.getContextPath()%>/admin/project/demoProjects.jsp" style="cursor: pointer;">Demo(11)</a>
                <a href="<%=request.getContextPath()%>/admin/project/daywiseEInvoiceCount.jsp" style="cursor: pointer;">Daywise E-Invoice</a>  
            </td>
            <td></td>

        </tr>
    </table>
    <br/>
    <%if (!mwd.projectList().isEmpty()) {%>

    <form name="theForm" id="theForm" method="post" action="<%=request.getContextPath()%>/admin/project/maintainWrmDays.jsp" onsubmit="disableSubmit();">

        <table >
            <tr height="21" style="font-weight: bold;background-color: #C3D9FF;">
                <td>Project</td>
                <td>WRM Day</td>
            </tr>
            <%int i = 0;
                for (Map.Entry<Long, String> entry : mwd.projectList().entrySet()) {
                    if ((i % 2) != 0) {
            %>
            <tr bgcolor="#E8EEF7" height="21">
                <%                     } else {
                %>

            <tr bgcolor="white" height="21">
                <%                    }
                    i++;
                %>

                <td><input type="hidden" name="pid" value="<%=entry.getKey()%>"> <%=entry.getValue()%></td>
                <td>                        <select name="wrmDay" id="wrmDay">
                        <option value="-1" selected="">--Select One--</option>
                        <%
                            int day = -1;//default value is -1
                            if (mwd.getProjectWrmDays() != null && !mwd.getProjectWrmDays().isEmpty()) {
                                for (ApmWrmDay awd : mwd.getProjectWrmDays()) {
                                    if (awd.getPid().equals(entry.getKey())) {
                                        day = awd.getWrmDay();
                                    }
                                }
                            }
                            for (Map.Entry<Integer, String> entrya : mwd.days().entrySet()) {
                                if (day == entrya.getKey()) {
                        %>
                        <option value="<%=entrya.getKey()%>" selected=""><%=entrya.getValue()%></option>
                        <%} else {%>
                        <option value="<%=entrya.getKey()%>" ><%=entrya.getValue()%></option>
                        <%}
                            }%>
                    </select>
                </td>
            </tr>
            <%}%>
            <tr style="text-align: center;"><td colspan="2" ><input type="submit" id="submit" value="Submit"/></td></tr>
        </table>
    </form>
    <%} else {%>
    <div style="text-align: center;color: red;"></div>
    <%}%>
</body>
</html>
