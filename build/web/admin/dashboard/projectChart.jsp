<%-- 
    Document   : projectChart
    Created on : Nov 21, 2012, 11:54:03 AM
    Author     : Tamilvelan
--%>

<%@page pageEncoding="UTF-8"%>
<%@ page import="org.apache.log4j.*"%>
<%@page import="dashboard.*, java.applet.*,java.util.*,com.eminent.util.GetProjects,com.eminent.util.GetProjectMembers,dashboard.TestCases"%>

<%
    session.setAttribute("forwardpage", "/MyAssignment/UpdateIssue.jsp");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Cache-Control", "no-store");
    response.setDateHeader("Expires", 0);
    response.setHeader("Pragma", "no-cache");

                        //Configuring log4j properties
    

    Logger logger = Logger.getLogger("displayChart");
  
    String logoutcheck = (String) session.getAttribute("Name");
    if (logoutcheck == null) {

%>
<jsp:forward page="/SessionExpired.jsp"></jsp:forward>
<%    }


%>

<%--
The taglib directive below imports the JSTL library. If you uncomment it,
you must also add the JSTL library to the project. The Add Library... action
on Libraries node in Projects view can be used to add the JSTL 1.1 library.
--%>
<%--
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%> 
--%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <meta name="keywords" content="GST in SAP, SAP GST Accelerator, GST Success in SAP, GST India in SAP, GST SAP Success, GST Suvidha Provider, GST ASP GSP, GST, CGST,SGST, IGST, UGST,  SAP NW based Product Development, SAP Consulting, SAP Implementation, SAP Support Services, SAP Outsourcing, SAP Implementation India, SAP Implementation Bangalore, SAP Implementation Chennai, SAP Implementation Belgium, SAP Implementation Paris, SAP Implemtation Australia, SAP Implementation France, SAP Implementation Mumbai, SAP Implementation Kerala, SAP Implementation Belgaum, SAP Implementation Thailand, SAP Implementation Mexico, SAP Implementation America">



        <title>eTracker&#153; - Eminentlabs&#153; CRM, APM, TQM,  ERM and  EPTS
            Solution</title>
        <LINK title=STYLE
              href="<%= request.getContextPath()%>/eminentech support files/main_ie.css"
              type="text/css" rel=STYLESHEET>
        <script type="text/javascript" src="<%=request.getContextPath()%>/fusion/fusioncharts.js?version=30032016"></script>
    </head>

    <script>
                function call(theForm)
                {
                var x = document.getElementById("project").value;
                        theForm.action = 'projectChart.jsp?project=' + x;
                        theForm.submit();
                }
    </script>
    <body>
        <%@ include file="/header.jsp"%>
        <table cellpadding="0" cellspacing="0" width="100%">
            <tr border="2" bgColor="#C3D9FF">
                <td bgcolor="#C3D9FF" border="1" align="left" width="100%"><font
                        size="4" COLOR="#0000FF"><b>Status-wise Project Dashboard </b></font></td>
            </tr>
        </table>
        <br>

        <%!
            String[] priority = {"P1-Now", "P2-High", "P3-Medium", "P4-Low"};

            String[] status = {"Unconfirmed", "Rejected", "Duplicate", "User Error", "Documentation", "Review", "Training", "Evaluation", "Investigation", "Confirmed", "QA-BTC", "QA-BTC Review",
                "Replicating in DS",
                "Detail Design",
                "Customizing Request",
                "Workbench Request",
                "Code Review",
                "Solution Review",
                "Transport to TS",
                "QA-TCE",
                "Transport to PS",
                "Verified"};

        %>
        <%

            String project = request.getParameter("project");
            String phase = request.getParameter("phase");

            if (!project.equalsIgnoreCase("NA")) {

                logger.info("Project :" + project);

                if (phase == null) {

                    ArrayList<String> parseDetails = dashboard.Project.getDetails(project);
                    phase = parseDetails.get(1);

                }

               //Identifying category and type provided it is a project
                HashMap<String, Integer> hm = dashboard.MaxIssue.getIssueCount(project);
                logger.info("Issue Count" + hm);
                String pid = GetProjects.getProjectId(project);
                String cases[][] = TestCases.showTestCases(pid);
                int noOfTestcases = cases.length;
                // Get Project governance people
                HashMap managers = GetProjectMembers.getProjectManagers(pid);
                int userId = (Integer) session.getAttribute("uid");
                int roleId = (Integer) session.getAttribute("Role");
                String category = "NA";
                if (project != null) {
                    category = CheckCategory.getCategory(project);
                }

        %>
        <table width="100%">
            <tr>
                <td width="5%">
                    <%                    if (category.equalsIgnoreCase("SAP Project")) {
                    %>
                    <a href="<%=request.getContextPath()%>/testMap.jsp?pid=<%=pid%>">Business Process Map</a>&nbsp;&nbsp;&nbsp;
                    <a href="<%=request.getContextPath()%>/admin/dashboard/displayChart.jsp?project=<%=project%>">Phase-wise Dashboard</a>&nbsp;&nbsp;&nbsp;
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
                </td>
            </tr>
        </table>
        <table width="100%">
            <tr>
                <td width="5%">
                    <%

                        int maximum = hm.get("maximum");
                        logger.debug("Maximum" + maximum);
                        int yetToAdd = 10 - (maximum % 10);

                        int chartScale = (maximum + yetToAdd) / 10;


                    %>


                    <script type="text/javascript">
                        FusionCharts.ready(function() {
                        var stackedChart = new FusionCharts({
                        type: 'stackedcolumn3d',
                                renderAt: 'chartcontainer',
                                width: '1000',
                                height: '500',
                                dataFormat: 'json',
                                "dataSource": {
                                "chart": {
                                "caption": "Issue Statistics",
                                        "yAxisName": "Issues",
                                        //                     
                                        //                                                   "showSum": "1",
                                        "formatnumber":"0",
                                        "formatnumberscale":"0",
                                        "sformatnumber":"0",
                                        "sformatnumberscale":"0",
                                        "yAxisMinValue":"0",
                                        "yAxisMaxValue":"10",
                                        "bgColor": "#ffffff",
                                        "borderAlpha": "20",
                                        "showCanvasBorder": "10",
                                        "usePlotGradientColor": "0",
                                        "plotBorderAlpha": "10",
                                        "legendBorderAlpha": "0",
                                        "legendShadow": "0",
                                        "valueFontColor": "#000",
                                        "showXAxisLine": "1",
                                        "xAxisLineColor": "#999999",
                                        "divlineColor": "#999999",
                                        "divLineIsDashed": "1",
                                        "showAlternateHGridColor": "0",
                                        "subcaptionFontBold": "0",
                                        "subcaptionFontSize": "14",
                                        "showHoverEffect":"1",
                                        "canvasBgColor":"#ffffff",
                                        "canvasbgAlpha":"0",
                                        "labelDisplay": "rotate",
                                        "slantLabels": "1",
                                        "legendPosition":"RIGHT",
                                        "exportEnabled": "1",
                                        "canvasBaseColor":"#ffffff"

                                },
                                        "categories": [
                                        {
                                        "category": [
                        <%                for (int i = 1; i <= status.length; i++) {%>
                                        {
                                        "label": "<%=status[i - 1]%>"
                                        },
                        <%}%>
                                        ]
                                        }
                                        ],
                                        "dataset": [
                        <%int priorityIndex = 0;
                                    for (int j = 1; j <= priority.length; j++) {
                                        int statusIndex = 0;
                        %>
                                        {
                                        "seriesname": "<%=priority[j - 1]%>",
                        <%if (priorityIndex == 0) {%>
                                        "color": '#FF0000',
                        <%} else if (priorityIndex == 1) {%>
                                        "color": '#DF7401',
                        <%} else if (priorityIndex == 2) {%>
                                        "color": '#F7FE2E',
                        <%} else if (priorityIndex == 3) {%>
                                        "color": '#04B45F',
                        <%}%>
                                        "data": [
                        <%  for (int i = 1; i <= status.length; i++) {

                                        int checkForZero = CountIssue.getCount(project, status[statusIndex], priority[priorityIndex]);
                                        if (checkForZero > 0) {%>
                                        {    "value": "<%=checkForZero%>",
                                                "link":'<%=  request.getContextPath()%>/admin/dashboard/issuesForProject.jsp?project=<%= project%>&status=<%= status[statusIndex]%>&priority=<%= priority[priorityIndex]%>'

                                                                    },
                        <%} else {%> {
                                                                            "value": ""
                                                                            },<%}
                                                                                            statusIndex += 1;
                                                                                        }%>]
                                                                    },<%
                                                                                    priorityIndex += 1;
                                                                                }%>
                                                                    ]
                                                            }
                                                    });
                                                            stackedChart.render();
                                                    });</script><div id="chartcontainer" class="chartarea">FusionCharts XT will load here!</div>


                    <form name="theForm" onSubmit='return fun(this)'>
                        <table width="100%" border="0" bgcolor="#E8EEF7" cellpadding="0"
                               align="center">


                            <tr>
                                <td><font face="Book Antiqua">Project : </font></td>
                                <td><select id="project" name="project" size=1 
                                            onchange="javascript:call(this.form)">
                                        <strong class="style20"></strong>

                                        <%
                                            //Getting User Id and Role
                                            Integer role = (Integer) session.getAttribute("Role");
                                            Integer uid = (Integer) session.getAttribute("userid_curr");
                                            int roleValue = role.intValue();
                                            int uidValue = uid.intValue();

                                            //Displaying all the projects for Admin role
                                            ArrayList<String> al = null;
                                            if (roleValue == 1) {
                                                al = CountIssue.getAllProject();
                                            } else {
                                                //Displaying only assigned projects to other roles        
                                                al = CountIssue.getProjectForUser(uidValue);
                                            }

                                            for (String dbProject : al) {
                                                if (project.equalsIgnoreCase(dbProject)) {
                                        %>
                                        <option value="<%= project%>" selected><%= project%> <%
                                        } else {
                                            %>

                                        <option value="<%= dbProject%>"><%= dbProject%> <%
                                                }
                                            }


                                            %>
                                    </select>
                                <td><font face="Book Antiqua">Phase&nbsp;:&nbsp;<%= phase%></font></td>


                                <%

                                    if (hm.get("closed") + hm.get("altogether") != 0) {
                                %>
                                <td><font face="Book Antiqua">Closed&nbsp;:&nbsp;<%=  hm.get("closed")%></font></td>
                                <td><font face="Book Antiqua">Total&nbsp;:&nbsp;<%= (hm.get("closed") + hm.get("altogether"))%></font></td>
                                <td><font face="Book Antiqua"> Completion&nbsp;:&nbsp;<%= (dashboard.ArithOperation.calcPercentage((hm.get("closed") + hm.get("altogether")), hm.get("closed"))) + "%"%></font></td>
                                        <%
                                        } else {

                                        %>
                                <td><font face="Book Antiqua">Status&nbsp;:&nbsp;To be
                                        started </font></td>
                                        <%                            }
                                        } else {
                                        %>
                            <br></br>
                            <br></br>
                            <table align="center">
                                <tr>
                                    <td><font face="Times New Roman" size="2"><b>No Projects Assigned to You</b></font><td>
                                <tr>
                            </table>
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


