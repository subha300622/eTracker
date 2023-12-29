<%-- 
    Document   : projectPeformanceChart
    Created on : 21 Jun, 2010, 1:19:02 PM
    Author     : ADAL
--%>

<%@ page import="org.apache.log4j.*"%>
<%@page import="dashboard.*,com.eminent.util.GetProjectMembers,com.eminent.util.GetProjectManager,com.eminent.util.IssueDetails, java.applet.*,java.util.*,com.eminent.timesheet.EminentPerformance,com.eminent.util.GetProjects"%>
<%@ include file="/header.jsp"%>
<%!
    int userId = GetProjectMembers.getAdminID();
%>
<%
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Cache-Control", "no-store");
    response.setDateHeader("Expires", 0);
    response.setHeader("Pragma", "no-cache");

    //Configuring log4j properties
    Logger logger = Logger.getLogger("userPerformanceChart");

    String logoutcheck = (String) session.getAttribute("Name");
    if (logoutcheck == null) {

%>
<jsp:forward page="/SessionExpired.jsp"></jsp:forward>
<%    }
    String pid = request.getParameter("pid");

    Calendar cl = Calendar.getInstance();
    cl.setTime(new Date());
    Long start = cl.getTimeInMillis();

    String project = GetProjects.getProjectName(pid);

    cl.setTime(new Date());
    Long end = cl.getTimeInMillis();
    System.out.println(end - start + "<----->getProjectName<----->");
    start = end;

    String Values[][] = ProjectPerformance.getValueList(pid);

    cl.setTime(new Date());
    end = cl.getTimeInMillis();
    System.out.println(end - start + "<----->ProjectPerformance.getValue(pid);<----->");
    start = end;

    String dueDate[][] = new String[0][0];
    try {
        logger.info("Project in JSP" + pid);
        dueDate = IssueDetails.dueDateExceededIssues(pid);
    } catch (Exception ex) {
        logger.error(ex.getMessage());
    }
%>
<html>
    <meta name="keywords" content="GST in SAP, SAP GST Accelerator, GST Success in SAP, GST India in SAP, GST SAP Success, GST Suvidha Provider, GST ASP GSP, GST, CGST,SGST, IGST, UGST,  SAP NW based Product Development, SAP Consulting, SAP Implementation, SAP Support Services, SAP Outsourcing, SAP Implementation India, SAP Implementation Bangalore, SAP Implementation Chennai, SAP Implementation Belgium, SAP Implementation Paris, SAP Implemtation Australia, SAP Implementation France, SAP Implementation Mumbai, SAP Implementation Kerala, SAP Implementation Belgaum, SAP Implementation Thailand, SAP Implementation Mexico, SAP Implementation America">
    <meta http-equiv="Content-Type" content="text/html">
    <TITLE>eTracker&#153; - Eminentlabs&#153; CRM, APM, TQM,  ERM and  EPTS Solution</TITLE>
    <LINK title=STYLE href="<%= request.getContextPath()%>/eminentech support files/main_ie.css" type="text/css" rel="STYLESHEET">
    <script type="text/javascript" src="<%=request.getContextPath()%>/fusion/fusioncharts.js?version=30032016"></script>
    <script type="text/javascript">
                function call(theForm)
                {
                var x = document.getElementById("pid").value;
                        theForm.action = 'projectPerformanceChart.jsp?pid=' + x;
                        theForm.submit();
                }
    </script>
</head>
<body>
    <%
        String category = CheckCategory.getProjectCategory(pid);
        String cases[][] = TestCases.showTestCases(pid);
        int noOfTestcases = cases.length;

        // Get Project governance people
        HashMap managers = GetProjectMembers.getProjectManagers(pid);
        int userId = (Integer) session.getAttribute("uid");
        int roleId = (Integer) session.getAttribute("Role");


    %>

    <table cellpadding="0" cellspacing="0" width="100%">
        <tr bgcolor="#C3D9FF">
            <td align="left" width="100%"><font size="4" COLOR="#0000FF"><b>Performance Chart of <%=GetProjects.getProjectName(pid).replace(":", " v")%></b></font><FONT SIZE="3" COLOR="#0000FF"></FONT></td>
        </tr>
    </table>
    <table width="100%" >
        <tr><td >

                <%
                    if (category.equalsIgnoreCase("SAP Project")) {
                %>
                <!--edit by mukesh end -->
                <a href="<%=request.getContextPath()%>/testMap.jsp?pid=<%=pid%>">Business Process Map</a>&nbsp;&nbsp;&nbsp;
                <!--edit by mukesh end -->
                <a href="<%=request.getContextPath()%>/admin/dashboard/projectChart.jsp?project=<%=project%>">Status-wise Dashboard</a>&nbsp;&nbsp;&nbsp;
                <%
                    }

                %>
                <a href="<%=request.getContextPath()%>/admin/dashboard/modulewiseChart.jsp?project=<%=project%>">Module-wise Dashboard</a>&nbsp;&nbsp;&nbsp;
                <%
                    if (noOfTestcases > 0) {
                %>              <a href="<%=request.getContextPath()%>/admin/dashboard/TestCasesChart.jsp?project=<%=pid%>">View Test Coverage</a>&nbsp;&nbsp;&nbsp;
                <%}%>
                <a href="<%=request.getContextPath()%>/UserProject/listProjectTestPlan.jsp?pid=<%=pid%>">View Test Plans</a>&nbsp;&nbsp;&nbsp;
                <a href="<%=request.getContextPath()%>/admin/dashboard/openIssueByProject.jsp?pid=<%=pid%>">View Issues</a>&nbsp;&nbsp;&nbsp;
                <a href="<%=request.getContextPath()%>/MOM/momProjectTeamWise.jsp?pid=<%=pid%>" title="Weekly Review MoM">WRM</a>&nbsp;&nbsp;&nbsp; 
                <%if (project.contains("eTracker")) {%>
                <a href="<%=request.getContextPath()%>/UserProfile/userException.jsp">Server Log</a>&nbsp;&nbsp;&nbsp;&nbsp;
                <%}%>
                <a href="<%=request.getContextPath()%>/CreateIssue/uploadIssues.jsp?pid=<%=pid%>" >Upload Issues</a>&nbsp;&nbsp;&nbsp; 
            </td>
        </tr>
    </table>
    <script type="text/javascript">
        FusionCharts.ready(function () {
        var hourlySalesChart = new FusionCharts({
        type: 'msline',
                renderAt: 'chart-container',
                width: '990',
                height: '450',
                dataFormat: 'json',
                dataSource: {

                //Vertical divline configuration
                "chart": {
                "caption": "<%=project%> Performance Chart",
                        "subcaption": "Last 1 year",
                        "xaxisname": "Month",
                        "showvalues": "0",
                        "paletteColors": "#FF0080,#58FA58,#FF8000,#088A08",
                        "bgColor": "#ffffff",
                        "showBorder":"0",
                        "showcanvasborder":"0",
                        "showXaxisline":"1",
                        "showYAxisline":"1",
                        "vDivLineColor": "#C3D9FF",
                        "numVDivLines": "12",
                        "numDivLines": "9",
                        "showAlternateHGridColor":"0",
                        "legendPosition":"RIGHT",
                        "exportEnabled": "1"
                },
                        "categories": [
                        {"category": [
        <%    try {

                for (int i = 0, k = 1; i < 12; i++, k++) {
                    String month = Values[i][0];
                    String total = Values[i][1];
                    String closed = Values[i][2];
                    String created = Values[i][3];
                    String mon = Values[i][4];
                    String open = Values[i][5];

                    String yr = month.substring(month.indexOf("-") + 1, month.length());

        %>

                        { "label": "<%=month%>" },
        <%

                }
            } catch (Exception e) {
                logger.error(e.getMessage());
            }
        %>

                        ]
                        }
                        ],
                        "dataset": [{"seriesname": "Open Issues", "linethickness": "2",
                                "data": [ <%    try {

                                        for (int i = 0, k = 1; i < 12; i++, k++) {
                                            String month = Values[i][0];
                                            String total = Values[i][1];
                                            String closed = Values[i][2];
                                            String created = Values[i][3];
                                            String mon = Values[i][4];
                                            String open = Values[i][5];

                                            String yr = month.substring(month.indexOf("-") + 1, month.length());

        %>

                                { "value": "<%=open%>",
                                        "link":'<%= request.getContextPath()%>/admin/user/eminentOpenIssues.jsp?month=<%=mon%>&year=<%=yr%>&pid=<%=pid%>' },
        <%

                }
            } catch (Exception e) {
                logger.error(e.getMessage());
            }
        %>




                                                                    ]
                                                            },
                                                            {
                                                            "seriesname": "Worked Issues",
                                                                    "linethickness": "2",
                                                                    "data": [ <%    try {

                                                                            for (int i = 0, k = 1; i < 12; i++, k++) {
                                                                                String month = Values[i][0];
                                                                                String total = Values[i][1];
                                                                                String closed = Values[i][2];
                                                                                String created = Values[i][3];
                                                                                String mon = Values[i][4];
                                                                                String open = Values[i][5];

                                                                                String yr = month.substring(month.indexOf("-") + 1, month.length());

        %>

                                                                    { "value": "<%=total%>",
                                                                            "link":'<%= request.getContextPath()%>/admin/user/eminentWorkedIssues.jsp?month=<%=mon%>&year=<%=yr%>&pid=<%=pid%>' },
        <%

                }
            } catch (Exception e) {
                logger.error(e.getMessage());
            }
        %>
                                                                                                        ]
                                                                                                },
                                                                                                {
                                                                                                "seriesname": "Created Issues",
                                                                                                        "linethickness": "2",
                                                                                                        "data": [ <%    try {

                                                                                                                for (int i = 0, k = 1; i < 12; i++, k++) {
                                                                                                                    String month = Values[i][0];
                                                                                                                    String total = Values[i][1];
                                                                                                                    String closed = Values[i][2];
                                                                                                                    String created = Values[i][3];
                                                                                                                    String mon = Values[i][4];
                                                                                                                    String open = Values[i][5];

                                                                                                                    String yr = month.substring(month.indexOf("-") + 1, month.length());

        %>

                                                                                                        { "value": "<%=created%>",
                                                                                                                "link":'<%= request.getContextPath()%>/admin/user/eminentCreatedIssues.jsp?month=<%=mon%>&year=<%=yr%>&pid=<%=pid%>' },
        <%

                }
            } catch (Exception e) {
                logger.error(e.getMessage());
            }
        %>




                                                                                                                                            ]
                                                                                                                                    },
                                                                                                                                    {
                                                                                                                                    "seriesname": "Closed Issues",
                                                                                                                                            "linethickness": "2",
                                                                                                                                            "data": [ <%    try {

                                                                                                                                                    for (int i = 0, k = 1; i < 12; i++, k++) {
                                                                                                                                                        String month = Values[i][0];
                                                                                                                                                        String total = Values[i][1];
                                                                                                                                                        String closed = Values[i][2];
                                                                                                                                                        String created = Values[i][3];
                                                                                                                                                        String mon = Values[i][4];
                                                                                                                                                        String open = Values[i][5];

                                                                                                                                                        String yr = month.substring(month.indexOf("-") + 1, month.length());

        %>

                                                                                                                                            { "value": "<%=closed%>",
                                                                                                                                                    "link":'<%= request.getContextPath()%>/admin/user/eminentClosedIssues.jsp?month=<%=mon%>&year=<%=yr%>&pid=<%=pid%>' },
        <%

                }
            } catch (Exception e) {
                logger.error(e.getMessage());
            }
        %>




                                                                                                                                                                                ]
                                                                                                                                                                        }

                                                                                                                                                                        ]
                                                                                                                                                                }
                                                                                                                                                        }).render();
                                                                                                                                                        });</script>

    <div id="chart-container" class="chartarea"></div>

    <form name="theForm" onSubmit='return fun(this)'>
        <table width="100%" bgcolor="#C3D9FF" border="0">
            <tr align="center">
                <td width="20%"><b>Project</b></td>
                <td width="20%" align="left">
                    <select id="pid" name="pid" size=1
                            onchange="javascript:call(this.form)">


                        <%
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
                            Iterator iter = se.iterator();
                            int projectId = 0;
                            while (iter.hasNext()) {

                                String key = (String) iter.next();
                                String nameofproject = (String) projects.get(key);
                                logger.info("Userid" + key);
                                logger.info("Name" + nameofproject);
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
                        %>
                    </select>
                </td>
                <%                    int noOfIssues = dueDate.length;
                    if (noOfIssues > 0) {
                %>
                <td width="20%"><b>Number Of Due Date Exceeded Issues :</b></td>
                <td align="left"><a href="<%=request.getContextPath()%>/admin/dashboard/dueDateExceedIssues.jsp?pid=<%=pid%>"><b><%=noOfIssues%></b></a></td>
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

