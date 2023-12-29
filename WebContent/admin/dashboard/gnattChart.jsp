<%-- 
    Document   : projectPeformanceChart
    Created on : 21 Jun, 2010, 1:19:02 PM
    Author     : ADAL
--%>

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
    String pid = request.getParameter("pid");

    Calendar cl = Calendar.getInstance();
    cl.setTime(new Date());
    Long start = cl.getTimeInMillis();

    String project = GetProjects.getProjectName(pid);

    cl.setTime(new Date());
    Long end = cl.getTimeInMillis();
    start = end;

    String Values[][] = ProjectPerformance.getValueList(pid);

    cl.setTime(new Date());
    end = cl.getTimeInMillis();
    start = end;

    String dueDate[][] = new String[0][0];
    try {
        logger.info("Project in JSP" + pid);
        dueDate = IssueDetails.dueDateExceededIssues(pid);
    } catch (Exception ex) {
        logger.error(ex.getMessage());
    }
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
            theForm.action = 'gnattChart.jsp?pid=' + x;
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
    <%
        String category = CheckCategory.getProjectCategory(pid);
        String cases[][] = TestCases.showTestCases(pid);
        int noOfTestcases = cases.length;

        // Get Project governance people
        HashMap managers = GetProjectMembers.getProjectManagers(pid);
        int userId = (Integer) session.getAttribute("uid");
        int roleId = (Integer) session.getAttribute("Role");

    %>
    <jsp:useBean id="gc" class="com.eminentlabs.chart.GnattChart"></jsp:useBean>       
    <%gc.setAll(request);
        //Getting User Id and Role
        Integer role = (Integer) session.getAttribute("Role");
        Integer uid = (Integer) session.getAttribute("userid_curr");
        int roleValue = role.intValue();
        int uidValue = uid.intValue();
        HashMap<String, String> projects = null;
        if (roleValue == 1) {
            projects = GetProjectManager.getProjects();
        } else {
            //Displaying only assigned projects to other roles
            projects = GetProjectManager.getUserProjects(uidValue);
        }

        Collection se1 = projects.keySet();
    %> 
    <table cellpadding="0" cellspacing="0" width="100%">
        <tr bgcolor="#C3D9FF">
            <td align="left" width="60%"><font size="4" COLOR="#0000FF"><b>Gantt Chart of <%=GetProjects.getProjectName(pid).replace(":", " v")%></b></font><FONT SIZE="3" COLOR="#0000FF"></FONT></td>
            <td style="width:30%;text-align:right;">
                <form name="projectForm" id="projectForm" method="post" onsubmit="return fun(this);"><b>Project : </b> 
                    <select id="pid" name="pid" size=1 onchange="javascript:call(this.form)">                 

                        <%

                            //Displaying all the projects for Admin role
                            Iterator iter3 = se1.iterator();
                            int projectId = 0;
                            while (iter3.hasNext()) {

                                String key = (String) iter3.next();
                                String nameofproject = (String) projects.get(key);
                                //      logger.info("Userid"+key);
                                //      logger.info("Name"+nameofuser);
                                projectId = Integer.parseInt(key);
                                if (projectId == Integer.parseInt(pid)) {

                        %>
                        <option value="<%=pid%>" selected><%=nameofproject%></option>
                        <%
                        } else {%>
                        <option value="<%=projectId%>"><%=nameofproject%></option>
                        <% }
                            }%>
                    </select></form>
            </td>
        </tr>
    </table>
    <table width="100%" >
        <tr><td >

                <%
                    if (category.equalsIgnoreCase("SAP Project")) {
                %>
                <!--edit by mukesh end -->
                <a href="<%=request.getContextPath()%>/testMap.jsp?pid=<%=pid%>">Business Process Map</a>&nbsp;&nbsp;&nbsp;
                <!--edit by mukesh end -->
                <a href="<%=request.getContextPath()%>/admin/dashboard/projectChart.jsp?project=<%=project%>">Status-wise Dashboard</a>&nbsp;&nbsp;&nbsp;
                <%
                    }

                %>
                <a href="<%=request.getContextPath()%>/admin/dashboard/modulewiseChart.jsp?project=<%=project%>">Module-wise Dashboard</a>&nbsp;&nbsp;&nbsp;
                <%
                    if (noOfTestcases > 0) {
                %>              <a href="<%=request.getContextPath()%>/admin/dashboard/TestCasesChart.jsp?project=<%=pid%>">View Test Coverage</a>&nbsp;&nbsp;&nbsp;
                <%}%>
                <a href="<%=request.getContextPath()%>/UserProject/listProjectTestPlan.jsp?pid=<%=pid%>">View Test Plans</a>&nbsp;&nbsp;&nbsp;
                <a href="<%=request.getContextPath()%>/admin/dashboard/openIssueByProject.jsp?pid=<%=pid%>">View Issues</a>&nbsp;&nbsp;&nbsp;
                <a href="<%=request.getContextPath()%>/MOM/momProjectTeamWise.jsp?pid=<%=pid%>" title="Weekly Review MoM">WRM</a>&nbsp;&nbsp;&nbsp; 
                <%if (project.contains("eTracker")) {%>
                <a href="<%=request.getContextPath()%>/UserProfile/userException.jsp">Server Log</a>&nbsp;&nbsp;&nbsp;&nbsp;
                <%}%>
                <a href="<%=request.getContextPath()%>/CreateIssue/uploadIssues.jsp?pid=<%=pid%>" >Upload Issues</a>&nbsp;&nbsp;&nbsp; 
            </td>
        </tr>
    </table>
    <jsp:useBean id="pf" class="com.eminent.util.ProjectFinder"></jsp:useBean>
        <div id="dialog" title="Basic dialog">

        </div>

        <div class="tablecontent">
            <table width="100%"  id="countTable" class="tablesorter">
                <thead>
                    <tr style="text-align:center; font-weight:bold;background-color:#C3D9FF;">
                        <th class="header" style="text-align:center;" ><font style="color: #000000">User</font></th>
                        <% String title = "", color = "#000000";
                            int week = 1, year = 0;
                            for (String period : gc.getUniquePeriods()) {
                                year = Integer.parseInt(period.split(" ")[1].split("/")[1]);
                                week = Integer.parseInt(period.split(" ")[1].split("/")[0]);
                                                             if (week <= 52) {
                                    week = week + 1;
                                }
                                title = pf.dateRangeByWeekNumberAndYear(year, week);
                        %>
                    <th class="header" style="text-align:center;" title="<%=title%> <%=year%> <%=week%> " ><font style="color: #000000"><%=period%></font></th>
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
                    <td class="hard_left"><%=gc.getUsers().get(user)%></td>

                    <% int totCount = 0;
                        for (String period : gc.getUniquePeriods()) {
                               color = "";
                            year = Integer.parseInt(period.split(" ")[1].split("/")[1]);
                            week = Integer.parseInt(period.split(" ")[1].split("/")[0]);
                            if (year > gc.getEndYear()) {
                                color = "red";
                            } else {
                                if (year == gc.getEndYear() && week > gc.getEndMonth()) {
                                    color = "red";
                                }
                            }
                            GnattDTO gnattDTO = gc.getCount(gc.getGnattList(), user, period);
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

                    <td style="text-align: right;background-color: yellow;font-weight: bold;"><%=totCount%></td>
                </tr>
                <%}%>
            </tbody>
            <tfoot style="font-weight: bold;">
                <tr height="21" style="background-color: yellow;">
                    <td class="hard_left" style="text-align: right;">Period Wise</td>
                    <%int totCount = 0;
                        for (String period : gc.getUniquePeriods()) {%>
                    <td style="text-align: right;">
                        <%int count = gc.getUniquePeriodCount().get(period);
                            totCount = totCount + count;
                        %>
                        <%=count%>

                    </td>
                    <%}%>
                    <td style="text-align: right;"><%=totCount%></td>
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
        var pid = <%=pid%>

        $.ajax({

            url: '<%=request.getContextPath()%>/admin/dashboard/gnattIssuesSummary.jsp',
            data: {pid: pid, week: week, userId: userId, random: Math.random(1, 10)},
            async: true,
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

