<%@ page language="java" contentType="text/html"
         pageEncoding="UTF-8"%>
<%@ page import="org.apache.log4j.*"%>
<%@page import="dashboard.*, java.applet.*,java.util.*"%>

<%
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Cache-Control", "no-store");
    response.setDateHeader("Expires", 0);
    response.setHeader("Pragma", "no-cache");

                        //Configuring log4j properties
   

    Logger logger = Logger.getLogger("leadStatusDashBoard");
   

    String logoutcheck = (String) session.getAttribute("Name");
    if (logoutcheck == null) {

%>
<jsp:forward page="/SessionExpired.jsp"></jsp:forward>
<%    }


%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <meta name="keywords" content="GST in SAP, SAP GST Accelerator, GST Success in SAP, GST India in SAP, GST SAP Success, GST Suvidha Provider, GST ASP GSP, GST, CGST,SGST, IGST, UGST,  SAP NW based Product Development, SAP Consulting, SAP Implementation, SAP Support Services, SAP Outsourcing, SAP Implementation India, SAP Implementation Bangalore, SAP Implementation Chennai, SAP Implementation Belgium, SAP Implementation Paris, SAP Implemtation Australia, SAP Implementation France, SAP Implementation Mumbai, SAP Implementation Kerala, SAP Implementation Belgaum, SAP Implementation Thailand, SAP Implementation Mexico, SAP Implementation America">
        <meta http-equiv="Content-Type" content="text/html ">
        <LINK title=STYLE
              href="<%= request.getContextPath()%>/eminentech support files/main_ie.css"
              type="text/css" rel=STYLESHEET>
        <script type="text/javascript" src="<%= request.getContextPath()%>/fusion/fusioncharts.js?version=30032016"></script>
        <script type="text/javascript" src="<%= request.getContextPath()%>/javaScript/checkSubmit.js"></script>
        <script language=javascript	src="<%= request.getContextPath()%>/eminentech support files/datetimepicker.js"></script>

        <TITLE>eTracker&#0153; - Eminentlabs&#0153; CRM,APM,ERM and PTS
            Solution</TITLE>
        <script type="text/javaScript">
            function check(searchLead)  {  
            if ((searchLead.leadName.value==null)||(searchLead.leadName.value==""))
            {
            alert("Please Enter Name or Company ")
            searchLead.leadName.focus()
            return false
            }
            monitorSubmit();
            }

        </script>

    </head>
    <body>
        <%@ include file="/header.jsp"%>

        <%

            int countFirst = CountLeads.getStatus("Open");
            int countSecond = CountLeads.getStatus("Contacted");
            int countThird = CountLeads.getStatus("Qualified");
            int countFourth = CountLeads.getStatus("UnQualified");
        %>


        <form name="searchLead" onsubmit="return check(this);"
              action=" <%=  request.getContextPath()%>/admin/customer/searchLead.jsp">
            <table cellpadding="0" cellspacing="0" width="100%" bgColor="#C3D9FF">
                <tr>
                    <td align="left"><font size="4" COLOR="#0000FF"><b>Lead's
                                Status</b> </font>
                    <td align="center"><b>Enter the Name or Company:</b></td>
                    <td align="left"><input type="text" name="leadName"
                                            maxlength="20" size="15"></td>
                    <td align="left"><input type="submit" id="submit" name="submit"
                                            value="Search"></td>
                    <td align="left"><input type="reset" id="reset" name="reset" value="Reset">
                    </td>
                    <td></td>
                </tr>
            </table>
        </form>
        <TABLE width="100%" border="0">
            <tr>
                <td>
<!--                <a href="<%=request.getContextPath()%>/admin/customer/addnewlead.jsp">Add Lead</a>&nbsp;&nbsp;&nbsp;&nbsp;  -->
                    <a href="<%=request.getContextPath()%>/admin/customer/viewlead.jsp">View All Leads</a>&nbsp;&nbsp;&nbsp;&nbsp; 
                    <a href="<%=request.getContextPath()%>/admin/customer/waitingLead.jsp">Approve Lead</a>&nbsp;&nbsp;&nbsp;&nbsp;
                    <a href="<%=request.getContextPath()%>/admin/customer/deniedLeads.jsp">Denied Lead</a>&nbsp;&nbsp;&nbsp;&nbsp;
                    <a href="<%=request.getContextPath()%>/admin/customer/disabledLead.jsp">Disabled Lead</a>
                </td>
            </tr>
        </TABLE>
        <%
            if (countFirst > 0 || countSecond > 0 || countThird > 0 || countFourth > 0) {
                String firstStatus = "Open";
                String secondStatus = "Contacted";
                String thirdStatus = "Qualified";
                String fourthStatus = "UnQualified";
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
                            "caption": "Lead Status",
                            "paletteColors": "#F2F2F2, #893BFF, #088A08, #610B0B",
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
                            {
                                "label": "Open",
                                "value": "<%= countFirst%>",
                                "link": '<%=  request.getContextPath()%>/admin/dashboard/leadDashBoard.jsp?status=<%= firstStatus%>'
                                                    },
                                                    {
                                                        "label": "Contacted",
                                                        "value": "<%= countSecond%>",
                                                        "link": '<%=  request.getContextPath()%>/admin/dashboard/leadDashBoard.jsp?status=<%= secondStatus%>'
                                                                            },
                                                                            {
                                                                                "label": "Qualified",
                                                                                "value": "<%= countThird%>",
                                                                                "link": '<%=  request.getContextPath()%>/admin/dashboard/leadDashBoard.jsp?status=<%= thirdStatus%>'
                                                                                                    },
                                                                                                    {
                                                                                                        "label": "Open",
                                                                                                        "value": "<%= countFourth%>",
                                                                                                        "link": '<%=  request.getContextPath()%>/admin/dashboard/leadDashBoard.jsp?status=<%= fourthStatus%>'
                                                                                                                            }
                                                                                                                        ]
                                                                                                                    }
                                                                                                                }
                                                                                                                );
                                                                                                                ageGroupChart.render();
                                                                                                            });</script>
        <!--  Displaying pie chart for the project -->
        <div id="chart-container2" class="chartarea">FusionCharts XT will load here!</div>

        <%} else {
        %>
        </br>
        </br>
        </br>
        <table width="100%" height="70%" align="center">
            <tr>
                <td align="center"><font face="Tahoma" size="8" color="red">
                        <h3 align="center"><%= "No Leads are available"%></h3>
                    </font></td>
            </tr>
        </table>

        <%
            }

        %>
        <script src="//code.jquery.com/jquery-1.10.2.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/fusion/fusiontrailremover.js"></script>
    </body>
</html>