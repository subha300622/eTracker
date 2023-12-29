
<%@page import="com.eminent.server.SapSystemType"%>
<%@page import="com.eminent.server.SapMonitoringParamaters"%>
<%@page import="com.eminent.server.ServerSystem"%>
<%@page import="com.eminent.server.SapServerType"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.LinkedHashMap"%>
<%@page import="com.eminentlabs.userBPM.ViewBPM"%>
<%@page import="com.eminent.util.IssueDetails"%>
<%@page import="com.eminent.util.ProjectFinder"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Collection"%>
<%@page import="com.eminent.util.GetProjectManager"%>
<%@page import="java.util.HashMap"%>
<%@page import="dashboard.TestCases"%>
<%@page import="dashboard.CheckCategory"%>
<%@page import="com.eminent.util.GetProjects"%>
<%@page import="com.eminent.util.GetProjectMembers"%>
<%@page import="com.eminent.issue.ApmTeam"%>
<%@page import="com.eminentlabs.mom.BestPMTeamBean"%>
<%@page import="com.eminent.issue.formbean.IssueFormBean"%>
<%@page import="com.eminentlabs.mom.formbean.PMReportFormBean"%>
<%@page import="java.util.Map"%>
<%@page import="org.apache.log4j.Logger"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    Logger logger = Logger.getLogger("BestPMandTeamReport");
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
    <LINK title=STYLE href="<%= request.getContextPath()%>/eminentech support files/main_ie.css" type="text/css" rel="STYLESHEET">
    <script type="text/javascript" src="<%= request.getContextPath()%>/javaScript/checkSubmit.js"></script>
    <script type="text/javascript" src="<%= request.getContextPath()%>/javaScript/jquery.js"></script>
    <script type="text/javascript" src="<%= request.getContextPath()%>/javaScript/slide.js"></script>
    <script type="text/javascript" src="<%= request.getContextPath()%>/javaScript/tooltip.js"></script>
    <script language=javascript src="<%= request.getContextPath()%>/eminentech support files/datetimepicker.js"></script>
    <script src="<%=request.getContextPath()%>/javaScript/jquery.js" type="text/javascript"></script>
    <style>
        th{
            font: bolder;
            color: black;
        }
    </style>
    <script>
        function callServer(theForm)
        {

            var x = document.getElementById("serverId").value;
            var pid = document.getElementById("pid").value;
            document.theForm.action = '/eTracker/admin/project/maintainMonitoring.jsp?pid=' + pid + "&serverId=" + x;
            document.theForm.submit();
        }
        function call()
        {

            var pid = document.getElementById("pid").value;
            document.projectForm.action = '/eTracker/admin/project/maintainMonitoring.jsp?pid=' + pid;
            document.projectForm.submit();
        }
    </script>


</head>
<%
    String team = (String) session.getAttribute("team");
    Integer role = (Integer) session.getAttribute("Role");
    Integer uid = (Integer) session.getAttribute("userid_curr");
    int roleValue = role.intValue();
    int uidValue = uid.intValue();
    HashMap<String, String> projects = null;
    if (roleValue == 1) {
        projects = GetProjectManager.getProjects();
    } else {
        //Displaying only assigned projects to other roles
        projects = GetProjectManager.getUserProjects(uidValue);
    }
    String pid = null;
    for (String proj : projects.keySet()) {
        pid = proj;
        break;
    }
%>
<body class="home-bg">
    <div class="Ajax-loder">

        <div class="bg"></div>

        <img class="loading" src="<%=request.getContextPath()%>/images/276 (1).GIF"
             alt="loading...." /></div>
        <jsp:useBean id="ProjectFinder" class="com.eminent.util.ProjectFinder"/>

    <%@ include file="/header.jsp"%>
    <table style="width: 100%;background-color: #C3D9FF;font-weight: bold;">
        <tr>
            <td style="width:30%;text-align: left">Monitoring Report</td>

        </tr>
    </table>
    <table>
        <tr>
            <td>

                <%if (roleValue == 1 || team.equalsIgnoreCase("basis")) {%>
                <a href="<%=request.getContextPath()%>/admin/project/maintainMonitoring.jsp?pid=<%=pid%>" >SAP Monitoring</a>&nbsp;&nbsp;&nbsp; 
                <a href="<%=request.getContextPath()%>/admin/project/parameterSetup.jsp?pid=<%=pid%>" >Parameter Setup</a>&nbsp;&nbsp;&nbsp; 
                <%}%>
            </td>
        </tr>
    </table>
    <br/>
    <table width="100%" style=" border: 1px solid #ccccff;border-collapse:collapse;" id="issueSplit" class="tablesorter">

        <thead>
            <tr bgColor="#C3D9FF" height="21" style=" border: 1px solid #ccccff;">

                <% String[][] monitor = ProjectFinder.getBasisMonitoring(request);
                    try {
                        String projSplit = "", title = "";
                        for (String s : monitor[0]) {
                            if (s == null) {
                                s = "";
                            }
                            try {
                                //                   logger.info("Proj Name"+s);
                                projSplit = s.substring(0, s.indexOf("***"));

                                title = s.substring(s.indexOf("***") + 3, s.length());
                            } catch (Exception e) {
                                //              logger.error(e.getMessage());
                                projSplit = "";
                                title = "";
                            }
                %>  

                <th class="header" style=" border: 1px solid #ccccff;" title="<%=title%>"><b><%=projSplit%></th>
                    <%
                            }
                        } catch (Exception e) {
                            logger.error(e.getMessage());
                        }
                    %>
        </thead>

    </tr>
    <tbody>
        <%String value = "", prid = "", sid = "";
            int noOfRows = monitor.length;
            for (int m = 1; m < monitor.length; m++) { %>
        <tr <%if (m % 2 == 0) {%>class="zebraline"<%} else {%>class="zebralinealter"<%}%>>
            <%
                for (int j = 0; j < monitor[0].length; j++) {
                    value = monitor[m][j];
                    if (value == null) {
                        value = "";
                    }
                    if (m > 0 && j > 0) {
                        String[] resu = value.split("@@@");
                        prid = resu[0];
                        sid = resu[1];
                        value = resu[2];
                    }

                    if (m > 0 && j == 0) {
            %>
            <td style=" border: 1px solid #ccccff;"><b><%=value%></b> </td>

            <%
            } else {
            %>
            <td style=" border: 1px solid #ccccff;color:white;background-color:  <%if (value.equals("Monitored")) {%>green; <%} else {%>red;<%}%>">
                <a  style="color:white;"  <%if (value.contains("Monitored")) {%>    
                  href="<%=request.getContextPath()%>/admin/project/monitoringStatus.jsp?pid=<%=prid%>&serverId=<%=sid%>"
                <%} else if (value.contains("Matrix Not Maintained")) {%>
                 href="#"
                <%} else if (value.contains("Parameter Not Maintained")) {%>
                 href="<%=request.getContextPath()%>/admin/project/maintainMonitoring.jsp?pid=<%=prid%>&serverId=<%=sid%>"
                <%}%>>
                <%=value%> </a></td>

            <%
                    }
                }
            %>

        </tr>
        <%}%>
    </tbody>

</table>

</body>
<script src="<%=request.getContextPath()%>/javaScript/jquery-1.10.2.js"></script>
<script src="<%=request.getContextPath()%>/javaScript/jquery-ui.js"></script>

<script>
        $("#submit").on("click", function () {

            $('span.error2').remove();
            var checkedVals = $('.serverMaintain:checkbox:checked').map(function () {
                return this.value;
            }).get();
            if (checkedVals.length === 0) {
                $("<span class='error2'>Please select the paramaters</span>").insertAfter("#submit");
                return false;
            } else {
                $(".Ajax-loder").show();
                return true;
            }
        });
        $(".Ajax-loder").hide();
</script>
</html>
