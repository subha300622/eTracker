<%-- 
    Document   : dailyUserActivity
    Created on : Jan 27, 2012, 11:16:38 AM
    Author     : Tamilvelan
--%>

<%@ page import="org.apache.log4j.*"%>
<%@page import="com.pack.SessionCounter" %>
<%@page import="dashboard.*,com.eminent.util.UserUtils"%>
<%@ include file="/header.jsp"%>

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

    String Values[][] = UserUtils.userActivity();


%>
<html>
    <meta name="keywords" content="GST in SAP, SAP GST Accelerator, GST Success in SAP, GST India in SAP, GST SAP Success, GST Suvidha Provider, GST ASP GSP, GST, CGST,SGST, IGST, UGST,  SAP NW based Product Development, SAP Consulting, SAP Implementation, SAP Support Services, SAP Outsourcing, SAP Implementation India, SAP Implementation Bangalore, SAP Implementation Chennai, SAP Implementation Belgium, SAP Implementation Paris, SAP Implemtation Australia, SAP Implementation France, SAP Implementation Mumbai, SAP Implementation Kerala, SAP Implementation Belgaum, SAP Implementation Thailand, SAP Implementation Mexico, SAP Implementation America">
        <meta http-equiv="Content-Type" content="text/html">
        <TITLE>eTracker&#153; - Eminentlabs&#153; CRM, APM, TQM,  ERM and  EPTS Solution</TITLE>
        <LINK title=STYLE href="<%= request.getContextPath()%>/eminentech support files/main_ie.css" type="text/css" rel="STYLESHEET">
        <script type="text/javascript" src="<%= request.getContextPath()%>/fusion/fusioncharts.js?version=30032016"></script>


    </head>
    <body>
        <%

            int userId = (Integer) session.getAttribute("uid");
            int roleId = (Integer) session.getAttribute("Role");

            if (roleId == 1) {
        %>
        <table cellpadding="0" cellspacing="0" width="100%">
            <tr bgcolor="#C3D9FF">
                <td align="left" width="50%"><font size="4" COLOR="#0000FF"><b>User Activity</b></font><FONT SIZE="3" COLOR="#0000FF"></FONT></td>
                <td border="1" align="right"><font size="4" COLOR="#0000FF"><b>Active Sessions: <a href="<%=request.getContextPath()%>/admin/user/viewActiveUsers.jsp"><%=SessionCounter.getActiveUsers()%></a></b> </font></td>
            </tr>
        </table>
        <script type="text/javascript">

                    FusionCharts.ready(function () {
                    var hourlySalesChart = new FusionCharts({
                    type: 'msline',
                            renderAt: 'chart-container',
                            width: '990',
                            height: '550',
                            dataFormat: 'json',
                            dataSource: {

                            //Vertical divline configuration
                            "chart": {
                            "caption": "User Activity Chart",
                                    "subcaption": "Last 1 month",
                                    "xaxisname": "Day",
                                    "showvalues": "0",
                                    "paletteColors": "#58FA58,#088A08",
                                    "bgColor": "#ffffff",
                                    "showBorder":"0",
                                    "showcanvasborder":"0",
                                    "showXaxisline":"1",
                                    "showYAxisline":"1",
                                    "yAxisMaxvalue": "100",
                                    "yAxisMinValue": "0",
                                    "labelDisplay": "rotate",
                                    "slantLabels": "1",
                                    "vDivLineColor": "#C3D9FF",
                                    "numVDivLines": "10",
                                    "showAlternateHGridColor":"0",
                                    "numDivLines": "12",
                                    "legendPosition":"RIGHT",
                                    "exportEnabled": "1"

                            },
                                    "categories": [
                                    {"category": [
            <%

                        try {
                            for (int i = 0, k = 1; i < 30; i++, k++) {
                                String month = Values[i][0];
                                String total = Values[i][1];

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
                                    "dataset": [{"seriesname": "No Of Users", "linethickness": "2",
                                            "data": [ <%    try {

                                                            for (int i = 0, k = 1; i < 30; i++, k++) {
                                                                String month = Values[i][0];
                                                                String total = Values[i][1];


            %>

                                            { "value": "<%=total%>", "link":'<%= request.getContextPath()%>/admin/dashboard/viewLoggedUsers.jsp?month=<%=month.substring(month.indexOf(",") + 2)%>' },
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
            <tr align="center" ><td><font color="red">You are not authorized to access this page.</font></td></tr>
        </table>
        <%
            }
        %>
        <script src="//code.jquery.com/jquery-1.10.2.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/fusion/fusiontrailremover.js"></script>
    </body>
</html>
