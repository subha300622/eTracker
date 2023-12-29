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
   

    Logger logger = Logger.getLogger("displayChart");
    

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

        <TITLE>eTracker&#0153; - Eminentlabs CRM,APM,ERM and PTS
            Solution</TITLE>
        <script language="JavaScript">
            function check(searchLead) {
                if ((searchLead.leadName.value == null) || (searchLead.leadName.value == ""))
                {
                    alert("Please Enter Name or Company ")
                    searchLead.leadName.focus()
                    return false
                }
                return true
            }
            function printpost(post)
            {
                pp = window.open('./profile.jsp?post_id=' + post, 'pp', 'size = maximize,location=no,statusbar=no,menubar=no,scrollbars=no width=900,height=400');
                pp.focus();
            }
        </script>

    </head>
    <body>
        <%@ include file="/header.jsp"%>

        <%
            String status = request.getParameter("status");
            session.setAttribute("status", status);

            int countFirst = CountLeads.getCount("Hot", status);
            int countSecond = CountLeads.getCount("Warm", status);
            int countThird = CountLeads.getCount("Cold", status);
            logger.info("Hot Count" + countFirst);
            logger.info("Warm Count" + countSecond);
            logger.info("Cold Count" + countThird);
        %>


        <form name="searchLead" onsubmit="return check(this);"
              action=" <%=  request.getContextPath()%>/admin/customer/searchLead.jsp">
            <table cellpadding="0" cellspacing="0" width="100%" bgColor="#C3D9FF">
                <tr>
                    <td align="left"><font size="4" COLOR="#0000FF"><b>Lead's
                                Rating</b> </font>
                    <td align="center"><b>Enter the Name or Company:</b></td>
                    <td align="left"><input type="text" name="leadName"
                                            maxlength="20" size="15"></td>
                    <td align="left"><input type="submit" name="submit"
                                            value="Search"></td>
                    <td align="left"><input type="reset" name="reset" value="Reset">
                    </td>
                    <td></td>
                </tr>
            </table>
        </form>
        <TABLE width="100%" border="0">
            <tr>
                <td><a
                        href="<%=request.getContextPath()%>/admin/customer/viewlead.jsp">View
                        All Leads</a>&nbsp;&nbsp;&nbsp;&nbsp; <a
                        href="<%=request.getContextPath()%>/admin/customer/waitingLead.jsp">Approve
                        Lead</a>&nbsp;&nbsp;&nbsp;&nbsp; <a
                        href="<%=request.getContextPath()%>/admin/customer/deniedLeads.jsp">Denied
                        Lead</a>&nbsp;&nbsp;&nbsp;&nbsp; <a
                        href="<%=request.getContextPath()%>/admin/customer/disabledLead.jsp">Disabled
                        Lead</a></td>
            </tr>
        </TABLE>
        <%String firstRating = "Hot";
            String secondRating = "Warm";
            String thirdRating = "Cold";%>
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
                            "paletteColors": "#FF0000,#0000FF,#7A7A7A",
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
                                "label": "Hot",
                                "value": "<%= countFirst%>",
                                "link": '<%=  request.getContextPath()%>/admin/customer/viewleadrating.jsp?rating=<%= firstRating%>&status=<%= status%>'
                                                    },
                                                    {
                                                        "label": "Warm",
                                                        "value": "<%= countSecond%>",
                                                        "link": '<%=  request.getContextPath()%>/admin/customer/viewleadrating.jsp?rating=<%= secondRating%>&status=<%= status%>'
                                                                            },
                                                                            {
                                                                                "label": "Cold",
                                                                                "value": "<%= countThird%>",
                                                                                "link": '<%=  request.getContextPath()%>/admin/viewleadrating.jsp?rating=<%= thirdRating%>&status=<%= status%>'
                                                                                                    },
                                                                                                ]
                                                                                            }
                                                                                        }
                                                                                        );
                                                                                        ageGroupChart.render();
                                                                                    });</script>
        <!--  Displaying pie chart for the project -->
        <div id="chart-container2" class="chartarea">FusionCharts XT will load here!</div>
<script src="//code.jquery.com/jquery-1.10.2.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/fusion/fusiontrailremover.js"></script>
    </body>
</html>