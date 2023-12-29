<%-- 
    Document   : dashboardForCompany
    Created on : 5 Nov, 2011, 4:52:51 PM
    Author     : Tamilvelan
--%>
<%@page import="com.eminent.util.GetProjectManager"%>
<%@page import="dashboard.CheckCategory"%>
<%@page import="org.apache.log4j.Logger,org.apache.log4j.PropertyConfigurator,com.eminentlabs.userBPM.ViewBPM,java.util.LinkedHashMap,java.util.HashMap" %>
<%@page import="com.eminent.util.GetProjectMembers,java.util.Iterator,java.util.Collection,com.eminent.util.GetProjects,dashboard.TestCases" %>
<%
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Cache-Control", "no-store");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);

    //Configuring log4j properties
    Logger logger = Logger.getLogger("Test Case Chart");

    String sessionCheck = (String) session.getAttribute("Name");
    if (sessionCheck == null) {
%>
<jsp:forward page="/SessionExpired.jsp"></jsp:forward>
<%    }

%>


<html>
    <meta name="keywords" content="GST in SAP, SAP GST Accelerator, GST Success in SAP, GST India in SAP, GST SAP Success, GST Suvidha Provider, GST ASP GSP, GST, CGST,SGST, IGST, UGST,  SAP NW based Product Development, SAP Consulting, SAP Implementation, SAP Support Services, SAP Outsourcing, SAP Implementation India, SAP Implementation Bangalore, SAP Implementation Chennai, SAP Implementation Belgium, SAP Implementation Paris, SAP Implemtation Australia, SAP Implementation France, SAP Implementation Mumbai, SAP Implementation Kerala, SAP Implementation Belgaum, SAP Implementation Thailand, SAP Implementation Mexico, SAP Implementation America">
    <meta http-equiv="Content-Type" content="text/html">
    <title>eTracker&#0153; - Eminentlabs&#0153; CRM, BPM, APM, TQM, ERM and EPTS Solution</title>
    <LINK title=STYLE href="<%= request.getContextPath()%>/eminentech support files/main_ie.css" type="text/css" rel=STYLESHEET>
    <script type="text/javascript" src="<%=request.getContextPath()%>/fusion/fusioncharts.js?version=30032016"></script>
</head>
<body>

    <script>
        function call(theForm)
        {
            var x = document.getElementById("pid").value;
            theForm.action = 'dashboardForCompany.jsp?pid=' + x;
            theForm.submit();
        }
    </script>

    <%

        String pid = request.getParameter("pid");
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
    <%@ include file="/header.jsp"%>
    <table cellpadding="0" cellspacing="0" width="100%" bgColor="#C3D9FF">
        <tr  bgColor="#C3D9FF">
            <td  align="left" width="100%"><font size="4" COLOR="#0000FF"><b>View <%=GetProjects.getProject(Integer.parseInt(pid))%> Test Map Dashboard</b></font></td>
        </tr>
    </table>
    <table>
        <tr style="height:20px">
            <td>
                <a href="<%=request.getContextPath()%>/testMap.jsp?pid=<%=pid%>">Test Map Tree View</a>&nbsp;&nbsp;&nbsp;
                <%if (category.equalsIgnoreCase("SAP Project")) {
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
            </td>
        </tr>
        <tr>
            <td><span title="Client"><%=clientName%></span> >> <b>Company Code</b></td>
        </tr>
    </table>
    <%
        int sizeOftheCompany = company.size();
        if (sizeOftheCompany > 0) {
            int colorNo = 0;
            Collection set = company.keySet();
            Iterator ite = set.iterator();
            int k = 0;
            int bpCount = 1;

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
                        "caption": "Company Code",
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
        <%                while (ite.hasNext()) {
                int key = (Integer) ite.next();
                String nameofcomp = (String) company.get(key);
                logger.info("Value===>>" + nameofcomp);

                bpCount = ViewBPM.getBPCount(key);
                if (bpCount == 0) {
                    bpCount = 1;
                }
        %>
                        {
                            "label": "<%=nameofcomp%>",
                            "value": "<%= bpCount%>",
                            "link": '<%= request.getContextPath()%>/UserBPM/dashboardForBP.jsp?companyid=<%=key%>&pid=<%=pid%>&companyName=<%=nameofcomp%>&clientName=<%=clientName%>'
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
    } else {
    %>
    <br>
    <br>
    <br>
    <br>
    <br>
    <br>
    <br>
    <br>
    <br>
    <br>
    <br>
    <br>
    <br>
    <br>

    <table cellpadding="0" cellspacing="0" width="100%" datapagesize="25">
        <tr>
            <td  align="center" width="100%"><font size="4" COLOR="#0000FF"><b>No Company Code Available</b></font></td>
        </tr>
    </table>
    <br>
    <br>
    <br>
    <br>
    <br>
    <br>
    <br>
    <br>
    <br>
    <br>
    <br>
    <br>
    <br>
    <br>
    <br>
    <br>
    <br>
    <%    }
    %>
    <!-- edit by mukesh -->
    <form name="theForm" onSubmit='return fun(this)'>
        <table width="100%" border="0" bgcolor="#E8EEF7" cellpadding="0"
               align="center">


            <tr>
                <td><font face="Book Antiqua">Project : </font></td>
                <td><select id="pid" name="pid" size=1 
                            onchange="javascript:call(this.form)">
                        <strong class="style20"></strong>

                        <%
                            Iterator iter3 = se1.iterator();
                            int projectId = 0;
                            while (iter3.hasNext()) {
                                String key1 = (String) iter3.next();
                                String nameofproject = (String) projects.get(key1);
//      logger.info("Userid"+key);
                                //      logger.info("Name"+nameofuser);
                                projectId = Integer.parseInt(key1);

                                if (projectId == Integer.parseInt(pid)) {
                        %>
                        <option value="<%=pid%>" selected><%=nameofproject%></option>
                        <%
                        } else {
                        %>
                        <option value="<%=projectId%>"><%=nameofproject%></option>
                        <%
                                }

                            }

                        %>
                    </select>                              
            </tr>

        </table>

    </form>  
    <script src="//code.jquery.com/jquery-1.10.2.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/fusion/fusiontrailremover.js"></script>                             
</body>
</html>
