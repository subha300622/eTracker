<%-- 
    Document   : tqmPerformance
    Created on : 13 Mar, 2010, 6:43:53 PM
    Author     : Tamilvelan
--%>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="org.apache.log4j.*"%>
<%@page import="dashboard.*,com.eminent.util.GetProjectMembers, java.applet.*,java.util.*,com.eminent.tqm.TqmPerformance"%>
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
   

    Logger logger = Logger.getLogger("tqmPerformanceChart");
    
    String logoutcheck = (String) session.getAttribute("Name");
    if (logoutcheck == null) {

%>
<jsp:forward page="/SessionExpired.jsp"></jsp:forward>
<%    }

    String Values[][] = TqmPerformance.getValue();
%>
<html>
    <meta name="keywords" content="GST in SAP, SAP GST Accelerator, GST Success in SAP, GST India in SAP, GST SAP Success, GST Suvidha Provider, GST ASP GSP, GST, CGST,SGST, IGST, UGST,  SAP NW based Product Development, SAP Consulting, SAP Implementation, SAP Support Services, SAP Outsourcing, SAP Implementation India, SAP Implementation Bangalore, SAP Implementation Chennai, SAP Implementation Belgium, SAP Implementation Paris, SAP Implemtation Australia, SAP Implementation France, SAP Implementation Mumbai, SAP Implementation Kerala, SAP Implementation Belgaum, SAP Implementation Thailand, SAP Implementation Mexico, SAP Implementation America">
        <meta http-equiv="Content-Type" content="text/html">
        <TITLE>eTracker&#153; - Eminentlabs&#153; CRM, APM, TQM,  ERM and  EPTS Solution</TITLE>
        <LINK title=STYLE href="<%= request.getContextPath()%>/eminentech support files/main_ie.css" type="text/css" rel="STYLESHEET">
        <script type="text/javascript" src="<%=request.getContextPath()%>/fusion/fusioncharts.js?version=30032016"></script>
    </head>
    <body>
        <table cellpadding="0" cellspacing="0" width="100%">
            <tr bgcolor="#C3D9FF">
                <td align="left" width="100%"><font size="4" COLOR="#0000FF"><b>Eminentlabs&#153; TQM Performance Chart</b></font><FONT SIZE="3" COLOR="#0000FF"></FONT></td>
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
                            "caption": "Eminentlabs TQM Performance Chart",
                                    "subcaption": "Last 1 year",
                                    "xaxisname": "Month",
                                    "showvalues": "0",
                                    "paletteColors": "#58FA58,#088A08,#FF8000",
                                    "bgColor": "#ffffff",
                                    "showBorder":"0",
                                    "showcanvasborder":"0",
                                    "showXaxisline":"1",
                                    "showYAxisline":"1",
                                    "vDivLineColor": "#C3D9FF",
                                    "numVDivLines": "12",
                                    "numDivLines": "9",
                                    "legendPosition":"RIGHT",
                                    "showAlternateHGridColor":"0",
                                    "exportEnabled": "1"

                            },
                                    "categories": [
                                    {"category": [
            <%    try {

                    for (int i = 0, k = 1; i < 12; i++, k++) {
                        String month = Values[i][0];

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
                                    "dataset": [{"seriesname": "CTC Created", "linethickness": "2",
                                            "data": [ <%    try {

                                            for (int i = 0, k = 1; i < 12; i++, k++) {
                                                String month = Values[i][0];
                                                String CTC = Values[i][1];
                                                String PTC = Values[i][2];
                                                String TEP = Values[i][3];
                                                String mon = Values[i][4];

                                                String yr = month.substring(month.indexOf("-") + 1, month.length());

            %>

                                            { "value": "<%=CTC%>",
                                                    "link":'<%= request.getContextPath()%>/admin/tqm/listMonthlyCTC.jsp?month=<%=mon%>&year=<%=yr%>&userId=<%=userId%>' },
            <%

                    }
                } catch (Exception e) {
                    logger.error(e.getMessage());
                }
            %>




                                                                                        ]
                                                                                },
                                                                                {
                                                                                "seriesname": "PTC Created",
                                                                                        "linethickness": "2",
                                                                                        "data": [ <%    try {

                                                                                for (int i = 0, k = 1; i < 12; i++, k++) {
                                                                                    String month = Values[i][0];
                                                                                    String CTC = Values[i][1];
                                                                                    String PTC = Values[i][2];
                                                                                    String TEP = Values[i][3];
                                                                                    String mon = Values[i][4];

                                                                                    String yr = month.substring(month.indexOf("-") + 1, month.length());

            %>

                                                                                        { "value": "<%=PTC%>",
                                                                                                "link":'<%= request.getContextPath()%>/admin/tqm/listMonthlyPTC.jsp?month=<%=mon%>&year=<%=yr%>&userId=<%=userId%>' },
            <%

                    }
                } catch (Exception e) {
                    logger.error(e.getMessage());
                }
            %>
                                                                                                                                    ]
                                                                                                                            },
                                                                                                                            {
                                                                                                                            "seriesname": "TEP Created",
                                                                                                                                    "linethickness": "2",
                                                                                                                                    "data": [ <%    try {

                                                                                                                    for (int i = 0, k = 1; i < 12; i++, k++) {
                                                                                                                        String month = Values[i][0];
                                                                                                                        String CTC = Values[i][1];
                                                                                                                        String PTC = Values[i][2];
                                                                                                                        String TEP = Values[i][3];
                                                                                                                        String mon = Values[i][4];

                                                                                                                        String yr = month.substring(month.indexOf("-") + 1, month.length());
            %>

                                                                                                                                    { "value": "<%=TEP%>",
                                                                                                                                            "link":'<%= request.getContextPath()%>/admin/tqm/listMonthlyTEP.jsp?month=<%=mon%>&year=<%=yr%>&userId=<%=userId%>' },
            <%

                    }
                } catch (Exception e) {
                    logger.error(e.getMessage());
                }
            %>




                                                                                                                                                                                ]
                                                                                                                                                                        },
                                                                                                                                                                        ]
                                                                                                                                                                }
                                                                                                                                                        }).render();
                                                                                                                                                        });</script>

        <div id="chart-container" class="chartarea"></div>
<script src="//code.jquery.com/jquery-1.10.2.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/fusion/fusiontrailremover.js"></script>

    </body>
</html>

