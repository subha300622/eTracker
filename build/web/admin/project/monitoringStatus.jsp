<%-- 
    Document   : manageServers
    Created on : 18 May, 2020, 12:59:40 PM
    Author     : vanithaalliraj
--%>


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
    <%sm.updateParameterStatus(request);
    %>
    <table style="width: 100%;background-color: #C3D9FF;font-weight: bold;">
        <tr>
            <td style="width:30%;text-align: left">Monitoring Status Report<a href="<%=request.getContextPath()%>/admin/project/parameterSetup.jsp?pid=<%=pid%>">Parameter Setup</a>&nbsp;&nbsp;&nbsp;<a href="<%=request.getContextPath()%>/admin/project/maintainMonitoring.jsp?pid=<%=pid%>">SAP Monitoring</a></td>
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

    <%
        if (!sm.getMatrixServers().isEmpty()) {
    %>
    <form name="theForm" >       
        <table width="100%" bgColor=#E8EEF7 border="0" style="text-align: " align="center">
              <tr>
                <td height="25" style="width: 15%;"><b>Company Code</b></td>
                <td>
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
                        <option value="0">Select</option>
                        <%for (SapServerType ss : sm.getAllServers()) {
                                if (sm.getMatrixServers().contains(ss.getSId())) {
                        %>
                        <option value="<%=ss.getSId()%>" <%if (ss.getSId() == sm.getServerId()) {%>selected<%}%>><%=ss.getServerName()%></option>
                        <%}
                            }%>
                    </select>
                </td>

            </tr>
        </table>
    </form>

    <%if (sm.getMessge() != null) {%>
    <div class="error2" style="text-align: center; font: bold;color:<%if (sm.getMessge().contains("success")) {%>green<%}%>">
        <%=sm.getMessge()%>
    </div>
    <%}%>

    <%if (!sm.getSapMonitoringParamaterses().isEmpty()) {%>
        <table width="100%"  border="1" align="center">
            <tr>
                <th>PARAMETER</th><input type="hidden" name="pid" id="pid" value="<%=pid%>"/>
            <input type="hidden" name="serverId" id="serverId" value="<%=sm.getServerId()%>"/>
            <%for (Integer systemId : sm.getMap().keySet()) {
                    for (SapSystemType ss : sm.getAllSystems()) {
                        if (systemId == ss.getSId()) {
            %>
            <th><%=ss.getSName()%></th>
                <%}
                        }
                    }%>
            </tr>


            <%int a=0,b=0; String color="#E8EEF7";
            for (SapMonitoringParamaters smp : sm.getSapMonitoringParamaterses()) {
                    if (sm.getCheckedParameters().contains(smp.getParameterId())) {
            if(a%2==0){color="white";}else{color="#E8EEF7";}
            %>
            <tr height="25" style="background-color: <%=color%>"> 
                <td ><%=smp.getParameterName()%></td>
                <%for (Integer systemId : sm.getMap().keySet()) {
                        for (ParameterStatus ss : sm.getMap().get(systemId)) {
                            if (smp.getParameterId() == ss.getParameterId()) {
                %>
                <td style="background-color:  <%if (ss.getParamStatus() == null) {%>red; <%} else {%><%}%>">
                 <%=ss.getParamStatus() == null ? "Not Monitored" : ss.getParamStatus()%>
                </td>
                <%}
                        }
                    }%>
            </tr>
            <%a++;}
                }%>
        </table>        
        
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
                        $(".Ajax-loder").hide();
                        $("#submit").on("click", function () {
                        });
</script>
</html>
