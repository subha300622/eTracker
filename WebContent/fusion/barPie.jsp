<%-- 
    Document   : barChart
    Created on : 10 Jun, 2015, 2:54:17 PM
    Author     : EMINENT
--%>

<%@page import="com.eminent.util.GetProjects"%>
<%@page import="com.eminent.util.IssueDetails"%>
<%@page import="dashboard.CountIssue"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<html>
    <head>
        <title>My first chart using FusionCharts Suite XT</title>
        <script type="text/javascript" src="fusioncharts.js?version=30032016"></script>
        <script type="text/javascript" src="themes/fusioncharts.theme.fint.js"></script>
        <script type="text/javascript" src="fusioncharts.powercharts.js"></script>
        <%!
            String[] priority = {"P1-Now", "P2-High", "P3-Medium", "P4-Low"};

            String[] status = {"Unconfirmed", "Rejected", "Duplicate", "User Error", "Documentation", "Review", "Training", "Evaluation", "Investigation", "Confirmed", "QA-BTC", "Development",
                "Workinprogress", "Code Review", "ReadytoBuild", "QA-TCE", "Performance QA", "Verified"};
        %><%String project = request.getParameter("project");%>
        <script type="text/javascript">
                    FusionCharts.ready(function() {
                    var stackedChart = new FusionCharts({
                    "type": "stackedcolumn3d",
                            "renderAt": "chartContainer",
                            "width": "1000",
                            "height": "600",
                            "dataFormat": "json",
                            "bgColor":"#FFFFFF",
                            "dataSource": {
                            "chart": {
                            "caption": "Status wise dashboard",
                                    "subCaption": "For <%=project%>",
                                    "xAxisname": "Status",
                                    "yAxisName": "Issue",
//                                    "showSum": "1",
                                    "theme": "fint",
                                    "divLineDashed": "1",
                                    "xAxisNameBorderDashed":"1"
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
                                                        });
                                                                stackedChart.render();
                                                        });</script>


        <%String pid = GetProjects.getProjectId(project);
            String cases[][] = IssueDetails.showModulewiseIssue(pid);
            int noOfTestcases = cases.length;
        %>
        <script type="text/javascript">
                    FusionCharts.ready(function() {
                    var ageGroupChart = new FusionCharts({
                    type: 'pie3d',
                            renderAt: 'chart-container2',
                            width: '650',
                            height: '300',
                            dataFormat: 'json',
                            dataSource: {
                            "chart": {
                            "caption": "Module wise dashboard",
                                    "subCaption": "For  <%=project%>",
//                                    "paletteColors": "#0075c2,#1aaf5d,#f2c500,#f45b00,#8e0000",
                                    "bgColor": "#ffffff",
                                    "showBorder": "1",
                                    "use3DLighting": "0",
                                    "showShadow": "0",
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
                                    "legendItemFontColor": '#666666'
                            },
                                    "data": [
            <%
                for (int k = 0; k < noOfTestcases; k++) {
            %>
                                    {
                                    "label": "<%=cases[k][1]%>",
                                            "value": "<%= cases[k][2]%>",
                                            "link":'<%= request.getContextPath()%>/admin/dashboard/modulewiseOpenIssue.jsp?project=<%=project%>&mid=<%=cases[k][0]%>&pid=<%=pid%>'
                                                                        },
            <%}%>
                                                                        ]
                                                                }
                                                        }
                                                        ); ageGroupChart.render();
                                                        });</script>
        <script type="text/javascript">
                    FusionCharts.ready(function () {
                    var hourlySalesChart = new FusionCharts({
                    type: 'multiaxisline',
                            renderAt: 'chart-container3',
                            width: '600',
                            height: '350',
                            dataFormat: 'json',
                            dataSource: {
                            "chart": {
                            "caption": "Revenue Analysis",
                                    "subcaption": "Last 12 weeks",
                                    "xaxisname": "Week of Year",
                                    "showvalues": "0",
                                    "theme" : "fint"
                            },
                                    "categories": [
                                    {
                                    "category": [
                                    { "label": "1" },
                                    { "label": "2" },
                                    { "label": "3" },
                                    { "label": "4" },
                                    { "label": "5" },
                                    { "label": "6" },
                                    { "label": "7" },
                                    { "label": "8" },
                                    { "label": "9" },
                                    { "label": "10" },
                                    { "label": "11" },
                                    { "label": "12" }
                                    ]
                                    }
                                    ],
                                    "axis": [
                                    {
                                    "title": "Revenue",
                                            "titlepos": "left",
                                            "tickwidth": "10",
                                            "numberPrefix": "$",
                                            "divlineisdashed": "1",
                                            "dataset": [
                                            {
                                            "seriesname": "Revenue",
                                                    "linethickness": "3",
                                                    "data": [
                                                    { "value": "137500" },
                                                    { "value": "124350" },
                                                    { "value": "156700" },
                                                    { "value": "131450" },
                                                    { "value": "208300" },
                                                    { "value": "219900" },
                                                    { "value": "227500" },
                                                    { "value": "254300" },
                                                    { "value": "155900" },
                                                    { "value": "105650" },
                                                    { "value": "120950" },
                                                    { "value": "127500" }
                                                    ]
                                            }
                                            ]
                                    }, {
                                    "title": "Orders",
                                            "axisonleft": "0",
                                            "titlepos": "right",
                                            "numdivlines": "8",
                                            "tickwidth": "10",
                                            "divlineisdashed": "1",
                                            "dataset": [
                                            {
                                            "seriesname": "Orders",
                                                    "data": [
                                                    { "value": "22567" },
                                                    { "value": "21348" },
                                                    { "value": "24846" },
                                                    { "value": "19237" },
                                                    { "value": "20672" },
                                                    { "value": "23403" },
                                                    { "value": "30278" },
                                                    { "value": "26719" },
                                                    { "value": "21940" },
                                                    { "value": "24396" },
                                                    { "value": "22340" },
                                                    { "value": "25439" }
                                                    ]
                                            }
                                            ]
                                    },
                                    {
                                    "title": "Footfalls",
                                            "titlepos": "RIGHT",
                                            "axisonleft": "0",
                                            "numdivlines": "5",
                                            "tickwidth": "10",
                                            "numberSuffix": "",
                                            "divlineisdashed": "1",
                                            "dataset": [
                                            {
                                            "seriesname": "Footfalls",
                                                    "data": [
                                                    { "value": "68473" },
                                                    { "value": "57934" },
                                                    { "value": "78925" },
                                                    { "value": "69213" },
                                                    { "value": "74892" },
                                                    { "value": "81123" },
                                                    { "value": "90086" },
                                                    { "value": "91174" },
                                                    { "value": "68934" },
                                                    { "value": "80934" },
                                                    { "value": "73634" },
                                                    { "value": "84453" }
                                                    ]
                                            }
                                            ]
                                    }
                                    ]
                            }
                    }).render();
                            });
        </script>
    </head>
    <body>
        <div id="chartContainer">FusionCharts XT will load here!</div>
        <div id="chart-container2">FusionCharts XT will load here!</div>
        <div id="chart-container3">FusionCharts XT will load here!</div>
    </body>
    <script src="//code.jquery.com/jquery-1.10.2.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/fusion/fusiontrailremover.js"></script>
</html>