<%-- 
    Document   : manageServers
    Created on : 18 May, 2020, 12:59:40 PM
    Author     : vanithaalliraj
--%>


<%@page import="java.util.Set"%>
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
            document.theForm.action = '/eTracker/admin/project/maintainMonitoring.jsp?pid=' + pid + "&serverId=" + x + "&companyCode=" + companyCode;
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
    String pid = request.getParameter("pid");
    String team = (String) session.getAttribute("team");

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
    if (pid == null) {
        for (String proj : projects.keySet()) {
            pid = proj;
            break;
        }
    }
    String project = GetProjects.getProjectName(pid);
    String category = "NA";
    Collection se1 = projects.keySet();

    if (project != null) {
        category = CheckCategory.getCategory(project);
    }
    HashMap companyMap = ViewBPM.getCompany(Integer.parseInt(pid));
    LinkedHashMap company = GetProjectMembers.sortHashMapByKeys(companyMap, true);

    String cases[][] = TestCases.showTestCases(pid);
    int noOfTestcases = cases.length;

    String clientName = ViewBPM.getClientName(Integer.parseInt(pid));
    Set<Integer> managers = GetProjectManager.getPMnDMByPID(Integer.parseInt(pid));

%>
<body class="home-bg">
    <div class="Ajax-loder">

        <div class="bg"></div>

        <img class="loading" src="<%=request.getContextPath()%>/images/276 (1).GIF"
             alt="loading...." /></div>

    <%@ include file="/header.jsp"%>

    <jsp:useBean id="sm" class="com.eminent.server.ServerMaintenace"></jsp:useBean>
    <%sm.getMatrixParameters(request);
    %>


    <table style="width: 100%;background-color: #C3D9FF;font-weight: bold;">
        <tr>
            <td style="width:30%;text-align: left">Maintain Monitoring <a href="<%=request.getContextPath()%>/admin/project/parameterSetup.jsp?pid=<%=pid%>">Parameter Setup</a>&nbsp;&nbsp;&nbsp;<a href="<%=request.getContextPath()%>/admin/project/maintainSAPConfig.jsp?pid=<%=pid%>">Maintain SAP Config</a>&nbsp;&nbsp;&nbsp;<a href="<%=request.getContextPath()%>/admin/project/monitoringReport.jsp?pid=<%=pid%>">Monitoring Report</a></td> <a href="<%=request.getContextPath()%>/admin/project/maintainSAPLogon.jsp?pid=<%=pid%>" >SAP Systems</a>&nbsp;&nbsp;&nbsp; 
        <td style="width:30%;text-align:right; height: 25px;">
            <form name="projectForm" id="projectForm" method="post" onsubmit="return fun(this);"><b>Project : </b> 
                <select id="pid" name="pid" size=1 onchange="javascript:call(this.form)">     <% for (Map.Entry<String, String> entry : projects.entrySet()) {%>
                    <option value="<%=entry.getKey()%>" <% if (entry.getKey().equalsIgnoreCase(pid)) { %>selected  <% }%>><%=entry.getValue()%></option>
                    <% }%>
                </select>
            </form>
        </td>
    </tr>
</table>
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
            <%if (roleValue == 1 || managers.contains(uidValue) || team.equalsIgnoreCase("basis")) {%>
            <a href="<%=request.getContextPath()%>/admin/project/maintainMonitoring.jsp?pid=<%=pid%>" >SAP Monitoring</a>&nbsp;&nbsp;&nbsp;  
            <a href="<%=request.getContextPath()%>/admin/project/monitoringHistory.jsp?pid=<%=pid%>" >Monitoring Report</a>&nbsp;&nbsp;&nbsp; 
            <%}%>
        </td>
    </tr>
</table>
<br/>
<%if (sm.getMessge() != null) {%>   
<div class="error2" style="text-align: center; font: bold;color:<%if (sm.getMessge().contains("success")) {%>green<%}%>">
    <%=sm.getMessge()%>
</div>
<%}%>
<%
    if (!sm.getMatrixServers().isEmpty()) {
%>
<form name="theForm" >       
    <table width="70%" bgColor=#E8EEF7 border="0" align="center">
        <tr>
            <td height="21" style="width: 15%;"><b>Company Code</b></td>
            <td><input type="hidden" name="pid" id="pid" value="<%=pid%>"/>
                <select name="companyCode" id="companyCode" onchange="callServer(this);">

                    <%for (Map.Entry<Integer, String> ss : sm.getCompanyCodes().entrySet()) {
                    %>
                    <option value="<%=ss.getKey()%>" <%if (ss.getKey() == sm.getCompanyCode()) {%>selected<%}%>><%=ss.getValue()%></option>
                    <%
                            }%>
                </select>
            </td>
        </tr>
        <tr>
            <td height="21" style="width: 15%;"><b>Server Type</b></td>
            <td><input type="hidden" name="pid" id="pid" value="<%=pid%>"/>
                <select name="serverId" id="serverId" onchange="callServer(this);">
                    <option value="">select</option>
                    <%for (SapServerType ss : sm.getAllServers()) {
                            if (sm.getMatrixServers().contains(ss.getSId())) {
                    %>
                    <option value="<%=ss.getSId()%>" <%if (ss.getSId() == sm.getServerId()) {%>selected<%}%>><%=ss.getServerName()%></option>
                    <%}
                            }%>
                </select>
            </td>
            <%if (!sm.getServerMatrix().isEmpty()) {%>
            <td><b>Systems :</b>
                <%  StringBuilder nameBuilder = new StringBuilder();
                    for (ServerSystem ss : sm.getServerMatrix()) {
                        for (SapSystemType sst : sm.getAllSystems()) {
                            if (sst.getSId() == ss.getSyId() && ss.getServerId() == sm.getServerId()) {
                                nameBuilder.append(sst.getSName()).append(", ");
                            }
                        }
                    }
                    if (nameBuilder.length() > 0) {
                        nameBuilder.deleteCharAt(nameBuilder.length() - 1);
                    }
                %>
                <%=nameBuilder%>
            </td>
            <%}%>
        </tr>
    </table>
</form>

<%if (!sm.getSapMonitoringParamaterses().isEmpty()) {%>
<form name="monitorForm" method="post" action="<%=request.getContextPath()%>/admin/project/maintainMonitoring.jsp">   
    <table width="70%" bgColor=#E8EEF7 border="0" align="center">
        <tr>
            <td><b>Basis Monitoring Issue ID</b><input type="text" name="issueid" value="<%=sm.getIssueid() == null ? "" : sm.getIssueid()%>" required=""/></td>
        </tr>
    </table>
    <table width="70%" id="monitor" bgColor=#E8EEF7 border="0" align="center">
        <tr><th></th>
            <th>Parameter
                <input type="hidden" name="pid" id="pid" value="<%=pid%>"/>
                <input type="hidden" id="serverId" name="serverId" value="<%=sm.getServerId()%>"/>
                <input type="hidden" id="companyCode" name="companyCode" value="<%=sm.getCompanyCode()%>"/>
            </th><th>Parameter Type</th><th>Parameter Value</th></tr>          
                <%int count = 0;

                    for (SapMonitoringParamaters smp : sm.getSapMonitoringParamaterses()) {
                        count++;%>
        <tr>
            <td><input type="checkbox" class="serverMaintain" name="parameterId" value="<%=smp.getParameterId()%>"
                       <%if (sm.getCheckedParameters().contains(smp.getParameterId())) {%>checked="true"<%}%>
                       /></td>
            <td><%=smp.getParameterName()%></td>
            <td><%for (String ss : sm.getAllInputTypes()) {%>
                <%if (ss.equalsIgnoreCase(smp.getParameterType())) {%>
                <%=ss%>
                <%}%>
                <%}%>
            </td>
            <td><%=smp.getParameterValues() == null ? "" : smp.getParameterValues()%></td>
        </tr>
        <%}%>
    </table>
    <table width="70%" bgColor=#E8EEF7 border="0" align="center">
        <tr><td colspan="3" style="text-align: center;">
                <input type="submit" value="Submit" name="submit" id="submit"> 
            </td>
        </tr>
    </table>
</form>
<%} else {
        if (sm.getServerId() > 0) {%>
<table align="center">
    <tr align="center" ><td><font color="red">Parameter is not maintained. Please maintain it.</font></td></tr>
</table>
<%}
        }%>
<%} else {%>
<table align="center">
    <tr align="center" ><td><font color="red">Server type with system matrix is maintained for this project. Please contact Admin(Tamilvelan)</font></td></tr>
</table>
<%}%>
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
