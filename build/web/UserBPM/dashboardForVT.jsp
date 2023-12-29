<%-- 
    Document   : dashboardForVT
    Created on : 5 Nov, 2011, 9:55:22 PM
    Author     : Tamilvelan
--%>

<%@page import="org.apache.log4j.Logger,org.apache.log4j.PropertyConfigurator,com.eminentlabs.userBPM.ViewBPM,java.util.LinkedHashMap,java.util.HashMap" %>
<%@page import="dashboard.TestCases,com.eminent.util.GetProjectMembers,java.util.Iterator,java.util.Collection,com.eminent.util.GetProjects" %>
<%
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Cache-Control", "no-store");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);

    //Configuring log4j properties
   
    Logger logger = Logger.getLogger("Test Case Chart");
   
    String sessionCheck = (String) session.getAttribute("Name");
    if (sessionCheck == null) {
%>
<jsp:forward page="/SessionExpired.jsp"></jsp:forward>
<%
    }

%>


<html>
    <meta name="keywords" content="GST in SAP, SAP GST Accelerator, GST Success in SAP, GST India in SAP, GST SAP Success, GST Suvidha Provider, GST ASP GSP, GST, CGST,SGST, IGST, UGST,  SAP NW based Product Development, SAP Consulting, SAP Implementation, SAP Support Services, SAP Outsourcing, SAP Implementation India, SAP Implementation Bangalore, SAP Implementation Chennai, SAP Implementation Belgium, SAP Implementation Paris, SAP Implemtation Australia, SAP Implementation France, SAP Implementation Mumbai, SAP Implementation Kerala, SAP Implementation Belgaum, SAP Implementation Thailand, SAP Implementation Mexico, SAP Implementation America">
        <meta http-equiv="Content-Type" content="text/html">
        <title>eTracker&#0153; - Eminentlabs&#0153; CRM, BPM, APM, TQM, ERM and EPTS Solution</title>
        <LINK title=STYLE href="<%= request.getContextPath()%>/eminentech support files/main_ie.css" type="text/css" rel=STYLESHEET>
        <script type="text/javascript" src="<%=request.getContextPath()%>/fusion/fusioncharts.js?version=30032016"></script>
    </head>
    <body>
        <%
            String pid = request.getParameter("pid");
            String scId = request.getParameter("scId");
            String clientName = request.getParameter("clientName");
            String compName = request.getParameter("companyName");
            String nameofbp = request.getParameter("bpName");
            String nameofmp = request.getParameter("mpName");
            String nameofsp = request.getParameter("spName");
            String nameofsc = request.getParameter("scName");
            HashMap variantMap = ViewBPM.getVT(Integer.parseInt(scId));
            LinkedHashMap variant = GetProjectMembers.sortHashMapByKeys(variantMap, true);
        %>
        <%@ include file="/header.jsp"%>
        <table cellpadding="0" cellspacing="0" width="100%" bgColor="#C3D9FF">
            <tr  bgColor="#C3D9FF">
                <td  align="left" width="100%"><font size="4" COLOR="#0000FF"><b>View <%=GetProjects.getProject(Integer.parseInt(pid))%> Test Map Dashboard</b></font></td>
            </tr>
        </table>
        <table>
            <tr style="height:20px">
                <td>
                    <a href="<%=request.getContextPath()%>/testMap.jsp?pid=<%=pid%>">Test Map Tree View</a>&nbsp;&nbsp;&nbsp;
                    <%
                        String cases[][] = TestCases.showTestCases(pid);
                        int noOfTestcases = cases.length;
                        if (noOfTestcases > 0) {
                    %>
                    <a href="<%=request.getContextPath()%>/admin/dashboard/TestCasesChart.jsp?project=<%=pid%>">View Test Coverage</a>&nbsp;&nbsp;&nbsp;
                    <a href="<%=request.getContextPath()%>/UserProject/listProjectTestPlan.jsp?pid=<%=pid%>">View Test Plans</a>&nbsp;&nbsp;&nbsp;
                    <%}%>
                    <a href="<%=request.getContextPath()%>/admin/dashboard/projectPerformanceChart.jsp?pid=<%=pid%>">View Project Performance</a>&nbsp;&nbsp;&nbsp;

                </td>
            </tr>
            <tr>
                <td><span title="Client"><%=clientName%></span> >> <span title="Company Code"><%=compName%></span> >> <span title="Business Process"><%=nameofbp%></span> >> <span title="Main Process"><%=nameofmp%></span> >> <span title="Sub Process"><%=nameofsp%></span>  >> <span title="Scenario"><%=nameofsc%></span> >> <b>Variant</b></td>
            </tr>
        </table>
        <%
            int sizeOftheVT = variant.size();
            if (sizeOftheVT > 0) {
        %>
        <script type="text/javascript">
            FusionCharts.ready(function() {
                var ageGroupChart = new FusionCharts({
                    type: 'pie3d',
                    renderAt: 'chart-container2',
                    width: '850',
                    height: '500',
                    dataFormat: 'json',
                    dataSource: {
                        "chart": {
                            "caption": "Variant",
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
                            "showHoverEffect": "1",
                            "showLegend": "1",
                            "legendBgColor": "#ffffff",
                            "legendBorderAlpha": '0',
                            "legendShadow": '0',
                            "legendItemFontSize": '10',
                            "legendPosition": "RIGHT",
                            "exportEnabled": "1",
                            "legendItemFontColor": '#666666'
                        },
                        "data": [
            <%
                Collection set = variant.keySet();
                Iterator ite = set.iterator();
                int k = 0, tcCount = 0;
                while (ite.hasNext()) {
                    int key = (Integer) ite.next();
                    String nameofvt = (String) variant.get(key);
                    logger.info("Value===>>" + nameofvt);

                    tcCount = ViewBPM.getTSCount(key);
                    if (tcCount == 0) {
                        tcCount = 1;
                    }
            %>
                            {
                                "label": "<%=nameofvt%>",
                                "value": "<%= tcCount%>",
                                "link": '<%= request.getContextPath()%>/UserBPM/dashboardForTC.jsp?vtId=<%=key%>&pid=<%=pid%>&vtName=<%=nameofvt%>&scName=<%=nameofsc%>&spName=<%=nameofsp%>&mpName=<%=nameofmp%>&bpName=<%=nameofbp%>&companyName=<%=compName%>&clientName=<%=clientName%>'
                                                    },
            <%}%>
                                                ]
                                            }
                                        }
                                        );
                                        ageGroupChart.render();
                                    });</script>
        <!--  Displaying pie chart for the project -->
        <div id="chart-container2" class="chartarea">FusionCharts XT will load here!</div>

        <%
        } else {
        %>
        <br>
        <br>
        <br>
        <br>
        <br>
        <br>
        <br>
        <br>
        <br>
        <br>
        <br>
        <br>
        <br>
        <br>

        <table cellpadding="0" cellspacing="0" width="100%" datapagesize="25">
            <tr>
                <td  align="center" width="100%"><font size="4" COLOR="#0000FF"><b>No Variant Available</b></font></td>
            </tr>
        </table>
        <br>
        <br>
        <br>
        <br>
        <br>
        <br>
        <br>
        <br>
        <br>
        <br>
        <br>
        <br>
        <br>
        <br>
        <br>
        <br>
        <br>
        <%
            }
        %>
    </body>
    <script src="//code.jquery.com/jquery-1.10.2.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/fusion/fusiontrailremover.js"></script>
</html>

