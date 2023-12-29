<%-- 
    Document   : dayWiseChart
    Created on : Jun 16, 2014, 4:58:20 PM
    Author     : E0288
--%>

<%@page import="java.util.Map"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<!DOCTYPE html>
<%
    Logger logger = Logger.getLogger("dayWiseChart");
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
        <script type="text/javascript" src="<%= request.getContextPath()%>/javaScript/checkSubmit.js"></script>
        <LINK title=STYLE href="<%= request.getContextPath()%>/eminentech support files/main_ie.css" type="text/css" rel="STYLESHEET">
        <script type="text/javascript" src="<%=request.getContextPath()%>/fusion/fusioncharts.js?version=30032016"></script>
    </head>
    <body>
        <%@ include file="/header.jsp"%>
        <%
            int roleId = (Integer) session.getAttribute("Role");
            if (roleId == 1) {
        %> 
        <jsp:useBean id="tcir" class="com.eminent.issue.TeamClosedIssueReport"></jsp:useBean>
        <jsp:useBean id="dwc" class="com.eminent.issue.controller.DaywiseChart"></jsp:useBean>
        <%dwc.setAll(request);%>

        <form name="theForm" id="theForm" method="post" action="dayWiseChart.jsp" onsubmit="disableSubmit();">    
            <table cellpadding="0" cellspacing="0" width="100%">
                <tr bgcolor="#C3D9FF">
                    <td align="left" width="50%"><font size="4" COLOR="#0000FF"><b>APM Issues for </b></font><FONT SIZE="3" COLOR="#0000FF"></FONT>
                        <select name="month" id="month">
                            <%for (Map.Entry<Integer, String> month : tcir.getMonths().entrySet()) {
                                    if (month.getKey() == dwc.getMonth()) {%>
                            <option value="<%=month.getKey()%>" selected=""><%=month.getValue()%></option>
                            <%} else {%>
                            <option value="<%=month.getKey()%>"><%=month.getValue()%></option>
                            <%}
                                }%>
                        </select>
                        <select name='year' id='year' >

                            <%for (Integer year : tcir.getYears()) {%>
                            <%if (year == dwc.getYear()) {%>
                            <option value="<%=year%>" selected=""><%=year%></option>
                            <%} else {%>   
                            <option value="<%=year%>"><%=year%></option>
                            <%}
                                }%>
                        </select>

                        <input type="submit" id="submit" value="Submit" ></td>
                    <td style="text-align: right;"><a href="<%= request.getContextPath()%>/admin/user/apmPerformance.jsp">APM Performance</a>&nbsp;&nbsp;&nbsp;<a href="<%= request.getContextPath()%>/admin/dashboard/ageWiseIssueChart.jsp?month=<%=dwc.getMonth()%>&year=<%=dwc.getYear()%>">Age Wise</a>&nbsp;&nbsp;&nbsp;<a href="<%= request.getContextPath()%>/admin/dashboard/moduleWorkedIssuesChart.jsp?month=<%=dwc.getMonth()%>&year=<%=dwc.getYear()%>">Module Wise</a>&nbsp;&nbsp;&nbsp;<a  href="<%= request.getContextPath()%>/admin/dashboard/dueDateChangeWise.jsp?month=<%=dwc.getMonth()%>&year=<%=dwc.getYear()%>">DueDate Wise</a>&nbsp;&nbsp;&nbsp;<a style="font-weight: bold;" href="<%= request.getContextPath()%>/admin/dashboard/dayWiseChart.jsp?month=<%=dwc.getMonth()%>&year=<%=dwc.getYear()%>">Day Wise</a></td></tr>
            </table>
        </form>
        <br/>
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
                            "caption": "Apm Issues - Day Wise",
                                    "subcaption": "Last 1 year",
                                    "xaxisname": "Month",
                                    "showvalues": "0",
                                    "paletteColors": "#FF8000,#58FA58,#088A08",
                                    "bgColor": "#ffffff",
                                    "showBorder":"0",
                                    "showcanvasborder":"0",
                                    "showXaxisline":"1",
                                    "showYAxisline":"1",
                                    "labelDisplay": "rotate",
                                    "slantLabels": "1",
                                    "vDivLineColor": "#C3D9FF",
                                    "numVDivLines": "10",
                                    "numDivLines": "9",
                                    "showAlternateHGridColor":"0",
                                    "legendPosition":"RIGHT",
                                    "exportEnabled": "1"

                            },
                                    "categories": [
                                    {"category": [
            <%

                try {
                    int k = 0;
                    for (String day : dwc.getDaysList()) {
                        k++;

            %>
                                    { "label": "<%=day + "," + dwc.getWeekDaysList().get(day) + ")"%>" },
            <%

                    }
                } catch (Exception e) {
                    logger.error(e.getMessage());
                }
            %>
                                    ]
                                    }
                                    ],
                                    "dataset": [{"seriesname": "Created Issues", "linethickness": "2",
                                            "data": [ <%    try {

                                                    for (String day : dwc.getDaysList()) {
                                                        int created = 0;

                                                        //int open = 0;
                                                        if (dwc.getCreatedCount().get(day) != null) {
                                                            created = dwc.getCreatedCount().get(day);
                                                        }


            %>

                                            { "value": "<%=created%>", "link":'<%= request.getContextPath()%>/admin/dashboard/dayWiseIssues.jsp?month=<%=dwc.getMonth()%>&year=<%=dwc.getYear()%>&chartDate=<%=day.substring(0, 2)%>&chartType=Created' },
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

                                                    for (String day : dwc.getDaysList()) {
                                                        int worked = 0;

                                                        if (dwc.getWorkedCount().get(day) != null) {
                                                            worked = dwc.getWorkedCount().get(day);
                                                        }

            %>

                                            { "value": "<%=worked%>",
                                                    "link":'<%= request.getContextPath()%>/admin/dashboard/dayWiseIssues.jsp?month=<%=dwc.getMonth()%>&year=<%=dwc.getYear()%>&chartDate=<%=day.substring(0, 2)%>&chartType=Worked' },
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

                                                    for (String day : dwc.getDaysList()) {
                                                        int closed = 0;
                                                        if (dwc.getClosedCount().get(day) != null) {
                                                            closed = dwc.getClosedCount().get(day);
                                                        }

            %>

                                            { "value": "<%=closed%>",
                                                    "link":'<%= request.getContextPath()%>/admin/dashboard/dayWiseIssues.jsp?month=<%=dwc.getMonth()%>&year=<%=dwc.getYear()%>&chartDate=<%=day.substring(0, 2)%>&chartType=Closed' },
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
    
    <%} else {%>
    <BR>
    <table align="center">
        <tr align="center" ><td><font color="red">You are not authorised to access this page.</font></td></tr>
    </table>
    <%}%>
    <script src="//code.jquery.com/jquery-1.10.2.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/fusion/fusiontrailremover.js"></script>
</body>
</html>
