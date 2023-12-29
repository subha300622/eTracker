<%-- 
    Document   : dueDateChangeWise
    Created on : Jun 17, 2014, 1:22:16 PM
    Author     : E0288
--%>

<%@page import="java.util.Map"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    Logger logger = Logger.getLogger("dueDateChangeWise");
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
        <jsp:useBean id="tcir" class="com.eminent.issue.TeamClosedIssueReport"></jsp:useBean>
        <jsp:useBean id="random" class="java.util.Random"/>
        <jsp:useBean id="ddw" class="com.eminent.issue.controller.DueDateWise"></jsp:useBean>
        <%ddw.setAll(request);%>
        <%
            int roleId = (Integer) session.getAttribute("Role");
            if (roleId == 1) {
        %> 
                <form name="theForm" id="theForm" method="post" action="dueDateChangeWise.jsp" onsubmit="disableSubmit();">    

        <table cellpadding="0" cellspacing="0" width="100%">
            
	<tr bgcolor="#C3D9FF">
		<td align="left" width="50%"><font size="4" COLOR="#0000FF"><b>APM Issues for </b></font><FONT SIZE="3" COLOR="#0000FF"></FONT>
                        <select name="month" id="month">
                            <%for (Map.Entry<Integer, String> month : tcir.getMonths().entrySet()) {
                                    if (month.getKey() == ddw.getMonth()) {%>
                            <option value="<%=month.getKey()%>" selected=""><%=month.getValue()%></option>
                            <%} else {%>
                            <option value="<%=month.getKey()%>"><%=month.getValue()%></option>
                            <%}
                                }%>
                        </select>
                        <select name='year' id='year' >

                            <%for (Integer year : tcir.getYears()) {%>
                            <%if (year == ddw.getYear()) {%>
                            <option value="<%=year%>" selected=""><%=year%></option>
                            <%} else {%>   
                            <option value="<%=year%>"><%=year%></option>
                            <%}
                                }%>
                        </select>

                        <input type="submit" id="submit" value="Submit" ></td>
                <td style="text-align: right;"><a  href="<%= request.getContextPath() %>/admin/user/apmPerformance.jsp">APM Performance</a>&nbsp;&nbsp;&nbsp;<a href="<%= request.getContextPath() %>/admin/dashboard/ageWiseIssueChart.jsp?month=<%=ddw.getMonth()%>&year=<%=ddw.getYear()%>">Age Wise</a>&nbsp;&nbsp;&nbsp;<a href="<%= request.getContextPath() %>/admin/dashboard/moduleWorkedIssuesChart.jsp?month=<%=ddw.getMonth()%>&year=<%=ddw.getYear()%>">Module Wise</a>&nbsp;&nbsp;&nbsp;<a style="font-weight: bold;"  href="<%= request.getContextPath()%>/admin/dashboard/dueDateChangeWise.jsp?month=<%=ddw.getMonth()%>&year=<%=ddw.getYear()%>">DueDate Wise</a>&nbsp;&nbsp;&nbsp;<a  href="<%= request.getContextPath()%>/admin/dashboard/dayWiseChart.jsp?month=<%=ddw.getMonth()%>&year=<%=ddw.getYear()%>">Day Wise</a></td>
	</tr>
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
           for (Map.Entry<Integer, Integer> entry : ddw.getCreatedDueDateWiseList().entrySet()) {
               String noOfChange=entry.getKey().toString()+"Changes";
                if(entry.getKey()==0){
                    noOfChange="No changes";
                }

            %>
                                    {
                                        "label": "<%=noOfChange%>",
                                        "value": "<%= entry.getValue()%>",
                                                "link":'<%= request.getContextPath()%>/admin/dashboard/dueDateWiseIssues.jsp?month=<%=ddw.getMonth()%>&year=<%=ddw.getYear()%>&noofChanges=<%=entry.getKey()%>&chartType=Created'
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
                                    "legendItemFontColor": '#666666'
                            },
                                    "data": [

            <%
            for (Map.Entry<Integer, Integer> entry : ddw.getOpenDueDateWiseList().entrySet()) {
String noOfChange=entry.getKey().toString()+"Changes";
                if(entry.getKey()==0){
                    noOfChange="No changes";
                }
            %>
                                    {
                                        "label": "<%=noOfChange%>",
                                        "value": "<%= entry.getValue()%>",
                                                "link":'<%= request.getContextPath()%>/admin/dashboard/dueDateWiseIssues.jsp?month=<%=ddw.getMonth()%>&year=<%=ddw.getYear()%>&noofChanges=<%=entry.getKey()%>&chartType=Open'
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
                                    "legendItemFontColor": '#666666'
                            },
                                    "data": [

            <%
                        for (Map.Entry<Integer, Integer> entry : ddw.getWorkedDueDateWiseList().entrySet()) {
            String noOfChange=entry.getKey().toString()+"Changes";
                if(entry.getKey()==0){
                    noOfChange="No changes";
                }
            %>
                                    {
                                        "label": "<%=noOfChange%>",
                                         "value": "<%= entry.getValue()%>",
                                                "link":'<%= request.getContextPath()%>/admin/dashboard/dueDateWiseIssues.jsp?month=<%=ddw.getMonth()%>&year=<%=ddw.getYear()%>&noofChanges=<%=entry.getKey()%>&chartType=Worked'
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
                                    "legendItemFontColor": '#666666'
                            },
                                    "data": [

            <%
           for (Map.Entry<Integer, Integer> entry : ddw.getClosedDueDateWiseList().entrySet()) {
               String noOfChange=entry.getKey().toString()+"Changes";
                if(entry.getKey()==0){
                    noOfChange="No changes";
                }
            %>
                                    {
                                        "label": "<%=noOfChange%>",
                                                "value": "<%= entry.getValue()%>",
                                                "link":'<%= request.getContextPath()%>/admin/dashboard/dueDateWiseIssues.jsp?month=<%=ddw.getMonth()%>&year=<%=ddw.getYear()%>&noofChanges=<%=entry.getKey()%>&chartType=Closed'
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
        <%}else{%>
                <BR>
        <table align="center">
            <tr align="center" ><td><font color="red">You are not authorised to access this page.</font></td></tr>
        </table>
            <%}%>
        <script src="//code.jquery.com/jquery-1.10.2.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/fusion/fusiontrailremover.js"></script>
</body>
</html>
