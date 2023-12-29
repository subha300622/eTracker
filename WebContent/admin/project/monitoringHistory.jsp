<%-- 
    Document   : manageServers
    Created on : 18 May, 2020, 12:59:40 PM
    Author     : vanithaalliraj
--%>


<%@page import="com.eminent.server.StatusHistory"%>
<%@page import="com.eminent.server.ParameterStatus"%>
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
            var companyCode = document.getElementById("companyCode").value;
            var x = document.getElementById("serverId").value;
            var pid = document.getElementById("pid").value;
            document.theForm.action = '/eTracker/admin/project/monitoringStatus.jsp?pid=' + pid + "&serverId=" + x + "&companyCode=" + companyCode;
            document.theForm.submit();
        }
        function call()
        {
            var pid = document.getElementById("pid").value;
            document.projectForm.action = '/eTracker/admin/project/monitoringStatus.jsp?pid=' + pid;
            document.projectForm.submit();
        }
    </script>


</head>
<%
    String pid = request.getParameter("pid");
    String team = (String) session.getAttribute("team");
    String project = GetProjects.getProjectName(pid);
    String category = "NA";
    //Getting User Id and Role
    Integer role = (Integer) session.getAttribute("Role");
    Integer uid = (Integer) session.getAttribute("userid_curr");
    int roleValue = role.intValue();
    int uidValue = uid.intValue();
    //Displaying all the projects for Admin role
    HashMap<String, String> projects = null;
    if (roleValue == 1) {
        projects = GetProjectManager.getProjects();
    } else {
        //Displaying only assigned projects to other roles
        projects = GetProjectManager.getUserProjects(uidValue);
    }
    Collection se1 = projects.keySet();

    if (project != null) {
        category = CheckCategory.getCategory(project);
    }
    HashMap companyMap = ViewBPM.getCompany(Integer.parseInt(pid));
    LinkedHashMap company = GetProjectMembers.sortHashMapByKeys(companyMap, true);

    String cases[][] = TestCases.showTestCases(pid);
    int noOfTestcases = cases.length;

    String clientName = ViewBPM.getClientName(Integer.parseInt(pid));
%>
<body class="home-bg">
    <div class="Ajax-loder">

        <div class="bg"></div>

        <img class="loading" src="<%=request.getContextPath()%>/images/276 (1).GIF"
             alt="loading...." /></div>

    <%@ include file="/header.jsp"%>

    <jsp:useBean id="sm" class="com.eminent.server.ServerMaintenace"></jsp:useBean>
    <%sm.getMonitoringStatus(request);
    %>
    <form name="theFormz" id="theFormz" method="get"  action="./monitoringHistory.jsp" onsubmit="disableMomSubmit()">
        <div class="page-header">
            <span class='page-header-content1'> 
			 <select id="pid" name="pid" onchange="call(this);" >     <% for (Map.Entry<String, String> entry : projects.entrySet()) {%>
                    <option value="<%=entry.getKey()%>" <% if (entry.getKey().equalsIgnoreCase(pid)) { %>selected  <% }%>><%=entry.getValue()%></option>
                    <% }%>
                </select>
            </span>
            <span class="page-header-content2"> Monitoring Date <input type="text" id="moniDate" name="moniDate" maxlength="10" size="10"
                                                                         value="<%=sm.getMoniDate()%>" readonly /><a
                                                                         href="javascript:NewCal('moniDate','ddmmmyyyy','','','','past')"> <img
                        src="<%=request.getContextPath()%>/images/newhelp.gif" border="0"
                        width="16" height="16" alt="Pick a date"></a>


                <input type="submit" name="btnSubmit" id="btnSubmit" value="Submit"> </span>
            <span class="page-header-content3">
               
            </span>


        </div>

    </form>


  <table>
        <tr>
            <td>
                <a href="<%=request.getContextPath()%>/UserBPM/dashboardForCompany.jsp?pid=<%=pid%>">Business Process Map Dashboard View</a>&nbsp;&nbsp;&nbsp;
                <% if (category.equalsIgnoreCase("SAP Project")) {
                %>
                <a href="<%=request.getContextPath()%>/admin/dashboard/projectChart.jsp?project=<%=project%>">Status-wise Dashboard</a>&nbsp;&nbsp;&nbsp;
<!--                <a href="<%=request.getContextPath()%>/UserBPM/dashboardForCompany.jsp?pid=<%=pid%>">View Test Map Dashboard</a>&nbsp;&nbsp;&nbsp;-->
                <%
                    }
                %>
                <a href="<%=request.getContextPath()%>/admin/dashboard/modulewiseChart.jsp?project=<%=project%>">Module-wise Dashboard</a>&nbsp;&nbsp;&nbsp;

                <%
                    if (noOfTestcases > 0) {
                %>
                <a href="<%=request.getContextPath()%>/admin/dashboard/TestCasesChart.jsp?project=<%=pid%>">View Test Coverage</a>&nbsp;&nbsp;&nbsp;
                <a href="<%=request.getContextPath()%>/UserProject/listProjectTestPlan.jsp?pid=<%=pid%>">View Test Plans</a>&nbsp;&nbsp;&nbsp;
                <%}%>
                <a href="<%=request.getContextPath()%>/admin/dashboard/projectPerformanceChart.jsp?pid=<%=pid%>">View Project Performance</a>&nbsp;&nbsp;&nbsp;
                <a href="<%=request.getContextPath()%>/admin/dashboard/openIssueByProject.jsp?pid=<%=pid%>">View Issues</a>&nbsp;&nbsp;&nbsp;
                <a href="<%=request.getContextPath()%>/MOM/momProjectTeamWise.jsp?pid=<%=pid%>" title="Weekly Review MoM">WRM</a>&nbsp;&nbsp;&nbsp; 
                <%if (project.contains("eTracker")) {%>
                <a href="<%=request.getContextPath()%>/UserProfile/userException.jsp">Server Log</a>&nbsp;&nbsp;&nbsp;&nbsp;
                <%}%>
                <a href="<%=request.getContextPath()%>/CreateIssue/uploadIssues.jsp?pid=<%=pid%>" >Upload Issues</a>&nbsp;&nbsp;&nbsp; 
                <%if (roleValue == 1 || team.equalsIgnoreCase("basis")) {%>
                <a href="<%=request.getContextPath()%>/admin/project/maintainMonitoring.jsp?pid=<%=pid%>" >SAP Monitoring</a>&nbsp;&nbsp;&nbsp; 
                <a href="<%=request.getContextPath()%>/admin/project/monitoringHistory.jsp?pid=<%=pid%>" >Monitoring Report</a>&nbsp;&nbsp;&nbsp; 
                <%}%>
            </td>
        </tr>
    </table>
  
    <%if(!sm.getMoniStat().isEmpty()){
        for (Map.Entry<Integer, Map<Integer, Map<Integer, List<StatusHistory>>>> entry : sm.getMoniStat().entrySet()) {%>
    <div>
        <table width="100%"  border="0" align="center">       
            <tr>
                <th rowspan="2">
                    <%for (SapServerType serverType : sm.getAllServers()) {
                            if (entry.getKey() == serverType.getSId()) {%>
                    <%=serverType.getServerName()%>   PARAMETER</th>
                    <%}
                        }%>
                    <%for (Map.Entry<Integer, Map<Integer, List<StatusHistory>>> comp : entry.getValue().entrySet()) {%>
                <th style="text-align: center;" colspan="<%=comp.getValue().keySet().size()%>"><%=sm.getCompanyCodes().get(comp.getKey())%></th>


                <%}%>
            </tr>
            <tr >
                <%for (Map.Entry<Integer, Map<Integer, List<StatusHistory>>> comp : entry.getValue().entrySet()) {%>
                <%for (Map.Entry<Integer, List<StatusHistory>> system : comp.getValue().entrySet()) {%>
                <th>
                    <%for (SapSystemType systemType : sm.getAllSystems()) {
                            if (system.getKey() == systemType.getSId()) {%>
                    <%=systemType.getSName()%></th>
                    <%}%>
                    <%}%>
                    <%}
                        }%>
            </tr>

            <%int a = 1;
                String color = "#E8EEF7";
                for (SapMonitoringParamaters smp : sm.getSapMonitoringParamaterses()) {

                    for (Integer checkedParaemeter : sm.getCheckedParameters()) {
                        if (smp.getServerId() == entry.getKey() && smp.getParameterId() == checkedParaemeter) {
                            if (a % 2 == 0) {
                                color = "#E8EEF7";
                            } else {
                                color = "white";
                            }
            %>
            <tr height="30" style="background-color: <%=color%>"> 
                <td><%=smp.getParameterName()%></td>

                <%for (Map.Entry<Integer, Map<Integer, List<StatusHistory>>> comp : entry.getValue().entrySet()) {%>
                <%for (Map.Entry<Integer, List<StatusHistory>> system : comp.getValue().entrySet()) {%>
                <td>
                    <%for (StatusHistory histroy : system.getValue()) {
                            if (histroy.getServerId() == entry.getKey() && comp.getKey() == histroy.getCompayCode() && histroy.getSystemId() == system.getKey() && histroy.getParameterId() == checkedParaemeter) {

                    %>
                    <%=histroy.getParamStatus()%>

                </td>
                <%}
                        }%>
                <%}%>
                <%}%>

            </tr>
            <%a++;
                        }
                    }
                }%>




        </table>
    </div>
    <br/>
    <br/>
    <%}%>
    
    <%}else{%>
    <div class="error2" style="text-align: center; font: bold;color:red">
      Monitoring data is not available for the day
    </div>
    <%}%>

</body>
<script src="<%=request.getContextPath()%>/javaScript/jquery-1.10.2.js"></script>
<script src="<%=request.getContextPath()%>/javaScript/jquery-ui.js"></script>

<script>
                    $(".Ajax-loder").hide();
</script>
</html>
