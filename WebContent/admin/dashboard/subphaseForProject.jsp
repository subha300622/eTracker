
<%@page pageEncoding="UTF-8"%>
<%@ page import="org.apache.log4j.*"%>
<%@page import="dashboard.*, java.applet.*,java.util.*"%>

<%
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Cache-Control", "no-store");
    response.setDateHeader("Expires", 0);
    response.setHeader("Pragma", "no-cache");

    //Configuring log4j properties
   

    Logger logger = Logger.getLogger("subPhaseForProject");
  
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


    <body>
        <%@ include file="/header.jsp"%>
        <table cellpadding="0" cellspacing="0" width="100%">
            <tr border="2" bgColor="#C3D9FF">
                <td bgcolor="#C3D9FF" border="1" align="left" width="100%"><font
                        size="4" COLOR="#0000FF"><b>Project Dashboard </b></font></td>
            </tr>
        </table>

        <%!
            String[] priority = {"P1-Now", "P2-High", "P3-Medium", "P4-Low"};
        %>

        <%

            String project = request.getParameter("project");
            String projectType = request.getParameter("type");
            String phase = request.getParameter("phase");

            logger.debug("Project" + project);
            logger.debug("Project Type" + projectType);
            logger.debug("Phase" + phase);

            int maximum = ProjectPhase.getMaxCount(project, projectType, phase);
            ArrayList<String> subPhase = ProjectPhase.getSubPhases(projectType, phase);

            logger.debug("Sub Phase Size" + subPhase.size());

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
                            "caption": "<%=phase%>",
                             "subCaption": "For  <%=project%>",
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
                                    "canvasBaseColor":"#ffffff",
                                    "labelDisplay": "rotate",
                                    "slantLabels": "1",
                                    "vDivLineColor": "#C3D9FF",
                                    "legendPosition":"RIGHT",
                                    "numVDivLines": "<%=subPhase.size()%>",
                                    "exportEnabled": "1"

                            },
                                    "categories": [
                                    {
                                    "category": [
            <%                for (String stat : subPhase) {%>
                                    {
                                    "label": "<%=stat%>"
                                    },
            <%}%>
                                    ]
                                    }
                                    ],
                                    "dataset": [
            <%int priorityIndex = 0;
                logger.info("priority" + priority.length);
                for (int j = 0; j < priority.length; j++) {
                    int subPhaseIndex = 0;

            %>
                                    {
                                    "seriesname": "<%=priority[j]%>",
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
            <%  for (int i = 0; i < subPhase.size(); i++) {
                    int checkForZero = ProjectPhase.getSubPhaseIssueCount(project, projectType, phase, subPhase.get(subPhaseIndex), priority[priorityIndex]);
                    if (checkForZero > 0) {%>
                                    {    "value": "<%=checkForZero%>",
                                            "link":'<%=  request.getContextPath()%>/admin/dashboard/showIssues.jsp?project=<%= project%>&projectType=<%= projectType%>&phase=<%= phase%>&subphase=<%= subPhase.get(subPhaseIndex)%>&priority=<%= priority[priorityIndex]%>'

                                                                        },
            <%} else {%> {
                                                                                "value": ""
                                                                                },<%}
                                                                                        subPhaseIndex += 1;
                                                                                    }%>]
                                                                        },<%
                                                                                priorityIndex += 1;
                                                                            }%>
                                                                        ]
                                                                }
                                                        });
                                                                stackedChart.render();
                                                        });</script><div id="chartcontainer" class="chartarea">FusionCharts XT will load here!</div>


<script src="//code.jquery.com/jquery-1.10.2.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/fusion/fusiontrailremover.js"></script>
    </body>


</html>


