<%-- 
    Document   : statuswiseChart
    Created on : 5 Oct, 2011, 1:05:13 PM
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
                theForm.action = 'displayChart.jsp?project=' + x;
                theForm.submit();
        }
    </script>
    <body>
        <%@ include file="/header.jsp"%>
        <table cellpadding="0" cellspacing="0" width="100%">
            <tr border="2" bgColor="#C3D9FF">
                <td bgcolor="#C3D9FF" border="1" align="left" width="100%"><font
                        size="4" COLOR="#0000FF"><b>Project Dashboard </b></font></td>
            </tr>
        </table>
        <br>

        <%!
            String[] priority = {"P1-Now", "P2-High", "P3-Medium", "P4-Low"};

            String[] status = {"Unconfirmed", "Rejected", "Duplicate", "User Error", "Documentation", "Review", "Training", "Evaluation", "Investigation", "Confirmed", "QA-BTC", "Development",
                "Workinprogress", "Code Review", "ReadytoBuild", "QA-TCE", "Performance QA", "Verified"};

        %>
        <%

            String project = request.getParameter("project");
            String phase = request.getParameter("phase");

            if (!project.equalsIgnoreCase("NA")) {

                logger.info("Project :" + project);
                logger.info("Phase :" + phase);

                String category = "NA";

                if (phase == null) {

                    ArrayList<String> parseDetails = dashboard.Project.getDetails(project);
                    phase = parseDetails.get(1);

                }

                //Identifying category and type provided it is a project
                if (project != null) {
                    category = CheckCategory.getCategory(project);
                }
                logger.info("Category :" + category);

                HashMap<String, Integer> hm = dashboard.MaxIssue.getIssueCount(project);

                String pid = GetProjects.getProjectId(project);
                String cases[][] = TestCases.showTestCases(pid);
                int noOfTestcases = cases.length;
                // Get Project governance people
                HashMap managers = GetProjectMembers.getProjectManagers(pid);
                int userId = (Integer) session.getAttribute("uid");
                int roleId = (Integer) session.getAttribute("Role");

        %>
        <table width="100%">
            <tr>
                <td width="5%">
                    <a href="<%=request.getContextPath()%>/admin/dashboard/modulewiseChart.jsp?project=<%=project%>">Module-wise Dashboard</a>&nbsp;&nbsp;&nbsp;
                    <%
                        if (noOfTestcases > 0) {
                    %>
                    <a href="<%=request.getContextPath()%>/admin/dashboard/TestCasesChart.jsp?project=<%=pid%>">View Test Coverage</a>&nbsp;&nbsp;&nbsp;
                    <%}%>
                    <a href="<%=request.getContextPath()%>/admin/dashboard/projectPerformanceChart.jsp?pid=<%=pid%>">View Project Performance</a>&nbsp;&nbsp;&nbsp;
                    <a href="<%=request.getContextPath()%>/UserProject/listProjectTestPlan.jsp?pid=<%=pid%>">View Test Plans</a>&nbsp;&nbsp;&nbsp;
                    <%

                        if (category.equalsIgnoreCase("SAP Project")) {
                    %>
                    <a href="<%=request.getContextPath()%>/admin/dashboard/displayChart.jsp?project=<%=project%>">Phase wise Chart</a>&nbsp;&nbsp;&nbsp;
                    <%
                        }
                    %>
                </td>
            </tr>
        </table>
        <%
            if (category.equalsIgnoreCase("SAP Project")) {
                String type = null;
                type = CheckCategory.getProjectType(project);
                logger.debug("Type :" + type);

                ArrayList<String> phases = ASAPPhase.getPhases(type);
                logger.debug("phase count :" + phases.size());

                int countFirst = CountProjectIssue.getCount(project, phases.get(0), type);
                int countSecond = CountProjectIssue.getCount(project, phases.get(1), type);
                int countThird = CountProjectIssue.getCount(project, phases.get(2), type);
                int countFourth = CountProjectIssue.getCount(project, phases.get(3), type);
                int countFifth = CountProjectIssue.getCount(project, phases.get(4), type);

                if (countFirst == 0 && countSecond == 0 && countThird == 0 && countFourth == 0 && countFifth == 0) {
        %>
        <table width="100%" height="60%" border="0" cellpadding="0"
               align="center">
            <tr>
                <td>
                    <center>There are no issues</center>
                </td>
            </tr>

            <%
            } else {
            %>

            <!--  Displaying pie chart for the project -->

            <script type="text/javascript">
                FusionCharts.ready(function() {
                var ageGroupChart = new FusionCharts({
                type: 'pie3d',
                        renderAt: 'chart-container2',
                        width: '950',
                        height: '500',
                        dataFormat: 'json',
                        dataSource: {
                        "chart": {
                        "caption": "Phase wise dashboard",
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
                                "showHoverEffect":"1",
                                "showLegend": "1",
                                "legendBgColor": "#ffffff",
                                "legendBorderAlpha": '0',
                                "legendShadow": '0',
                                "legendItemFontSize": '10',
                                "exportEnabled": "1",
                                "legendItemFontColor": '#666666'
                        },
                                "data": [
                <%
                    int k = 0;
                    for (String phasea : phases) {
                %>
                                {
                                "label": "<%=phasea%>",
                                        "value": "<%= CountProjectIssue.getCount(project, phases.get(k), type)%>",
                                        "link":'<%= request.getContextPath()%>/admin/dashboard/subphaseForProject.jsp?project=<%= project%>&type=<%= type%>&phase=<%= phases.get(k)%>'
                                                            },
                <%k++;
                    }%>
                                                            ]
                                                    }
                                            }
                                            ); ageGroupChart.render();
                                            });</script><div id="chart-container2" class="chartarea">FusionCharts XT will load here!</div>

            <%
                }

            } else {


            %>



            <script type="text/javascript">
                FusionCharts.ready(function() {
                var stackedChart = new FusionCharts({
                type: 'stackedcolumn3d',
                        renderAt: 'chartcontainer',
                        width: '500',
                        height: '300',
                        dataFormat: 'json',
                        "dataSource": {
                        "chart": {
                        "caption": "Status wise dashboard",
                                "subCaption": "For <%=project%>",
                                "xAxisname": "Status",
                                "yAxisName": "Issue",
                                //                                    "showSum": "1",
                                "bgColor": "#ffffff",
                                "borderAlpha": "20",
                                "showCanvasBorder": "0",
                                "usePlotGradientColor": "0",
                                "plotBorderAlpha": "10",
                                "legendBorderAlpha": "0",
                                "legendShadow": "0",
                                "valueFontColor": "#ffffff",
                                "showXAxisLine": "1",
                                "xAxisLineColor": "#999999",
                                "showYAxisLine": "1",
                                "yAxisLineColor": "#999999",
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
                <%
                    for (String stat : status) {%>
                                {
                                "label": "<%=stat%>"
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
                        if (checkForZero != 0) {%>
                                {
                                "value": "<%=checkForZero%>",
                                        "link":'<%=  request.getContextPath()%>/admin/dashboard/issuesForProject.jsp?project=<%= project%>&status=<%= status[statusIndex]%>&priority=<%= priority[priorityIndex]%>'

                                                            },
                <%} else {%>
                                                            {
                                                            "value": ""
                                                            },
                <% }
                        statusIndex += 1;
                    }%>]
                                                            },<%
                                                                    priorityIndex += 1;
                                                                }%>
                                                            ]
                                                    }
                                            }).render();
                                            });</script>
            <div id="chartcontainer">FusionCharts XT will load here!</div>
            <%}%>
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
                                <%                                }
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

