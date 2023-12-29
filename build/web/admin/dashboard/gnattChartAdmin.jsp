

<%@page import="com.eminentlabs.chart.GnattDTO"%>
<%@ page import="org.apache.log4j.*"%>
<%@page import="dashboard.*,com.eminent.util.GetProjectMembers,com.eminent.util.GetProjectManager,com.eminent.util.IssueDetails, java.applet.*,java.util.*,com.eminent.timesheet.EminentPerformance,com.eminent.util.GetProjects"%>
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
%>
<html>
    <meta name="keywords" content="GST in SAP, SAP GST Accelerator, GST Success in SAP, GST India in SAP, GST SAP Success, GST Suvidha Provider, GST ASP GSP, GST, CGST,SGST, IGST, UGST,  SAP NW based Product Development, SAP Consulting, SAP Implementation, SAP Support Services, SAP Outsourcing, SAP Implementation India, SAP Implementation Bangalore, SAP Implementation Chennai, SAP Implementation Belgium, SAP Implementation Paris, SAP Implemtation Australia, SAP Implementation France, SAP Implementation Mumbai, SAP Implementation Kerala, SAP Implementation Belgaum, SAP Implementation Thailand, SAP Implementation Mexico, SAP Implementation America">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>eTracker&#153; - Eminentlabs&#153; CRM, APM, TQM,  ERM and  EPTS Solution</title>
    <script type="text/javascript" src="<%= request.getContextPath()%>/javaScript/tooltip.js"></script>
    <script type="text/javascript" src="<%= request.getContextPath()%>/javaScript/checkSubmit.js"></script>
    <script type="text/javascript"	src="<%= request.getContextPath()%>/eminentech support files/datetimepicker.js"></script>
    <LINK title=STYLE href="<%= request.getContextPath()%>/eminentech support files/main_ie.css?test=261020151225" type="text/css" rel="STYLESHEET">
    <script src="<%=request.getContextPath()%>/javaScript/XMLHttpRequest.js" type="text/javascript"></script>
    <script type="text/javascript" src="<%= request.getContextPath()%>/javaScript/fileAttach.js"></script>
    <link rel="stylesheet" href="//code.jquery.com/ui/1.11.4/themes/redmond/jquery-ui.css">
    <script src="//code.jquery.com/jquery-1.10.2.js"></script>
    <script src="//code.jquery.com/ui/1.11.4/jquery-ui.js"></script>   
    <script src="<%=request.getContextPath()%>/javaScript/XMLHttpRequest.js" type="text/javascript"></script>
    <script type="text/javascript" src="<%= request.getContextPath()%>/javaScript/fileAttach.js?test=261020151625"></script>
    <script src="<%=request.getContextPath()%>/javaScript/jquery.tablesorter1.js" type="text/javascript"></script>
    <script src="<%=request.getContextPath()%>/javaScript/jquery.tablesorter.widgets.js" type="text/javascript"></script>
    <link href="http://cdnjs.cloudflare.com/ajax/libs/select2/3.4.6/select2.min.css" rel="stylesheet">
    <script src="http://cdnjs.cloudflare.com/ajax/libs/select2/3.4.6/select2.min.js"></script>
    <script src="<%=request.getContextPath()%>/javaScript/widget-filter-formatter-select2.js" type="text/javascript"></script>
    <script type="text/javascript" src="<%= request.getContextPath()%>/javaScript/tooltip.js"></script>
    <script>
        function call(theForm)
        {
            var x = document.getElementById("pid").value;
            theForm.action = 'gnattChartAdmin.jsp?pid=' + x;
            theForm.submit();
        }
    </script>

</head>
<body class="home-bg">
    <div class="Ajax-loder">

        <div class="bg"></div>
        <img class="loading" src="<%=request.getContextPath()%>/images/276 (1).GIF"
             alt="loading...." /></div>
    <br/>
    <jsp:useBean id="pf" class="com.eminent.util.ProjectFinder"></jsp:useBean>
    <jsp:useBean id="gc" class="com.eminentlabs.chart.GnattChart"></jsp:useBean>       
    <%gc.setAdminAll(request);%>

    <table cellpadding="0" cellspacing="0" width="100%">
        <tr bgcolor="#C3D9FF">
            <td align="left" width="60%"><font size="4" COLOR="#0000FF"><b>Gantt Chart </b></font><FONT SIZE="3" COLOR="#0000FF"></FONT></td>
            <td style="width:30%;text-align:right;"><input type="hidden" name/>
                <form name="projectForm" id="projectForm" method="post" onsubmit="return fun(this);"><b>Project : </b> 
                    <select id="pid" name="pid" size=1 onchange="javascript:call(this.form)">                 
                        <option value="">All Projects</option>
                        <%  for (Map.Entry<Integer, String> entry : gc.getProjectSet().entrySet()) {
                                if (!gc.getProjectId().equals("") && entry.getKey() == Integer.parseInt(gc.getProjectId())) {
                        %>
                        <option value="<%=entry.getKey()%>" selected><%=entry.getValue()%></option>
                        <%} else {%>
                        <option value="<%=entry.getKey()%>"><%=entry.getValue()%></option>
                        <% }
                            }%>
                    </select></form>
            </td>
        </tr>
    </table>
    <table width="100%" >
        <tr> <td>
                <a href="<%=request.getContextPath()%>/admin/project/createProject.jsp">Add Project</a>&nbsp;&nbsp;&nbsp;
                <a href="<%=request.getContextPath()%>/admin/project/maintainDays.jsp">Maintain SLA</a>&nbsp;&nbsp;&nbsp;
                <a href="<%=request.getContextPath()%>/admin/project/treePrintAccess.jsp">Tree Print Access</a>&nbsp;&nbsp;&nbsp;
                <a href="<%=request.getContextPath()%>/admin/project/viewWRM.jsp">WRM Days</a>&nbsp;&nbsp;&nbsp;
                <a href="<%=request.getContextPath()%>/admin/project/apmTeam.jsp">Team Maintenance</a>&nbsp;&nbsp;&nbsp;
                <a href="<%=request.getContextPath()%>/admin/project/moduleIssueSplit.jsp">Issue Analysis</a>&nbsp;&nbsp;&nbsp;
                <a href="<%=request.getContextPath()%>/admin/project/momMaintanance.jsp" >MoM Maintenance</a>&nbsp;&nbsp;&nbsp;
                <a href="<%=request.getContextPath()%>/admin/project/trDisplay.jsp" >TR Display</a>&nbsp;&nbsp;&nbsp;
                <a href="<%=request.getContextPath()%>/admin/project/manageTR.jsp" >TR Pattern</a>&nbsp;&nbsp;&nbsp;
                <a href="<%=request.getContextPath()%>/admin/project/uploadIssues.jsp" >Upload Issues</a>&nbsp;&nbsp;&nbsp;
                <a href="<%=request.getContextPath()%>/admin/project/viewAttachedImages.jsp" style="cursor: pointer;">View Attached Images</a>
                <a href="<%=request.getContextPath()%>/admin/project/gstLogs.jsp" style="cursor: pointer;">GST 3in1 Cockpit</a>
                <a href="<%=request.getContextPath()%>/admin/dashboard/gnattChartAdmin.jsp" style="cursor: pointer;font-weight: bold; ">Gantt Chart</a>&nbsp;&nbsp;&nbsp;
                <a href="<%=request.getContextPath()%>/admin/project/maintainSapSystems.jsp" style="cursor: pointer;">Maintain SAP Systems</a>
                <a href="<%=request.getContextPath()%>/admin/project/demoProjects.jsp" style="cursor: pointer;">Demo(11)</a>
                <a href="<%=request.getContextPath()%>/admin/project/daywiseEInvoiceCount.jsp" style="cursor: pointer;">Daywise E-Invoice</a>  

            </td>
        </tr>
    </table>
    <div id="dialog" title="Basic dialog">

    </div>
    <%%>
    <div class="tablecontent">
        <table width="100%"   class="tablesorter">
            <thead>
                <tr style="text-align:center; font-weight:bold;background-color:#C3D9FF;">
                    <th class="header" style="text-align:center;width: 25%;" ><font style="color: #000000">User</font></th>
                        <% String title = "", color = "#000000";
                            int week = 1, year = 0;
                            for (String period : gc.getUniquePeriods()) {
                                color = "#000000";
                                year = Integer.parseInt(period.split(" ")[1].split("/")[1]);
                                week = Integer.parseInt(period.split(" ")[1].split("/")[0]);
                                if (week <= 52) {
                                    week = week + 1;
                                }

                                title = pf.dateRangeByWeekNumberAndYear(year, week);
                        %>
                    <th class="header" style="text-align:center;" title="<%=title%>"><font style="color: <%=color%>"><%=period%></font></th>
                        <%}%>
                    <th class="header" style="text-align:center;" ><font style="color: #000000">Total</font></th>
                </tr>
            </thead>
            <tbody>
                <%int a = 0;
                    for (int user : gc.getUniqueUsers()) {
                        if ((a % 2) != 0) {
                %>
                <tr class="zebraline" >
                    <%} else {%>
                <tr class="zebralinealter">
                    <%                    }
                        a++;%>           
                    <td class="hard_left" style="width: 25%;"><%=gc.getUsers().get(user)%></td>

                    <% int totCount = 0;
                        for (String period : gc.getUniquePeriods()) {
                            color = "";
                            year = Integer.parseInt(period.split(" ")[1].split("/")[1]);
                            week = Integer.parseInt(period.split(" ")[1].split("/")[0]);
                            if (!gc.getProjectId().equals("")) {
                                if (year > gc.getEndYear()) {
                                    color = "red";
                                } else {
                                    if (year == gc.getEndYear() && week > gc.getEndMonth()) {
                                        color = "red";
                                    }
                                }
                            }
                            GnattDTO gnattDTO = gc.getCount(gc.getGnattList(), user, period);
                            totCount = totCount + gnattDTO.getCount();
                    %>
                    <td style="text-align: center;<%if (gnattDTO.getCount() > 0) {%> background-color: <%=color%>;font-weight: bold;<%}%>">
                        <%if (gnattDTO.getCount() == 0) {%>
                        <%=gnattDTO.getCount()%>
                        <%} else {%>
                        <a href="#" style="" class="issuedisplay" week="<%=period%>" userId="<%=user%>" user="<%=gc.getUsers().get(user)%>" > <%=gnattDTO.getCount()%></a>
                        <%}%>
                    </td>
                    <%}%>

                    <td style="text-align: center;background-color: yellow;font-weight: bold;"><%=totCount%></td>
                </tr>
                <%}%>
            </tbody>
            <tfoot style="font-weight: bold;">
                <tr height="21" style="background-color: yellow;">
                    <td class="hard_left" style="text-align: right;">Period Wise</td>
                    <%int totCount = 0, count = 0;
                        for (String period : gc.getUniquePeriods()) {%>
                    <td style="text-align: center;">
                        <%count = 0;
                            if (gc.getUniquePeriodCount().containsKey(period)) {
                                count = gc.getUniquePeriodCount().get(period);
                            }
                            totCount = totCount + count;
                        %>
                        <%=count%>

                    </td>
                    <%}%>
                    <td style="text-align: center;"><%=totCount%></td>
                </tr>
            </tfoot>
        </table>
    </div>
    <br/><br/>
    <div class="tablecontent">
        <table width="100%"   class="tablesorter">
            <thead>
                <tr style="text-align:center; font-weight:bold;background-color:#C3D9FF;">
                    <th class="header" style="text-align:center;width: 25%;" ><font style="color: #000000">User</font></th>
                        <%  title = "";
                            week = 1;
                            year = 0;
                            for (String period : gc.getUniquePeriods()) {
                                year = Integer.parseInt(period.split(" ")[1].split("/")[1]);
                                week = Integer.parseInt(period.split(" ")[1].split("/")[0]);
                                if (week <= 52) {
                                    week = week + 1;
                                }
                                title = pf.dateRangeByWeekNumberAndYear(year, week);
                        %>
                    <th class="header" style="text-align:center;" title="<%=title%>"><font style="color: #000000"><%=period%></font></th>
                        <%}%>
                    <th class="header" style="text-align:center;" ><font style="color: #000000">Total</font></th>
                </tr>
            </thead>
            <tbody>
                <% a = 0;
                    for (int user : gc.getUniqueCustomerUsers()) {
                        if ((a % 2) != 0) {
                %>
                <tr class="zebraline" >
                    <%} else {%>
                <tr class="zebralinealter">
                    <%                    }
                        a++;%>           
                    <td class="hard_left" style="width: 25%;"><%=gc.getUsers().get(user)%></td>

                    <%  totCount = 0;
                        for (String period : gc.getUniquePeriods()) {
                            color = "";
                            if (!gc.getProjectId().equals("")) {
                                if (year > gc.getEndYear()) {
                                    color = "red";
                                } else {
                                    if (year == gc.getEndYear() && week > gc.getEndMonth()) {
                                        color = "red";
                                    }
                                }
                            }
                            GnattDTO gnattDTO = gc.getCount(gc.getGnattCustomerList(), user, period);
                            totCount = totCount + gnattDTO.getCount();
                    %>
                    <td style="text-align: center;<%if (gnattDTO.getCount() > 0) {%> background-color: <%=color%>;font-weight: bold;<%}%>">
                        <%if (gnattDTO.getCount() == 0) {%>
                        <%=gnattDTO.getCount()%>
                        <%} else {%>
                        <a href="#" class="issuedisplay" week="<%=period%>" userId="<%=user%>" user="<%=gc.getUsers().get(user)%>" > <%=gnattDTO.getCount()%></a>
                        <%}%>
                    </td>
                    <%}%>

                    <td style="text-align: center;background-color: yellow;font-weight: bold;"><%=totCount%></td>
                </tr>
                <%}%>
            </tbody>
            <tfoot style="font-weight: bold;">
                <tr height="21" style="background-color: yellow;">
                    <td class="hard_left" style="text-align: right;">Period Wise</td>
                    <%totCount = 0;
                        count = 0;
                        for (String period : gc.getUniquePeriods()) {%>
                    <td style="text-align: center;">
                        <%count = 0;
                            if (gc.getUniqueCustomerPeriodCount().containsKey(period)) {
                                count = gc.getUniqueCustomerPeriodCount().get(period);
                            }
                            totCount = totCount + count;
                        %>
                        <%=count%>

                    </td>
                    <%}%>
                    <td style="text-align: center;"><%=totCount%></td>
                </tr>
            </tfoot>
        </table>
    </div>

    <script src="<%=request.getContextPath()%>/javaScript/jquery.tablesorter.min.js" type="text/javascript"></script>
    <script type="text/javascript">
                        $(".tablesorter").tablesorter({
                            widgets: ['zebra'],
                            widgetOptions: {
                                zebra: ["zebraline", "zebralinealter"]
                            }
                        });
    </script>


</body>
<script type="text/javascript">
    $(document).on('click', '.issuedisplay', function () {
        var week = $.trim($(this).attr('week'));
        var userId = $.trim($(this).attr('userId'));
        var user = $.trim($(this).attr('user'));
        var pid = $("#pid").val();

        $.ajax({
            url: '<%=request.getContextPath()%>/admin/dashboard/gnattIssuesSummary.jsp',
            data: {pid: pid, week: week, userId: userId, random: Math.random(1, 10)},

            type: 'POST',
            success: function (responseText, statusTxt, xhr) {
                if (statusTxt === "success") {


                    $('#dialog').html(responseText);
                    $("#dialog").dialog("open");
                    $('.ui-dialog-title').html("Issues for " + user);
                }
            }
        });

    });
    $(function () {
        $("#dialog").dialog({
            autoOpen: false,
            width: 1000,
            maxHeight: 500,
            show: {
                effect: "blind",
                duration: 1000
            },
            hide: {
                effect: "blind",
                duration: 1000
            }
        });
    });
    $(".Ajax-loder").hide();
</script>

</html>

