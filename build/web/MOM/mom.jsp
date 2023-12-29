<%-- 
    Document   : mom
    Created on : Jan 1, 2013, 10:33:03 AM
    Author     : Tamilvelan
--%>
<%@page import="com.eminent.issue.dao.EscalationDAOImpl"%>
<%@page import="com.eminent.issue.dao.EscalationDAO"%>
<%@page import="com.eminentlabs.mom.MomMaintanance"%>
<%@page import="com.eminentlabs.mom.MomFeedback"%>
<%@page import="com.eminent.customer.CustomerUtil"%>
<%@page import="com.eminentlabs.mom.IssuesTask"%>
<%@page import="java.util.Collections"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.Set"%>
<%@ page import="com.eminent.issue.*,java.util.List,com.eminent.tqm.IssueTestCaseUtil, com.eminent.tqm.*, com.eminent.util.GetProjectManager,com.eminent.util.GetProjects,java.sql.*,java.text.*,java.util.HashMap,java.util.LinkedHashMap,com.pack.*,pack.eminent.encryption.*,org.apache.log4j.*,com.eminent.util.*,java.util.Collection, java.util.ArrayList, java.util.Iterator" buffer="1024kb" autoFlush="false"%>
<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="org.apache.log4j.Logger,java.text.SimpleDateFormat,java.util.Calendar,java.util.GregorianCalendar,java.util.Date" %>
<%@page import="java.util.ResourceBundle,java.util.Arrays,com.eminentlabs.mom.MoMUtil,com.eminentlabs.mom.MomUserTask,java.util.Iterator,java.util.List" %>
<!DOCTYPE html>

<%
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Cache-Control", "no-store");
    response.setDateHeader("Expires", 0);
    response.setHeader("Pragma", "no-cache");

    Logger logger = Logger.getLogger("MOM");
    String logoutcheck = (String) session.getAttribute("Name");
    if (logoutcheck == null) {
        logger.fatal("==============Session Expi#FF0000===============");
%>
<jsp:forward page="../SessionExpi#FF0000.jsp"></jsp:forward>
<%
    }

%>
<html>
    <meta name="keywords" content="GST in SAP, SAP GST Accelerator, GST Success in SAP, GST India in SAP, GST SAP Success, GST Suvidha Provider, GST ASP GSP, GST, CGST,SGST, IGST, UGST,  SAP NW based Product Development, SAP Consulting, SAP Implementation, SAP Support Services, SAP Outsourcing, SAP Implementation India, SAP Implementation Bangalore, SAP Implementation Chennai, SAP Implementation Belgium, SAP Implementation Paris, SAP Implemtation Australia, SAP Implementation France, SAP Implementation Mumbai, SAP Implementation Kerala, SAP Implementation Belgaum, SAP Implementation Thailand, SAP Implementation Mexico, SAP Implementation America">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>eTracker&#153; - Eminentlabs&#153; CRM, APM, TQM,  ERM and  EPTS Solution</title>
    <link title=STYLE href="<%=request.getContextPath()%>/eminentech support files/main_ie.css?test=03082015" type="text/css" rel="STYLESHEET"/>
    <script type="text/javascript" src="<%= request.getContextPath()%>/javaScript/checkSubmit.js"></script>
    <link rel="stylesheet" href="//code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css">
    <script src="//code.jquery.com/jquery-1.10.2.js"></script>
    <script src="//code.jquery.com/ui/1.11.4/jquery-ui.js"></script>
    <style type="text/css">
        input[type="checkbox"] {
            vertical-align: middle;
        }
        tr:first-child .up, tr:last-child .down {
            display:none;
        }
    </style>
    <script type="text/javascript">
        function fun() {
            var cPerson = document.getElementById("chairPerson").value;
            if (trim(cPerson) === "") {
                alert("Please select a chair person");
                document.getElementById("chairPerson").value = "";
                document.getElementById("chairPerson").focus();
                return false;
            }
            disableSubmit();
        }
        function trim(str) {
            while (str.charAt(str.length - 1) === " ")
                str = str.substring(0, str.length - 1);
            while (str.charAt(0) === " ")
                str = str.substring(1, str.length);
            return str;
        }
        function callProjectMom() {
            $(".Ajax-loder").show();
            var momTeamType = document.getElementById('momTeamType').value;
            var branch = document.getElementById('branch').value;
            window.location = "mom.jsp?momTeamType=" + momTeamType + "&branch=" + branch;

        }
    </script>
</head>
<jsp:useBean id="mmc" class="com.eminentlabs.mom.controller.MomMaintananceController"/>
<jsp:useBean id="vmc" class="com.eminentlabs.mom.controller.ViewMomController"/>
<jsp:useBean id="mas" class="com.eminent.issue.formbean.MyAsignmentIssues" /> 
<jsp:useBean id="smc" class="com.eminentlabs.mom.controller.SendMomController"/>
<jsp:useBean id="mwd" class="com.eminent.branch.BranchController"></jsp:useBean>
<jsp:useBean id="smmc" class="com.eminentlabs.mom.controller.SendMomMaintainController"></jsp:useBean>

<%mwd.getAllBranchMap();%>
<%
    Integer role = (Integer) session.getAttribute("Role");
    Integer uid = (Integer) session.getAttribute("userid_curr");

    EscalationDAO escalationDAO = new EscalationDAOImpl();
    List<String> escalationIssues = escalationDAO.AllEscalations(0);
    //  Calendar calend = Calendar.getInstance();
    //calend.setTime(new Date());
    //  long starttime = calend.getTimeInMillis();
    //System.out.print("mas.wrmIssues().size() starttime : " + starttime);
    int wrmSize = mas.wrmIssues().size();

    //calend.setTime(new Date());
    //  long endtime = calend.getTimeInMillis();
    //System.out.print("mas.wrmIssues().size() endTime : " + endtime + "  total time taken :" + (endtime - starttime) + " ms");
    // calend.setTime(new Date());
    // starttime = calend.getTimeInMillis();
    //System.out.print("setSendMomAll starttime : " + starttime);
    mmc.setSendMomAll(request);

    // calend.setTime(new Date());
    // endtime = calend.getTimeInMillis();
    // System.out.print("setSendMomAll endTime : " + endtime + "  total time taken :" + (endtime - starttime) + " ms");
    // calend.setTime(new Date());
    // starttime = calend.getTimeInMillis();
    // System.out.print("setAll starttime : " + starttime);
    smc.setAll(request);

    // calend.setTime(new Date());
    // endtime = calend.getTimeInMillis();
    // System.out.print("setAll endTime : " + endtime + "  total time taken :" + (endtime - starttime) + " ms");
    Calendar c = new GregorianCalendar();
    Date date = c.getTime();
    SimpleDateFormat sdf = new SimpleDateFormat("dd-MMM-yyyy");
    SimpleDateFormat sdfs = new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss");
    String dateFor = sdf.format(date);
    SimpleDateFormat time = new SimpleDateFormat("HH");
    String timeFor = time.format(date);
    int current_time = Integer.parseInt(timeFor);
    String taskTime = "Planned";
    String mTime = "Morning";
    String momTime = "'Morning','Evening'";
    boolean allowUnPlan = true;
    if (current_time > 14) {
        taskTime = "Actual";
        mTime = "Evening";
        allowUnPlan = false;
    }

    int assignedto = (Integer) session.getAttribute("userid_curr");
    ResourceBundle rb = ResourceBundle.getBundle("Resources");
    String mods = rb.getString("mom-mods");
    String noOfIds[] = mods.split(",");
    Calendar cal = Calendar.getInstance();
    Date today = cal.getTime();

    // calend.setTime(new Date());
    // starttime = calend.getTimeInMillis();
    //System.out.print("GetProjectMembers.showUsers() starttime : " + starttime);
    Map<Integer, String> member = GetProjectMembers.getAllEminentMembers();

    //calend.setTime(new Date());
    //endtime = calend.getTimeInMillis();
    //System.out.print("GetProjectMembers.showUsers() endTime : " + endtime + "  total time taken :" + (endtime - starttime) + " ms");
    List<String> todayPlan = new ArrayList();

    //calend.setTime(new Date());
    // starttime = calend.getTimeInMillis();
    //System.out.print("ProjectPlanUtil.findByPlannedOn(today) starttime : " + starttime);
    todayPlan = ProjectPlanUtil.findByPlannedOn(today);

    // calend.setTime(new Date());
    //endtime = calend.getTimeInMillis();
    // System.out.print("ProjectPlanUtil.findByPlannedOn(today) endTime : " + endtime + "  total time taken :" + (endtime - starttime) + " ms");
    //calend.setTime(new Date());
    //starttime = calend.getTimeInMillis();
    //System.out.print(" MoMUtil.attendanceDetails(dateFor, momTime) starttime : " + starttime);
    Map<Integer, String> attendanceForUsers = MoMUtil.attendanceDetails(dateFor, momTime);
    // calend.setTime(new Date());
    //endtime = calend.getTimeInMillis();
    // System.out.print(" MoMUtil.attendanceDetails(dateFor, momTime) endTime : " + endtime + "  total time taken :" + (endtime - starttime) + " ms");
    List<String> modList = Arrays.asList(noOfIds);
    /*
     calend.setTime(new Date());
     starttime = calend.getTimeInMillis();
     System.out.print("MoMUtil.closedIssuesOnDate(dateFor) starttime : " + starttime);
     */
    Map<String, String> closedIssueOnToday = MoMUtil.closedIssuesOnDate(dateFor);

//        calend.setTime(new Date());
//        endtime = calend.getTimeInMillis();
//        System.out.print("MoMUtil.closedIssuesOnDate(dateFor) endTime : " + endtime + "  total time taken :" + (endtime - starttime) + " ms");
//
//        calend.setTime(new Date());
//        starttime = calend.getTimeInMillis();
//        System.out.print("getTodayLeaves starttime : " + starttime);
    Map<Integer, String> getTodayLeaves = CustomerUtil.getTodyLeaves();

//        calend.setTime(new Date());
//        endtime = calend.getTimeInMillis();
//        System.out.print("getTodayLeaves endTime : " + endtime + "  total time taken :" + (endtime - starttime) + " ms");
//
//        calend.setTime(new Date());
//        starttime = calend.getTimeInMillis();
//        System.out.print("actalUpdatedIssues starttime : " + starttime);
    String[][] actalUpdatedIssues = MoMUtil.getCurrentActuals(new ArrayList(), date);

//        calend.setTime(new Date());
//        endtime = calend.getTimeInMillis();
//        System.out.print("actalUpdatedIssues endTime : " + endtime + "  total time taken :" + (endtime - starttime) + " ms");
//
//        calend.setTime(new Date());
//        starttime = calend.getTimeInMillis();
//        System.out.print("uniqueMomFeedBack starttime : " + starttime);
    MomFeedback momFeedback = MoMUtil.uniqueMomFeedBack(mTime, date, smc.getMomTeamType(), smc.getBranch());

//        calend.setTime(new Date());
//        endtime = calend.getTimeInMillis();
//        System.out.print("uniqueMomFeedBack endTime : " + endtime + "  total time taken :" + (endtime - starttime) + " ms");
    List<IssuesTask> wrmIssues = new ArrayList<IssuesTask>();

//        calend.setTime(new Date());
//        starttime = calend.getTimeInMillis();
//        System.out.print("momWrmIssues starttime : " + starttime);
    wrmIssues = vmc.momWrmIssues(null, dateFor);

//        calend.setTime(new Date());
//        endtime = calend.getTimeInMillis();
//        System.out.print("momWrmIssues endTime : " + endtime + "  total time taken :" + (endtime - starttime) + " ms");
//        calend.setTime(new Date());
//        starttime = calend.getTimeInMillis();
//        System.out.print("convertIssueNo starttime : " + starttime);
    List<String> wrmIssueNos = MoMUtil.convertIssueNo(wrmIssues);

//        calend.setTime(new Date());
//        endtime = calend.getTimeInMillis();
//        System.out.print("convertIssueNo endTime : " + endtime + "  total time taken :" + (endtime - starttime) + " ms");
    int chairPerson = 0;
    if (momFeedback != null) {

//            calend.setTime(new Date());
//            starttime = calend.getTimeInMillis();
//            System.out.print("getChairperson starttime : " + starttime);
        chairPerson = momFeedback.getChairperson();

//            calend.setTime(new Date());
//            endtime = calend.getTimeInMillis();
//            System.out.print("getChairperson endTime : " + endtime + "  total time taken :" + (endtime - starttime) + " ms");
    }
    List<Integer> momUseridList = new ArrayList<Integer>();
    Map<Integer, String> coutUserTask = new HashMap<Integer, String>();
    Map<Integer, String> intimationCount = MoMUtil.getIntimationCount();
    smmc.getLocationNBranch(assignedto);
%>
<body>
    <%@ include file="../header.jsp"%>
    <div class="Ajax-loder">

        <div class="bg"></div>

        <img class="loading" src="<%=request.getContextPath()%>/images/276 (1).GIF"
             alt="loading...." /></div>
    <form name="theForm" action="createMOM.jsp" onsubmit="return fun();" method="post">
        <table cellpadding="0" cellspacing="0" width="100%">
            <tr border="2" bgcolor="#C3D9FF" style="height: 21px;">
                <td border="1" align="left" width="70%">
                    <font size="4" COLOR="#0000FF"><b>Send Minutes of Meeting on <%=dateFor%> by </b>
                    <select id="branch" name="branch" onchange="callProjectMom(this);" style="    padding: 8px;    border-radius: 6px;    border: 1px solid #CCC;">
                        <option value="">All Location</option>
                        <%if (!mwd.getBranchMap().isEmpty()) {
                                for (Map.Entry<Integer, String> entry : mwd.getBranchMap().entrySet()) {%>
                        <option value="<%=entry.getKey()%>" <%if (smc.getBranch() == entry.getKey()) {%> selected=""<%}%>><%=entry.getValue()%></option>
                        <%}
                            }%>                                                
                    </select>

                    <select name="chairPerson" id="chairPerson" class="momTeamType">
                        <option value="">--Select One--</option>
                        <%for (Map.Entry<Integer, String> entry : member.entrySet()) {
                                for (MomMaintanance mmtc : smc.getMomUsers()) {
                                    if (entry.getKey() == mmtc.getUserid()) {
                                        if (chairPerson == mmtc.getUserid()) {
                        %>                        
                        <option value="<%=mmtc.getUserid()%>" selected=""><%=member.get(mmtc.getUserid())%></option>
                        <%} else {%>
                        <option value="<%=mmtc.getUserid()%>"><%=member.get(mmtc.getUserid())%></option>
                        <%}
                                        momUseridList.add(mmtc.getUserid());
                                    }
                                }
                            }
                        %>
                        <%%>
                    </select>
                    <select name="momTeamType" id="momTeamType" class="momTeamType" onchange="callProjectMom(this);">
                        <%for (Map.Entry<Integer, String> entry : smc.getMomTypeList().entrySet()) {
                                if (smc.getMomTeamType() == entry.getKey()) {
                        %>
                        <option value="<%=entry.getKey()%>" selected=""><%=entry.getValue()%></option>
                        <%} else {%>
                        <option value="<%=entry.getKey()%>"><%=entry.getValue()%></option>
                        <%}
                            }%>
                    </select>
                    </font>
                    <!--                    <select id="time">
                                            <option value="10">10 AM</option>
                                            <option value="5">5 PM</option>
                                        </select>-->
                </td>
                <td style="font-weight: bold;color: blue;text-align: right;"><label id="minutes">00</label>:<label id="seconds">00</label></td>
            </tr>
        </table>
        <table cellpadding="0" cellspacing="0" width="100%">

            <tr>
                <td style="height: 25px;">
                    <a href="<%=request.getContextPath()%>/MOM/addTask.jsp"> Add Issue / Task</a>&nbsp;&nbsp;&nbsp;&nbsp;
                    <a href="<%=request.getContextPath()%>/MOM/viewTask.jsp" style="cursor: pointer;">View Issue / Task</a> &nbsp;&nbsp;&nbsp;

                    <a href="<%=request.getContextPath()%>/MOM/plannedIssuesReport.jsp" style="cursor: pointer;">Planned Issue Report</a> &nbsp;&nbsp;&nbsp;

                    <%
                        if (smmc.getSendMomMaintenance() != null && smmc.getSendMomMaintenance().getUserId() != null && smmc.getSendMomMaintenance().getUserId().intValue() == assignedto) {
                    %>
                    <a href="<%=request.getContextPath()%>/MOM/mom.jsp" style="cursor: pointer; font-weight: bold;">Send MOM</a> &nbsp;&nbsp;&nbsp;
                    <a href="<%=request.getContextPath()%>/MOM/feedBackCommand.jsp" style="cursor: pointer;">FeedBack</a> &nbsp;&nbsp;&nbsp;
                    <a title="Fine Management" href="<%=request.getContextPath()%>/MOM/addFineAmtForUser.jsp" style="cursor: pointer;">Fine Mgmt</a> &nbsp;&nbsp;
                    <a href="<%=request.getContextPath()%>/MOM/projectWiseClosedReport.jsp" style="cursor: pointer;">PM'S Rank</a> &nbsp;&nbsp;&nbsp;
                    <%                 } else {
                    %>
                    <a href="<%=request.getContextPath()%>/MOM/fineAmtReort.jsp" style="cursor: pointer;">Fine Amount </a> &nbsp;&nbsp;&nbsp;
                    <a href="<%=request.getContextPath()%>/MOM/fineReport.jsp" style="cursor: pointer;">Fine Report</a> &nbsp;&nbsp;&nbsp;
                    <%}%>
                    <a href="weekPerformers.jsp" style="cursor: pointer;">Team Performance</a> &nbsp;&nbsp;&nbsp;
                    <a href="<%=request.getContextPath()%>/MOM/bestPMNTeam.jsp" style="cursor: pointer;">Best PM/Team</a> &nbsp;&nbsp;&nbsp;
                    <a href="<%=request.getContextPath()%>/MOM/dueDateReport.jsp" style="cursor: pointer; ">DDR</a> &nbsp;&nbsp;&nbsp;
                    <a href="<%=request.getContextPath()%>/MOM/wrmIssues.jsp" style="cursor: pointer; ">WRM Issues (<%=wrmSize%>)</a> &nbsp;&nbsp;&nbsp;
                    <a href="<%=request.getContextPath()%>/Reimbursement/reimbursementUpload.jsp" style="cursor: pointer; ">Reimbursement</a> &nbsp;&nbsp;&nbsp;


                </td>
            </tr>
        </table>

        <input type="hidden" name="startTime" value="<%=sdfs.format(date)%>">

        <%
            //  calend.setTime(new Date());
            // starttime = calend.getTimeInMillis();
            // System.out.print("MomMaintanance momWrmIssuesByPlan starttime : " + starttime);
            //
            wrmIssues = MoMUtil.momWrmIssuesByPlan(null, dateFor);

            // calend.setTime(new Date());
            // endtime = calend.getTimeInMillis();
            // System.out.print("MomMaintanance momWrmIssuesByPlan endTime : " + endtime + "  total time taken :" + (endtime - starttime) + " ms");
            Set<String> attStatu = MoMUtil.attendancsStatus();
            for (Map.Entry<Integer, String> entrya : mmc.momTypeMaintanance().entrySet()) {
                if (smc.getMmcSplit().containsKey(entrya.getKey())) {%>
        <p style="width: 100%;background-color: #C3D9FF;font-weight: bold;"><%=entrya.getValue()%></p> 

        <%
            List<MomMaintanance> mm = smc.getMmcSplit().get(entrya.getKey());
            for (MomMaintanance maintanance : mm) {
                Integer userid = maintanance.getUserid();
                String username = member.get(userid);

                // calend.setTime(new Date());
                // starttime = calend.getTimeInMillis();
                //    System.out.print("actalUpdatedIssues starttime : " + starttime);
                Map<String, String> issueList = MoMUtil.actalUpdatedIssues(userid, actalUpdatedIssues, dateFor);

                //  calend.setTime(new Date());
                //   endtime = calend.getTimeInMillis();
                //  System.out.print("actalUpdatedIssues endTime : " + endtime + "  total time taken :" + (endtime - starttime) + " ms");
                List<IssuesTask> issuesByUser = new ArrayList<IssuesTask>();
// calend.setTime(new Date());
                // starttime = calend.getTimeInMillis();
                //System.out.print("MomMaintanance momWrmIssuesByUser starttime : " + starttime);
                issuesByUser = MoMUtil.momWrmIssuesByUser(userid, wrmIssues);

                // calend.setTime(new Date());
                //endtime = calend.getTimeInMillis();
                // System.out.print("MomMaintanance momWrmIssuesByUser endTime : " + endtime + "  total time taken :" + (endtime - starttime) + " ms");

        %>

        <table style="width: 100%;">

            <tr style="background-color: #E8EEF7;">
                <td style="width:20%;font-weight: bold;"><%=username%></td>
                <td style="width:10%;"><a href="addUserTask.jsp?uId=<%=userid%>">Add User Task</a></td>
                <td width="10%"><select id="<%=userid%>status" name="<%=userid%>status" class="userstatus">
                        <%
                            String[] parts;
                            String userStatus = "";
                            String comments = "";
                            if (attendanceForUsers.get(userid) != null) {
                                parts = attendanceForUsers.get(userid).split("-");
                                userStatus = parts[0];
                                comments = parts[1];
                                if (comments == null || comments.isEmpty() || comments.equalsIgnoreCase("null")) {
                                    comments = "";
                                }

                            }

                            for (String status : attStatu) {

                                if (status.equalsIgnoreCase(userStatus)) {

                        %>
                        <option value="<%=status%>" selected><%=status%></option>
                        <%} else if (status.equalsIgnoreCase("Approved Leave") && getTodayLeaves.containsKey(userid)) {
                            String dur = getTodayLeaves.get(userid);
                            if (!dur.equalsIgnoreCase("Full Day")) {
                                if (taskTime.equalsIgnoreCase("Planned") && dur.equalsIgnoreCase("First Half")) {
                        %>
                        <option value="<%=status%>" selected><%=status%></option>
                        <%
                        } else if (taskTime.equalsIgnoreCase("Actual") && dur.equalsIgnoreCase("Second Half")) {
                        %>
                        <option value="<%=status%>" selected><%=status%></option>
                        <%
                        } else {
                        %>
                        <option value="<%=status%>" ><%=status%></option>
                        <%
                            }
                        } else {
                        %>
                        <option value="<%=status%>" selected><%=status%></option>
                        <%
                            }

                        } else {%>
                        <option value="<%=status%>"><%=status%></option>
                        <%}
                            }%>
                    </select></td>
                <td width="15%"><input id="<%=userid%>comments" name="<%=userid%>comments" value="<%=comments%>" type="text" width="150"></td>
                <td id="count<%=userid%>"> <%if (intimationCount.containsKey(userid)) {%>
                    <b><%=intimationCount.get(userid)%></b>
                    <%}%>
                </td>
            </tr>
        </table>
        <%String plan = "", planDetail = "", escalationColor = "#000000";
            try {
                int i = 0;
                plan = "";
                planDetail = "";
                String count = "";
                MomUserTask userTask = null;
// calend.setTime(new Date());
                // starttime = calend.getTimeInMillis();
                // System.out.print("MomMaintanance viewTask starttime : " + starttime);
                List task = MoMUtil.viewTask(userid, dateFor);

                //  calend.setTime(new Date());
                //  endtime = calend.getTimeInMillis();
                //  System.out.print("MomMaintanance viewTask endTime : " + endtime + "  total time taken :" + (endtime - starttime) + " ms");
                List<String> planIssuesByuser = new ArrayList<String>();
                List<IssuesTask> planIssueTasks = new ArrayList<IssuesTask>();
                for (Iterator reqIterator = task.iterator(); reqIterator.hasNext(); i++) {
                    userTask = (MomUserTask) reqIterator.next();
                    plan = userTask.getTasktime();
                    if (plan.equalsIgnoreCase("Planned")) {
                        if (userTask.getType().equalsIgnoreCase("Issue")) {
                            String issueno = "";
                            IssuesTask iTask = MoMUtil.getIssueDetails(userTask.getTask());
                            if (userTask.getTask().length() > 12) {
                                issueno = iTask.getIssueno().trim();
//                                if (wrmIssueNos.contains(issueno)) {
                                planIssuesByuser.add(issueno);
                                planIssueTasks.add(iTask);
//                                }
                            }
                        } else if (userTask.getType().equalsIgnoreCase("Count")) {
                            count = userTask.getTask();
                        }

                    }
                }
                if ("".equals(count) && coutUserTask.isEmpty()) {
                    // calend.setTime(new Date());
                    //starttime = calend.getTimeInMillis();
                    // System.out.print("MomMaintanance createIssueCountTask starttime : " + starttime);
                    coutUserTask = new MoMUtil().createIssueCountTaskProcedure(momUseridList);
                    //count = MoMUtil.createIssueCountTask(userid);
                    //calend.setTime(new Date());
                    // endtime = calend.getTimeInMillis();
                    // System.out.print("MomMaintanance createIssueCountTask endTime : " + endtime + "  total time taken :" + (endtime - starttime) + " ms");
                }%> <table ><tr >
                <td  colspan="10" style="width:50px;"><b>Planned</b></td>
                <%if (coutUserTask.isEmpty()) {

                %>
                <td><%=count%></td>
                <%} else {

                    String taskbyuser = coutUserTask.get(userid);
                %>
                <td><%=taskbyuser%></td>
                <%}%>
            </tr>
        </table>
        <table>

            <% for (IssuesTask iTask : planIssueTasks) {
    //                for (IssuesTask its : planIssueTasks) {
    //                    if (iTask.getIssueno().equalsIgnoreCase(its.getIssueno())) {
    //                        iTask = its;
    //                        break;
    //                    }
    //                }
                    String issueno = "";
                    String issueSubject = "";
                    String pName = "";
                    issueno = iTask.getIssueno().trim();
                    pName = iTask.getProjectName();
                    String sub = iTask.getSubject();
                    escalationColor = "#000000";
                    if (escalationIssues.contains(issueno)) {
                        escalationColor = "#FF0000";
                        sub = sub.replace(":#D2691E", "#FF0000");
                        issueSubject = " # <font style='color:#FF0000;'>" + iTask.getStatus() + "</font> : " + sub;
                    } else {
                        issueSubject = " # " + iTask.getStatus() + " : " + iTask.getSubject();
                    }
                    if (planIssuesByuser.contains(issueno)) {
                        String ratingColor = "";
                        if (closedIssueOnToday.containsKey(issueno)) {
                            ratingColor = closedIssueOnToday.get(issueno);
                        }
                        if (todayPlan.contains(issueno)) {
            %>


            <tr style="color:<%=escalationColor%>">
                <td  colspan="10" style="width:50px;"><b></b></td><td colspan="4" style="color:<%=escalationColor%>"><%if (allowUnPlan == true) {%><input type="checkbox" name="<%=userid%>momPlanIssue" value="<%=issueno%>" checked/><%}%><a target="_blank" title="<%=pName%>" href="<%=request.getContextPath()%>/viewIssueDetails.jsp?issueid=<%=issueno%>"><font style="background-color:<%=ratingColor%>;"><%=issueno%></font></a><font style="color:<%=escalationColor%>;"><%=issueSubject%></font>
                        <% if (wrmIssueNos.contains(issueno)) {%>

                    <img src="<%=request.getContextPath()%>/images/exclamation.png"  title="WRM Planned Issue"  style="cursor: pointer;height: 9px;"/>
                    <%}%>
                    <%if (!todayPlan.isEmpty()) {
                    %>
                    <img src="<%=request.getContextPath()%>/images/tick.png"  title="Customer Priority + Delivery Planned"  style="cursor: pointer;"/>
                    <% if (mTime.equalsIgnoreCase("morning")) {%>
                    <a href="javascript:void(0)" class ='up'><a href="javascript:void(0)" class ='up'><img style='position: realtive;cursor:pointer;height: 12px;width: 12px;' src='<%=request.getContextPath()%>/images/up_arrow.png' title="Up"  style="cursor: pointer" /></a>
                        <a href="javascript:void(0)" class='down'><img style='position: realtive;cursor:pointer;height: 12px;width: 12px;' src='<%=request.getContextPath()%>/images/down_arrow.png' title="Down" style="cursor: pointer" /></a>
                            <% }%>



                        <%}
                        }%>
            </tr>

            <%}
                }


            %>

            <%                for (Iterator reqIterator = task.iterator(); reqIterator.hasNext(); i++) {
                    userTask = (MomUserTask) reqIterator.next();
                    plan = userTask.getTasktime();
                    if (!plan.equalsIgnoreCase(planDetail)) {
                        planDetail = plan;
                    } else {
                        planDetail = "";
                    }
                    boolean flag = true;
                    if (userTask.getTask() != null) {
                        if (plan.equalsIgnoreCase("Planned") && userTask.getType().equalsIgnoreCase("Issue")) {
                            IssuesTask iTask = MoMUtil.getIssueDetails(userTask.getTask());
                            String issueno = "";
                            if (userTask.getTask().length() > 12) {
                                issueno = iTask.getIssueno().trim();
                            }
                            if (planIssuesByuser.contains(issueno)) {
                                flag = false;
                            }
                        }
                    }
                    if (flag == true) {

                        if (planDetail.equalsIgnoreCase("Actual")) {
            %>


            <table ><tr >
                    <td  colspan="10" style="width:50px;"><b><%=planDetail%></b></td>
                            <%}
                                if (userTask.getType().equalsIgnoreCase("Issue")) {
                                    IssuesTask iTask = MoMUtil.getIssueDetails(userTask.getTask());
                                    String issueno = "";
                                    String issueSubject = "";
                                    String pName = "";
                                    escalationColor = "#000000";
                                    String sub = iTask.getSubject();
                                    if (userTask.getTask().length() > 12) {
                                        issueno = iTask.getIssueno().trim();
                                        pName = iTask.getProjectName();
                                        if (escalationIssues.contains(issueno)) {
                                            escalationColor = "#FF0000";
                                            sub = sub.replace(":#D2691E", "#FF0000");
                                            issueSubject = " # <font style='color:#FF0000;'>" + iTask.getStatus() + "</font> : " + sub;
                                        } else {
                                            issueSubject = " # " + iTask.getStatus() + " : " + iTask.getSubject();
                                        }

                                    }
                                    String ratingColor = "";
                                    if (closedIssueOnToday.containsKey(issueno)) {
                                        ratingColor = closedIssueOnToday.get(issueno);
                                    }

                                    if (planDetail.equalsIgnoreCase("Actual")) {%>
                <table > <tr style="color:<%=escalationColor%>">
                        <td  colspan="10" style="width:50px;"><b><%=planDetail%></b></td>

                        <td colspan="4">
                            <%} else {%>
                    <tr style="color: <%=escalationColor%>">
                        <td  colspan="10" style="width:50px;"><b></b></td>

                        <td colspan="4">

                            <%}
                                if (userTask.getTasktime().equalsIgnoreCase("Actual")) {
                                    issueList = new HashMap();

                            %>

                            <%}%><%if (allowUnPlan == true) {%><input type="checkbox" name="<%=userid%>momPlanIssue" value="<%=issueno%>" checked/><%}%><a target="_blank" title="<%=pName%>" href="<%=request.getContextPath()%>/viewIssueDetails.jsp?issueid=<%=issueno%>"><font style="background-color:<%=ratingColor%>;"><%=issueno%></font></a><font style="color:<%=escalationColor%>;"><%=issueSubject%></font>
                                <% if (wrmIssueNos.contains(issueno)) {%>

                            <img src="<%=request.getContextPath()%>/images/exclamation.png"  title="WRM Planned Issue"  style="cursor: pointer;height: 9px;"/>
                            <%}%>  

                            <%if (!todayPlan.isEmpty()) {
                                            if (todayPlan.contains(issueno)) {%>
                            <img src="<%=request.getContextPath()%>/images/tick.png"  title="Customer Priority + Delivery Planned"  style="cursor: pointer;"/>
                            <% if (mTime.equalsIgnoreCase("morning")) {%>  
                            <a href="javascript:void(0)" class ='up'><a href="javascript:void(0)" class ='up'><img style='position: realtive;cursor:pointer;height: 12px;width: 12px;' src='<%=request.getContextPath()%>/images/up_arrow.png'title="Up"  style="cursor: pointer"/></a>
                                <a href="javascript:void(0)" class='down'><img style='position: realtive;cursor:pointer;height: 12px;width: 12px;' src='<%=request.getContextPath()%>/images/down_arrow.png' title="Down"  style="cursor: pointer"/></a>
                                    <%}
                                            }
                                        }%>
                        </td>

                        <%
                                } else if (userTask.getTasktime().equalsIgnoreCase("Actual") && userTask.getType().equalsIgnoreCase("Count")) {%>
                        <td colspan="4">

                            <%=userTask.getTask()%>

                        </td>
                        <%} else if (userTask.getType().equalsIgnoreCase("Task")) {%>
                    <table ><tr style="color:<%=escalationColor%>">
                            <td  colspan="10" style="width:50px;"><td colspan="4"><%if (allowUnPlan == true) {%><input type="checkbox" name="<%=userid%>momPlantask" value="<%=userTask.getMomtaskid()%>" checked/><%}%><font style="color:<%=escalationColor%>;"><%=userTask.getTask()%></font>
                                <img src="<%=request.getContextPath()%>/images/tick.png"  title="Customer Priority + Delivery Planned"  style="cursor: pointer;"/>
                            </td>
                            <%}%>
                        </tr>

                        <%}
                                planDetail = plan;
                            }%>
                    </table><%
                        } catch (Exception e) {
                        }
                        if (taskTime.equalsIgnoreCase("Actual")) {
                            String issueCount = "";
// calend.setTime(new Date());
                            // starttime = calend.getTimeInMillis();
                            // System.out.print("MomMaintanance uniqueMOMIssueCount starttime : " + starttime);

                            boolean issueCountFlag = MoMUtil.uniqueMOMIssueCount(dateFor, "Count", taskTime, userid);

                                // calend.setTime(new Date());
                            //  endtime = calend.getTimeInMillis();
                            // System.out.print("MomMaintanance uniqueMOMIssueCount endTime : " + endtime + "  total time taken :" + (endtime - starttime) + " ms");
                            if (issueCountFlag == false) {
                                issueCount = MoMUtil.createIssueCountTask(userid);
                    %><table><tr><td ><b><%=taskTime%></b></td><td><%=issueCount%></td>  </tr>                                           
                    </table>
                    <%
                            }
                        }
                        if (taskTime.equalsIgnoreCase("Actual")) {
                            if (!issueList.isEmpty()) {%>
                    <table><tr><td colspan="3"><b>Actuals</b></td></tr>
                        <%for (Map.Entry<String, String> entry : issueList.entrySet()) {
                                String totalTask = entry.getKey() + entry.getValue();
                                IssuesTask iTask = MoMUtil.getIssueDetails(totalTask);
                                String issueno = "";
                                String issueSubject = "";
                                String pName = "";
                                escalationColor = "#000000";
                                String sub = iTask.getSubject();
                                if (totalTask.length() > 12) {
                                    issueno = iTask.getIssueno().trim();
                                    pName = iTask.getProjectName();
                                    if (escalationIssues.contains(issueno)) {
                                        escalationColor = "#FF0000";
                                        sub = sub.replace("#D2691E", "");
                                        issueSubject = " # <font style='color:#FF0000;'>" + iTask.getStatus() + "</font> : " + sub;
                                    } else {
                                        issueSubject = " # " + iTask.getStatus() + " : " + iTask.getSubject();
                                    }
                                }
                                String ratingColor = "";
                                if (closedIssueOnToday.containsKey(issueno)) {
                                    ratingColor = closedIssueOnToday.get(issueno);
                                }
                        %>
                        <tr style="color:<%=escalationColor%>"><td style="width: 50px;">&nbsp;</td><td><input type="checkbox" name="<%=userid%>issue" value=<%=issueno%> checked/><a target="_blank" title="<%=pName%>" href="<%=request.getContextPath()%>/viewIssueDetails.jsp?issueid=<%=issueno%>"><font style="background-color:<%=ratingColor%>;"><%=issueno%></font></a> <%=entry.getValue()%>
                                    <%if (!todayPlan.isEmpty()) {
                                                    if (todayPlan.contains(issueno)) {%>
                                <img src="<%=request.getContextPath()%>/images/tick.png"  title="Customer Priority + Delivery Planned"  style="cursor: pointer;"/>
                                <%}
                                            }%>
                            </td></tr>
                        <%}%></table><%}
                        } else {
                            if (!issueList.isEmpty()) {%>
                    <table><tr><td colspan="3"><b>Actual Updated Issue</b></td></tr>
                        <% escalationColor = "#000000";
                            for (Map.Entry<String, String> entry : issueList.entrySet()) {
                                String totalTask = entry.getKey() + entry.getValue();
                                IssuesTask iTask = MoMUtil.getIssueDetails(totalTask);
                                String issueno = "";
                                String issueSubject = "";
                                String pName = "";
                                escalationColor = "#000000";
                                String sub = iTask.getSubject();
                                if (totalTask.length() > 12) {
                                    issueno = iTask.getIssueno().trim();
                                    pName = iTask.getProjectName();
                                    if (escalationIssues.contains(issueno)) {
                                        escalationColor = "#FF0000";
                                        sub = sub.replace(":#D2691E", "#FF0000");
                                        issueSubject = " # <font style='color:#FF0000;'>" + iTask.getStatus() + "</font> : " + sub;
                                    } else {
                                        issueSubject = " # " + iTask.getStatus() + " : " + iTask.getSubject();
                                    }
                                }
                                String ratingColor = "";
                                if (closedIssueOnToday.containsKey(issueno)) {
                                    ratingColor = closedIssueOnToday.get(issueno);
                                }

                        %> <tr style="color:<%=escalationColor%>"><td style="width: 50px;">&nbsp;</td><td><a target="_blank" title="<%=pName%>" href="<%=request.getContextPath()%>/viewIssueDetails.jsp?issueid=<%=issueno%>"><font style="background-color:<%=ratingColor%>;"><%=issueno%></font></a> <font style="color:<%=escalationColor%>;"><%=entry.getValue()%></font>
                                    <%if (!todayPlan.isEmpty()) {
                                                    if (todayPlan.contains(issueno)) {%>
                                <img src="<%=request.getContextPath()%>/images/tick.png"  title="Customer Priority + Delivery Planned"  style="cursor: pointer;"/>
                                <%}
                                            }%>
                            </td></tr>
                        <%}%></table><%}
                                        }
                                    }
                                }
                            }
                        %>


                    <br>
                    <tr><td><input type="hidden" name="allowUnPlan" value="<%=allowUnPlan%>">
                            <input type="submit" name="submit" id="submit" value="Submit"></td></tr>
                </table>
                </form>
                <a href="#" id="back-to-top" title="Back to top">&uarr;</a>
                </body>
                <script type="text/javascript">
                    var minutesLabel = document.getElementById("minutes");
                    var secondsLabel = document.getElementById("seconds");
                    var totalSeconds = 0;
                    setInterval(setTime, 1000);

                    function setTime()
                    {
                        ++totalSeconds;
                        secondsLabel.innerHTML = pad(totalSeconds % 60);
                        minutesLabel.innerHTML = pad(parseInt(totalSeconds / 60));
                    }

                    function pad(val)
                    {
                        var valString = val + "";
                        if (valString.length < 2)
                        {
                            return "0" + valString;
                        } else
                        {
                            return valString;
                        }
                    }
                    if ($('#back-to-top').length) {
                        var scrollTrigger = 100, // px
                                backToTop = function() {
                                    var scrollTop = $(window).scrollTop();
                                    if (scrollTop > scrollTrigger) {
                                        $('#back-to-top').addClass('show');
                                    } else {
                                        $('#back-to-top').removeClass('show');
                                    }
                                };
                        backToTop();
                        $(window).on('scroll', function() {
                            backToTop();
                        });
                        $('#back-to-top').on('click', function(e) {
                            e.preventDefault();
                            $('html,body').animate({
                                scrollTop: 0
                            }, 700);
                        });
                    }
                </script>
                <script type="text/javascript">
                    $(window).load(function() {
                        $(".Ajax-loder").fadeOut(100);

                    });
                    $(window).bind('load', function() {
                        var datefor = '<%=dateFor%>';
                        var mtime = '<%=mTime%>';
                        $.ajax({
                            url: "momAttendanceStatus.jsp",
                            data: {datefor: datefor, mtime: mtime, random: Math.random(1, 10)},
                            async: false,
                            type: 'GET',
                            success: function(responseText, statusTxt, xhr) {
                                if (statusTxt === "success") {
                                } else {
                                }
                            }
                        });
                    });


                    $(document).on('change', '.userstatus', function(e) {
                        var status = $(this).val();
                        var id = $(this).attr('id');
                        var userid = id.split("status")[0];
                        $('#count' + userid).html('');
                        if (status === 'Permission' || status === 'Intimated') {
                            $.ajax({
                                url: '<%=request.getContextPath()%>/MOM/getMoMStatusCount.jsp',
                                data: {status: status, userid: userid, random: Math.random(1, 10)},
                                async: false,
                                type: 'GET',
                                success: function(responseText, statusTxt, xhr) {
                                    if (statusTxt === "success") {
                                        var result = $.trim(responseText);
                                        $('#count' + userid).html('<b>' + result + '</b>');
                                    }
                                }
                            });
                        }
                    });


                    $('form input').on('keypress', function(e) {
                        return e.which !== 13;

                    });
                    $(".up,.down").click(function() {

                        var $element = this;
                        var row = $($element).parents("tr:first");

                        if ($(this).is('.up')) {
                            row.insertBefore(row.prev());
                        }

                        else {
                            row.insertAfter(row.next());
                        }

                    });
                </script>
                </html>
