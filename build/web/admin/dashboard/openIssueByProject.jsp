<%-- 
    Document   : openIssueByProject
    Created on : Oct 24, 2013, 10:58:22 AM
    Author     : E0288
--%>
<%@page import="com.eminent.issue.dao.IssueCategoryDAOImpl"%>
<%@page import="com.eminent.issue.IssueCategory"%>
<%@page import="com.eminent.issue.dao.EscalationDAOImpl"%>
<%@page import="com.eminent.issue.dao.EscalationDAO"%>
<%@page import="com.eminentlabs.mom.ApmWrmPlan"%>
<%@page import="com.eminentlabs.mom.TeamWiseMom"%>
<%@page import="com.eminent.holidays.HolidaysUtil"%>
<%@page import="com.eminent.holidays.Holidays"%>
<%@page import="com.eminentlabs.mom.MoMUtil"%>
<%@page import="com.eminent.issue.PlanStatus"%>
<%@page import="com.eminent.issue.ProjectPlannedIssue"%>
<%@page import="com.eminent.util.ProjectPlanUtil"%>
<%@page import="com.eminent.util.GetAge"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.eminent.util.GetName"%>
<%@page import="com.eminent.util.IssueDetails"%>
<%@page import="com.eminent.util.ProjectFinder"%>
<%@page pageEncoding="UTF-8"%>
<%@ page import="org.apache.log4j.*"%>
<%@page import="dashboard.*, java.applet.*,java.util.*,com.eminent.util.GetProjects,com.eminent.util.GetProjectMembers,dashboard.TestCases"%>

<%
    //Configuring log4j properties
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Cache-Control", "no-store");
    response.setDateHeader("Expires", 0);
    response.setHeader("Pragma", "no-cache");
    Logger logger = Logger.getLogger("openIssuesByProject");
    String logoutcheck = (String) session.getAttribute("Name");
    if (logoutcheck == null) {
%>
<jsp:forward page="/SessionExpired.jsp"></jsp:forward>
<%    }

%>
<!DOCTYPE html>
<html>
    <meta name="keywords" content="GST in SAP, SAP GST Accelerator, GST Success in SAP, GST India in SAP, GST SAP Success, GST Suvidha Provider, GST ASP GSP, GST, CGST,SGST, IGST, UGST,  SAP NW based Product Development, SAP Consulting, SAP Implementation, SAP Support Services, SAP Outsourcing, SAP Implementation India, SAP Implementation Bangalore, SAP Implementation Chennai, SAP Implementation Belgium, SAP Implementation Paris, SAP Implemtation Australia, SAP Implementation France, SAP Implementation Mumbai, SAP Implementation Kerala, SAP Implementation Belgaum, SAP Implementation Thailand, SAP Implementation Mexico, SAP Implementation America">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>eTracker&#153; - Eminentlabs&#153; CRM, APM, TQM,  ERM and  EPTS
        Solution</title>
    <LINK title=STYLE href="<%= request.getContextPath()%>/eminentech support files/main_ie.css?test=120720161653" type="text/css" rel="STYLESHEET">
    <script src="<%=request.getContextPath()%>/javaScript/XMLHttpRequest.js" type="text/javascript"></script>
    <script type="text/javascript" src="<%= request.getContextPath()%>/javaScript/fileAttach.js"></script>
    <script type="text/javascript" src="<%= request.getContextPath()%>/javaScript/tooltip.js"></script>
    <script type="text/javascript" src="<%= request.getContextPath()%>/javaScript/checkSubmit.js?c=0"></script>
    <script type="text/javascript" src="<%= request.getContextPath()%>/javaScript/slide.js"></script>
    <script type="text/javascript"	src="<%= request.getContextPath()%>/eminentech support files/datetimepicker.js"></script>
    <script src="<%=request.getContextPath()%>/javaScript/jquery.js" type="text/javascript"></script>
    <script src="<%=request.getContextPath()%>/javaScript/jquery.tablesorter.min.js" type="text/javascript"></script>
    <LINK title=STYLE href="<%= request.getContextPath()%>/css/displayColumns.css?test=280620161553" type="text/css" rel="STYLESHEET">
    <link rel="stylesheet" type="text/css" href="<%= request.getContextPath()%>/css/dragtable.css" />

    <script src="<%=request.getContextPath()%>/javaScript/jquery-ui.min.js"></script>
    <script src="<%=request.getContextPath()%>/javaScript/jquery.dragtable.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/javaScript/jquery.chili-2.2.js"></script>
    <script src="<%=request.getContextPath()%>/javaScript/jquery.tablesorter1.js" type="text/javascript"></script>
    <link title=STYLE href="<%= request.getContextPath()%>/css/notifyMe.css?test=1" type="text/css" rel="STYLESHEET"/>

    <style>
        .some-handle {
            cursor:move;
        }
        .some-handle {
            height:8px;
            margin:0 1px;
        }
        .showsubissue {
            width: 20px;
            height: 20px;
            border-radius: 30px;
            font-size: 18px;
            color: black;
            text-shadow: 0 1px 0 #666;
            text-align: center;
            text-decoration: none;
            box-shadow: 1px 1px 2px #000;
            background: #accc;
            opacity: .95;
            margin-right: 0;
            float: right;
            cursor:  pointer;
        }
    </style>
    <script type="text/javascript">
        function showPrint(issueid) {
            window.open("<%=request.getContextPath()%>/viewIssueDetails.jsp?issueid=" + issueid);
        }
        $.tablesorter.addParser({
            id: 'img_alt',
            is: function(s, table, cell) {
                return false;
            },
            format: function(s, table, cell) {
                var $cell = $(cell);
                return $cell.find('img').attr('alt') || s;
            },
            type: 'text'
        });

        $.tablesorter.addParser({
            // set a unique id 
            id: 'ddMMMyy',
            is: function(s) {
                // return false so this parser is not auto detected 
                return false;
            },
            format: function(s) {
                // parse the string as a date and return it as a number 
                return +new Date(s);
            },
            // set type, either numeric or text 
            type: 'numeric'
        });
        $(document).ready(function()
        {
            //                var d = new Date();
            //                var time = d.getHours();
            //                alert("Time"+time);
            //               
            //                if(time>13){
            //                    $("input.group").prop("disabled", true);
            //                }
            $("#customerTable").tablesorter({
                widgets: ['zebra'],
                widgetOptions: {
                    zebra: ["zebraline", "zebralinealter"]
                },
                // change the multi sort key from the default shift to alt button 
                sortMultiSortKey: 'altKey',
                headers: {
                    1: {sorter: 'img_alt'
                    },
                    6: {// <-- replace 6 with the zero-based index of your column
                        sorter: 'ddMMMyy'
                    }
                }
            });
            $("#esplTable").tablesorter({
                widgets: ['zebra'],
                widgetOptions: {
                    zebra: ["zebraline", "zebralinealter"]
                },
                // change the multi sort key from the default shift to alt button 
                sortMultiSortKey: 'altKey',
                headers: {
                    1: {sorter: 'img_alt'
                    },
                    6: {// <-- replace 6 with the zero-based index of your column
                        sorter: 'ddMMMyy'
                    }
                }
            });
            $('.tablesorter').dragtable({dragHandle: '.some-handle'});
        }
        );

    </script>
    <script type="text/javascript">
        function trim(str)
        {
            while (str.charAt(str.length - 1) === " ")
                str = str.substring(0, str.length - 1);
            while (str.charAt(0) === " ")
                str = str.substring(1, str.length);
            return str;
        }
        function isDate(str)
        {
            var pattern = "0123456789-";
            var i = 0;
            do
            {
                var pos = 0;
                for (var j = 0; j < pattern.length; j++)
                    if (str.charAt(i) === pattern.charAt(j))
                    {
                        pos = 1;
                        break;
                    }
                i++;
            } while (pos === 1 && i < str.length)
            if (pos === 0)
                return false;
            return true;
        }
        function callProject()
        {
            var x = document.getElementById("projectname").value;
            var planDate = document.getElementById("planDate").value;
            var planType = $('input[name=planType]:checked').val();
            if (document.getElementById("plannedFor") !== null) {
                var plannedFor = document.getElementById("plannedFor").value;
                document.projectForm.action = '/eTracker/admin/dashboard/openIssueByProject.jsp?projectname=' + x + '&planDate=' + planDate + '&plannedFor=' + plannedFor + "&planType=" + planType;
            } else {
                document.projectForm.action = '/eTracker/admin/dashboard/openIssueByProject.jsp?projectname=' + x + '&planDate=' + planDate + "&planType=" + planType;
            }
            document.projectForm.submit();
        }
        function callProjectPlan()
        {
            var x = document.getElementById("projectname").value;
            var planDate = document.getElementById("planDate").value;
            var planType = $('input[name=planType]:checked').val();
            var plannedForParam = $.trim($("#plannedForParam").val());
            var count = 0;
            var plannedFor = document.getElementById("plannedFor").value;
            if (plannedFor == "") {
                count++;
            } else if (plannedForParam.length == 0 && (plannedFor == 'Today')) {
                count++;
            } else if (plannedForParam == plannedFor) {
                count++;
            }
            if (count == 0) {
                if (document.getElementById("plannedFor") !== null) {
                    var plannedFor = document.getElementById("plannedFor").value;

                    document.projectForm.action = '/eTracker/admin/dashboard/openIssueByProject.jsp?projectname=' + x + '&planDate=' + planDate + '&plannedFor=' + plannedFor + "&planType=" + planType;
                } else {
                    document.projectForm.action = '/eTracker/admin/dashboard/openIssueByProject.jsp?projectname=' + x + '&planDate=' + planDate + "&planType=" + planType;
                }
                document.projectForm.submit();
            } else {
                return false;
            }
        }
        function call()
        {

            var str = document.dateForm.planDate.value;
            var first = str.indexOf("-");
            var last = str.lastIndexOf("-");
            var year = str.substring(last + 1, last + 5);
            var month = str.substring(first + 1, last);
            var date = str.substring(0, first);
            var form_date = new Date(year, month - 1, date);
            var current_date = new Date();
            var current_year = current_date.getFullYear();
            var current_month = current_date.getMonth();
            var current_date = current_date.getDate();
            var today = new Date(current_year, current_month, current_date);
            if (form_date > today) {
                if (document.getElementById("nextWDay") === null) {
                    alert('Plan Date cannot be greater than Today');
                    document.dateForm.planDate.focus();
                    return false;
                } else {
                    var stra = document.getElementById("nextWDay").value;
                    var firsta = stra.indexOf("-");
                    var lasta = stra.lastIndexOf("-");
                    var yeara = stra.substring(lasta + 1, lasta + 5);
                    var montha = stra.substring(firsta + 1, lasta);
                    var datea = stra.substring(0, firsta);
                    var form_datea = new Date(yeara, montha - 1, datea);
                    if (form_datea < form_date) {
                        alert('Plan Date cannot be greater than ' + stra);
                        document.dateForm.planDate.focus();
                        return false;
                    }
                }
            }
            disableSearchSubmit();
        }
        function collapseimg() {
            if (!$("#closedImg").hasClass('plus')) {
                $("#closedImg").attr('src', '/eTracker/images/minus.gif');
                $("#closedImg").addClass('plus');
            } else {
                $("#closedImg").attr('src', '/eTracker/images/plus.gif');
                $("#closedImg").removeClass('plus');
                $("#closedImg").addClass('minus');
            }
        }
        var xmlhttp = createRequest();
        function callClosedAlways() {
            collapseimg();
            callClosed();
        }
        function callClosed() {
            document.getElementById('progressbar').style.visibility = 'visible';
            var project = document.getElementById("wrmpid").value;
            var wrmDay = document.getElementById("wrmDay").value;
            var plannedon = document.getElementById("wrmPlannedOn").value;
            if (xmlhttp !== null) {

                xmlhttp.open("GET", "/eTracker/closedIssuesByWRM.jsp?pid=" + encodeURIComponent(project) + "&wrmDay=" + wrmDay + "&planDate=" + plannedon + "&rand=" + Math.random(1, 10), true);
                xmlhttp.onreadystatechange = function() {
                    callbackres();
                };
                xmlhttp.send(null);
            } else {
                alert('no ajax request');
            }
        }
        function callbackres() {
            var firsttime = document.getElementById("firsttime");
            if (xmlhttp.readyState === 4)
            {
                if (xmlhttp.status === 200)
                {
                    var closedresp = xmlhttp.responseText;
                    $('#closedapm').html("");
                    $('#closedapm').append(closedresp);
                    if (firsttime === null) {
                        $("#closedapm").toggle(100);
                    }
                    document.getElementById('progressbar').style.visibility = 'hidden';
                }

            }
        }
        function callWrm() {
            var planType = $.trim($("input[name=planType]:checked").val());
            var agreed = $.trim($('input[name=agreed]:checked').val());
            var wrmCheck = $("#wrmCheck").val();
            var wrmCheckMsg = $("#wrmCheckMsg").val();
            if (agreed !== '') {
                alert('You cannot be select WRM and Agreed Issues.');
                $("input[name=planType]").attr("checked", false);
            } else {
                if (planType == 'WRM' && wrmCheck === 'notDone') {
                    alert("Last week(" + wrmCheckMsg + ")'s performance rating is not obtained. Please get the rating from customer before planning the WRM issues.");
                    $("input[name=planType]").attr("checked", false);
                } else {
                    $('input[name=Agreed]').attr("disable", true);
                    $("input[name=pIssue]").each(function() {
                        var issue = $.trim($(this).val());
                        var obj = $(this);
                        var count = 0;
                        if (planType == 'WRM') {
                            $('#planDaySelector').hide();
                            $(".wrm").each(function() {
                                var issuea = $.trim($(this).attr("issue"));
                                if (issue == issuea) {
                                    count = 1;
                                    obj.attr("checked", true);
                                }
                            });
                            if (count == 0) {
                                obj.attr("checked", false);
                            }
                        } else {
                            $('#planDaySelector').show();
                            $(".planned").each(function() {
                                var issuea = $.trim($(this).attr("issue"));
                                if (issue == issuea) {
                                    count = 1;
                                    obj.attr("checked", true);
                                }
                            });
                            if (count == 0) {
                                obj.attr("checked", false);
                            }
                        }
                    });
                }
            }
        }
        function callAgreed() {
            var planType = $.trim($("input[name=planType]:checked").val());
            var agreed = $.trim($('input[name=agreed]:checked').val());

            $('#plannedFor').prop('selectedIndex', 0);
            $("input[name=pIssue]").each(function() {
                $(this).attr("checked", false);
            });
            $('#planDaySelector').show();

            if (planType !== '') {
                $("input[name=planType]").attr("checked", false);
            }
            if (agreed !== '') {
//                $('#plannedFor').prop('disabled', true);
                $('input[name=planType]').prop('disabled', true);

                $("input[name=pIssue]").each(function() {
                    var issue = $.trim($(this).val());
                    var obj = $(this);
                    var count = 0;
                    obj.attr("checked", false);
                    $("." + agreed).each(function() {
                        var issuea = $.trim($(this).attr("issue"));
                        if (issue == issuea) {
                            count = 1;
                            obj.attr("checked", true);
                        }
                    });
                    if (count == 0) {
                        obj.attr("checked", false);
                    }
                });

            } else {
                $('#plannedFor').prop('disabled', false);
                $('input[name=planType]').prop('disabled', false);

            }
        }

    </script>
    <style type="text/css">
        .mom table
        {
            border-collapse:collapse;
        }
        .mom table, .mom td, .mom th 
        {
            border:1px solid black;
        }
    </style>
</head>
<jsp:useBean id="twm" class="com.eminentlabs.mom.TeamWiseMom" ></jsp:useBean>
<jsp:useBean id="wic" class="com.eminentlabs.wrm.controller.WrmIssuesController" ></jsp:useBean>
    <body>
    <%@ include file="/header.jsp"%>

    <%
        int userid_curri, age;
        SimpleDateFormat sdfss = new SimpleDateFormat("dd-MM-yyyy");
        String team = (String) session.getAttribute("team");
        userid_curri = (Integer) session.getAttribute("userid_curr");
        String mail = (String) session.getAttribute("theName");
        String url = null;
        if (mail != null) {
            url = mail.substring(mail.indexOf("@") + 1, mail.length());
        }
        Calendar cal = Calendar.getInstance();
        Date plannedOn = cal.getTime();
        String plannedForParam = request.getParameter("plannedFor");
        if (plannedForParam == null) {
            plannedForParam = "";
        }
        Date nextWorkDay = MoMUtil.nextDay(plannedOn);
        boolean flag = true;
        while (flag == true) {
            List<Holidays> holidaysList = HolidaysUtil.findByHolidayDate(nextWorkDay);
            if (!holidaysList.isEmpty()) {
                nextWorkDay = MoMUtil.nextDay(nextWorkDay);
            } else {
                flag = false;
            }
        }
        String nextWDay = sdfss.format(nextWorkDay);
        SimpleDateFormat time = new SimpleDateFormat("HH");
        String timeFor = time.format(plannedOn);
        int current_time = Integer.parseInt(timeFor);
        String project = request.getParameter("pid");
        String pname = request.getParameter("projectname");
        if (pname != null) {
            project = GetProjects.getProjectId(pname);
        }
        if (project == null) {
            if (session.getAttribute("viewIssuePid") != null) {
                project = (String) session.getAttribute("viewIssuePid");
            }
        }
        SimpleDateFormat sdfs = new SimpleDateFormat("dd-MMM-yyyy");
        SimpleDateFormat sdfwrm = new SimpleDateFormat("yyyy-MM-dd");
        String planType = request.getParameter("planType");
        if (planType == null) {
            planType = "";
        }
        planType = planType.trim();
        String planDate = request.getParameter("planDate");
        if (plannedForParam.equalsIgnoreCase(IssueDetails.plannedForList().get(0))) {
            planDate = sdfss.format(new Date());
        }
        logger.info(planDate);
        if (planDate != null) {
            planDate = com.pack.ChangeFormat.changeDateFormat(planDate.trim());
            plannedOn = sdfs.parse(planDate);
        }

        String planOn = sdfss.format(plannedOn);
        if (plannedForParam.equalsIgnoreCase(IssueDetails.plannedForList().get(1))) {
            planOn = sdfss.format(nextWorkDay);
        }
        session.setAttribute("viewIssuePid", project);
        session.setAttribute("forwardpage", "/admin/dashboard/openIssueByProject.jsp");
        String issueDetails[][] = IssueDetails.openIssuesByProject(project);
        int pid = Integer.parseInt(project);
        HashMap<Integer, String> customerUsers = GetProjectMembers.getCustomeUsers(pid);
        Map<String, String> agreedIssue = GetProjectMembers.getAgreedIssues(pid);
//        if(pid==10134){
//            agreedIssue = GetProjectMembers.getAgreedIssueforCKC(pid);
//            System.out.println("Project::"+pid);
//        }
        int customerCount = 0;
        for (int i = 0; i < issueDetails.length; i++) {
            String assignedTo = issueDetails[i][10];
            int assi = Integer.parseInt(assignedTo);
            if (customerUsers.containsKey(assi)) {
                customerCount++;
            }
        }

        int closedIssueCount = IssueDetails.closedIssuesCountByProject(project);
        String projectName = GetProjects.getProjectName(project);
        HashMap<Integer, String> PMAndDM = GetProjectMembers.getPMAndDM(project);
        HashMap<Integer, String> managers = GetProjectMembers.getProjectManagers(project);
        List<String> wrmDays = new ArrayList();
        HashMap<Integer, String> member = GetProjectMembers.showUsersSName();

        Calendar wrmcal = Calendar.getInstance();
        int curDay = wrmcal.get(Calendar.DAY_OF_WEEK);
        logger.info("curDay:" + curDay);
        int day = ProjectFinder.getProjectWRMDay(pid);
        if (day == 0) {
            day = 2;
        }

        wrmcal.set(Calendar.DAY_OF_WEEK, day);
        if (day >= curDay) {
            wrmcal.add(Calendar.DATE, -7);
        }
        Date wrmStartDate = wrmcal.getTime();
        wrmDays.add(sdfs.format(wrmStartDate));
        for (int w = 1; w < 20; w++) {
            wrmcal.add(Calendar.DATE, -7);
            wrmDays.add(sdfs.format(wrmcal.getTime()));
        }
        wrmcal.setTime(wrmStartDate);
        logger.info(wrmStartDate);
        wrmStartDate = sdfs.parse(sdfs.format(wrmStartDate));
        String wrmParam = request.getParameter("wrmDay");

        if (wrmParam != null) {
            wrmStartDate = sdfs.parse(wrmParam);
        }

        wrmcal.setTime(wrmStartDate);

        wrmcal.add(Calendar.DATE, 7);
        Date wrmEndDate = wrmcal.getTime();
        /**
         * Wrm Plan Issues Start
         */
        EscalationDAO escalationDAO = new EscalationDAOImpl();
        List<String> escalationIssues = escalationDAO.escalationList(pid);
        String wrmDay = sdfs.format(wrmStartDate);
        Calendar wrmcala = Calendar.getInstance();
        wrmcala.setTime(wrmStartDate);
        if (curDay == day) {
            wrmcala.add(Calendar.DATE, 7);
        }

        List<ApmWrmPlan> apmWrmPlans = twm.findLastWRMDay(pid);
        Date lastWrm = twm.getMaxHeldOn(pid);
        List<String> wrmPlanIssues = new ArrayList();
        for (ApmWrmPlan apmWrmPlan : apmWrmPlans) {
            if (apmWrmPlan.getStatus().equalsIgnoreCase("Active")) {
                wrmPlanIssues.add(apmWrmPlan.getIssueid());
            }
        }
        /*
         * Wrm Plan Issues Start
         */

        List<String> plannedissuenos = new ArrayList<String>();
        plannedissuenos = MoMUtil.todayPlannedIssues(sdfs.format(plannedOn));
        if (plannedForParam.equalsIgnoreCase(IssueDetails.plannedForList().get(1))) {
            plannedissuenos = MoMUtil.todayPlannedIssues(sdfs.format(sdfss.parse(planOn)));
        }
        List<ProjectPlannedIssue> weekWisePlanIssue = ProjectPlanUtil.findByDayAndProjectId(sdfss.parse(planOn), Long.valueOf(project.trim()));
        List<String> planIssues = new ArrayList();
        for (ProjectPlannedIssue ppi : weekWisePlanIssue) {
            if (ppi.getStatus().equalsIgnoreCase(PlanStatus.ACTIVE.getStatus())) {
                planIssues.add(ppi.getIssueId());
            }
        }
        String category = "NA";
        if (project != null) {
            if (projectName != null) {
                category = CheckCategory.getCategory(projectName);
            }
        }
        logger.info("Category :" + category);
        String cases[][] = TestCases.showTestCases(project);
        int noOfTestcases = cases.length;
        Map<String, Integer> lastAsigneeAgeList = new HashMap();
        Map<String, Integer> fileCountList = new HashMap();
        Map<String, Integer> sunIssueCountList = new HashMap();
        List<String> wrmTouchedByCustomerIssues = new ArrayList();
        List<String> wrmTouchedByESPLIssues = new ArrayList();
        wrmTouchedByCustomerIssues = wic.wrmTouchedByCustomer(String.valueOf(pid));
        wrmTouchedByESPLIssues = wic.wrmTouchedByEspl(String.valueOf(pid));
        List<IssueCategory> ississueCategorys = new IssueCategoryDAOImpl().getByPid(pid);
    %>
    <div style="width:100%;"><span  style="font-weight: bold;float:left;background-color: #C3D9FF;width: 30%;height: 25px; ">

            Open Issues of <%=projectName%> </span><span style="height: 25px;float: left;background-color: #C3D9FF;width: 30%;">
            <form name="dateForm" id="dateForm" method="post" action="<%=request.getContextPath()%>/admin/dashboard/openIssueByProject.jsp" onsubmit="return call();">
                <b>Planned On :</b><input type="text" id="planDate" name="planDate" maxlength="10" size="10" value="<%=planOn%>" readonly />
                <a href="javascript:NewCal('planDate','ddmmyyyy')"> <img src="<%=request.getContextPath()%>/images/newhelp.gif" border="0" width="16" height="16" alt="Pick a date"></a></b></font>

                <% if (current_time >= 0) {%><input type="hidden" name="nextWDay" id="nextWDay" value="<%=nextWDay%>"><%}%><input type="hidden" name="pid" value="<%=pid%>"><input type="submit" name="search" id="search" value="Search">
            </form></span>
        <span style="float:left;background-color: #C3D9FF;width: 38%;text-align: right;height: 25px;"><form name="projectForm" id="projectForm" method="post" onsubmit="return fun(this);"><b>Project : </b> 
                <select id="projectname" name="projectname" size=1 onchange="callProject(this);" >                  

                    <%
                        //Getting User Id and Role
                        Integer role = (Integer) session.getAttribute("Role");
                        Integer uid = (Integer) session.getAttribute("userid_curr");
                        int roleValue = role.intValue();
                        int uidValue = uid.intValue();

                        //Displaying all the projects for Admin role
                        ArrayList<String> al = null;
                        if (roleValue == 1) {
                            al = CountIssue.getAllProject();
                        } else {
                            //Displaying only assigned projects to other roles        
                            al = CountIssue.getProjectForUser(uidValue);
                        }

                        for (String dbProject : al) {
                            if (projectName != null && projectName.equalsIgnoreCase(dbProject)) {
                    %>
                    <option value="<%= projectName%>" selected><%= projectName%> <%
                    } else {
                        %>

                    <option value="<%= dbProject%>"><%= dbProject%> <%
                            }
                        }


                        %>
                </select></form></span></div><br/>
    <p style="height: 1px;">&nbsp;</p>

    <table style="width:100%;">
        <tr >
            <td>This list shows <%=issueDetails.length%> open issues of <%=projectName%>
            </td>

        </tr>
    </table>
    <table width="100%">
        <tr>
            <td width="5%">
                <%
                    if (category.equalsIgnoreCase("SAP Project")) {
                %>
                <a href="<%=request.getContextPath()%>/testMap.jsp?pid=<%=project%>">Business Process Map Tree View</a>&nbsp;&nbsp;&nbsp;
                <a href="<%=request.getContextPath()%>/admin/dashboard/projectChart.jsp?project=<%=projectName%>">Status-wise Dashboard</a>&nbsp;&nbsp;&nbsp;
<!--                <a href="<%=request.getContextPath()%>/UserBPM/dashboardForCompany.jsp?pid=<%=project%>">View Test Map Dashboard</a>&nbsp;&nbsp;&nbsp;-->
                <%
                    }
                %>
                <a href="<%=request.getContextPath()%>/admin/dashboard/modulewiseChart.jsp?project=<%=projectName%>">Module-wise Dashboard</a>&nbsp;&nbsp;&nbsp;
                <%
                    if (noOfTestcases > 0) {
                %>
                <a href="<%=request.getContextPath()%>/admin/dashboard/TestCasesChart.jsp?project=<%=project%>">View Test Coverage</a>&nbsp;&nbsp;&nbsp;
                <a href="<%=request.getContextPath()%>/UserProject/listProjectTestPlan.jsp?pid=<%=project%>&project=<%=project%>">View Test Plans</a>&nbsp;&nbsp;&nbsp;
                <%}%>
                <a href="<%=request.getContextPath()%>/admin/dashboard/projectPerformanceChart.jsp?pid=<%=project%>">View Project Performance</a>&nbsp;&nbsp;&nbsp;
                <a href="<%=request.getContextPath()%>/admin/dashboard/openIssueByProject.jsp?pid=<%=project%>" style="font-weight: bold;">View Issues</a>&nbsp;&nbsp;&nbsp;
                <a href="<%=request.getContextPath()%>/MOM/momProjectTeamWise.jsp?pid=<%=project%>" title="Weekly Review MoM">WRM</a>&nbsp;&nbsp;&nbsp; 
                <%if (project.contains("10043")) {%>
                <a href="<%=request.getContextPath()%>/UserProfile/userException.jsp">Server Log</a>&nbsp;&nbsp;&nbsp;&nbsp;
                <%}%>
                <a href="<%=request.getContextPath()%>/CreateIssue/uploadIssues.jsp?pid=<%=pid%>" >Upload Issues</a>&nbsp;&nbsp;&nbsp; 
            </td>
        </tr>
    </table>

    <%if (!(new Date().compareTo(sdfss.parse(planOn)) < 0) && !(sdfss.format(new Date()).equals(planOn))) {
            PMAndDM = new HashMap();
        }

        String projDetails[] = MoMUtil.getProjectIssueCounts(project);
        if (projDetails != null) {%>
    <table class="mom"   style="width:100%;border-collapse:collapse;">
        <tr style="text-align:center; font-weight:bold;background-color:#C3D9FF;">
            <td class="mom" style="width:18%;">Project</td>
            <td class="mom">With PM</td>
            <td class="mom">With Customer Users for Input</td>
            <td class="mom">With Functional Consultants</td>
            <td class="mom">With Functional Consultants for Dev Inputs / Functional Realization</td>
            <td class="mom">With Development</td>
            <td class="mom">With Functional Consultants for Testing</td>
            <td class="mom">With Customer Users for UAT</td>
            <td class="mom">Total</td>
        </tr>
        <tr  style="height:21px;"> <td class="mom">   
                <% if (url.equals("eminentlabs.net")) {%>
                <a   href="<%=request.getContextPath()%>/admin/dashboard/gnattChart.jsp?pid=<%=project%>"><b class="blink_me"><%=projDetails[0]%></b></a>
                    <%} else {%>
                    <%= projDetails[0]%>
                    <%}%>                    
                (<font color="blue"><a href="/eTracker/MOM/projectWiseIssues.jsp?pId=<%= projDetails[11]%>&projectMoMStatus=altogether"><%= projDetails[1]%></font></a>)
            </td>
            <td class="mom" style="text-align:center;"><a href="/eTracker/MOM/projectWiseIssues.jsp?pId=<%= projDetails[11]%>&projectMoMStatus=pmcount"><%=projDetails[2]%></a></td>
            <td class="mom" style="text-align:center;"><a href="/eTracker/MOM/projectWiseIssues.jsp?pId=<%=projDetails[11]%>&projectMoMStatus=customercount"><%=projDetails[3]%></a></td>
            <td class="mom" style="text-align:center;border: 1px solid black;"><a href="/eTracker/MOM/projectWiseIssues.jsp?pId=<%=projDetails[11]%>&projectMoMStatus=withfc"> <%=projDetails[4]%></a></td>
            <td style="text-align:center;border: 1px solid black;"><a href="/eTracker/MOM/projectWiseIssues.jsp?pId=<%=projDetails[11]%>&projectMoMStatus=qa-btc"><%=projDetails[5]%><a></td>
                        <td style="text-align:center;border: 1px solid black;"><a href="/eTracker/MOM/projectWiseIssues.jsp?pId=<%=projDetails[11]%>&projectMoMStatus=withabap"><%= projDetails[6]%></a></td>
                        <td style="text-align:center;border: 1px solid black;"><a href="/eTracker/MOM/projectWiseIssues.jsp?pId=<%=projDetails[11]%>&projectMoMStatus=qa-tce"> <%=projDetails[7]%></a></td>
                        <td style="text-align:center;border: 1px solid black;"><a href="/eTracker/MOM/projectWiseIssues.jsp?pId=<%=projDetails[11]%>&projectMoMStatus=customeruat"><%=projDetails[8]%></a></td>
                        <td style="text-align:center;border: 1px solid black;background-color: <%= projDetails[10]%>;"><%= projDetails[9]%></td></tr>
                        </table>
                        <br/>
                        <%}%>
                        <%
                            if (closedIssueCount > 0) {
                        %>
                        <form name="wrmForm" id="wrmForm" method="post"  >
                            <table  style="width: 100%;background-color: #E8EEF7;text-align: left;"><tr><td style="width: 2%;" ><img class="minus" src="<%=request.getContextPath()%>/images/plus.gif" id="closedImg" style="cursor: pointer;" onclick="callClosed();
                                    collapseimg();
                                    return false;">&nbsp;</td><td style="width:30%;"><a href="#"   onclick="callClosed();
                                            collapseimg();
                                                                           " style="text-decoration: none;font-weight: bold;color:blue;"  title="Closed Issues Details" >Closed Issues Count =<%= closedIssueCount%></a></td>
                                    <td style="font-weight: bold;"> WRM Day : <select name="wrmDay" id="wrmDay"  onchange="javascript:callClosedAlways();">
                                            <%for (String wDay : wrmDays) {
                                                    if (wrmDay.equals(wDay)) {%>
                                            <option value="<%=wDay%>" selected=""><%=wDay%></option>
                                            <% } else {%>                                     
                                            <option value="<%=wDay%>"><%=wDay%></option>
                                            <%}
                                                }%>
                                        </select><input type="hidden" name="wrmpid" id="wrmpid" value="<%=project%>"/><input type="hidden" name="wrmPlannedOn" id="wrmPlannedOn" value="<%=planOn%>"/>
                                        <span>
                                            <div class="dropdown">
                                                <img src="/eTracker/images/table.png" title="Columns Filter" style="cursor: pointer;vertical-align: middle; height:15px;width:20px">
                                                <div class="dropdown-content" id="chkBox">
                                                    <a><input type="checkbox" name="columns" id="severity" value="severity" checked="checked"><label for="severity">Severity</label></a>
                                                    <a><input type="checkbox" name="columns" id="issueNo" value="issueNo" checked="checked"><label for="issueNo">Issue No</label></a>
                                                    <a><input type="checkbox" name="columns" id="priority" value="priority" checked="checked"><label for="priority">Priority</label></a>
                                                    <a><input type="checkbox" name="columns" id="module" value="module" checked="checked"><label for="module">Module</label></a>
                                                    <a><input type="checkbox" name="columns" id="subject" value="subject" checked="checked"><label for="subject">Subject</label></a>
                                                    <a><input type="checkbox" name="columns" id="status" value="status" checked="checked"><label for="status">Status</label></a>
                                                    <a><input type="checkbox" name="columns" id="dueDate" value="dueDate" checked="checked"><label for="dueDate">Due Date</label></a>
                                                    <a><input type="checkbox" name="columns" id="assignedTo" value="assignedTo" checked="checked"><label for="assignedTo">Assigned To</label></a>
                                                    <a><input type="checkbox" name="columns" id="refer" value="refer" checked="checked"><label for="refer">Refer</label></a>
                                                    <a><input type="checkbox" name="columns" id="age" value="age" checked="checked"><label for="age">Age</label></a>
                                                </div>                                       
                                            </div>
                                            <div class="dropdown">
                                                <div class="dropbtn">
                                                    <img src="/eTracker/images/filter.png" title="Issues Filter" style="cursor: pointer;vertical-align: middle; height:15px;width:20px">
                                                </div>
                                                <div class="dropdown-content" id="custRowChkBox">
                                                    <a><input id="cAll" type="radio" name="crows" value="all" checked="true"><label for="cAll">All</label></a>       
                                                    <a><input id="cAgreed" type="radio" name="crows" value="Agreed"><label for="cAgreed">Agreed</label></a>
                                                        <%for (IssueCategory ic : ississueCategorys) {%>
                                                    <a><input id="c<%=ic.getCategoryName()%>" type="radio" name="crows" value="<%=ic.getCategoryName()%>"><label for="c<%=ic.getCategoryName()%>"><%=ic.getCategoryName()%></label></a>
                                                        <%}%>
                                                    <a><input id="cPlanned" type="radio" name="crows" value="planned"><label for="cPlanned">Planned</label></a>
                                                    <a><input id="cwrm" type="radio" name="crows" value="wrm"><label for="cwrm">WRM</label></a>
                                                    <a><input id="cwrmUntouched" type="radio" name="crows" value="wrmUntouched"><label for="cwrmUntouched">WRM Untouched</label></a>                                     
                                                    <a><input id="cothers" type="radio" name="crows" value="others"><label for="cothers">Others</label></a>                                     
                                                </div>                                                
                                            </div>

                                            <span style="font-weight: bold;color:blue; width: 100%;" id="totFilterCount"></span>
                                        </span>
                                    </td>
                                    <td align="center"><img id="progressbar" style='visibility: hidden;' src='/eTracker/images/file-progress.gif'/></td>


                                </tr></table>
                            <div id="closedapm" class="showClosed"><input type="hidden" name="firsttime" id="firsttime" value="test">
                            </div>
                        </form>
                        <%}%>
                        <form name="theForm" id="theForm" method="post" action="<%=request.getContextPath()%>/admin/dashboard/addProjectPlanIssue.jsp" onsubmit="return checkPlanType();">
                            <table style="width:100%;"><tr>

                                    <%
                                        String wrmCheck = "notDone";
                                        if (lastWrm == null || sdfwrm.format(lastWrm).equals(sdfwrm.format(plannedOn))) {
                                            wrmCheck = "done";
                                        }
                                        int col = 2;
                                        if (curDay == day && !plannedForParam.equals(IssueDetails.plannedForList().get(1))) {
                                            col = 1;
                                            if (PMAndDM.containsKey(userid_curri)) {

                                    %>
                                    <td id="planTypeTd" style="    width: 32%;">You are planning for <b><input type="hidden" id="wrmCheck" value="<%=wrmCheck%>"/><input type="hidden" id="wrmCheckMsg" value="<%=(lastWrm == null ? "" : sdfs.format(lastWrm))%> to <%=sdfs.format(plannedOn)%>"/>
                                            <%                                                    if (planType.equals("Daily")) {%>
                                            <input type="radio" name="planType" id="planType" onclick="callWrm()" value="Daily" checked="true">Daily
                                            <% } else {%>
                                            <input type="radio" name="planType" id="planType" onclick="callWrm()" value="Daily" >Daily
                                            <% }
                                                if (planType.equalsIgnoreCase("WRM")) {%>
                                            <input type="radio" name="planType" id="planType" value="WRM" onclick="callWrm();" checked="true" >WRM</b>
                                            <%} else {%>
                                        <input type="radio" name="planType" id="planType" value="WRM" onclick="callWrm();"  >WRM</b>
                                        <% }
                                        %>

                                    </td>
                                    <%} else if (managers.containsKey(userid_curri)) {%>
                                    <td>You are planning for <b>WRM</b><input type="hidden" name="planType" value="WRM"/>
                                    </td>
                                    <%}
                                        }
                                        if (PMAndDM.containsKey(userid_curri)) {
                                            if (col == 2) {
                                    %>
                                    <td id="agreedTd" style="text-align: center;width: 72%" colspan="2"> 
                                        <%} else {%>
                                    <td > 
                                        <%}%>
                                        <b> <input type="radio" name="agreed"  value="Agreed" onclick="callAgreed();">Agreed Issues</b>                                        
                                            <%for (IssueCategory ic : ississueCategorys) {%>
                                        <b> <input type="radio" name="agreed"  value="<%=ic.getCategoryName()%>" onclick="callAgreed();"><%=ic.getCategoryName()%> Issues</b>                                        
                                            <%}%>
                                    </td>
                                    <%}%>
                                    <% if (current_time >= 0) {%>
                                    <td id="planDaySelector" style="text-align: right;"> 
                                        <b>Plan For</b> <select name="plannedFor" id="plannedFor" onchange="callProjectPlan();">
                                            <option value="">Select-One</option>
                                            <%for (String plannedFor : IssueDetails.plannedForList()) {
                                                    if (plannedForParam.equalsIgnoreCase(plannedFor)) {
                                            %>
                                            <option value="<%=plannedFor%>" selected><%=plannedFor%></option>
                                            <%} else {%>
                                            <option value="<%=plannedFor%>" ><%=plannedFor%></option>
                                            <%}
                                                }%>
                                        </select>
                                    </td>

                                    <%   }%>
                                </tr></table>
                                <%  if (customerCount > 0) {%>

                            <div  style="background-color: #E8EEF7; margin-bottom: 20px;">
                                <span  style="font-weight: bold;color:blue; float: left;">Open Issues with <%=projectName%> Team members = <%=customerCount%></span>
                                <span style="font-weight: bold;color:blue; width: 100%; margin-left: 25px; " id="custFilterCount"></span>
                            </div>
                            <%} else {%>
                            <div style="width: 100%;background-color: #E8EEF7;text-align: left;font-weight: bold;color:blue;">Open Issues with <%=projectName%> Team members = <%=customerCount%></div>
                            <%}%>
                            <%String totalissuenos = "";
                                for (int i = 0; i < issueDetails.length; i++) {
                                    totalissuenos = totalissuenos + "'" + issueDetails[i][0] + "',";
                                }

                                if (totalissuenos.contains(",")) {
                                    totalissuenos = totalissuenos.substring(0, totalissuenos.length() - 1);
                                    lastAsigneeAgeList = GetAge.issuelastAsigneeAge(totalissuenos);
                                    fileCountList = IssueDetails.displayFilesCount(totalissuenos);
                                    sunIssueCountList = IssueDetails.subIssueCount(totalissuenos);
                                }
                                int k = 0;
                                if (customerCount > 0) {%>


                            <table width="100%" height="23" id="customerTable" class="tablesorter" >
                                <thead>
                                    <tr bgcolor="#C3D9FF" height="21">
                                        <th class="header severity "style="background-color: #C3D9FF;" width="3%" TITLE="Severity"><div class="some-handle"></div><font><b>S</b></font></th>
                                <th class="header issueNo" width="16%"><font><b>Issue No</b></font></th>
                                <th class="header priority "  width="2%" TITLE="Priority"><div class="some-handle"></div><font><b>P</b></font></th>
                                <th class="header module " width="7%"><div class="some-handle"></div><font><b>Module</b></font></th>
                                <th class="header subject " width="28%"><div class="some-handle"></div><font><b>Subject</b></font></th>
                                <th class="header status " width="11%"><div class="some-handle"></div><font><b>Status</b></font></th>
                                <th class="header dueDate "  width="10%"><div class="some-handle"></div><font><b>Due Date</b></font></th>
                                <th class="header assignedTo " width="11%"><div class="some-handle"></div><font><b>AssignedTo</b></font></th>
                                <th class="header refer " width="8%"><div class="some-handle"></div><font><b>Refer</b></font></th>
                                <th class="header age " width="4%" TITLE="In Days"><div class="some-handle"></div><font><b>Age</b></font></th>

                                </tr>
                                </thead>
                                <tbody>
                                    <%String escColor = "#000000";

                                        try {
                                            for (int i = 0; i < issueDetails.length; i++) {
                                                escColor = "#000000";
                                                String assignedTo = issueDetails[i][10];
                                                int assi = Integer.parseInt(assignedTo);
                                                if (customerUsers.containsKey(assi)) {
                                                    k++;
                                                    String iss = issueDetails[i][0];
                                                    String project1 = issueDetails[i][1];
                                                    String type = issueDetails[i][2];
                                                    String status = issueDetails[i][3];
                                                    String sub = issueDetails[i][4];
                                                    String subject = issueDetails[i][4];
                                                    String desc = issueDetails[i][5];
                                                    String pri = issueDetails[i][6];
                                                    String sev = issueDetails[i][7];
                                                    String createdBy = issueDetails[i][8];
                                                    String createdOn = issueDetails[i][9];

                                                    String modifiedOn = issueDetails[i][11];
                                                    String dueDateFormat = issueDetails[i][12];
                                                    String rating = issueDetails[i][13];
                                                    String feedback = issueDetails[i][14];
                                                    String module = issueDetails[i][15];

                                                    String fullModule = module;
                                                    if (module.length() > 10) {
                                                        module = module.substring(0, 10) + "...";
                                                    }
                                                    if (sub.length() > 42) {
                                                        sub = sub.substring(0, 42) + "...";
                                                    }
                                                    int current = Integer.parseInt(assignedTo);
                                                    String p = "NA";
                                                    if (pri != null) {
                                                        p = pri.substring(0, 2);
                                                    }

                                                    assignedTo = member.get(current);

                                                    SimpleDateFormat sdf = new SimpleDateFormat("dd-MMM-yy");
                                                    SimpleDateFormat dateConversion = new SimpleDateFormat("yyyy-MM-dd");

                                                    String dueDate = "NA";
                                                    if (dueDateFormat != null) {
                                                        dueDate = sdf.format(dateConversion.parse(dueDateFormat));
                                                    }

                                                    String dateString1 = sdf.format(dateConversion.parse(modifiedOn));
                                                    String create = sdf.format(dateConversion.parse(createdOn));

                                                    String s1 = "S1- Fatal";
                                                    String s2 = "S2- Critical";
                                                    String s3 = "S3- Important";
                                                    String s4 = "S4- Minor";
                                                    if (escalationIssues.contains(iss) && url.equals("eminentlabs.net")) {
                                                        escColor = "red";
                                                    }
                                                    //                age = WorkedTime.getHoldingTime(iss, workeduserid,selectedStartDate,selectedEndDate);
                                                    //                         logger.info("Calculated time........"+i);
                                                    //        age =GetAge.getHoldingTime(connection, iss, workeduserid);
                                                    age = Integer.valueOf(issueDetails[i][16]);
                                                    int lastAsigneeAge = 1;
                                                    if (lastAsigneeAgeList.containsKey(iss)) {
                                                        lastAsigneeAge = lastAsigneeAgeList.get(iss);
                                                    }
                                                    if (lastAsigneeAge == 1) {
                                                        lastAsigneeAge = age;
                                                    }

                                                    if (lastAsigneeAge == 0) {
                                                        lastAsigneeAge = lastAsigneeAge + 1;
                                                    }
                                                    String bgcolor = "";
                                                    if (sev.equals(s1)) {
                                                        bgcolor = "#FF0000";
                                                    } else if (sev.equals(s2)) {
                                                        bgcolor = "#FF9900";
                                                    } else if (sev.equals(s3)) {
                                                        bgcolor = "#FFFF00";
                                                    } else if (sev.equals(s4)) {
                                                        bgcolor = "#00FF40";
                                                    }
                                                    if ((k % 2) == 0) {

                                    %>
                                    <tr class="zebraline" height="23" id="main<%=iss%>">
                                        <%                } else {
                                        %>

                                    <tr class="zebralinealter" height="23" id="main<%=iss%>">
                                        <%                    }
                                        %>


                                        <td class="severity" width="3%" bgcolor="<%=bgcolor%>">
                                            <%
                                                int subIssue = 0;
                                                if (sunIssueCountList.get(iss) != null) {
                                                    subIssue = sunIssueCountList.get(iss);
                                                }
                                                if (subIssue > 0) {%>
                                            <span class="showsubissue" id="showsubissue<%=iss%>">+</span>
                                            <%  }%>
                                        </td>
                                        <td class="issueNo" width="16%" TITLE="<%= type%>">
                                            <%if (PMAndDM.containsKey(userid_curri)) {
                                                    if (planIssues.contains(iss)) {%>
                                            <input type="checkbox" name="pIssue" value="<%=iss%>" checked="true" style="vertical-align: middle;">
                                            <%} else {
                                            %>
                                            <input type="checkbox" name="pIssue" value="<%=iss%>" style="vertical-align: middle;">

                                            <%}%><input type="hidden" name="<%=iss%>assignedTo" value="<%=issueDetails[i][10]%>"/>
                                            <%} else if (curDay == day && managers.containsKey(userid_curri)) {

                                            %>
                                            <input type="checkbox" name="pIssue" value="<%=iss%>" style="vertical-align: middle;">

                                            <input type="hidden" name="<%=iss%>assignedTo" value="<%=issueDetails[i][10]%>"/>
                                            <%}

                                            %>

                                            <A
                                                href="javascript:callissue('<%=iss%>')" style="visibility: visible"> <font
                                                    face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#0033FF"><%=iss%>
                                                </font></A><%
                                                    if (agreedIssue.containsKey(iss)) {
                                                        for (String is : agreedIssue.get(iss).split("&&")) {
                                                %>
                                            <img src="<%=request.getContextPath()%>/images/war.png" class="<%=is%>" issue="<%=iss%>" alt="<%=is%>"  title="<%=is%> Issues"  style="cursor: pointer;<%if (!is.equalsIgnoreCase("agreed")) {%>display: none<%}%>"/>
                                            <%}
                                                }
                                                if (planIssues.contains(iss)) {
                                                    if (plannedissuenos.contains(iss)) {
                                            %>
                                            <img src="<%=request.getContextPath()%>/images/tick.png" alt="planned" class="planned" issue="<%=iss%>"  title="Customer Priority + Delivery Planned"  style="cursor: pointer;"/>
                                            <%
                                            } else {
                                            %>
                                            <img src="<%=request.getContextPath()%>/images/yt.png" alt="planned" height="14" width="10" title="Customer Priority" style="cursor: pointer;" class="planned" issue="<%=iss%>" />          
                                            <%
                                                    }

                                                }
                                                if (wrmPlanIssues.contains(iss)) {%>
                                            <img src="<%=request.getContextPath()%>/images/exclamation.png" alt="wrm" class="wrm" issue="<%=iss%>" title="WRM Planned Issue"  style="cursor: pointer;height: 9px;"/>
                                            <%if (!wrmTouchedByCustomerIssues.contains(iss)) {%>
                                            <img src="<%=request.getContextPath()%>/images/Bomb.png" alt="wrmUntouched"  class="wrmUntouched" title="WRM Untouched"  style="cursor: pointer;vertical-align: middle;"/>
                                            <% }
                                                }

                                            %></td>
                                        <td class="priority" width="2%"><font face="Verdana, Arial, Helvetica, sans-serif"
                                                                              size="1" color="#000000"><%= p%> </font></td>

                                        <td class="module" title="<%=fullModule%>" style="width: 7%;"><font face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%=module%></font></td>
                                        <td class="subject" id="<%=iss%>tab"  style="width: 28%;" onmouseover="xstooltip_show('<%=iss%>', '<%=iss%>tab', 289, 49);" onmouseout="xstooltip_hide('<%=iss%>');" ><font face="Verdana, Arial, Helvetica, sans-serif" size="1" color="<%=escColor%>"><span id="<%=iss%>span"><%= sub%></span></font><div class="issuetooltip" id="<%=iss%>"><%= desc%></div>
                                            <input id="<%=iss%>sub" type="hidden" value="<%=subject%>"/>
                                        </td>

                                        <td class="status" width="11%" onclick="showPrint('<%=iss%>');" style="cursor: pointer;"><font face="Verdana, Arial, Helvetica, sans-serif"
                                                                                                                                       size="1" color="#000000"><%= status%> </font></td>
                                            <%

                                                if ((status != null) && (!status.equalsIgnoreCase("Closed")) && (!dueDate.equalsIgnoreCase("NA")) && (CheckDate.getFlag(dueDate) == true)) {

                                            %>
                                        <td class="dueDate" width="10%" title="Last Modified On <%= dateString1%>"><font
                                                face="Verdana, Arial, Helvetica, sans-serif" size="1" color="RED"><%= dueDate%></font>
                                        </td>
                                        <%
                                        } else if ((status.equalsIgnoreCase("Closed") && (CheckDate.getClosedIssueFlag(dueDate, dateString1) == true))) {
                                        %>
                                        <td class="dueDate" width="10%" title="Last Modified On <%= dateString1%>"><font
                                                face="Verdana, Arial, Helvetica, sans-serif" size="1" color="RED"><%= dueDate%></font>
                                        </td>
                                        <%
                                        } else {
                                        %>
                                        <td class="dueDate" width="10%" title="Last Modified On <%= dateString1%>"><font
                                                face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%= dueDate%></font>
                                        </td>
                                        <%
                                            }
                                        %>
                                        <td class="assignedTo" width="11%" title="Created By <%= member.get(Integer.parseInt(createdBy))%>"><font face="Verdana, Arial, Helvetica, sans-serif" size="1" color="<%=escColor%>"><%=assignedTo%>
                                            </font></td>
                                            <%
                                                int fileCount = 0;
                                                if (fileCountList.get(iss) != null) {
                                                    fileCount = fileCountList.get(iss);
                                                }
                                                if (fileCount > 0) {%>
                                        <td class="refer" width="8%"><font face="Verdana, Arial, Helvetica, sans-serif"
                                                                           size="1" color="#000000"><A onclick="viewFileAttachForIssue('<%=iss%>');" href="#">ViewFiles(<%=fileCount%>)</A></font></td>
                                                <%} else {%>
                                        <td class="refer" width="8%"><font face="Verdana, Arial, Helvetica, sans-serif"
                                                                           size="1" color="#000000">No Files</font></td>
                                            <%}


                                            %>
                                        <td class="age" title="<%=lastAsigneeAge%>" style="width:4%;"><font face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%=age%></font></td>
                                    </tr>
                                    <tr class="more-info" id="subIssue<%=iss%>" style="display: none">

                                    </tr>
                                    <%
                                            }

                                        }%>
                                </tbody>
                            </table><%} catch (Exception e) {
                                        logger.error("Exception:" + e);
                                    }
                                }%><br/>

                            <% if ((issueDetails.length - customerCount) > 0) {%>                               
                            <div  style="background-color: #E8EEF7; margin-bottom: 20px;">
                                <span  style="font-weight: bold;color:blue; width: 100%;" style="float: left;">Open Issues with ESPL Team members = <%=issueDetails.length - customerCount%></span>                                   
                                <span style="font-weight: bold;color:blue; width: 100%;margin-left: 25px;" id="esplFilterCount"></span>

                            </div>                                
                            <%} else {%>
                            <div style="width: 100%;background-color: #E8EEF7;text-align: left;font-weight: bold;color:blue;">Open Issues with ESPL Team members = <%=issueDetails.length - customerCount%></div>
                            <%}%>

                            <% if ((issueDetails.length - customerCount) != 0) {%>
                            <table width="100%" height="23" id="esplTable" class="tablesorter">
                                <thead>
                                    <tr bgcolor="#C3D9FF" style="height: 21px;">
                                        <th class="header severity " style="background-color: #C3D9FF;" width="3%" TITLE="Severity"><div class="some-handle"></div><font><b>S</b></font></th>
                                <th class="header issueNo  " width="16%"><font><b>Issue No</b></font></th>
                                <th class="header priority " width="2%" TITLE="Priority"><div class="some-handle"></div><font><b>P</b></font></th>
                                <th class="header module "  width="7%"><div class="some-handle"></div><font><b>Module</b></font></th>
                                <th class="header subject " width="28%"><div class="some-handle"></div><font><b>Subject</b></font></th>
                                <th class="header status "  width="11%"><div class="some-handle"></div><font><b>Status</b></font></th>
                                <th class="header dueDate " width="10%"><div class="some-handle"></div><font><b>DueDate</b></font></th>
                                <th class="header assignedTo " width="11%"><div class="some-handle"></div><font><b>AssignedTo</b></font></th>
                                <th class="header refer " width="8%"><div class="some-handle"></div><font><b>Refer</b></font></th>
                                <th class="header age " width="4%" TITLE="In Days"><div class="some-handle"></div><font><b>Age</b></font></th>
                                </tr>
                                </thead>
                                <tbody>
                                    <%k = 0;
                                        String escColor = "#000000";
                                        try {
                                            for (int i = 0; i < issueDetails.length; i++) {
                                                escColor = "#000000";
                                                String assignedTo = issueDetails[i][10];
                                                int assi = Integer.parseInt(assignedTo);
                                                if (!customerUsers.containsKey(assi)) {
                                                    k++;
                                                    String iss = issueDetails[i][0];
                                                    String project1 = issueDetails[i][1];
                                                    String type = issueDetails[i][2];
                                                    String status = issueDetails[i][3];
                                                    String sub = issueDetails[i][4];
                                                    String subject = issueDetails[i][4];
                                                    String desc = issueDetails[i][5];
                                                    String pri = issueDetails[i][6];
                                                    String sev = issueDetails[i][7];
                                                    String createdBy = issueDetails[i][8];
                                                    String createdOn = issueDetails[i][9];

                                                    String modifiedOn = issueDetails[i][11];
                                                    String dueDateFormat = issueDetails[i][12];
                                                    String rating = issueDetails[i][13];
                                                    String feedback = issueDetails[i][14];
                                                    String module = issueDetails[i][15];

                                                    String fullModule = module;
                                                    if (module.length() > 10) {
                                                        module = module.substring(0, 10) + "...";
                                                    }
                                                    if (sub.length() > 42) {
                                                        sub = sub.substring(0, 42) + "...";
                                                    }
                                                    int current = Integer.parseInt(assignedTo);
                                                    String p = "NA";
                                                    if (pri != null) {
                                                        p = pri.substring(0, 2);
                                                    }

                                                    assignedTo = member.get(current);

                                                    SimpleDateFormat sdf = new SimpleDateFormat("dd-MMM-yy");
                                                    SimpleDateFormat dateConversion = new SimpleDateFormat("yyyy-MM-dd");

                                                    String dueDate = "NA";
                                                    if (dueDateFormat != null) {
                                                        dueDate = sdf.format(dateConversion.parse(dueDateFormat));
                                                    }

                                                    String dateString1 = sdf.format(dateConversion.parse(modifiedOn));
                                                    String create = sdf.format(dateConversion.parse(createdOn));

                                                    String s1 = "S1- Fatal";
                                                    String s2 = "S2- Critical";
                                                    String s3 = "S3- Important";
                                                    String s4 = "S4- Minor";
                                                    if (escalationIssues.contains(iss) && url.equals("eminentlabs.net")) {
                                                        escColor = "red";
                                                    }
                                                    //                age = WorkedTime.getHoldingTime(iss, workeduserid,selectedStartDate,selectedEndDate);
                                                    //                         logger.info("Calculated time........"+i);
                                                    //        age =GetAge.getHoldingTime(connection, iss, workeduserid);
                                                    age = Integer.valueOf(issueDetails[i][16]);
                                                    int lastAsigneeAge = 1;
                                                    if (lastAsigneeAgeList.containsKey(iss)) {
                                                        lastAsigneeAge = lastAsigneeAgeList.get(iss);
                                                    }
                                                    if (lastAsigneeAge == 1) {
                                                        lastAsigneeAge = age;
                                                    }

                                                    if (lastAsigneeAge == 0) {
                                                        lastAsigneeAge = lastAsigneeAge + 1;
                                                    }
                                                    String bgcolor = "";
                                                    if (sev.equals(s1)) {
                                                        bgcolor = "#FF0000";
                                                    } else if (sev.equals(s2)) {
                                                        bgcolor = "#FF9900";
                                                    } else if (sev.equals(s3)) {
                                                        bgcolor = "#FFFF00";
                                                    } else if (sev.equals(s4)) {
                                                        bgcolor = "#00FF40";
                                                    }
                                                    if ((k % 2) == 0) {
                                    %>
                                    <tr class="zebraline" height="23" id="main<%=iss%>">
                                        <%                } else {
                                        %>

                                    <tr class="zebralinealter" height="23" id="main<%=iss%>">
                                        <%                    }
                                        %>

                                        <td class="severity" width="3%" bgcolor="<%=bgcolor%>">
                                            <%
                                                int subIssue = 0;
                                                if (sunIssueCountList.get(iss) != null) {
                                                    subIssue = sunIssueCountList.get(iss);
                                                }
                                                if (subIssue > 0) {%>
                                            <span class="showsubissue" id="showsubissue<%=iss%>">+</span>
                                            <%  }%>
                                        </td>
                                        <td width="16%" class="issueNo" TITLE="<%= type%>">
                                            <%if (PMAndDM.containsKey(userid_curri)) {
                                                    if (planIssues.contains(iss)) {%>
                                            <input type="checkbox" class="group" name="pIssue" value="<%=iss%>" checked="true" style="vertical-align: middle;">
                                            <%} else {
                                            %>
                                            <input type="checkbox" class="group"  name="pIssue" value="<%=iss%>" style="vertical-align: middle;">

                                            <%}%><input type="hidden" name="<%=iss%>assignedTo" value="<%=issueDetails[i][10]%>"/>
                                            <%} else if (curDay == day && managers.containsKey(userid_curri)) {

                                            %>
                                            <input type="checkbox" class="group" name="pIssue" value="<%=iss%>" style="vertical-align: middle;">

                                            <input type="hidden" name="<%=iss%>assignedTo" value="<%=issueDetails[i][10]%>"/>
                                            <%}

                                            %>

                                            <A
                                                href="javascript:callissue('<%=iss%>')" style="visibility: visible"> <font
                                                    face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#0033FF"><%=iss%>
                                                </font></A><%
                                                    if (agreedIssue.containsKey(iss)) {
                                                        for (String is : agreedIssue.get(iss).split("&&")) {
                                                %>
                                            <img src="<%=request.getContextPath()%>/images/war.png" class="<%=is%>" issue="<%=iss%>" alt="<%=is%>"  title="<%=is%> Issues"  style="cursor: pointer;<%if (!is.equalsIgnoreCase("agreed")) {%>display: none<%}%>"/>
                                            <%}
                                                }
                                                if (planIssues.contains(iss)) {
                                                    if (plannedissuenos.contains(iss)) {
                                            %>
                                            <img src="<%=request.getContextPath()%>/images/tick.png" class="planned" issue="<%=iss%>" alt="planned"  title="Customer Priority + Delivery Planned"  style="cursor: pointer;"/>
                                            <%
                                            } else {
                                            %>
                                            <img src="<%=request.getContextPath()%>/images/yt.png" height="14" width="10" alt="planned" title="Customer Priority" style="cursor: pointer;" class="planned" issue="<%=iss%>"/>          
                                            <%
                                                    }

                                                }
                                                if (wrmPlanIssues.contains(iss)) {%>
                                            <img src="<%=request.getContextPath()%>/images/exclamation.png" class="wrm" issue="<%=iss%>"  alt="wrm"  title="WRM Planned Issue"  style="cursor: pointer;height: 9px;"/>
                                            <%if (!wrmTouchedByESPLIssues.contains(iss)) {%>
                                            <img src="<%=request.getContextPath()%>/images/Bomb.png" class="wrmUntouched" title="WRM Untouched"  alt="wrmUntouched" style="cursor: pointer;vertical-align: middle;"/>
                                            <% }
                                                }

                                            %></td>
                                        <td class="priority" width="2%"><font face="Verdana, Arial, Helvetica, sans-serif"
                                                                              size="1" color="#000000"><%= p%> </font></td>

                                        <td class="module" title="<%=fullModule%>" style="width: 7%;"><font face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%=module%></font></td>
                                        <td class="subject" id="<%=iss%>tab"  style="width: 28%;" onmouseover="xstooltip_show('<%=iss%>', '<%=iss%>tab', 289, 49);" onmouseout="xstooltip_hide('<%=iss%>');" ><font face="Verdana, Arial, Helvetica, sans-serif" size="1" color="<%=escColor%>"><span id="<%=iss%>span"><%= sub%></span></font><div class="issuetooltip" id="<%=iss%>"><%= desc%></div>
                                            <input id="<%=iss%>sub" type="hidden" value="<%=subject%>"/>
                                        </td>

                                        <td class="status" width="11%" onclick="showPrint('<%=iss%>')" style="cursor: pointer;"><font face="Verdana, Arial, Helvetica, sans-serif"
                                                                                                                                      size="1" color="#000000"><%= status%> </font></td>
                                            <%

                                                if ((status != null) && (!status.equalsIgnoreCase("Closed")) && (!dueDate.equalsIgnoreCase("NA")) && (CheckDate.getFlag(dueDate) == true)) {

                                            %>
                                        <td class="dueDate" width="10%" title="Last Modified On <%= dateString1%>"><font
                                                face="Verdana, Arial, Helvetica, sans-serif" size="1" color="RED"><%= dueDate%></font>
                                        </td>
                                        <%
                                        } else if ((status.equalsIgnoreCase("Closed") && (CheckDate.getClosedIssueFlag(dueDate, dateString1) == true))) {
                                        %>
                                        <td class="dueDate" width="10%" title="Last Modified On <%= dateString1%>"><font
                                                face="Verdana, Arial, Helvetica, sans-serif" size="1" color="RED"><%= dueDate%></font>
                                        </td>
                                        <%
                                        } else {
                                        %>
                                        <td class="dueDate" width="10%" title="Last Modified On <%= dateString1%>"><font
                                                face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%= dueDate%></font>
                                        </td>
                                        <%
                                            }
                                        %>
                                        <td class="assignedTo" width="11%" title="Created By <%= member.get(Integer.parseInt(createdBy))%>"><font face="Verdana, Arial, Helvetica, sans-serif" size="1" color="<%=escColor%>"><%=assignedTo%>
                                            </font></td>
                                            <%
                                                int fileCount = 0;
                                                if (fileCountList.get(iss) != null) {
                                                    fileCount = fileCountList.get(iss);
                                                }
                                                if (fileCount > 0) {%>
                                        <td class="refer" width="8%"><font face="Verdana, Arial, Helvetica, sans-serif"
                                                                           size="1" color="#000000"><A onclick="viewFileAttachForIssue('<%=iss%>');" href="#">ViewFiles(<%=fileCount%>)</A></font></td>
                                                <%} else {%>
                                        <td class="refer" width="8%"><font face="Verdana, Arial, Helvetica, sans-serif"
                                                                           size="1" color="#000000">No Files</font></td>
                                            <%}
                                            %>
                                        <td class="age" title="<%=lastAsigneeAge%>" style="width:4%;"><font face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%=age%></font></td>
                                    </tr>
                                    <tr class="more-info" id="subIssue<%=iss%>" style="display: none">

                                    </tr>
                                    <%
                                            }

                                        }

                                    %>
                                </tbody>
                            </table>

                            <%} catch (Exception e) {
                                        e.printStackTrace();
                                        logger.error("Exception:" + e);
                                    }
                                }

                            %>

                            <%if (PMAndDM.containsKey(userid_curri)) {%>
                            <div style="text-align: center;"><input type="hidden" name="plannedForParam" id="plannedForParam" value="<%=plannedForParam%>"/><input type="hidden" name="pId" id="pId" value="<%=project%>"/><input type="submit" id="submit" name="submit" value="Submit" /></div>
                                <%} else if (curDay == day && managers.containsKey(userid_curri)) {%>
                            <div style="text-align: center;"><input type="hidden" name="pId" id="pId" value="<%=project%>"/><input type="submit" id="submit" name="submit" value="Submit" /></div>

                            <%}%>
                        </form>
                        <div id="overlay"></div>

                        <br/>
                        <div id="MDAVpopup" class="popup">
                            <h3 class="popupHeading">View Attached Files</h3>
                            <div>
                                <div class="clear"></div>
                                <div class="tableshow">
                                    <div id="IssuePopupFiles">

                                    </div>
                                    <button class="custom-popup-close" onclick="closeIssuePopup();" type="button">close</button>

                                </div>
                            </div>
                        </div>

                        <!--                        <div id="notifypopup" class="popupNotify"  >
                                                    <h3 class="popupHeadingaa">Agreed Issues <br/>
                                                    </h3>
                                                    <div style="margin: 10px;">
                                                        If any issues are agreed to customer, Please check the agreed issues option and then select the issues to submit
                                                    </div>
                                                    <button  onclick="closeFilesPopup();" type="button" class="classname" style="float: right;">Got it</button>
                                                </div>-->

                        </body>
                        <script type="text/javascript">
                            <%if (planType.equalsIgnoreCase("WRM")) {%>
                            $(document).ready(function() {
                                callWrm();
                                callAgreed();
                            });
                            <%} else {
                                    logger.info("planType--------------->" + planType);
                                }%>
                            function checkPlanType() {
                                var plannedType = $.trim($('input[name=planType]:checked').val());
                                var plannedFor = $.trim($('#plannedFor').val());
                                var agreed = $.trim($('input[name=agreed]:checked').val());
                                var d = new Date();
                                var n = d.getHours();
                                if (agreed !== '') {
                                    if (confirm("You are submitting for " + agreed + " issues only")) {
                                        disableSubmit();
                                    } else {
                                        return false;
                                    }
                                } else {
                                    if ($('input[name="planType"]').length) {

                                    } else {
                                        plannedType = "Daily";
                                    }
                                    if (plannedType.length == 0) {
                                        alert('Please select your plan type');
                                        return false;
                                    } else {
                                        if (plannedType == 'Daily') {
                                            if (plannedFor.length == 0) {
                                                alert('Please select your plan for');
                                                $('#plannedFor').focus();
                                                return false;
                                            } else if (plannedFor == 'Daily' && (n >= 15)) {
                                                alert('You cannot plan for today after 3 pm');
                                                return false;
                                            } else if (confirm("You are planning for " + plannedFor)) {
                                                disableSubmit();
                                            } else {
                                                return false;
                                            }
                                        } else {
                                            if (confirm("You are planning for " + plannedType)) {
                                                disableSubmit();
                                            } else {
                                                return false;
                                            }
                                        }
                                    }
                                }
                            }

                            $('input[name="pIssue"]').click(function(e) {
                                var plannedType = $.trim($('input[name=planType]:checked').val());
                                var plannedFor = $.trim($('#plannedFor').val());
                                var agreed = $.trim($('input[name=agreed]:checked').val());
                                if (agreed !== '') {

                                } else {

                                    if ($('input[name="planType"]').length) {

                                    } else {
                                        plannedType = "Daily";
                                    }
                                    if (plannedType.length == 0) {
                                        alert('Please select your plan type');
                                        return false;
                                    } else {
                                        if (plannedType == 'Daily') {

                                            if (plannedFor.length == 0) {
                                                alert('Please select your plan for');
                                                $('#plannedFor').focus();
                                                return false;
                                            }
                                            var d = new Date();
                                            var n = d.getHours();
                                            if ((n >= 15) && (plannedFor == 'Today')) {
                                                alert('You cannot plan for today after 3 pm');
                                                return false;
                                            }
                                        }

                                    }
                                }
                            });
                            $('#colSelect1').click(function(e) {
                                $("#columnSelector").toggle();
                            });

                            $('#colSelect2').click(function(e) {
                                $("#columnSelectorESPL").toggle();
                            });





                            $(document).ready(function() {
                                var $chk = $("#chkBox input:checkbox");
                                var $tbl = $(".tablesorter");
                                var checkedCol = "";
                                $chk.click(function() {
                                    checkedCol = "";
                                    $.each($("input[name='columns']").not(':checked'), function() {
                                        checkedCol = $(this).val() + "," + checkedCol;
                                    });
                                    console.log(checkedCol);
                                    if (typeof (Storage) !== "undefined") {
                                        localStorage.setItem("unChecked", checkedCol);
                                    }
                                    var colToHide = $tbl.find("." + $(this).attr("id"));
                                    $(colToHide).toggle();
                                    displayFullSubject();
                                });
                                var $chk = $("#custRowChkBox input:radio");
                                $chk.click(function() {
                                    var count = 0, counta = 0;
                                    var filterBy;
                                    var checked = $(this).val();
                                    if (checked === 'all') {
                                        $('#esplTable td.issueNo').each(function() {
                                            $(this).parent().show();
                                            count++;
                                        });
                                        $('#customerTable td.issueNo').each(function() {
                                            $(this).parent().show();
                                            counta++;
                                        });
                                    } else if (checked === 'others') {
                                        $('#esplTable td.issueNo').each(function() {
                                            if ($(this).find('img').length === 0) {
                                                $(this).parent().show();
                                                count++;
                                            } else {
                                                $(this).parent().hide();
                                            }
                                        });

                                        $('#customerTable td.issueNo').each(function() {
                                            if ($(this).find('img').length === 0) {
                                                $(this).parent().show();
                                                counta++;
                                            } else {
                                                $(this).parent().hide();
                                            }
                                        });

                                    } else {

                                        $('#esplTable td.issueNo').each(function() {
                                            var imgSize = $(this).find('img').length;
                                            if (imgSize === 0) {
                                                $(this).parent().hide();
                                            } else {
                                                if (checked === 'planned') {
                                                    if ($(this).find('img.planned').attr('alt') === checked) {
                                                        $(this).parent().show();
                                                        count++;
                                                    } else {
                                                        $(this).parent().hide();
                                                    }
                                                } else if (checked === 'wrm') {
                                                    if ($(this).find('img.planned').attr('alt') === 'undefined' || $(this).find('img.wrm').attr('alt') === checked) {
                                                        $(this).parent().show();
                                                        count++;
                                                    } else {
                                                        $(this).parent().hide();
                                                    }
                                                } else if (checked === 'wrmUntouched') {
                                                    if ($(this).find('img.planned').attr('alt') === 'undefined' || $(this).find('img.wrm').attr('alt') === 'undefined' || $(this).find('img.wrmUntouched').attr('alt') === checked) {
                                                        $(this).parent().show();
                                                        count++;
                                                    } else {
                                                        $(this).parent().hide();
                                                    }
                                                } else if (checked === 'Active') {
                                                    if ($(this).find('img.Active').attr('alt') === checked) {
                                                        $(this).parent().show();
                                                        count++;
                                                    } else {
                                                        $(this).parent().hide();
                                                    }
                                                } else {
                                                    if ($(this).find('img.' + checked).attr('alt') === checked) {
                                                        $(this).parent().show();
                                                        count++;
                                                    } else {
                                                        $(this).parent().hide();
                                                    }

                                                }
                                            }

                                        });

                                        $('#customerTable td.issueNo').each(function() {
                                            var imgSize = $(this).find('img').length;
                                            if (imgSize === 0) {
                                                $(this).parent().hide();
                                            } else {
                                                if (checked === 'planned') {
                                                    if ($(this).find('img.planned').attr('alt') === checked) {
                                                        $(this).parent().show();
                                                        counta++;
                                                    } else {
                                                        $(this).parent().hide();
                                                    }
                                                }
                                                else if (checked === 'wrm') {
                                                    if ($(this).find('img.planned').attr('alt') === 'undefined' || $(this).find('img.wrm').attr('alt') === checked) {
                                                        $(this).parent().show();
                                                        counta++;
                                                    } else {
                                                        $(this).parent().hide();
                                                    }
                                                } else if (checked === 'wrmUntouched') {
                                                    if ($(this).find('img.planned').attr('alt') === 'undefined' || $(this).find('img.wrm').attr('alt') === 'undefined' || $(this).find('img.wrmUntouched').attr('alt') === checked) {
                                                        $(this).parent().show();
                                                        counta++;
                                                    } else {
                                                        $(this).parent().hide();
                                                    }
                                                } else if (checked === 'Active') {
                                                    if ($(this).find('img.Active').attr('alt') === checked) {
                                                        $(this).parent().show();
                                                        counta++;
                                                    } else {
                                                        $(this).parent().hide();
                                                    }
                                                } else {
                                                    if ($(this).find('img.' + checked).attr('alt') === checked) {
                                                        $(this).parent().show();
                                                        counta++;
                                                    } else {
                                                        $(this).parent().hide();
                                                    }

                                                }
                                            }

                                        });
                                    }
                                    $('#custFilterCount').html("");
                                    $('#esplFilterCount').html("");
                                    $('#totFilterCount').html("");
                                    if (checked === 'all') {
                                        filterBy = "All Issues";
                                    } else if (checked === 'others') {
                                        filterBy = "Other Issues";
                                    } else if (checked === 'wrm') {
                                        filterBy = "WRM Issues";
                                    } else if (checked === 'wrmUntouched') {
                                        filterBy = "WRM Untouched Issues";
                                    } else if (checked === 'planned') {
                                        filterBy = "Planned Issues";
                                    } else {
                                        filterBy = checked + " Issues";
                                    }
                                    $('#custFilterCount').append("Filtered by : " + filterBy + " and  Count is " + counta);
                                    $('#esplFilterCount').append("Filtered by : " + filterBy + " and  Count is " + count);
                                    $('#totFilterCount').append("Filtered by : " + filterBy + " and  Count is " + (counta + count));
                                    columnsHide();
                                });
                            });
                            $(document).ready(function() {
                                columnsHide();
                                displayFullSubject();

                            });
                            function columnsHide() {
                                var esplCheckedCols;
                                if (typeof (Storage) !== "undefined") {
                                    esplCheckedCols = localStorage.getItem("unChecked");
                                    if (esplCheckedCols != null) {
                                        var esplCols = esplCheckedCols.split(',');
                                        for (var i = 0; i < esplCols.length - 1; i++)
                                        {
                                            $('#' + esplCols[i]).attr('checked', false);
                                            $(".tablesorter").find("." + esplCols[i]).hide();
                                        }
                                    }
                                }
                            }
                            function displayFullSubject() {
                                var esplCheckedCols;
                                if (typeof (Storage) !== "undefined") {
                                    esplCheckedCols = localStorage.getItem("unChecked");
                                    if (esplCheckedCols != null) {
                                        var esplCols = esplCheckedCols.split(',');
                                        var issue, issueSpan, sub;
                                        $('td.subject').each(function() {
                                            sub = $(this).attr('id');
                                            if (sub.length > 0) {
                                                issue = sub.substring(0, 12);
                                                sub = issue + "sub";
                                                issueSpan = issue + "span";
                                            }
                                            if (esplCols.length <= 3) {
                                                var subLen = $('#' + sub).val();
                                                if (subLen > 42) {
                                                    $('#' + issueSpan).html(subLen);
                                                } else {
                                                    subLen = subLen.substring(0, 42);
                                                    subLen = subLen + "...";
                                                    $('#' + issueSpan).html(subLen);
                                                }
                                            } else {
                                                $('#' + issueSpan).html($('#' + sub).val());
                                            }
                                        });
                                    }
                                }
                            }
                            function closeFilesPopup() {
                                if (typeof (Storage) !== "undefined") {
                                    if (sessionStorage.clickcount) {
                                        sessionStorage.clickcount = Number(sessionStorage.clickcount) + 1;
                                    } else {
                                        sessionStorage.clickcount = 1;
                                    }
                                } else {
                                    alert("Sorry, your browser does not support web storage...");
                                }
                                $('#notifypopup').fadeOut('fast', 'swing');
                                $('#overlay').fadeOut('fast', 'swing');
                            }

                            $(document).ready(function() {
                                $('.showsubissue').click(function() {
                                    var obj = $(this);
                                    var trid = obj.closest('tr').attr('id'); // table row ID 
                                    trid = trid.replace("main", "");
                                    if ($('#subIssue' + trid).is(':visible')) {
                                        $('#showsubissue' + trid).html('+');
                                        $('#subIssue' + trid).hide('slow');
                                    } else {
                                        $('#subIssue' + trid).html("");
                                        $.ajax({url: '<%=request.getContextPath()%>/admin/dashboard/getSubIssues.jsp',
                                            data: {mainIssue: trid, random: Math.random(1, 10)},
                                            async: true,
                                            type: 'GET',
                                            success: function(responseText, statusTxt, xhr) {
                                                if (statusTxt === "success") {
                                                    var result = $.trim(responseText);
                                                    $('#subIssue' + trid).html(result);
                                                }
                                            }
                                        });
                                        $('#showsubissue' + trid).html('-');
                                        $('#subIssue' + trid).show('slow');

                                    }

                                });
                            });
                            function callissue(issueid) {
                                var team = '<%=team%>';
                                var mail = '<%=url%>';
                                var d = new Date();
                                var n = d.getHours();
                                if (mail === 'eminentlabs.net') {
                                    if (n > 8 && n < 18) {
                                        var result;
                                        $.ajax({url: '<%=request.getContextPath()%>/admin/project/checkPlannedSeq.jsp',
                                            data: {issueid: issueid, random: Math.random(1, 10)},
                                            async: true,
                                            type: 'GET',
                                            success: function(data) {
                                                result = $.trim(data);
                                            }, complete: function() {
                                                if (result === '') {
                                                    location.href = '<%=request.getContextPath()%>/Issuesummaryview.jsp?planSeq=yes&issueid=' + issueid;
                                                } else {
                                                    alert(result);
                                                }
                                            }
                                        });
                                    } else {
                                        location.href = '<%=request.getContextPath()%>/Issuesummaryview.jsp?planSeq=yes&issueid=' + issueid;

                                    }
                                } else {
                                    location.href = '<%=request.getContextPath()%>/Issuesummaryview.jsp?planSeq=yes&issueid=' + issueid;

                                }
                            }
                        </script>
                        <style type="text/css">
                            .blink_me {
                                animation: blinker 1s linear infinite;
                            }
                        </style>
                        </html>
