<%@ page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="org.apache.log4j.*"%>
<%@page import="dashboard.*, java.applet.*,java.util.*"%>

<%
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Cache-Control", "no-store");
    response.setDateHeader("Expires", 0);
    response.setHeader("Pragma", "no-cache");

                        //Configuring log4j properties
   

    Logger logger = Logger.getLogger("ContactStatus");
  
    String logoutcheck = (String) session.getAttribute("Name");
    if (logoutcheck == null) {

%>
<jsp:forward page="/SessionExpired.jsp"></jsp:forward>
<%    }

    String link = "/admin/customer/viewcontact.jsp";
    session.setAttribute("forwardpage", link);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <meta name="keywords" content="GST in SAP, SAP GST Accelerator, GST Success in SAP, GST India in SAP, GST SAP Success, GST Suvidha Provider, GST ASP GSP, GST, CGST,SGST, IGST, UGST,  SAP NW based Product Development, SAP Consulting, SAP Implementation, SAP Support Services, SAP Outsourcing, SAP Implementation India, SAP Implementation Bangalore, SAP Implementation Chennai, SAP Implementation Belgium, SAP Implementation Paris, SAP Implemtation Australia, SAP Implementation France, SAP Implementation Mumbai, SAP Implementation Kerala, SAP Implementation Belgaum, SAP Implementation Thailand, SAP Implementation Mexico, SAP Implementation America">
        <meta http-equiv="Content-Type" content="text/html ">
        <LINK title=STYLE href="<%= request.getContextPath()%>/eminentech support files/main_ie.css" type="text/css" rel=STYLESHEET>
        <script type="text/javascript" src="<%= request.getContextPath()%>/fusion/fusioncharts.js?version=30032016"></script>
        <script type="text/javascript" src="<%= request.getContextPath()%>/javaScript/checkSubmit.js"></script>
        <TITLE>eTracker&#153; - Eminentlabs&#153; CRM, APM, ERM and PTS Solution</TITLE>
        <script type="text/javaScript">
            function check(searchContact)  {
            if ((searchContact.contactName.value==null)||(searchContact.contactName.value==""))
            {
            alert("Please Enter Contact Name ")
            searchContact.contactName.focus()
            return false
            }
            monitorSubmit();
            }

            function printpost(post)
            {
            pp = window.open('./profile.jsp?post_id=' + post,'pp','size = maximize,location=no,statusbar=no,menubar=no,scrollbars=no width=900,height=400');
            pp.focus();
            }
        </script>
    </head>
    <body>
        <%@ include file="/header.jsp"%>
        <%

            session.removeAttribute("rating");

            int hot = CountContact.getContactNo("Hot");
            int warm = CountContact.getContactNo("Warm");
            int cold = CountContact.getContactNo("Cold");

        %>
        <form name="searchContact" onsubmit="return check(this);"
              action="/eTracker/admin/customer/searchContact.jsp">
            <table cellpadding="0" cellspacing="0" width="100%" bgColor="#C3D9FF">
                <tr>
                    <td align="left"><font size="4" COLOR="#0000FF"><b>Contact
                                Administration</b> </font>
                    <td align="center"><b>Enter the Name or Contact Name:</b></td>
                    <td align="left"><input type="text" name="contactName"
                                            maxlength="20" size="15"></td>
                    <td><input type="submit" id="submit" name="submit" value="Search"></td>
                    <td><input type="reset" id="reset" name="reset" value="Reset"></td>
                    <td></td>
                </tr>
            </table>
        </form>

        <TABLE width="100%" border="0">
            <tr>
                <td><a href="<%=request.getContextPath()%>/admin/customer/addnewcontact.jsp">AddContact</a>&nbsp;&nbsp;&nbsp;&nbsp; 
                    <a href="<%=request.getContextPath()%>/admin/customer/viewcontact.jsp">View All Contacts</a>&nbsp;&nbsp;&nbsp;&nbsp;
                    <a href="<%=request.getContextPath()%>/admin/customer/waitingContacts.jsp">Approve	Contact</a>&nbsp;&nbsp;&nbsp;&nbsp; 
                    <a href="<%=request.getContextPath()%>/admin/customer/deniedContacts.jsp">Denied Contacts</a>&nbsp;&nbsp;&nbsp;&nbsp; 
                    <a href="<%=request.getContextPath()%>/admin/customer/disabledContacts.jsp">Disabled Contacts</a>
                </td>
            </tr>
            <!-- 	<tr>
                                    <img src="<%=request.getContextPath()%>>/Contact/com.eminent.graphs.PiechartServlet?config=pieproperties.txt&data=<%=request.getContextPath()%>>/ContactData"width="500" height="420">
                    </tr>
            -->
        </TABLE>
        <%
            if (hot > 0 || cold > 0 || warm > 0) {

                String firstStatus = "Hot";
                String secondStatus = "Warm";
                String thirdStatus = "Cold";

        %><script type="text/javascript">
            FusionCharts.ready(function() {
                var ageGroupChart = new FusionCharts({
                    type: 'pie3d',
                    renderAt: 'chart-container2',
                    width: '850',
                    height: '500',
                    dataFormat: 'json',
                    dataSource: {
                        "chart": {
                            "caption": "Contact Status",
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
                                "value": "<%= hot%>",
                                "link": '<%=  request.getContextPath() %>/admin/customer/viewContactStatus.jsp?rating=<%= firstStatus %>'
                                                    },
                                                    {
                                                        "label": "Warm",
                                                        "value": "<%= warm%>",
                                                        "link": '<%=  request.getContextPath() %>/admin/customer/viewContactStatus.jsp?rating=<%= secondStatus %>'
                                                                            },
                                                                            {
                                                                                "label": "Cold",
                                                                                "value": "<%= cold%>",
                                                                                "link": '<%=  request.getContextPath() %>/admin/customer/viewContactStatus.jsp?rating=<%= thirdStatus %>'
                                                                                                    },
                                                                                                ]
                                                                                            }
                                                                                        }
                                                                                        );
                                                                                        ageGroupChart.render();
                                                                                    });</script>
        <!--  Displaying pie chart for the project -->
        <div id="chart-container2" class="chartarea">FusionCharts XT will load here!</div>

        <%
        }else{
        %>
        </br>
        </br>
        </br>
        <table width="100%" height="70%" align="center">
            <tr>
                <td><font face="Tahoma" size="5" color="red">
                        <h3 align="center"><%= "No contacts are available " %></h3>
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