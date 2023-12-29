<%--
    Document   : TestCasesChart
    Created on : 10 Jun, 2010, 8:26:41 AM
    Author     : Tamilvelan
--%>
<%@page  import="dashboard.*,com.eminent.util.GetProjectMembers,org.apache.log4j.*,com.eminent.util.GetProjects,com.eminent.util.IssueDetails,java.util.*,java.util.HashMap,com.eminent.util.GetProjectManager"%>
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
<%
    }

%>
<html>
    <meta name="keywords" content="GST in SAP, SAP GST Accelerator, GST Success in SAP, GST India in SAP, GST SAP Success, GST Suvidha Provider, GST ASP GSP, GST, CGST,SGST, IGST, UGST,  SAP NW based Product Development, SAP Consulting, SAP Implementation, SAP Support Services, SAP Outsourcing, SAP Implementation India, SAP Implementation Bangalore, SAP Implementation Chennai, SAP Implementation Belgium, SAP Implementation Paris, SAP Implemtation Australia, SAP Implementation France, SAP Implementation Mumbai, SAP Implementation Kerala, SAP Implementation Belgaum, SAP Implementation Thailand, SAP Implementation Mexico, SAP Implementation America">
        <meta http-equiv="Content-Type" content="text/html">
        <title>eTracker&#0153; - Eminentlabs CRM,APM,ERM and PTS Solution</title>
        <LINK title=STYLE href="<%= request.getContextPath()%>/eminentech support files/main_ie.css" type="text/css" rel=STYLESHEET>
        <script type="text/javascript" src="<%=request.getContextPath()%>/fusion/fusioncharts.js?version=30032016"></script>

        <script>
            function call(theForm)
            {
                var x = document.getElementById("project").value;
                theForm.action = 'TestCasesChart.jsp?project=' + x;
                theForm.submit();

            }
        </script>
    </head>
    <body>
        <%
            int noOfTestcases = 0;
            String pid = request.getParameter("project");
            String project = GetProjects.getProjectName(pid);
            logger.info("Pid--->" + pid);
            String moduleTestCases[][] = TestCases.showTestCases(pid);
            noOfTestcases = moduleTestCases.length;
            logger.info("No fo Modules" + noOfTestcases);
            Random randomGenerator = new Random();

            // Get Project governance people
            HashMap managers = GetProjectMembers.getProjectManagers(pid);

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

            Collection se = projects.keySet();

        %>
        <%@ include file="/header.jsp"%>
        <table cellpadding="0" cellspacing="0" width="100%" bgColor="#C3D9FF">
            <tr  bgColor="#C3D9FF">
                <td  align="left" width="100%"><font size="4" COLOR="#0000FF"><b>Project Test Coverage</b></font></td>
            </tr>
        </table>
        <table width="100%" >
            <tr>
                <td width="1%">

                    <%    String category = CheckCategory.getProjectCategory(pid);
                        if (category.equalsIgnoreCase("SAP Project")) {
                    %>
                    <!--edit by mukesh end -->
                    <a href="<%=request.getContextPath()%>/testMap.jsp?pid=<%=pid%>">Business Process Map Dashboard</a>&nbsp;&nbsp;&nbsp;
                    <!--edit by mukesh end -->
                    <a href="<%=request.getContextPath()%>/admin/dashboard/projectChart.jsp?project=<%=project%>">Status-wise Dashboard</a>&nbsp;&nbsp;&nbsp;
                    <%
                        }

                    %>
                    <a href="<%=request.getContextPath()%>/admin/dashboard/modulewiseChart.jsp?project=<%=project%>">Module-wise Dashboard</a>&nbsp;&nbsp;&nbsp;
                    <a href="<%=request.getContextPath()%>/UserProject/listProjectTestPlan.jsp?pid=<%=pid%>">View Test Plans</a> &nbsp;&nbsp;&nbsp;
                    <a href="<%=request.getContextPath()%>/admin/dashboard/projectPerformanceChart.jsp?pid=<%=pid%>">View Project Performance</a>&nbsp;&nbsp;&nbsp;


                    <a href="<%=request.getContextPath()%>/admin/tqm/listPTC.jsp?pid=<%=pid%>">View All Test Cases</a> &nbsp;&nbsp;&nbsp;
                    <a href="<%=request.getContextPath()%>/admin/dashboard/openIssueByProject.jsp?pid=<%=pid%>">View Issues</a>&nbsp;&nbsp;&nbsp;
                    <a href="<%=request.getContextPath()%>/MOM/momProjectTeamWise.jsp?pid=<%=pid%>" title="Weekly Review MoM">WRM</a>&nbsp;&nbsp;&nbsp; 
                    <%if (project.contains("eTracker")) {%>
                    <a href="<%=request.getContextPath()%>/UserProfile/userException.jsp">Server Log</a>&nbsp;&nbsp;&nbsp;&nbsp;
                    <%}%>
                          <a href="<%=request.getContextPath()%>/CreateIssue/uploadIssues.jsp?pid=<%=pid%>" >Upload Issues</a>&nbsp;&nbsp;&nbsp; 
                </td>
            </tr>
        </table>
        <%
            if (noOfTestcases > 0) {
        %>

        <script type="text/javascript">
            FusionCharts.ready(function() {
                var ageGroupChart = new FusionCharts({
                    type: 'pie3d',
                    renderAt: 'chart-container2',
                    width: '850',
                    height: '500',
                    dataFormat: 'json',
                    dataSource: {
                        "chart": {
                            "caption": "Test coverage statistics",
                            "subCaption": "For  <%=project%>",
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
            <%
                for (int k = 0; k < noOfTestcases; k++) {
            %>
                            {
                                "label": "<%=moduleTestCases[k][1]%>",
                                "value": "<%= moduleTestCases[k][2]%>",
                                "link": '<%= request.getContextPath()%>/admin/dashboard/viewTestCases.jsp?mid=<%=moduleTestCases[k][0]%>&pid=<%=pid%>'
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


        <table cellpadding="0" cellspacing="0" width="100%" datapagesize="25">
            <tr>
                <td  align="center" width="100%"><font size="4" COLOR="#0000FF"><b>No Test Cases Available</b></font></td>
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
        <%
            }
        %>
        <form name="theForm" onSubmit='return fun(this)'>
            <table width="100%" bgcolor="#C3D9FF">
                <tr align="center">
                    <td width="10%"><b>Project</b></td>
                    <td width="20%" align="left">
                        <select id="project" name="project" size=1
                                onchange="javascript:call(this.form)">


                            <%
                                Iterator iter = se.iterator();
                                int projectId = 0;
                                while (iter.hasNext()) {

                                    String key = (String) iter.next();
                                    String nameofproject = (String) projects.get(key);
                                    //      logger.info("Userid"+key);
                                    //      logger.info("Name"+nameofuser);
                                    projectId = Integer.parseInt(key);
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
                    </td>
                    <%                    logger.info("Project Id" + pid);
                        //Displaying all the Test case status for project
                        HashMap<String, String> testCaseStatus = IssueDetails.getTestCaseStatus(pid);
                        logger.info("No Of Status" + testCaseStatus.size());
                        Collection set = testCaseStatus.keySet();
                        Iterator it = set.iterator();
                        while (it.hasNext()) {
                            String key = (String) it.next();
                            String nameofstatus = (String) testCaseStatus.get(key);
                            logger.info("Userid" + key);
                            logger.info("Name" + nameofstatus);
                    %>
                    <td><b><%=key%><%="  :  "%><%=nameofstatus%></b></td>
                    <%
                        }


                    %>
                </tr>
            </table>
        </form>

<script src="//code.jquery.com/jquery-1.10.2.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/fusion/fusiontrailremover.js"></script>
    </body>
</html>
