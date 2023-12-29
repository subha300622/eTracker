<%@page import="com.eminent.holidays.HolidaysUtil"%>
<%@page import="com.eminent.holidays.Holidays"%>
<%@page import="java.math.BigDecimal"%>
<%@page import="com.eminentlabs.mom.MoMAttendance"%>
<%@page import="com.eminent.util.GetProjectMembers"%>
<%@page import="com.eminentlabs.mom.MomUserDetail"%>
<%@page import="com.eminentlabs.mom.MoMUtil"%>
<%@ page import="org.apache.log4j.*,com.eminent.leaveUtil.*,java.util.*,java.text.SimpleDateFormat"%>
<%@ page import="java.util.ResourceBundle,pack.eminent.encryption.*,com.pack.CalculateIssueValue,com.eminent.util.GetProjectManager,com.eminent.util.GetProjects"%>
<%
    //Configuring log4j properties
    Logger logger = Logger.getLogger("Profile");

    String logoutcheck = (String) session.getAttribute("Name");
    if (logoutcheck == null) {
%>
<jsp:forward page="../SessionExpired.jsp"></jsp:forward>
<%    }
%>
<%@ include file="../header.jsp"%> 
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
    <meta name="keywords" content="GST in SAP, SAP GST Accelerator, GST Success in SAP, GST India in SAP, GST SAP Success, GST Suvidha Provider, GST ASP GSP, GST, CGST,SGST, IGST, UGST,  SAP NW based Product Development, SAP Consulting, SAP Implementation, SAP Support Services, SAP Outsourcing, SAP Implementation India, SAP Implementation Bangalore, SAP Implementation Chennai, SAP Implementation Belgium, SAP Implementation Paris, SAP Implemtation Australia, SAP Implementation France, SAP Implementation Mumbai, SAP Implementation Kerala, SAP Implementation Belgaum, SAP Implementation Thailand, SAP Implementation Mexico, SAP Implementation America">
    <TITLE>eTracker&#153; - Eminentlabs&#153; CRM, APM, TQM,  ERM and  EPTS Solution</TITLE>
    <meta http-equiv="X-UA-Compatible" content="IE=Edge">
    <LINK title=STYLE href="<%= request.getContextPath()%>/eminentech support files/main_ie.css?test=11" type="text/css" rel=STYLESHEET>
    <link href='<%=request.getContextPath()%>/css/fullcalendar.css?test=7' rel='stylesheet' />
    <link href='<%=request.getContextPath()%>/css/fullcalendar.print.css' rel='stylesheet' media='print' />
    <link rel="stylesheet" href="//code.jquery.com/ui/1.11.4/themes/redmond/jquery-ui.css">
    <script type="text/javascript" src="<%= request.getContextPath()%>/javaScript/checkSubmit.js"></script>

    <script src="//code.jquery.com/jquery-1.10.2.js"></script>
    <script src="//code.jquery.com/ui/1.11.4/jquery-ui.js"></script>
    <script src='<%=request.getContextPath()%>/javaScript/moment.min.js'></script>
    <script src='<%=request.getContextPath()%>/javaScript/fullcalendar.min.js'></script>
    <script src="<%=request.getContextPath()%>/javaScript/jquery.tablesorter.min.js" type="text/javascript"></script>
    <style type="text/css">
        .fc-sun { color:red; }
        .fc-sat { color:red; }
    </style>

    <script language="JavaScript">
        function printpost(post)
        {
            pp = window.open('changepwd.jsp?post_id=' + post, 'pp', ' maximize =no,location=no,statusbar=no,menubar=no,scrollbars=yes width=600,height=400');
            pp.focus();
        }
        function createRequest() {
            var reqObj = null;
            try {
                reqObj = new ActiveXObject("Msxml2.XMLHTTP");
            } catch (err) {
                try {
                    reqObj = new ActiveXObject("Microsoft.XMLHTTP");
                } catch (err2) {
                    try {
                        reqObj = new XMLHttpRequest();
                    } catch (err3) {
                        reqObj = null;
                    }
                }
            }
            return reqObj;
        }
        function updateAlerts() {
            var projects = document.getElementsByName('alerts');
            var unchecked = new Array();
            var checked = new Array();
            var k = 0, j = 0;
            for (i = 0; i < projects.length; i++)
            {
                if (!(projects[i].checked)) {
                    //           alert(projects[i].value);
                    unchecked[k] = projects[i].value;
                    k++;
                } else {
                    checked[j] = projects[i].value;
                    j++;
                }
            }
            xmlhttp = createRequest();
            if (xmlhttp != null) {

                xmlhttp.open("GET", "${pageContext.servletContext.contextPath}/UserProfile/disableAlerts.jsp?noofdata=" + k + "&uncheckedpids=" + unchecked + "&checkedpids=" + checked + "&rand=" + Math.random(1, 10), false);
                xmlhttp.onreadystatechange = update;
                xmlhttp.send(null);
            }

        }
        function Update()
        {
            location = '/eTracker/UserProfile/getpasswd.jsp';
        }

    </script>

</HEAD>
<jsp:useBean id="smmc" class="com.eminentlabs.mom.controller.SendMomMaintainController"></jsp:useBean>
<jsp:useBean id="tcir" class="com.eminent.issue.TeamClosedIssueReport"></jsp:useBean>
<%
    int assignedto = (Integer) session.getAttribute("userid_curr");
    tcir.setPeriod(request);
    smmc.getLocationNBranch(assignedto);%>
<BODY bgColor=#ffffff leftMargin=0 topMargin=0 marginheight="0"
      marginwidth="0">
    <div class="Ajax-loder">

        <div class="bg"></div>

        <img class="loading" src="<%=request.getContextPath()%>/images/276.GIF"
             alt="loading...." /></div>
    <div id="dialog" ><div id='usercalendar'></div></div>
    <form action="<%=request.getContextPath()%>/UserProfile/disableAlerts.jsp"
          method="post"><%@ page import="java.sql.*"%>

        <br>

        <TABLE width="100%">

            <TR >
                <TD align="left"  bgcolor="#E8EEF7">
                    <B>Your Profile:</B>
                </TD>
            </TR>

        </TABLE>
        <%int roleId = (Integer) session.getAttribute("Role");
            ResourceBundle rb = ResourceBundle.getBundle("Resources");
            String mods = rb.getString("mom-mods");
            String noOfIds[] = mods.split(",");
            int branch = (Integer) session.getAttribute("branch");
            List<String> modList = Arrays.asList(noOfIds);
            HashMap<Integer, String> member = GetProjectMembers.showUsers();
            String mail = (String) session.getAttribute("theName");
            String url = null;
            if (mail != null) {
                url = mail.substring(mail.indexOf("@") + 1, mail.length());
            }
            if (url.equals("eminentlabs.net")) {
        %>
        <%
            String leaveDetails[][] = LeaveUtil.waitingForApproval(assignedto);
            String requestedDetails[][] = LeaveUtil.getLeaveRequest(assignedto);

            int noOfRequests = leaveDetails.length;
            int noOfLeaveRequested = requestedDetails.length;

            LinkedHashMap<String, String> leaveType = LeaveUtil.hrLeaveTypes();

        %>
        <table style="width: 100%;">
            <tr>
                <td>
                    <a href="employeeHandbook.jsp"> Employee Handbook</a>&nbsp;&nbsp;&nbsp;&nbsp;
                    <a href="holidayCalendar.jsp"> Holiday Calendar</a>&nbsp;&nbsp;&nbsp;&nbsp;
                    <a href="leaveRequest.jsp"> Leave Management</a>&nbsp;&nbsp;&nbsp;&nbsp;
                    <%                            if (noOfRequests > 0) {
                    %>
                    <a href="editLeaveRequest.jsp"> Approve Leave</a>&nbsp;&nbsp;&nbsp;&nbsp;
                    <%                }
                        if (assignedto == 104 || assignedto == 103) {%>
                    <a href="<%=request.getContextPath()%>/admin/user/branceMaintenance.jsp">Branch Maintenance</a>&nbsp;&nbsp;&nbsp;&nbsp;

                    <% }
                        if (assignedto == 112 || assignedto == 103 || assignedto == 104 || roleId == 4 || mail.equals("accounts@eminentlabs.net") || (smmc.getSendMomMaintenance() != null && smmc.getSendMomMaintenance().getUserId() != null && smmc.getSendMomMaintenance().getUserId().intValue() == assignedto)) {
                            if (assignedto == 112 || assignedto == 103 || assignedto == 104 || roleId == 4 || mail.equals("accounts@eminentlabs.net")) {%>
                    <a href="<%=request.getContextPath()%>/admin/user/leaveRequest.jsp">Leave  Request For User </a>&nbsp;&nbsp;&nbsp;&nbsp;
                    <% }%>
                    <a href="<%=request.getContextPath()%>/leave/leaveView.jsp">Leaves </a>&nbsp;&nbsp;&nbsp;&nbsp;
                    <a href="<%=request.getContextPath()%>/leave/LeaveViewByPeriod.jsp">Leaves Summary </a>&nbsp;&nbsp;&nbsp;&nbsp;
                    <% }%>

                </td>
                <td style="text-align: right;">
                    <%if (url.equals("eminentlabs.net")) {%>



                    <%
                        float privilageLeaveNo = LeaveBlancePeriodDAO.getPrivilegeLeave(assignedto);

                        Map<String, Float> leaveTypeDetails = LeaveUtil.leaveDetailsByUser(assignedto, branch);

                    %>

                    <table  style="border-collapse: collapse;border:1px solid black;">
                        <tr style="font-weight: bold;border:1px solid black; "><td style="border:1px solid black; ">Leave Type</td><td style="text-align: center;border:1px solid black;">Eligible</td><td style="text-align: center;border:1px solid black;">Availed</td><td style="text-align: center;border:1px solid black;">Balance</td></tr>
                        <% float total = 0, availed = 0, balance = 0;
                            int count = 1;
                            for (Map.Entry<String, String> entry : leaveType.entrySet()) {
                                total = 0;
                                balance = 0;
                                availed = 0;%>
                        <tr style="border:1px solid black; "> 
                            <%if (entry.getKey().equals("Sick Leave") || entry.getKey().equals("Casual Leave") || entry.getKey().equals("Privilege Leave")) {%>
                            <td style="font-weight: bold;">  <%=entry.getKey()%>    </td>
                            <%

                                if (leaveTypeDetails.get(entry.getKey()) != null) {
                                    availed = (Float) leaveTypeDetails.get(entry.getKey());
                                }
                                if (entry.getKey().equals("Sick Leave") || entry.getKey().equals("Casual Leave")) {
                                    total = 8;
                                    balance = total - availed;
                                } else if (entry.getKey().equals("Privilege Leave")) {
                                    total = (float) privilageLeaveNo;
                                    balance = total - availed;
                                }
                            %>
                            <td style="text-align: center;border:1px solid black;"><%=total%></td>
                            <td style="text-align: center;border:1px solid black;"><%=availed%></td>
                            <td style="text-align: center;border:1px solid black;"><%=balance%></td>
                            <%} else if (leaveTypeDetails.containsKey(entry.getKey())) {%>
                            <td style="font-weight: bold;">    <%=entry.getKey()%></td>                            
                            <%
                                total = 0;
                                if (leaveTypeDetails.get(entry.getKey()) != null) {
                                    availed = (Float) leaveTypeDetails.get(entry.getKey());
                                }
                                balance = 0;
                            %>                                
                            <td style="text-align: center;border:1px solid black;"><%=total%></td>
                            <td style="text-align: center;border:1px solid black;"><%=availed%></td>
                            <td style="text-align: center;border:1px solid black;"><%=balance%></td>
                            <%}%>                           
                        </tr>
                        <%}%>
                    </table>
                    <%}%>
                </td>
            </tr>
        </table>
        <%}%>
        <TABLE bgColor align="center">

            <jsp:useBean id="CalculateIssue" class="com.pack.CalculateIssueValue" />

            <%
                Connection connection = null;
                ResultSet rs = null;
                Statement st = null;
                //Initialize Connection Variable
                try {
//	connection = Admin.ConnectToDatabase(); 
                    connection = MakeConnection.getConnection();
                    //Get Connection from ConnectToDatabase() Method in AdminBean 

                    //Start Of IF Block That Checks Whether the Connection Does Have any Value
                    String message = request.getParameter("alertUpdate");

                    if (connection != null) {

                        int userid_curr = (Integer) session.getAttribute("userid_curr");
                        st = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
                        rs = st.executeQuery("SELECT FIRSTNAME,LASTNAME,COMPANY,EMAIL,phone,mobile,TEAM,LASTLOGGEDON,EMP_ID FROM USERS WHERE userid=" + userid_curr);
                        if (rs != null) {
                            while (rs.next()) {
                                String firstname = rs.getString("firstname");
                                String lastname = rs.getString("lastname");
                                String company = rs.getString("company");
                                String email = rs.getString("email");
                                String phone = rs.getString("phone");
                                String mobile = rs.getString("mobile");
                                String team = rs.getString("team");
                                Timestamp loggedon = rs.getTimestamp("lastloggedon");
                                String lastLoggedOn = "NA";
                                if (loggedon != null) {
                                    lastLoggedOn = new SimpleDateFormat("dd-MMM-yy HH:mm:ss").format(loggedon);
                                }
                                if (message != null) {
            %>
            <tr><td><font <%if (message.equalsIgnoreCase("Mail Alert Successfully Updated")) {%> color="green"<%} else {%>color="red"<%}%>><%=message%></font></td></tr>
                        <%
                            }
                        %>
            <table width="100%" border="0" cellpadding="0"
                   align="center">
                <tr width="100%" bgcolor="#C3D9FF" style="font-weight: bold;"><td>&nbsp;&nbsp;&nbsp;Profile</td></tr>
            </table>
            <table width="100%" border="0" cellpadding="0"
                   align="center">
                <tr>
                    <td align="left" height="30" width="10%">&nbsp;&nbsp;&nbsp;<B>FirstName</B></td>
                    <td align="center" height="30" width="2%"><b>:</b></td>
                    <td align="left" height="30" width="12%"><%= firstname%>
                    <td style="width: 3%;"></td>
                    <td align="left" height="30" width="15%">&nbsp;&nbsp;&nbsp;<B>LastName</B></td>
                    <td align="center" height="30" width="2%"><b>:</b></td>
                    <td align="left" height="30" width="12%"><%= lastname%>
                    <td style="width: 3%;"></td>
                    <td align="left" height="30" width="10%">&nbsp;&nbsp;&nbsp;<B>Company</B></td>
                    <td align="center" height="30" width="2%"><b>:</b></td>
                    <td align="left" height="30" width="35%"><%= company%>
                </tr>

                <tr>
                    <td align="left" height="30" width="10%">&nbsp;&nbsp;&nbsp;<B>Phone</B></td>
                    <td align="center" height="30" width="2%"><b>:</b></td>
                    <td align="left" height="30" width="12%"><%= phone%>
                    <td style="width: 3%;"></td>
                    <td align="left" height="30" width="15%">&nbsp;&nbsp;&nbsp;<B>Mobile</B></td>
                    <td align="center" height="30" width="2%"><b>:</b></td>
                    <td align="left" height="30" width="12%"><%= mobile%>
                    <td style="width: 3%;"></td>
                    <td align="left" height="30" width="10%">&nbsp;&nbsp;&nbsp;<B>Email</B></td>
                    <td align="center" height="30" width="2%"><b>:</b></td>
                    <td align="left" height="30" width="12%"><%= email%>
                    <td>
                </tr>


                <tr>
                    <td align="left" height="30" width="10%">&nbsp;&nbsp;&nbsp;<B>Team</B></td>
                    <td align="center" height="30" width="2%"><b>:</b></td>
                    <td align="left" height="30" width="12%"><%= team%>
                    <td style="width: 3%;"></td>
                    <td align="left" height="30" width="15%">&nbsp;&nbsp;&nbsp;<B>Month value</B></td>
                    <td align="center" height="30" width="2%"><b>:</b></td>
                    <td align="left" height="30" width="12%"><%=CalculateIssueValue.CreateValue(userid_curr)%>
                    <td style="width: 3%;"></td>
                    <td align="left" height="30" width="10%">&nbsp;&nbsp;&nbsp;<B>Password</B></td>
                    <td align="center" height="30" width="2%"><b>:</b></td>
                    <td width="35%" align="left"><font size="2"
                                                       face="Verdana, Arial, Helvetica, sans-serif"><a
                                href="<%=request.getContextPath()%>/UserProfile/changepwd.jsp">Change
                                Password</a></font></td>
                </tr>




                <tr>

                    <%
                        mail = (String) session.getAttribute("theName");
                        url = null;
                        if (mail != null) {
                            url = mail.substring(mail.indexOf("@") + 1, mail.length());
                        }
                        if (url.equals("eminentlabs.net")) {
                            String empId = rs.getString("EMP_ID");
                            if (empId == "" || empId == null) {
                                empId = "";
                            }
                    %>

                    <td width="10%">&nbsp;&nbsp;&nbsp;<strong>Employee ID</strong></td>
                    <td align="center" height="30" width="2%"><b>:</b></td>
                    <td align="left" height="30" width="12%"><%= empId%>
                    <td style="width: 3%;"></td>
                    <%
                        }
                    %>
                    <td align="left" height="30" width="10%">&nbsp;&nbsp;&nbsp;<B>Projects Involved</B></td>
                    <td align="center" height="30" width="1%"><b>:</b></td>
                    <td align="left" height="30" colspan="6"><%=GetProjectManager.getProjects(userid_curr)%>
                </tr>
                <tr>
                    <td colspan="10" align="center">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input
                            type="button" value="   Edit   " onclick="javascript:Update();"></td>
                </tr>
            </table>




            <%
                ArrayList<String> al = GetProjects.showEmailAlers(userid_curr);
                if (al.size() > 0) {
            %>
            <table width="100%" border="0" cellpadding="0"
                   align="center">
                <tr width="100%" bgcolor="#C3D9FF" style="font-weight: bold;"><td>&nbsp;&nbsp;&nbsp;Mail Alerts</td></tr>
            </table>
            <table  style="table-layout: fixed;">
                <tr>

                    <%
                        String pid = null;
                        String project = null;
                        String alert = null;
                        int count = 0;
                        for (String details : al) {
                            count++;
                            pid = details.substring(0, details.indexOf(":"));
                            project = details.substring(details.indexOf(":") + 1, details.lastIndexOf(":"));
                            alert = details.substring(details.lastIndexOf(":") + 1, details.length());
                            if (count == 6) {
                                count = 1;
                    %>
                </tr><tr>

                    <%}
                    %>
                    <td><input type="checkbox" name="alerts" id="alerts" value="<%=pid%>" <%if (alert.equalsIgnoreCase("yes")) {%>checked<%}%>><%=project%></td>
                    <td style="width: 3%;"></td>
                    <%
                        }
                    %>
                </tr>
                <tr><td>&nbsp;</td></tr>
                <tr >

                    <td colspan="8" align="center"><input type="submit" name="email" value="Update Mail Alerts" ></td>
                </tr>


                <%
                    }%>
            </table>

            <% }

                    }
                }
                if (url.equals("eminentlabs.net")) {%>
            <%if (roleId == 1 || assignedto == 1189 || assignedto == 4885) {%>

            <div style="clear: both;"></DIV>

            <div class="header-line" >
                <span>MOM Attendance For:</span>
                <select name="month" id="month" >


                    <%for (Map.Entry<Integer, String> month : tcir.getMonths().entrySet()) {
                            if (month.getKey() == tcir.getMonth()) {%>
                    <option value="<%=month.getKey()%>" selected=""><%=month.getValue()%></option>
                    <%} else {%>
                    <option value="<%=month.getKey()%>"><%=month.getValue()%></option>
                    <%}
                        }%>
                </select>
                <select name='year' id='year' >

                    <%for (Integer year : tcir.getYears()) {%>
                    <%if (year == tcir.getYear()) {%>
                    <option value="<%=year%>" selected=""><%=year%></option>
                    <%} else {%>   
                    <option value="<%=year%>"><%=year%></option>
                    <%}
                        }%>
                </select>
                <input type="button" id="submit" value="Submit" >
            </div>
            <jsp:useBean id="dwc" class="com.eminent.issue.controller.DaywiseChart"></jsp:useBean>

                <div class="momattendance">
                <%Set<String> attStatu = MoMUtil.attendancsStatus();
                    List<MoMAttendance> userAttendies = MoMUtil.userAttendance(tcir.getMonth() + 1, tcir.getYear(), 1, assignedto);
                    if (!userAttendies.isEmpty()) {%>
                <table class="mom tablesorter"  style="width: 100%;float: left;border-collapse: collapse;margin-top:10px ;">
                    <thead>
                        <tr style=" ">
                            <th style="color: #000;padding-left:16px;">User</th>
                                <%for (String status : attStatu) {%>
                            <th style="padding-left:16px;color: #000;"><%=status%></th>
                                <%}%>
                        </tr>
                    </thead>
                    <tbody class="tablecontent">

                        <%
                            Map<BigDecimal, String> users = new LinkedHashMap<BigDecimal, String>();

                            for (MoMAttendance uds : userAttendies) {
                                if (!users.containsKey(uds.getUserId())) {
                                    users.put(uds.getUserId(), uds.getName());
                                }
                            }
                            for (Map.Entry<BigDecimal, String> entry : users.entrySet()) {

                        %>
                        <tr style="height: 21px;"><td style="width: 18%;"><a href='javascript:;' class="useratt" userid='<%=entry.getKey()%>' style="text-decoration: none;"><%=entry.getValue()%></a></td>

                            <%
                                for (String status : attStatu) {
                                    int count = 0;
                                    for (MoMAttendance uds : userAttendies) {
                                        if (uds.getUserId().equals(entry.getKey())) {
                                            if (status.equalsIgnoreCase(uds.getStatus())) {
                                                count = uds.getCount();
                                            }
                                        }
                                    }%>
                            <td style="text-align: center;"><%=count%></td>
                            <%}%></tr>
                            <%}%>

                    </tbody>


                    <%}%>
                </table>
            </div>

            <%} else {%>
            <div class="header-line" >
                <span>MOM Attendance </span>
            </div>
            <div class='attsummary'>

            </div>
            <div id='calendar'>

            </div>

            <%}
                    }
                } catch (Exception e) {
                    logger.error(e.getMessage());

                } finally {
                    if (rs != null) {
                        rs.close();
                    }
                    if (st != null) {
                        st.close();
                    }
                    if (connection != null) {
                        connection.close();
                    }
                }
            %>



    </form>


</BODY>
<style>



    #calendar {
        width:825px; 
        max-width: 900px;
        margin: 20px 20px auto;
        float: left;
    }
    .attsummary{
        float:left;
        margin-top: 10px;
    }
    .mom
    {
        border-collapse:collapse;
        margin-left: 22px;
        width: 825px;
    }
    .mom table, .mom td, .mom th 
    {
        border:1px solid #B5CAF9;
        -moz-box-shadow:0px 0px 2px 1px #FFF;
        box-shadow: 0px 0px 2px 1px #FFF;
        padding: 10px;
    }
</style>


<SCRIPT type="text/javascript">
    $("#submit").click(function () {
        $(".Ajax-loder").show();
        $('#usercalendar').html("");
        var month = $("#month").val();
        var year = $("#year").val();
        $.ajax({
            url: '<%=request.getContextPath()%>/UserProfile/userAttendance.jsp',
            data: {month: month, year: year, rand: Math.random(1, 10)},
            async: false,
            type: 'GET',
            success: function (responseText, statusTxt, xhr) {

                if (statusTxt == "success") {
                    var result = $.trim(responseText);
                    $(".momattendance").replaceWith(result);
                    $(".mom").tablesorter({
                        // change the multi sort key from the default shift to alt button 
                        sortMultiSortKey: 'altKey'

                    });
                    $(".Ajax-loder").hide();
                }
            }


        });
    });</Script>

<script>

    $(document).ready(function () {
        callcalendar();
    });
    $(document).on('click', '.fc-left,.fc-right', function () {
        callSummary();
    });
    $(document).on('click', '.useratt', function () {
        $("#dialog").dialog("open");
        var title = $(this).html();
        $('#usercalendar').html("");
        var text = $(this).html();
        var userId = $(this).attr('userid');
        $.ajax({
            url: '<%=request.getContextPath()%>/UserProfile/requestedAttendance.jsp?month=' + $("#month").val() + '&year=' + $("#year").val() + '&userId=' + userId + '&rand=' + Math.random(1, 10),
            type: 'POST',
            async: true,
            success: function (response, statusTxt, calslback) {
                $('#dialog').html(response);
                $('.ui-dialog-title').html(title);
            }
        });
    });
    function callSummary() {
        var view = $('#calendar').fullCalendar('getView');
        var start = view.title;
        $.ajax({
            url: '<%=request.getContextPath()%>/UserProfile/attendanceSummary.jsp',
            type: 'POST',
            data: {
                start: start
            },
            async: true,
            success: function (response, statusTxt, calslback) {
                $('.attsummary').html(response);
            }
        });
    }
    function callcalendar() {
        $('#calendar').fullCalendar({
            header: {
                left: 'prev,next stoday',
                center: 'title',
            },
            editable: true,
            eventLimit: true, // allow "more" link when too many events
            events: '<%=request.getContextPath()%>/UserProfile/userAttJson.jsp?month=3&year=2014&rand=' + Math.random(1, 10),
            eventMouseover: function (calEvent, jsEvent) {
                var tooltip = '<div class="tooltipevent" style="width:100px;height:90px;background:#FFF;position:absolute;z-index:10001;padding:10px;border :1px solid #CCC;border-radius:10px;">' + calEvent.title + '</div>';
                $("body").append(tooltip);
                $(this).mouseover(function (e) {
                    $(this).css('z-index', 10000);
                    $('.tooltipevent').fadeIn('500');
                    $('.tooltipevent').fadeTo('10', 1.9);
                }).mousemove(function (e) {
                    $('.tooltipevent').css('top', e.pageY + 10);
                    $('.tooltipevent').css('left', e.pageX + 20);
                });
            },
            eventMouseout: function (calEvent, jsEvent) {
                $(this).css('z-index', 8);
                $('.tooltipevent').remove();
            },
            eventRender: function (event, element) {
                element.find('span.fc-title').html(element.find('span.fc-title').text());
            },
        });
        callSummary();
    }
    $(document).ready(function ()
    {
//                var d = new Date();
//                var time = d.getHours();
//                alert("Time"+time);
//               
//                if(time>13){
//                    $("input.group").prop("disabled", true);
//                }
        $(".tablesorter ").tablesorter({
            widgets: ['zebra'],
            // change the multi sort key from the default shift to alt button 
            sortMultiSortKey: 'altKey'

        });
    });
    $(document).on('click', '.fc-future,.fc-today', function () {
        var fromDate = $(this).attr('data-date');
        $('#dialog').html('');
        $("#dialog").dialog("open");
        $.ajax({
            url: '<%=request.getContextPath()%>/UserProfile/leave.jsp?fromDate=' + fromDate + '&rand=' + Math.random(1, 10),
            type: 'POST',
            async: true,
            success: function (response, statusTxt, calslback) {
                $('#dialog').html(response);
                $('.ui-dialog-title').html("Leave Request");
            }
        });
    });
    $(document).on('click', '#submit1', function () {
        $("span.error2").remove();
        var leaveid = $('#leaveid').val();
        var fromdate = $('#fromdate').val();
        var todate = $('#todate').val();
        var reason = $('#reason').val();
        var duration = $('#duration').val();
        var description = $('#description').val();
        var count = 0;
        if (fromdate === "") {
            $('<span class="error2">Pick From Date</span>').insertAfter('#submit1');
            count++;
        }
        if (todate === "") {
            $('<span class="error2">Pick to Date</span>').insertAfter('#calImg');
            count++;
        } else {

            var first = fromdate.indexOf("-");
            var last = fromdate.lastIndexOf("-");
            var year = fromdate.substring(last + 1, last + 5);
            var month = fromdate.substring(first + 1, last);
            var date = fromdate.substring(0, first);
            var form_date = new Date(year, month - 1, date);
            var current_date = new Date();

            var current_year = current_date.getFullYear();
            var current_month = current_date.getMonth();
            var current_date = current_date.getDate();
            var today = new Date(current_year, current_month, current_date);

            var last = todate.lastIndexOf("-");
            var year = todate.substring(last + 1, last + 5);
            var month = todate.substring(first + 1, last);
            var date = todate.substring(0, first);
            var form_date1 = new Date(year, month - 1, date);
            var current_date = new Date();
            current_date.setHours(0, 0, 0, 0);

            var lastDate = current_date.getTime() - 24 * 60 * 60 * 1000;


            if (form_date1.getTime() < lastDate) {
                $('<span class="error2">To Date cannot be less than yesterday</span>').insertAfter('#calImg');
                count++;
            }
            if (form_date1 < form_date) {
                $('<span class="error2">To Date cannot be From Date</span>').insertAfter('#calImg');
                count++;
            }
        }
        if (reason === "--Select One--") {
            $('<span class="error2">Select leave type</span>').insertAfter('#reason');
            count++;
        }

        if (duration === "") {
            $('<span class="error2">Select duration</span>').insertAfter('#duration');
            count++;
        } else if (duration === 'First Half' || duration === 'Second Half') {
            if (fromdate !== todate) {
                $('<span class="error2"> More than one day leave is not allowed for first half/second half</span>').insertAfter('#submit1');
                count++;
            }
        }

        if (description === "") {
            $('<span class="error2">Enter description</span>').insertAfter('#description');
            count++;
        }

        if (count === 0) {
            $("#dialog").dialog("close");
            $.ajax({
                url: '<%=request.getContextPath()%>/UserProfile/createLeaveAjax.jsp?fromdate=' + fromdate + '&todate=' + todate + '&reason=' + reason + '&duration=' + duration + '&description=' + description + '&leaveid=' + leaveid + '&rand=' + Math.random(1, 10),
                type: 'POST',
                async: true,
                success: function (response, statusTxt, calslback) {

                    $('#calendar').fullCalendar({

                        events: [{
                                title: 'Yet to Approve',
                                start: new Date(fromdate),
                                end: new Date(todate),
                                allDay: false
                            }]
                    });
                }
            });
        }
    });
    $(function () {
        $("#dialog").dialog({
            autoOpen: false,
            width: 900,
            //  height: 600,
            //my: "center",
            //at: "top",
            //  of: window,
            position: ['center' + 50, 50],
            show: {
                effect: "blind",
                duration: 1000
            },
            hide: {
                effect: "blind",
                duration: 1000
            }
        });
        $("#dialog").dialog("widget").animate({
            left: "140px",
            top: "20px"
        }, 1500);
    });
    $(".Ajax-loder").hide();
</script>
</HTML>
