<%-- 
    Document   : ageWiseIssueChart
    Created on : Jun 17, 2014, 6:09:48 PM
    Author     : E0288
--%>

<%@page import="com.eminent.issue.controller.ModuleIssuesChart"%>
<%@page import="java.util.Map"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    Logger logger = Logger.getLogger("ageWiseIssueChart");
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
        <LINK title=STYLE href="<%= request.getContextPath()%>/eminentech support files/main_ie.css?test=1" type="text/css" rel=STYLESHEET>
        <script type="text/javascript" src="<%=request.getContextPath()%>/fusion/fusioncharts.js?version=30032016"></script>
    </head>
    <body>
        <%@ include file="/header.jsp"%>
        <%
            int roleId = (Integer) session.getAttribute("Role");
            if (roleId == 1) {
        %> 
        <jsp:useBean id="tcir" class="com.eminent.issue.TeamClosedIssueReport"></jsp:useBean>
        <jsp:useBean id="awc" class="com.eminent.issue.controller.AgeWiseIssues"></jsp:useBean>
        <jsp:useBean id="random" class="java.util.Random"/>
        <% awc.setAll(request);%>
        <form name="theForm" id="theForm" method="post" action="ageWiseIssueChart.jsp" onsubmit="disableSubmit();">    
            <table cellpadding="0" cellspacing="0" width="100%">
                <tr bgcolor="#C3D9FF">
                    <td align="left" width="50%"><font size="4" COLOR="#0000FF"><b>APM Issues for </b></font><FONT SIZE="3" COLOR="#0000FF"></FONT>
                        <select name="month" id="month">
                            <%for (Map.Entry<Integer, String> month : tcir.getMonths().entrySet()) {
                                    if (month.getKey() == awc.getMonth()) {%>
                            <option value="<%=month.getKey()%>" selected=""><%=month.getValue()%></option>
                            <%} else {%>
                            <option value="<%=month.getKey()%>"><%=month.getValue()%></option>
                            <%}
                                }%>
                        </select>
                        <select name='year' id='year' >

                            <%for (Integer year : tcir.getYears()) {%>
                            <%if (year == awc.getYear()) {%>
                            <option value="<%=year%>" selected=""><%=year%></option>
                            <%} else {%>   
                            <option value="<%=year%>"><%=year%></option>
                            <%}
                                }%>
                        </select>

                        <input type="submit" id="submit" value="Submit" ></td>
                    <td style="text-align: right;"><a href="<%= request.getContextPath()%>/admin/user/apmPerformance.jsp">APM Performance</a>&nbsp;&nbsp;&nbsp;<a style="font-weight: bold;" href="<%= request.getContextPath()%>/admin/dashboard/ageWiseIssueChart.jsp?month=<%=awc.getMonth()%>&year=<%=awc.getYear()%>">Age Wise</a>&nbsp;&nbsp;&nbsp;<a href="<%= request.getContextPath()%>/admin/dashboard/moduleWorkedIssuesChart.jsp?month=<%=awc.getMonth()%>&year=<%=awc.getYear()%>">Module Wise</a>&nbsp;&nbsp;&nbsp;<a  href="<%= request.getContextPath()%>/admin/dashboard/dueDateChangeWise.jsp?month=<%=awc.getMonth()%>&year=<%=awc.getYear()%>">DueDate Wise</a>&nbsp;&nbsp;&nbsp;<a href="<%= request.getContextPath()%>/admin/dashboard/dayWiseChart.jsp?month=<%=awc.getMonth()%>&year=<%=awc.getYear()%>">Day Wise</a></td> </tr>
            </table>
        </form>
         
        <script type="text/javascript">
                    FusionCharts.ready(function() {
                    var ageGroupChart = new FusionCharts({
                    type: 'pie3d',
                            renderAt: 'chart-container',
                            width: '600',
                            height: '500',
                            dataFormat: 'json',
                            dataSource: {
                            "chart": {
                            "caption": "Created",
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
                                    "legendItemFontColor": '#666666'
                            },
                                    "data": [

            <%int j = 0;
                for (Map.Entry<String, Integer> entry : awc.getCreatedAgeWiseList().entrySet()) {
                    String color="";
                    if(entry.getKey().equalsIgnoreCase(awc.getAgeTypes().get(0))){
                    color= "#179614";
                }else if(entry.getKey().equalsIgnoreCase(awc.getAgeTypes().get(1))){
                    color= "#FFFF00";
                }else if(entry.getKey().equalsIgnoreCase(awc.getAgeTypes().get(2))){
                    color= "#FF9900";
                }else if(entry.getKey().equalsIgnoreCase(awc.getAgeTypes().get(3))){
                    color= "#FF0000";
                }else if(entry.getKey().equalsIgnoreCase(awc.getAgeTypes().get(4))){
                    color= "#179814";
                }else if(entry.getKey().equalsIgnoreCase(awc.getAgeTypes().get(5))){
                    color= "#FFFA00";
                }else if(entry.getKey().equalsIgnoreCase(awc.getAgeTypes().get(6))){
                    color= "#FF9600";
                }else if(entry.getKey().equalsIgnoreCase(awc.getAgeTypes().get(7))){
                    color= "#FF0A00";
                }
            %>
                                    {
                                    "label": "<%=entry.getKey()%>",
                                    "color":"<%=color%>",
                                    "issliced": "1",
                                            "value": "<%= entry.getValue()%>",
                                            "link":'<%= request.getContextPath()%>/admin/dashboard/ageWiseIssues.jsp?month=<%=awc.getMonth()%>&year=<%=awc.getYear()%>&ageParam=<%=entry.getKey()%>&chartType=Open'
                                                                        },
            <% j++;
                }%>
                                                                        ]
                                                                }
                                                        }
                                                        ); ageGroupChart.render();
                                                        });</script>
        <script type="text/javascript">
                    FusionCharts.ready(function() {
                    var ageGroupChart = new FusionCharts({
                    type: 'pie3d',
                            renderAt: 'chart-containera',
                            width: '600',
                            height: '500',
                            dataFormat: 'json',
                            dataSource: {
                            "chart": {
                            "caption": "Open",
                                    "paletteColors": ",,#FF9900,,#179814,#FFFA00,#FF9600,#FF0A00",
                                    "bgColor": "#ffffff",
                                    "pieslicedepth": "30",
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

            <%String color="";
              for (Map.Entry<String, Integer> entry : awc.getOpenAgeWiseList().entrySet()) {
                  if(entry.getKey().equalsIgnoreCase(awc.getAgeTypes().get(0))){
                    color= "#179614";
                }else if(entry.getKey().equalsIgnoreCase(awc.getAgeTypes().get(1))){
                    color= "#FFFF00";
                }else if(entry.getKey().equalsIgnoreCase(awc.getAgeTypes().get(2))){
                    color= "#FF9900";
                }else if(entry.getKey().equalsIgnoreCase(awc.getAgeTypes().get(3))){
                    color= "#FF0000";
                }else if(entry.getKey().equalsIgnoreCase(awc.getAgeTypes().get(4))){
                    color= "#179814";
                }else if(entry.getKey().equalsIgnoreCase(awc.getAgeTypes().get(5))){
                    color= "#FFFA00";
                }else if(entry.getKey().equalsIgnoreCase(awc.getAgeTypes().get(6))){
                    color= "#FF9600";
                }else if(entry.getKey().equalsIgnoreCase(awc.getAgeTypes().get(7))){
                    color= "#FF0A00";
                }
            %>
                                    {
                                    "label": "<%=entry.getKey()%>",
                                    "color":"<%=color%>",
                                    "issliced": "1",
                                    "value": "<%= entry.getValue()%>",
                                            "link":'<%= request.getContextPath()%>/admin/dashboard/ageWiseIssues.jsp?month=<%=awc.getMonth()%>&year=<%=awc.getYear()%>&ageParam=<%=entry.getKey()%>&chartType=Open'
                                                                        },
            <% j++;
                }%>
                                                                        ]
                                                                }
                                                        }
                                                        ); ageGroupChart.render();
                                                        });</script>
        <script type="text/javascript">
                    FusionCharts.ready(function() {
                    var ageGroupChart = new FusionCharts({
                    type: 'pie3d',
                            renderAt: 'chart-containerb',
                            width: '600',
                            height: '500',
                            dataFormat: 'json',
                            dataSource: {
                            "chart": {
                            "caption": "Worked",
                                   "paletteColors": "#179614,#FFFF00,#FF9900,#FF0000,#179814,#FFFA00,#FF9600,#FF0A00",
                                    "bgColor": "#ffffff",
                                    "use3DLighting": "0",
                                    "pieslicedepth": "30",
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
                 for (Map.Entry<String, Integer> entry : awc.getWorkedAgeWiseList().entrySet()) {
                     if(entry.getKey().equalsIgnoreCase(awc.getAgeTypes().get(0))){
                    color= "#179614";
                }else if(entry.getKey().equalsIgnoreCase(awc.getAgeTypes().get(1))){
                    color= "#FFFF00";
                }else if(entry.getKey().equalsIgnoreCase(awc.getAgeTypes().get(2))){
                    color= "#FF9900";
                }else if(entry.getKey().equalsIgnoreCase(awc.getAgeTypes().get(3))){
                    color= "#FF0000";
                }else if(entry.getKey().equalsIgnoreCase(awc.getAgeTypes().get(4))){
                    color= "#179814";
                }else if(entry.getKey().equalsIgnoreCase(awc.getAgeTypes().get(5))){
                    color= "#FFFA00";
                }else if(entry.getKey().equalsIgnoreCase(awc.getAgeTypes().get(6))){
                    color= "#FF9600";
                }else if(entry.getKey().equalsIgnoreCase(awc.getAgeTypes().get(7))){
                    color= "#FF0A00";
                }
            %>
                                    {
                                    "label": "<%=entry.getKey()%>",
                                    "color":"<%=color%>",
                                    "issliced": "1",
                                    "value": "<%= entry.getValue()%>",
                                            "link":'<%= request.getContextPath()%>/admin/dashboard/ageWiseIssues.jsp?month=<%=awc.getMonth()%>&year=<%=awc.getYear()%>&ageParam=<%=entry.getKey()%>&chartType=Worked'
                                                                        },
            <% j++;
                }%>
                                                                        ]
                                                                }
                                                        }
                                                        ); ageGroupChart.render();
                                                        });</script>
        <script type="text/javascript">
                    FusionCharts.ready(function() {
                    var ageGroupChart = new FusionCharts({
                    type: 'pie3d',
                            renderAt: 'chart-containerc',
                            width: '600',
                            height: '500',
                            dataFormat: 'json',
                            dataSource: {
                            "chart": {
                            "caption": "Closed",
                                    "paletteColors": "#179614,#FFFF00,#FF9900,#FF0000,#179814,#FFFA00,#FF9600,#FF0A00",
                                    "bgColor": "#ffffff",
                                    "use3DLighting": "0",
                                    "pieslicedepth": "30",
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
                for (Map.Entry<String, Integer> entry : awc.getClosedAgeWiseList().entrySet()) {
                    if(entry.getKey().equalsIgnoreCase(awc.getAgeTypes().get(0))){
                    color= "#179614";
                }else if(entry.getKey().equalsIgnoreCase(awc.getAgeTypes().get(1))){
                    color= "#FFFF00";
                }else if(entry.getKey().equalsIgnoreCase(awc.getAgeTypes().get(2))){
                    color= "#FF9900";
                }else if(entry.getKey().equalsIgnoreCase(awc.getAgeTypes().get(3))){
                    color= "#FF0000";
                }else if(entry.getKey().equalsIgnoreCase(awc.getAgeTypes().get(4))){
                    color= "#179814";
                }else if(entry.getKey().equalsIgnoreCase(awc.getAgeTypes().get(5))){
                    color= "#FFFA00";
                }else if(entry.getKey().equalsIgnoreCase(awc.getAgeTypes().get(6))){
                    color= "#FF9600";
                }else if(entry.getKey().equalsIgnoreCase(awc.getAgeTypes().get(7))){
                    color= "#FF0A00";
                }
            %>
                                    {
                                    "label": "<%=entry.getKey()%>",
                                    "color":"<%=color%>",
                                    "issliced": "1",
                                            "value": "<%= entry.getValue()%>",
                                            "link":'<%= request.getContextPath()%>/admin/dashboard/ageWiseIssues.jsp?month=<%=awc.getMonth()%>&year=<%=awc.getYear()%>&ageParam=<%=entry.getKey()%>&chartType=Closed'
                                                                        },
            <% j++;
                }%>
                                                                        ]
                                                                }
                                                        }
                                                        ); ageGroupChart.render();
                                                        });</script>
        <div style="width: 100%;">
            <div id="chart-container" class="chartarea" style="width: 46%;float: left;margin: 20px 20px 20px 20px;">
                <img class="loading" src="<%=request.getContextPath()%>/images/276 (1).GIF" alt="FusionCharts XT will load here!" />
            </div>
            <div id="chart-containera" class="chartarea" style="width: 46%;float: left;margin: 20px 20px 20px 20px;">
                <img class="loading" src="<%=request.getContextPath()%>/images/276 (1).GIF" alt="FusionCharts XT will load here!" />
            </div><div id="chart-containerb" class="chartarea" style="width: 46%;float: left;margin: 20px 20px 20px 20px;">
                <img class="loading" src="<%=request.getContextPath()%>/images/276 (1).GIF" alt="FusionCharts XT will load here!" />
            </div>
            <div id="chart-containerc" class="chartarea" style="width: 46%;float: left;margin: 20px 20px 20px 20px;">
                <img class="loading" src="<%=request.getContextPath()%>/images/276 (1).GIF" alt="FusionCharts XT will load here!" />
            </div>
        </div>
        <%
        } else {
        %>
        <BR>
        <table align="center">
            <tr align="center" ><td><font color="red">You are not authorised to access this page.</font></td></tr>
        </table>
        <%    }
        %>
        
        <script src="//code.jquery.com/jquery-1.10.2.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/fusion/fusiontrailremover.js"></script>
    </body>
</html>
