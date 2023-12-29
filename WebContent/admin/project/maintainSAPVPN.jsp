<%-- 
    Document   : manageServers
    Created on : 18 May, 2020, 12:59:40 PM
    Author     : vanithaalliraj
--%>


<%@page import="com.eminent.server.SapLogon"%>
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

        function call()
        {

            var pid = document.getElementById("pid").value;
            document.projectForm.action = '/eTracker/admin/project/maintainSAPVPN.jsp?pid=' + pid;
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
%>
<body class="home-bg">
    <div class="Ajax-loder">

        <div class="bg"></div>

        <img class="loading" src="<%=request.getContextPath()%>/images/276 (1).GIF"
             alt="loading...." /></div>

    <%@ include file="/header.jsp"%>

    <jsp:useBean id="sm" class="com.eminent.server.VpnController"></jsp:useBean>
    <%sm.setAll(request);
    %>


    <table style="width: 100%;background-color: #C3D9FF;font-weight: bold;">
        <tr>
            <td style="width:30%;text-align: left">Maintain SAP VPN Detail</td>
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
                <%if (roleValue == 1 || team.equalsIgnoreCase("basis")) {%>
                <a href="<%=request.getContextPath()%>/admin/project/maintainMonitoring.jsp?pid=<%=pid%>" >SAP Monitoring</a>&nbsp;&nbsp;&nbsp; 
                <%}%>
                <a href="<%=request.getContextPath()%>/admin/project/maintainSAPLogon.jsp?pid=<%=pid%>" >SAP Systems</a>&nbsp;&nbsp;&nbsp; 
            </td>
        </tr>
    </table>
    <br/>


    <%if (sm.getMessge() != null) {%>
    <div class="error2" style="text-align: center; font: bold;color:<%if (sm.getMessge().contains("success")) {%>green<%}%>">
        <%=sm.getMessge()%>
    </div>
    <%}%>

                    <%if (roleValue == 1 || team.equalsIgnoreCase("basis")) {%>

    <form name="monitorForm" method="post" action="<%=request.getContextPath()%>/admin/project/maintainSAPVPN.jsp">   

        <table width="70%" id="monitor" bgColor=#E8EEF7 border="0" align="center">
            <tr>
                <th>   <input type="hidden" name="pid" id="pid" value="<%=pid%>"/><input type="hidden" name="pid" id="pid" value="<%=pid%>"/>IP Address</th><th>Port No</th><th>Username</th><th>Password</th><th>URL</th></tr>          

            <tr>
                <td><input type="text" name="ipaddress" value="<%=sm.getVpn() == null ? "" : sm.getVpn().getVIpAdd()%>"><input type="hidden" name="id" value="<%=sm.getVpn() == null ? "" : sm.getVpn().getId()%>"></td>
                <td><input type="text" name="port" value="<%=sm.getVpn() == null ? "" : sm.getVpn().getVPort()%>"></td>
                <td><input type="text" name="username" value="<%=sm.getVpn() == null ? "" : sm.getVpn().getVUname()%>"></td>
                <td><input type="text" name="password" value="<%=sm.getVpn() == null ? "" : sm.getVpn().getVPwd()%>"></td>
                <td><input type="text" name="url" value="<%=sm.getVpn() == null ? "" : sm.getVpn().getVName()%>"></td>
            </tr>
        </table>

        <table width="70%" bgColor=#E8EEF7 border="0" align="center">
            <tr><td colspan="3" style="text-align: center;">
                    <input type="submit" value="Submit" name="submit" id="submit"> 
                </td>
            </tr>
        </table>        


    </form>
<%} else {%>
    
        <table width="70%" id="monitor" bgColor=#E8EEF7 border="0" align="center">
            <tr>
                <th> IP Address</th><th>Port No</th><th>Username</th><th>Password</th><th>URL</th></tr>          

            <tr>
                <td><%=sm.getVpn() == null ? "NA" : sm.getVpn().getVIpAdd()%></td>
                <td><%=sm.getVpn() == null ? "NA" : sm.getVpn().getVPort()%></td>
                <td><%=sm.getVpn() == null ? "NA" : sm.getVpn().getVUname()%></td>
                <td><%=sm.getVpn() == null ? "NA" : sm.getVpn().getVPwd()%></td>
                <td><%=sm.getVpn() == null ? "NA" : sm.getVpn().getVName()%></td>
            </tr>
        </table>
    <%}%>
            
</body>
<script src="<%=request.getContextPath()%>/javaScript/jquery-1.10.2.js"></script>
<script src="<%=request.getContextPath()%>/javaScript/jquery-ui.js"></script>

<script>
                        $("#submit").on("click", function () {

//                            $('span.error2').remove();
//                            var checkedVals = $('.serverMaintain:checkbox:checked').map(function () {
//                                return this.value;
//                            }).get();
//                            if (checkedVals.length === 0) {
//                                $("<span class='error2'>Please select the paramaters</span>").insertAfter("#submit");
//                                return false;
//                            } else {
//                                $(".Ajax-loder").show();
//                                return true;
//                            }
                        });
                        $(".Ajax-loder").hide();
</script>
</html>
