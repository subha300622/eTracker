<%-- 
    Document   : manageServers
    Created on : 18 May, 2020, 12:59:40 PM
    Author     : vanithaalliraj
--%>


<%@page import="com.eminent.server.SapMonitoringParamaters"%>
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

    <script>
        function callServer(theForm)
        {

            var x = document.getElementById("serverId").value;
            var pid = document.getElementById("pid").value;
            document.theForm.action = '/eTracker/admin/project/parameterSetup.jsp?pid=' + pid + "&serverId=" + x;
            document.theForm.submit();
        }
    </script>
    <style>
        th{
            font: bolder;
            color: black;
        }
    </style>

</head>
<%
    String pid = request.getParameter("pid");
    String category = "NA";
    //Getting User Id and Role
    Integer role = (Integer) session.getAttribute("Role");
    Integer uid = (Integer) session.getAttribute("userid_curr");
    String team = (String) session.getAttribute("team");
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
    <%sm.getParameterInputTypes(request);
    %>



    <table style="width: 100%;background-color: #C3D9FF;font-weight: bold;">
        <tr>
            <td style="width:30%;text-align: left">Parameter Setup &nbsp;&nbsp;&nbsp;<a href="<%=request.getContextPath()%>/admin/project/monitoringReport.jsp">Monitoring Report</a></td>

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
                <%if (role == 1 || team.equalsIgnoreCase("basis")) {%>
                <a href="<%=request.getContextPath()%>/admin/project/maintainMonitoring.jsp?pid=<%=pid%>&serverId=<%=sm.getServerId()%>" >SAP Monitoring</a>&nbsp;&nbsp;&nbsp; 
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
    <form name="theForm" >       
        <table width="70%" bgColor=#E8EEF7 border="0" align="center">
            <tr>
                <td height="21" style="width: 15%;"><b>Server Type</b></td>
                <td><input type="hidden" name="pid" id="pid" value="<%=pid%>"/>
                    <select name="serverId" id="serverId" onchange="callServer(this);">
                        <option value="">select</option>
                        <%for (SapServerType ss : sm.getAllServers()) {%>
                        <option value="<%=ss.getSId()%>" <%if (ss.getSId() == sm.getServerId()) {%>selected<%}%>><%=ss.getServerName()%></option>
                        <%}%>
                    </select>
                </td>
            </tr>
        </table>
    </form>
    <form name="parameterForm" method="post" action="<%=request.getContextPath()%>/admin/project/parameterSetup.jsp" >
        <table width="70%" id="monitor" bgColor=#E8EEF7 border="0" align="center">
            <tr><th>Parameter
                    <input type="hidden" name="pid" id="pid" value="<%=pid%>"/>
                    <input type="hidden" id="serverId" name="serverId" value="<%=sm.getServerId()%>"/>
                </th><th>Parameter Type</th><th>Parameter Value*(enter options by comma seperated)</th></tr>          
                    <%int count = 0;
                        if (sm.getSapMonitoringParamaterses() != null) {
                            for (SapMonitoringParamaters smp : sm.getSapMonitoringParamaterses()) {
                                count++;%>
            <tr>
                <td><input type="hidden" name="parameterId" value="<%=smp.getParameterId()%>"/>
                    <textarea name="paramaterName" id="paramaterName<%=count%>"><%=smp.getParameterName()%></textarea></td>
                <td>
                    <select name="parameterType" class="parameterType" id="parameterType<%=count%>">
                        <%for (String ss : sm.getAllInputTypes()) {%>
                        <option <%if (ss.equalsIgnoreCase(smp.getParameterType())) {%>selected<%}%>><%=ss%></option>
                        <%}%>
                    </select>
                </td>
                <td><textarea name="parameterValue"  id="parameterType<%=count%>"
                              <%if (smp.getParameterType().equalsIgnoreCase("text")) {%>readonly="true"<%}%>
                              ><%=smp.getParameterValues() == null ? "" : smp.getParameterValues()%></textarea></td>
            </tr>
            <%}
                }
                if (sm.getServerId() > 0) {%>

            <tr >

                <td>
<input type="hidden" name="parameterId" value="0"/>
                    <textarea name="paramaterName" class="paramaterName" id="paramaterName<%=count%>"></textarea></td>
                <td>
                    <select name="parameterType" class="parameterType" id="parameterType<%=count%>">
                        <%for (String ss : sm.getAllInputTypes()) {%>
                        <option ><%=ss%></option>
                        <%}%>
                    </select>
                </td>
                <td><textarea name="parameterValue" class="parameterValue" id="parameterValue<%=count%>"></textarea>
                    <%if (count > 0) {%>
                    <img class='deleteservertype'  src='/eTracker/images/remove.gif' alt='Remove Server Type' title='Remove Server Type'/>
                    <%}%>
                </td>
            </tr>
        </table>
        <table width="70%" bgColor=#E8EEF7 border="0" align="center">
            <tr><td colspan="3" style="text-align: center;">
                    <input type="button" id="addParamater" value="Add Parameter">
                    <input type="submit" value="Submit" name="submit" id="submit"> 
                </td>
            </tr>
        </table>
        <%}%>

    </form>

    <script src="<%=request.getContextPath()%>/javaScript/jquery-1.10.2.js"></script>
    <script src="<%=request.getContextPath()%>/javaScript/jquery-ui.js"></script>
</body>
<script>
                        $("#addParamater").on("click", function () {
                            $('span.error2').remove();
                            $('p.error2').remove();
                            $("#submit").hide();
                            var name = $("#monitor tr:last textarea[name='paramaterName']");
                            var type = $("#monitor tr:last select[name='parameterType']").val();
                            var val = $("#monitor tr:last textarea[name='parameterValue']");
                            var count = 0;
                            if (name.val() === '') {
                                name.css("border-color", "red");
                                name.focus();
                                $("<span class='error2'>Enter parameter name</span>").insertAfter("#addParamater");
                                count = 1;

                            }
                            if (count === 0) {
                                var values = [];
                                $('textarea[name="paramaterName"]').each(
                                        function () {
                                            $('span.error2').remove();
                                            if (values.indexOf(this.value) >= 0) {
                                                $(this).css("border-color", "red");
                                                this.focus();
                                                $("<span class='error2'>" + this.value + " is duplicate paraemeter name</span>").insertAfter("#addParamater");
                                                count = 1;
                                            } else {
                                                $(this).css("border-color", ""); //clears since last check
                                                values.push(this.value);

                                            }
                                        });
                            }
                            if (count === 0) {
                                if (type === 'Radio' || type === 'Checkbox') {
                                    if (val.val() === '') {
                                        val.focus();
                                        $("<span class='error2'>Enter parameter values with comma seperated</span>").insertAfter("#addParamater");
                                        ;
                                        count = 1;
                                    }
                                    if (count === 0) {
                                        if (val.val().length > 0) {
                                            var splitString = val.val().split(',').length;
                                            if (splitString === 1) {
                                                val.focus();
                                                $("<span class='error2'>Enter parameter values with comma seperated</span>").insertAfter("#addParamater");
                                                ;
                                                count = 1;
                                            }
                                        }
                                    }
                                }
                            }


                            if (count === 0) {
                                var tr = "<tr>\n\
<td><input type='hidden' name='parameterId' value='0'/><textarea  name='paramaterName'></textarea></td>\n\
<td><select name='parameterType' class='parameterType'><%for (String ss : sm.getAllInputTypes()) {%><option><%=ss%></option><%}%></select></td>\n\
<td><textarea  name='parameterValue'></textarea><img class='deleteservertype'  src='/eTracker/images/remove.gif' alt='Remove Server Type' title='Remove Server Type'/></td></tr>";
                                $("#monitor").append(tr);
                                $('#submit').show();
                            }
                        });
                        $('#monitor').on('click', '.deleteservertype', function () {
 $('span.error2').remove();
                            $(this).closest('tr').remove();
                        });
                        $('#monitor').on('change', '.parameterType', function () {
                            var val = $(this).val();
                            var next = $(this).closest('tr').find('[name=parameterValue]');
                            next.val("");
                            if (val === 'Text') {
                                next.attr('readonly', true);
                            } else {
                                next.attr('readonly', false);
                            }

                        });
                        $("#submit").on("click", function () {
                            $('span.error2').remove();
                            var name = $("#monitor tr:last textarea[name='paramaterName']");
                            var type = $("#monitor tr:last select[name='parameterType']").val();
                            var val = $("#monitor tr:last textarea[name='parameterValue']");
                            var count = 0;
                            if (name.val() === '') {
                                name.css("border-color", "red");
                                name.focus();
                                $("<span class='error2'>Enter parameter name</span>").insertAfter("#submit");
                                count = 1;

                            }
                            if (count === 0) {
                                var values = [];
                                $('textarea[name="paramaterName"]').each(
                                        function () {
                                            $('span.error2').remove();
                                            if (values.indexOf(this.value) >= 0) {
                                                $(this).css("border-color", "red");
                                                this.focus();
                                                $("<span class='error2'>" + this.value + " is duplicate paraemeter name</span>").insertAfter("#submit");
                                                count = 1;
                                            } else {
                                                $(this).css("border-color", ""); //clears since last check
                                                values.push(this.value);

                                            }
                                        });
                            }
                            if (count === 0) {
                                if (type === 'Radio' || type === 'Checkbox') {
                                    if (val.val() === '') {
                                        val.focus();
                                        $("<span class='error2'>Enter parameter values with comma seperated</span>").insertAfter("#submit");
                                        ;
                                        count = 1;
                                    }
                                    if (count === 0) {
                                        if (val.val().length > 0) {
                                            var splitString = val.val().split(',').length;
                                            if (splitString === 1) {
                                                val.focus();
                                                $("<span class='error2'>Enter parameter values with comma seperated</span>").insertAfter("#submit");
                                                ;
                                                count = 1;
                                            }
                                        }
                                    }
                                }
                            }



                            if (count == 0) {
                                $(".Ajax-loder").show();
                                return true;

                            } else {
                                return false;
                            }

                        }
                        );
                        $(".Ajax-loder").hide();

</script>
</html>
