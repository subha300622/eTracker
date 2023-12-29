<%@page pageEncoding="UTF-8"%>
<%@ page import="org.apache.log4j.*,pack.eminent.encryption.MakeConnection,java.sql.Connection"%>
<%@page import="com.eminentlabs.appraisal.AppraisalUtil,com.eminentlabs.erm.ERMUtil"  %>
<%@page import="dashboard.*, java.applet.*,java.util.*,com.eminent.util.GetProjectMembers,com.eminent.leaveUtil.*,com.eminent.timesheet.*,com.eminent.tqm.TestCasePlan"%>
<%
    session.setAttribute("forwardpage", "/MyAssignment/UpdateIssue.jsp");

    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Cache-Control", "no-store");
    response.setDateHeader("Expires", 0);
    response.setHeader("Pragma", "no-cache");
    //Configuring log4j properties

    Logger logger = Logger.getLogger("chartForUsers");

    String logoutcheck = (String) session.getAttribute("Name");
    if (logoutcheck == null) {

%>
<jsp:forward page="/SessionExpired.jsp"></jsp:forward>
<%            }


%>
<%--
The taglib directive below imports the JSTL library. If you uncomment it,
you must also add the JSTL library to the project. The Add Library... action
on Libraries node in Projects view can be used to add the JSTL 1.1 library.
--%>
<%--
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%> 
--%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <meta name="keywords" content="GST in SAP, SAP GST Accelerator, GST Success in SAP, GST India in SAP, GST SAP Success, GST Suvidha Provider, GST ASP GSP, GST, CGST,SGST, IGST, UGST,  SAP NW based Product Development, SAP Consulting, SAP Implementation, SAP Support Services, SAP Outsourcing, SAP Implementation India, SAP Implementation Bangalore, SAP Implementation Chennai, SAP Implementation Belgium, SAP Implementation Paris, SAP Implemtation Australia, SAP Implementation France, SAP Implementation Mumbai, SAP Implementation Kerala, SAP Implementation Belgaum, SAP Implementation Thailand, SAP Implementation Mexico, SAP Implementation America">
        <meta http-equiv="Content-Type" content="text/html">
        <title>eTracker&#153; - Eminentlabs&#153; CRM, APM, TQM,  ERM and  EPTS Solution</title>
        <LINK title=STYLE href="<%= request.getContextPath()%>/eminentech support files/main_ie.css" type="text/css" rel=STYLESHEET>
        <script type="text/javascript" src="<%=request.getContextPath()%>/fusion/fusioncharts.js?version=30032016"></script>


    </head>
    <style>
        .ui-dialog{
            min-width: 1130px;
        }
    </style>

    <script type="text/javascript">
                function call(theForm)
                {
                var x = document.getElementById("userId").value;
                        theForm.action = '/eTracker/admin/dashboard/chartForUsers.jsp?userId=' + x;
                        theForm.submit();
                }
    </script>
    <body>

        <%@ include file="/header.jsp"%>

        <span class="refer"></span>

        <div class="refissuepopupa " style="display: none;">
            <img src="<%=request.getContextPath()%>/images/file-progress.gif" style="margin:5% 10% auto;"/>
            <div>
            </div>
        </div>


        <%!
            String[] priority = {"P1-Now", "P2-High", "P3-Medium", "P4-Low"};

        %>
        <%
            Connection connection = null;
            try {
                String mail = (String) session.getAttribute("theName");
                String url = null;
                if (mail != null) {
                    url = mail.substring(mail.indexOf("@") + 1, mail.length());
                }
                String get = request.getParameter("userId");

                String name = "My";
                Integer current_userId = (Integer) session.getAttribute("userid_curr");
                Integer branch = (Integer) session.getAttribute("branch");
                logger.debug("User ID" + get);
                String currentUser = null;
                currentUser = current_userId.toString();
                String userId = null;
                String nameOfSelectedUser = null;
                if (get == null) {
                    userId = currentUser;
                } else {

                    userId = get;
                    if (currentUser == get || currentUser.equalsIgnoreCase(get)) {
                        name = name;
                    } else {
                        nameOfSelectedUser = GetProjectMembers.getUserName(userId);
                        name = nameOfSelectedUser + "'s";
                    }
                }

                HashMap<String, Integer> hm = dashboard.MaxIssue.getIssueCountForUser(userId, currentUser);

                String statusLisType = dashboard.StatusList.getProjecType(userId);
                logger.info("Status Issue Count" + hm);
                ArrayList<String> statusList = dashboard.StatusList.getMyDashboardStatusList(statusLisType);
                logger.info("Status List" + statusList);
                logger.info("Status List Type" + statusLisType);
                int maximum = hm.get("maximum");

                int yetToAdd = 10 - (maximum % 10);

                int chartScale = (maximum + yetToAdd) / 10;

                //Setting property values according to the type of status list
                int appletWidth = 1000;
                int barWidth = 35;
                int depth3D = 25;
                int gridXPos = 65;
                int legendX = 930;
                int legendY = 43;
                int titleX = 800;
                int titleY = 10;
                String legendTitle = "";
                String series1 = "P1";
                String series2 = "P2";
                String series3 = "P3";
                String series4 = "P4";
                if (statusLisType.equalsIgnoreCase("both")) {
                    appletWidth = 1050;
                    barWidth = 30;
                    depth3D = 21;
                    gridXPos = 35;
                    legendX = 930;
                    legendY = 45;
                    titleX = 800;
                    titleY = 1;
                }

                if (statusLisType.equalsIgnoreCase("nonSAP")) {
                    //             legendTitle = "Priority Description";
                    series1 = "P1";
                    series2 = "P2";
                    series3 = "P3";
                    series4 = "P4";
                }

                if (statusLisType.equalsIgnoreCase("SAP")) {
                    legendX = 930;
                    titleX = 800;
                }


        %>


        <table cellpadding="0" cellspacing="0" width="100%">
            <tr bgColor="#C3D9FF">
                <td bgcolor="#C3D9FF" align="left" width="100%"><font
                        size="4" COLOR="#0000FF"><b><%=name%> Dashboard </b></font></td>
            </tr>
        </table>
        <jsp:useBean id="ResourceRequest" class="com.eminent.resource.ResourceRequestBean" />
        <jsp:useBean id="CRMIssue" class="com.pack.CRMIssueBean" /> 
        <%
            int user = Integer.parseInt(userId);
            connection = MakeConnection.getConnection();

        %>
        <table width="100%" >
            <tr height="10">
                    <td align="left" width="15%">This list shows <b> <%=(hm.get("altogether"))%> </b>issues assigned to <%
                        if (user == current_userId || user == 104) { %>you.<%} else {%><%=nameOfSelectedUser%>.<%}%></td>
                    <%
                        logger.info("Selected User" + user);
                        if (user == current_userId || current_userId == 104) {

                            int crmIssues = CRMIssue.getCRMIssues(connection, user);
                            String for_ward = "";
                            if (current_userId == 104) {
                                for_ward = CRMIssue.getHigestCRMIssues(connection, user, current_userId);
                            } else {
                                for_ward = CRMIssue.getHigestCRMIssues(connection, user, current_userId);
                            }

                            int resourceRequest = ResourceRequest.getResourceRequestNo(connection, user);
                            String leaveDetails[][] = LeaveUtil.waitingForApproval(user);
                            int noOfRequests = leaveDetails.length;
                            List l = CreateTimeSheet.GetTimeSheet(user);
                            int noOfTimeSheet = l.size();
                            int ermAssignment = ERMUtil.getAssignedApplicantCount(user);
                            int appraisalReq = AppraisalUtil.getNoOfAppraisalRequest(user);

                            // List tce          =   TestCasePlan.listUserExecutionCountJDBC(user);
                            int noOfTce = TestCasePlan.listUserExecutionCountJDBC(user);
                            if (resourceRequest > 0) {%>
                <TD align="left" width="10%">You have <a href="<%=request.getContextPath()%>/ResourceRequest/viewResourceRequest.jsp "><%=resourceRequest%></a> ERM Issues</TD>
                    <%}
                        if (noOfTce > 0) {%>
                <TD align="left" width="10%">You have <a href="<%=request.getContextPath()%>/MyAssignment/listTestCases.jsp?userId=<%=userId%>"><%=noOfTce%></a> Test Cases</TD>
                    <%}
                        if (crmIssues > 0) {%>
                <TD align="left" width="10%">You have <a href="<%=request.getContextPath()%><%=for_ward%>"><%=crmIssues%></a> CRM Issues</TD>
                    <%}
                        if (noOfRequests > 0) {
                    %>
                <TD align="left" width="10%">You have <a href="<%=request.getContextPath()%>/UserProfile/editLeaveRequest.jsp?userId=<%=userId%>"><%=noOfRequests%></a> Leave Requests</TD>
                    <%
                        }
                        if (noOfTimeSheet > 0) {
                    %>
                <TD align="left" width="10%">You have <a href="<%=request.getContextPath()%>/MyTimeSheet/timeSheetList.jsp?userId=<%=userId%> "><%=noOfTimeSheet%></a> TimeSheet Requests</TD>
                    <%
                        }
                        if (appraisalReq > 0) {
                    %>
                <TD align="left" width="11%">You have <a href="<%=request.getContextPath()%>/MyAssignment/viewAppraisal.jsp "><%=appraisalReq%></a> Appraisal Request</TD>
                    <%
                        }
                        if (ermAssignment > 0) {
                    %>
                <TD align="left" width="11%">You have <a href="<%=request.getContextPath()%>/ERM/assignedApplicants.jsp "><%=ermAssignment%></a> Candidate </TD>
                    <%
                            }
                        }
                    %>


            </tr>
        </table>
        <script type="text/javascript">
            FusionCharts.ready(function() {
            var stackedChart = new FusionCharts({
            type: 'stackedcolumn3d',
                    renderAt: 'chartcontainer',
                    width: '1000',
                    height: '500',
                    dataFormat: 'json',
                    "dataSource": {
                    "chart": {

                    "yAxisName": "Issues",
                            //                     
                            //                                                   "showSum": "1",
                            "formatnumber":"0",
                            "formatnumberscale":"0",
                            "sformatnumber":"0",
                            "sformatnumberscale":"0",
                            "yAxisMinValue":"0",
                            "yAxisMaxValue":"10",
                            "bgColor": "#ffffff",
                            "borderAlpha": "20",
                            "showCanvasBorder": "10",
                            "usePlotGradientColor": "0",
                            "plotBorderAlpha": "10",
                            "legendBorderAlpha": "0",
                            "legendShadow": "0",
                            "valueFontColor": "#000",
                            "showXAxisLine": "1",
                            "xAxisLineColor": "#999999",
                            "divlineColor": "#999999",
                            "divLineIsDashed": "1",
                            "showAlternateHGridColor": "0",
                            "subcaptionFontBold": "0",
                            "subcaptionFontSize": "14",
                            "showHoverEffect":"1",
                            "canvasBgColor":"#ffffff",
                            "canvasbgAlpha":"0",
                            "labelDisplay": "rotate",
                            "slantLabels": "1",
                            "legendPosition":"RIGHT",
                            "exportEnabled": "1",
                            "canvasBaseColor":"#ffffff"

                    },
                            "annotations": { "groups": [{ "items": [{ "type": "text", "text": "My Dashboard","toolText":"Display All Issue", "fontSize": "13", "color": "#000000", "bold": "1", "link": "JavaScript:callDashBoard()", "x": "$chartStartX +450", "y": "$chartStartY + 17" ,}] }] },
                            "categories": [
                            {
                            "category": [
            <%
                for (String stat : statusList) {%>
                            {
                            "label": "<%=stat%>"
                            },
            <%}%>
                            ]
                            }
                            ],
                            "dataset": [
            <%int priorityIndex = 0;
                for (int j = 1; j <= priority.length; j++) {
                    int statusIndex = 0;
            %>
                            {
                            "seriesname": "<%=priority[j - 1]%>",
            <%if (priorityIndex == 0) {%>
                            "color": '#FF0000',
            <%} else if (priorityIndex == 1) {%>
                            "color": '#DF7401',
            <%} else if (priorityIndex == 2) {%>
                            "color": '#F7FE2E',
            <%} else if (priorityIndex == 3) {%>
                            "color": '#04B45F',
            <%}%>
                            "data": [
            <%  for (int i = 1; i <= statusList.size(); i++) {

                    int checkForZero = CountIssue.getCountForUser(userId, currentUser, statusList.get(statusIndex), priority[priorityIndex]);
                    if (checkForZero > 0) {%>

                            {    "value": "<%=checkForZero%>",
                                    // "link":'<%= request.getContextPath()%>/admin/dashboard/displayIssue.jsp?userId=<%= userId%>&status=<%= statusList.get(statusIndex)%>&priority=<%= priority[priorityIndex]%>&currentUser=<%=currentUser%>'
                                    "link":"JavaScript:callIssue('<%= userId%>,<%= statusList.get(statusIndex)%>,<%= priority[priorityIndex]%>,<%=currentUser%>')"
                            },
            <%} else {%> {
                                    "value": ""
                                    },<%}
                                            statusIndex += 1;
                                        }%>]
                            },<%
                                    priorityIndex += 1;
                                }%>
                            ]
                    }
            });
                    stackedChart.render();
            });</script><div id="chartcontainer" class="chartarea">FusionCharts XT will load here!</div>

        <form name="theForm" onSubmit='return fun(this)'>
            <table width="100%" border="0" bgcolor="#E8EEF7" cellpadding="0"
                   align="center">


                <tr>
                    <td><font face="Book Antiqua"><b>Select Dashboard of : </b></font></td>
                    <td><select id="userId" name="userId" size=1 onchange="javascript:call(this.form)">
                            <%
                                int role = (Integer) session.getAttribute("Role");
                                ArrayList<String> al = null;
                                if (role == 1) {
                                    al = CountIssue.getAllUsers();
                                } else {
                                    al = CountIssue.getSpecificUsers(currentUser);
                                }
                                String getUser = null;

                                for (int i = 0; i < al.size(); i += 2) {

                                    getUser = al.get(i);
                                    if (getUser.equals(userId)) {
                            %>
                            <option value="<%= getUser%>" selected><%= al.get(i + 1)%>
                                <%

                                } else {
                                %>

                            <option value="<%= getUser%>"><%= al.get(i + 1)%> <%
                                    }
                                }
                                %>
                        </select>
                    </td>
                    <% if (url.equalsIgnoreCase("eminentlabs.net")) {%>
                    <td><a href="<%=request.getContextPath()%>/MyTimeSheet/myTimeWiseDashboard.jsp?userId=<%=userId%>">My Time Wise Dashboard</a></td>
                    <%}%>
                    <td><font face="Book Antiqua"><b>Total</b>&nbsp;:&nbsp;<a href="<%=request.getContextPath()%>/admin/dashboard/userIssue.jsp?userId=<%=userId%>"><%= (hm.get("altogether"))%></a></font></td>

                </tr>
                <%
                    } catch (Exception e) {
                        logger.error(e.getMessage());
                    } finally {
                        if (connection != null) {
                            connection.close();
                        }
                    }

                %>
            </table>

        </form>
        <script src="<%=request.getContextPath()%>/javaScript/jquery-1.10.2.js"></script>
        <script src="<%=request.getContextPath()%>/javaScript/jquery-ui.js"></script>
    </body>
    <link rel="stylesheet" href="//code.jquery.com/ui/1.11.4/themes/redmond/jquery-ui.css">
    <script src="<%=request.getContextPath()%>/javaScript/XMLHttpRequest.js" type="text/javascript"></script>
    <script type="text/javascript" src="<%= request.getContextPath()%>/javaScript/fileAttach.js?test=261020151625"></script>
    <script src="<%=request.getContextPath()%>/javaScript/jquery.tablesorter1.js" type="text/javascript"></script>
    <script src="<%=request.getContextPath()%>/javaScript/jquery.tablesorter.widgets.js" type="text/javascript"></script>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/select2/3.4.6/select2.min.css" rel="stylesheet">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/select2/3.4.6/select2.min.js"></script>
    <script src="<%=request.getContextPath()%>/javaScript/widget-filter-formatter-select2.js" type="text/javascript"></script>
    <script type="text/javascript" src="<%= request.getContextPath()%>/javaScript/tooltip.js"></script>

    <script type="text/javascript">

                                function callDashBoard(){
                                $('.refissuepopupa').dialog({ autoOpen: true});
                                        $(".refissuepopupa").dialog({position: {my: "right center", at: "right bottom"}

                                });
                                        mydashbordAllIsuue();
                                }
                        function  callIssue(user){

                        $('.refissuepopupa').dialog({ autoOpen: true});
                                $(".refissuepopupa").dialog({position: {my: "right center", at: "right bottom"}

                        });
                                myajaxfun(user);
                        }
                        $(function () {
                        $(".refissuepopupa").dialog({
                        autoOpen: false,
                                width: '90%',
                                maxHeight: 500,
                                title: "Issue(s) based on your selection are listed below",
                                position: {my: "left top", at: "right bottom", of: '.refer'},
                                show: {
                                effect: "slide",
                                        direction: "right",
                                        duration: 1000
                                },
                                hide: {
                                effect: "slide",
                                        direction: "right",
                                        duration: 1000
                                }
                        });
                        });
                                function myajaxfun(user) {
                                $(".refissuepopupa > img").show();
                                        $(".refissuepopupa > div").html("");
                                        $(".refissuepopupa").dialog("open");
                                        var issue = user.split(",");
                                        var userId = issue[0];
                                        var status = issue[1];
                                        var priority = issue[2];
                                        var currentUser = issue[3];
                                        $.ajax({
                                        url: '<%=request.getContextPath()%>/admin/dashboard/displayIssueAjax.jsp',
                                                data: {userId: userId, status:status, priority:priority, currentUser : currentUser, random: Math.random(1, 10)},
                                                async: true,
                                                type: 'GET',
                                                success: function (responseText, statusTxt, xhr) {
                                                if (statusTxt === "success") {
                                                var result = $.trim(responseText);
                                                        $(".refissuepopupa > div").html(result);
                                                        $(".refissuepopupa > img").hide();
                                                }
                                                }
                                        });
                                }
                                
                        function mydashbordAllIsuue() {
                        $(".refissuepopupa > img").show();
                                $(".refissuepopupa > div").html("");
                                $(".refissuepopupa").dialog("open");
                                var userId=$("#userId").val();
                            
                                $.ajax({
                                url: '<%=request.getContextPath()%>/admin/dashboard/displayAllIssueAjax.jsp',
                                        data: {userId: userId, random: Math.random(1, 10)},
                                        async: true,
                                        type: 'GET',
                                        success: function (responseText, statusTxt, xhr) {
                                        if (statusTxt === "success") {
                                        var result = $.trim(responseText);
                                                $(".refissuepopupa > div").html(result);
                                                $(".refissuepopupa > img").hide();
                                        }
                                        }
                                });
                        }
                        function showPrint(issueid) {
                        window.open("<%=request.getContextPath()%>/viewIssueDetails.jsp?issueid=" + issueid);
                        }
    </script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/fusion/fusiontrailremover.js"></script>

</html>
