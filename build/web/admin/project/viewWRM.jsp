<%-- 
    Document   : viewWRM
    Created on : 19 Dec, 2014, 11:43:00 AM
    Author     : Tamilvelan
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="org.apache.log4j.Logger,com.eminent.util.ProjectFinder"%>
<%
    //Configuring log4j properties
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Cache-Control", "no-store");
    response.setDateHeader("Expires", 0);
    response.setHeader("Pragma", "no-cache");
    Logger logger = Logger.getLogger("viewWRM");
    String logoutcheck = (String) session.getAttribute("Name");
    if (logoutcheck == null) {
%>
<jsp:forward page="/SessionExpired.jsp"></jsp:forward>
<%    }

%>
<!DOCTYPE html>
<html>
    <meta name="keywords" content="GST in SAP, SAP GST Accelerator, GST Success in SAP, GST India in SAP, GST SAP Success, GST Suvidha Provider, GST ASP GSP, GST, CGST,SGST, IGST, UGST,  SAP NW based Product Development, SAP Consulting, SAP Implementation, SAP Support Services, SAP Outsourcing, SAP Implementation India, SAP Implementation Bangalore, SAP Implementation Chennai, SAP Implementation Belgium, SAP Implementation Paris, SAP Implemtation Australia, SAP Implementation France, SAP Implementation Mumbai, SAP Implementation Kerala, SAP Implementation Belgaum, SAP Implementation Thailand, SAP Implementation Mexico, SAP Implementation America">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>eTracker&#153; - Eminentlabs&#153; CRM, APM, TQM,  ERM and  EPTS Solution</title>
        <LINK title=STYLE href="<%= request.getContextPath()%>/eminentech support files/main_ie.css"  type="text/css" rel=STYLESHEET>
    </head>
    <%@ include file="/header.jsp"%>
    <body>
        <table cellpadding="0" cellspacing="0" width="100%" bgColor="#C3D9FF">
            <tr border="2">
                <td border="1" align="left" width="100%"><font size="4" COLOR="#0000FF"><b>View WRM Days</b></font> <FONT SIZE="3" COLOR="#0000FF"> </FONT></td>
            </tr>
        </table>
        <br>
        <table width="100%" border="0">
            <tr>
                <td><a
                        href="<%=request.getContextPath()%>/admin/project/createProject.jsp">Add
                        Project</a>&nbsp;&nbsp;&nbsp;
                    <a href="<%=request.getContextPath()%>/admin/project/maintainDays.jsp">Maintain SLA</a>&nbsp;&nbsp;&nbsp;
                    <a href="<%=request.getContextPath()%>/admin/project/treePrintAccess.jsp">Tree Print Access</a>&nbsp;&nbsp;&nbsp;
                    <a href="<%=request.getContextPath()%>/admin/project/viewWRM.jsp">WRM Days</a>&nbsp;&nbsp;&nbsp;
                    <a href="<%=request.getContextPath()%>/admin/project/apmTeam.jsp">Team Maintenance</a>&nbsp;&nbsp;&nbsp;
                    <a href="<%=request.getContextPath()%>/admin/project/moduleIssueSplit.jsp">Issue Analysis</a>&nbsp;&nbsp;&nbsp;
                    <a href="<%=request.getContextPath()%>/admin/project/momMaintanance.jsp" >MoM Maintenance</a>&nbsp;&nbsp;&nbsp;
                    <a href="<%=request.getContextPath()%>/admin/project/trDisplay.jsp" >TR Display</a>&nbsp;&nbsp;&nbsp;
                    <a href="<%=request.getContextPath()%>/admin/project/manageTR.jsp" >TR Pattern</a>
                </td>
                <td></td>

            </tr>
        </table>
        <br>
        <%
            String projectWRMs[][] = ProjectFinder.getProjectWRM();
        %>
        <table width="100%" style=" border: 1px solid #ccccff;border-collapse:collapse;">
            <tr bgColor="#C3D9FF" height="21" style=" border: 1px solid #ccccff;">
                <td style=" border: 1px solid #ccccff;text-align: center;" title="Time in IST"><b>Time</td>
                <td style=" border: 1px solid #ccccff;text-align: center;"><b>Sunday</td>
                <td style=" border: 1px solid #ccccff;text-align: center;"><b>Monday</td>
                <td style=" border: 1px solid #ccccff;text-align: center;"><b>Tuesday</td>
                <td style=" border: 1px solid #ccccff;text-align: center;"><b>Wednesday</td>
                <td style=" border: 1px solid #ccccff;text-align: center;"><b>Thursday</td>
                <td style=" border: 1px solid #ccccff;text-align: center;"><b>Friday</td>
                <td style=" border: 1px solid #ccccff;text-align: center;"><b>Saturday</td>
            </tr>
            <%
                int t = 7;
                String value = "";
                for (int i = 0; i < 12; i++, t++) {
            %>
            <tr <% if (i % 2 == 0) {%>class="zebralinealter"<%} else {%>class="zebraline"<%}%>>
                <td style=" border: 1px solid #ccccff;"><%=t%>:00</td>
                <%
                    for (int j = 0; j < 7; j++) {
                        value = projectWRMs[i][j];
                        if (value == null) {
                            value = "";
                        }
                %>
                <td style=" border: 1px solid #ccccff;"><%=value%></td>
                <%
                    }
                %>
            </tr>
            <%
                }

            %>
        </table> 
    </body>
</html>
