<%-- 
    Document   : eminentPerformance
    Created on : Nov 23, 2009, 7:28:23 PM
    Author     : Administrator
--%>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="org.apache.log4j.*"%>
<%@page import="dashboard.*,com.eminent.util.GetProjectMembers, java.applet.*,java.util.*,com.eminent.timesheet.EminentPerformance"%>

<%!
    int userId = GetProjectMembers.getAdminID();
%>
<%
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Cache-Control", "no-store");
    response.setDateHeader("Expires", 0);
    response.setHeader("Pragma", "no-cache");

    //Configuring log4j properties
    Logger logger = Logger.getLogger("APM PerformanceChart");

    String logoutcheck = (String) session.getAttribute("Name");
    if (logoutcheck == null) {

%>
<jsp:forward page="/SessionExpired.jsp"></jsp:forward>
<%    }

    String Values[][] = EminentPerformance.getValue();
%>
<html>
    <meta name="keywords" content="GST in SAP, SAP GST Accelerator, GST Success in SAP, GST India in SAP, GST SAP Success, GST Suvidha Provider, GST ASP GSP, GST, CGST,SGST, IGST, UGST,  SAP NW based Product Development, SAP Consulting, SAP Implementation, SAP Support Services, SAP Outsourcing, SAP Implementation India, SAP Implementation Bangalore, SAP Implementation Chennai, SAP Implementation Belgium, SAP Implementation Paris, SAP Implemtation Australia, SAP Implementation France, SAP Implementation Mumbai, SAP Implementation Kerala, SAP Implementation Belgaum, SAP Implementation Thailand, SAP Implementation Mexico, SAP Implementation America">
        <meta http-equiv="Content-Type" content="text/html">
        <TITLE>eTracker&#153; - Eminentlabs&#153; CRM, APM, TQM,  ERM and  EPTS Solution</TITLE>
        <LINK title=STYLE href="<%= request.getContextPath()%>/eminentech support files/main_ie.css" type="text/css" rel="STYLESHEET">
        <script type="text/javascript" src="<%=request.getContextPath()%>/fusion/fusioncharts.js?version=30032016"></script>

    </head>
    <body>
        <%@ include file="/header.jsp"%>
        <table cellpadding="0" cellspacing="0" width="100%">
            <tr bgcolor="#C3D9FF">
                <td align="left" width="30%"><font size="4" COLOR="#0000FF"><b>Eminentlabs&#0153; APM Performance Chart</b></font><FONT SIZE="3" COLOR="#0000FF"></FONT></td>
                <td style="text-align: right;"><a style="font-weight: bold;" href="<%= request.getContextPath()%>/admin/user/apmPerformance.jsp">APM Performance</a>&nbsp;&nbsp;&nbsp;<a href="<%= request.getContextPath()%>/admin/dashboard/ageWiseIssueChart.jsp">Age Wise</a>&nbsp;&nbsp;&nbsp;<a href="<%= request.getContextPath()%>/admin/dashboard/moduleWorkedIssuesChart.jsp">Module Wise</a>&nbsp;&nbsp;&nbsp;<a  href="<%= request.getContextPath()%>/admin/dashboard/dueDateChangeWise.jsp">DueDate Wise</a>&nbsp;&nbsp;&nbsp;<a  href="<%= request.getContextPath()%>/admin/dashboard/dayWiseChart.jsp">Day Wise</a></td>
            </tr>
        </table>
        <%
            int roleId = (Integer) session.getAttribute("Role");
            if (roleId == 1) {

        %>        
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
                            "caption": "Eminentlabs APM Performance Chart",
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
                                    "dataset": [{"seriesname": "Open Issues","linethickness": "2",
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
                                                    "link":'<%= request.getContextPath()%>/admin/dashboard/projectIssuesChart.jsp?month=<%=mon%>&year=<%=yr%>&userId=<%=userId%>' },
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

                                                                String mon = Values[i][4];

                                                                String yr = month.substring(month.indexOf("-") + 1, month.length());

            %>

                                                                                        { "value": "<%=total%>",
                                                                                                "link":'<%= request.getContextPath()%>/admin/dashboard/workedIssuesChart.jsp?month=<%=mon%>&year=<%=yr%>&userId=<%=userId%>' },
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

                                                                String created = Values[i][3];
                                                                String mon = Values[i][4];

                                                                String yr = month.substring(month.indexOf("-") + 1, month.length());

            %>

                                                                                                                                    { "value": "<%=created%>",
                                                                                                                                            "link":'<%= request.getContextPath()%>/admin/dashboard/createdIssueChart.jsp?month=<%=mon%>&year=<%=yr%>&userId=<%=userId%>' },
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
                                                                String closed = Values[i][2];
                                                                String mon = Values[i][4];
                                                                String open = Values[i][5];

                                                                String yr = month.substring(month.indexOf("-") + 1, month.length());

            %>

                                                                                                                                                                                { "value": "<%=closed%>",
                                                                                                                                                                                        "link":'<%= request.getContextPath()%>/admin/dashboard/closedIssuesChart.jsp?month=<%=mon%>&year=<%=yr%>&userId=<%=userId%>' },
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


        <%
        } else {
        %>
        <BR>
        <table align="center">
            <tr align="center" ><td><font color="red">You are not authorised to access this page.</font></td></tr>
        </table>
        <%
            }
        %>
    </body>
    <script src="//code.jquery.com/jquery-1.10.2.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/fusion/fusiontrailremover.js"></script>
</html>
