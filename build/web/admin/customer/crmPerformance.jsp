<%-- 
    Document   : crmPerformance
    Created on : 13 Mar, 2010, 3:17:53 PM
    Author     : Tamilvelan
--%>
<%@ page import="org.apache.log4j.*"%>
<%@page import="dashboard.*,com.eminent.util.GetProjectMembers,com.eminent.util.crmPerformance, java.applet.*,java.util.*,com.eminent.timesheet.EminentPerformance"%>
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
    Logger logger = Logger.getLogger("crmPerformanceChart");

    String logoutcheck = (String) session.getAttribute("Name");
    if (logoutcheck == null) {

%>
<jsp:forward page="/SessionExpired.jsp"></jsp:forward>
<%    }
    String Values[][] = new String[12][6];
    try {
        Values = crmPerformance.getValue();
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

    </head>
    <body>
        
        <table width="100%">
        <tr>
            <td colspan="3">
                <a href="<%=request.getContextPath()%>/admin/customer/crmPerformance.jsp" style="font-weight: bold;cursor: pointer">CRM Performance Chart</a> &nbsp;&nbsp;&nbsp;&nbsp;              
                <a href="<%=request.getContextPath()%>/MyCRM/crmSummary.jsp" style="cursor: pointer">CRM Summary</a> &nbsp;&nbsp;&nbsp;&nbsp;              
                <a href="<%=request.getContextPath()%>/MyCRM/crmAnalysis.jsp" style="cursor: pointer">CRM Analysis</a> &nbsp;&nbsp;&nbsp;&nbsp;
                <a href="<%=request.getContextPath()%>/MyCRM/industryMaintenance.jsp" style="cursor: pointer">Industry Maintenance</a> &nbsp;&nbsp;&nbsp;&nbsp;
            </td>
        </tr>
    </table>
    <br>
        
        
        <table cellpadding="0" cellspacing="0" width="100%">
            <tr bgcolor="#C3D9FF">
                <td align="left" width="100%"><font size="4" COLOR="#0000FF"><b>Eminentlabs&#153; CRM Performance Chart </b></font><FONT SIZE="3" COLOR="#0000FF"></FONT></td>
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
                            "caption": "Eminentlabs CRM Performance Chart",
                                    "subcaption": "Last 1 year",
                                    "xaxisname": "Month",
                                    "showvalues": "0",
                                    "formatnumber":"0",
                                    "formatnumberscale":"0",
                                    "sformatnumber":"0",
                                    "sformatnumberscale":"0",
                                    "paletteColors": "#58FA58,#B404AE,#0101DF,#088A08",
                                    "bgColor": "#ffffff",
                                    "showBorder":"0",
                                    "showcanvasborder":"0",
                                    "showXaxisline":"1",
                                    "showYAxisline":"1",
                                    "vDivLineColor": "#C3D9FF",
                                    "numVDivLines": "12",
                                    "showAlternateHGridColor":"0",
                                    "numDivLines": "9",
                                    "legendPosition":"RIGHT",
                                    "exportEnabled": "1"

                            },
                                    "categories": [
                                    {"category": [
            <%    try {
                    String month = null, contact = null, lead = null, opportunity = null, account = null, mon = null;
                    for (int i = 0, k = 1; i < 12; i++, k++) {
                        month = Values[i][0];
                        contact = Values[i][1];
                        lead = Values[i][2];
                        opportunity = Values[i][3];
                        account = Values[i][4];
                        mon = Values[i][5];


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
                                    "dataset": [{"seriesname": "Contacts Created", "linethickness": "2", "data": [
            <%    try {
                    String month = null, contact = null, lead = null, opportunity = null, account = null, mon = null;
                    for (int i = 0, k = 1; i < 12; i++, k++) {
                        month = Values[i][0];
                        contact = Values[i][1];
                        lead = Values[i][2];
                        opportunity = Values[i][3];
                        account = Values[i][4];
                        mon = Values[i][5];
                        String yr = month.substring(month.indexOf("-") + 1, month.length());
            %>
                                    {
                                    "value": "<%=contact%>",
                                            "link":'<%= request.getContextPath()%>/admin/customer/listMonthlyContact.jsp?month=<%=mon%>&year=<%=yr%>&userId=<%=userId%>' },
            <%

                    }
                } catch (Exception e) {
                    logger.error(e.getMessage());
                }
            %>
                                                                        ]
                                                                        },
                                                                        {
                                                                        "seriesname": "Leads Created",
                                                                                "linethickness": "2",
                                                                                "data": [
            <%    try {
                    String month = null, contact = null, lead = null, opportunity = null, account = null, mon = null;
                    for (int i = 0, k = 1; i < 12; i++, k++) {
                        month = Values[i][0];
                        contact = Values[i][1];
                        lead = Values[i][2];
                        opportunity = Values[i][3];
                        account = Values[i][4];
                        mon = Values[i][5];
                        String yr = month.substring(month.indexOf("-") + 1, month.length());

            %>
                                                                                {
                                                                                "value": "<%=lead%>",
                                                                                        "link":'<%= request.getContextPath()%>/admin/customer/listMonthlyLead.jsp?month=<%=mon%>&year=<%=yr%>&userId=<%=userId%>'
                                                                                                                            },
            <%

                    }
                } catch (Exception e) {
                    logger.error(e.getMessage());
                }
            %>]
                                                                                                                    },
                                                                                                                    {
                                                                                                                    "seriesname": "Opportunities Created",
                                                                                                                            "linethickness": "2",
                                                                                                                            "data": [ <%    try {
                                                                                                                                            String month = null, contact = null, lead = null, opportunity = null, account = null, mon = null;
                                                                                                                                            for (int i = 0, k = 1; i < 12; i++, k++) {
                                                                                                                                                month = Values[i][0];
                                                                                                                                                contact = Values[i][1];
                                                                                                                                                lead = Values[i][2];
                                                                                                                                                opportunity = Values[i][3];
                                                                                                                                                account = Values[i][4];
                                                                                                                                                mon = Values[i][5];
                                                                                                                                                String yr = month.substring(month.indexOf("-") + 1, month.length());
            %> { "value": "<%=opportunity%>",
                                                                                                                                    "link":'<%= request.getContextPath()%>/admin/customer/listMonthlyOpportunities.jsp?month=<%=mon%>&year=<%=yr%>&userId=<%=userId%>'
                                                                                                                                                                        },
            <%

                    }
                } catch (Exception e) {
                    logger.error(e.getMessage());
                }
            %>
                                                                                                                                                                        ]
                                                                                                                                                                },
                                                                                                                                                                {
                                                                                                                                                                "seriesname": "Accounts Created",
                                                                                                                                                                        "linethickness": "2",
                                                                                                                                                                        "data": [ <%    try {
                                                                                                                                                                                        String month = null, contact = null, lead = null, opportunity = null, account = null, mon = null;
                                                                                                                                                                                        for (int i = 0, k = 1; i < 12; i++, k++) {
                                                                                                                                                                                            month = Values[i][0];
                                                                                                                                                                                            contact = Values[i][1];
                                                                                                                                                                                            lead = Values[i][2];
                                                                                                                                                                                            opportunity = Values[i][3];
                                                                                                                                                                                            account = Values[i][4];
                                                                                                                                                                                            mon = Values[i][5];
                                                                                                                                                                                            String yr = month.substring(month.indexOf("-") + 1, month.length());
            %>
                                                                                                                                                                        {
                                                                                                                                                                        "value": "<%=account%>",
                                                                                                                                                                                "link":'<%= request.getContextPath()%>/admin/customer/listMonthlyAccount.jsp?month=<%=mon%>&year=<%=yr%>&userId=<%=userId%>' },
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
