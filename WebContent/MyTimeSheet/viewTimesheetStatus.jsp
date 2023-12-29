<%-- 
    Document   : viewTimesheetStatus
    Created on : Nov 20, 2012, 10:39:51 AM
    Author     : Tamilvelan
--%>
<%@page import="com.eminent.util.GetValues"%>
<%@ page import="org.apache.log4j.*,com.eminent.util.GetProjectMembers,com.eminent.timesheet.Users,java.util.HashMap,java.util.Date,java.text.SimpleDateFormat,java.util.List,com.eminent.timesheet.CreateTimeSheet,com.eminent.timesheet.Timesheet,java.util.Iterator"%>
<%

    session.setAttribute("forwardpage", "/MyTimeSheet/viewTimesheetStatus.jsp");

    //Configuring log4j properties
    Logger logger = Logger.getLogger("TimeSheet List");

    String logoutcheck = (String) session.getAttribute("Name");
    if (logoutcheck == null) {
        logger.fatal("=========================Session Expired======================");
%>
<jsp:forward page="../SessionExpired.jsp"></jsp:forward>
<%
        //response.sendRedirect(request.getContextPath()+"/SessionExpired.jsp");
    }

%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">
<%@ include file="../header.jsp"%>
<html>
    <meta name="keywords" content="GST in SAP, SAP GST Accelerator, GST Success in SAP, GST India in SAP, GST SAP Success, GST Suvidha Provider, GST ASP GSP, GST, CGST,SGST, IGST, UGST,  SAP NW based Product Development, SAP Consulting, SAP Implementation, SAP Support Services, SAP Outsourcing, SAP Implementation India, SAP Implementation Bangalore, SAP Implementation Chennai, SAP Implementation Belgium, SAP Implementation Paris, SAP Implemtation Australia, SAP Implementation France, SAP Implementation Mumbai, SAP Implementation Kerala, SAP Implementation Belgaum, SAP Implementation Thailand, SAP Implementation Mexico, SAP Implementation America">
    <meta http-equiv="Content-Type" content="text/html">
    <title>eTracker&#153; - Eminentlabs&#153; CRM, APM, TQM,  ERM and  EPTS Solution</title>
    <LINK title=STYLE  href="<%= request.getContextPath()%>/eminentech support files/main_ie.css" type="text/css" rel="STYLESHEET">
    <script src="<%=request.getContextPath()%>/javaScript/jquery.js" type="text/javascript"></script>
    <script src="<%=request.getContextPath()%>/javaScript/jquery.tablesorter.min.js" type="text/javascript"></script>
    <script type="text/javascript">

        $.tablesorter.addParser({
            // set a unique id 
            id: 'ddMMMyy',
            is: function (s) {
                // return false so this parser is not auto detected 
                return false;
            },
            format: function (s) {
                // parse the string as a date and return it as a number 
                return +new Date(s);
            },
            // set type, either numeric or text 
            type: 'numeric'
        });

        $(document).ready(function ()
        {
            $("#searchTable").tablesorter({
                widgets: ['zebra'],
                widgetZebra: {css: ['zebraline', 'zebralinealter']},
                // change the multi sort key from the default shift to alt button 
                sortMultiSortKey: 'altKey'

            });
        }
        );

    </script>   
</head>
<body>

    <table cellpadding="0" cellspacing="0" width="100%">
        <tr border="2" bgcolor="#E8EEF7">
            <td align="left"><b> TimeSheet Approval </b></td>

        </tr>

    </table>
    <%
        try {
            int roleId = (Integer) session.getAttribute("Role");
            int userId = (Integer) session.getAttribute("uid");
            List l = CreateTimeSheet.GetTimeSheet();
            int noOfRecords = l.size();

            HashMap<Integer, String> monthSelect = new HashMap();

            monthSelect.put(0, "Jan");
            monthSelect.put(1, "Feb");
            monthSelect.put(2, "Mar");
            monthSelect.put(3, "Apr");
            monthSelect.put(4, "May");
            monthSelect.put(5, "Jun");
            monthSelect.put(6, "Jul");
            monthSelect.put(7, "Aug");
            monthSelect.put(8, "Sep");
            monthSelect.put(9, "Oct");
            monthSelect.put(10, "Nov");
            monthSelect.put(11, "Dec");

            if (noOfRecords > 0) {
    %>
    <br>
    <table width="100%">
        <tr height="10">
            <td align="left" width="100%">This list shows <b> <%=noOfRecords%></b> TimeSheet requests.</td>

        </tr>
    </table>
    <TABLE width="100%" border="0">




        <%
            if (request.getParameter("update") != null && request.getParameter("update").equalsIgnoreCase("disabled")) {
        %>
        <Tr>
            <td align="center"><font color="red"><%= request.getParameter("noofrecords")%>
                    User(s) have been disabled!</font></td>
        </Tr>
        <%
            }
            if (request.getParameter("update") != null && request.getParameter("update").equalsIgnoreCase("enabled")) {
        %>
        <Tr>
            <td align="center"><font color="green"><%= request.getParameter("noofrecords")%>
                    User(s) have been Enabled!</font></td>
        </Tr>
        <%
            }

            //Code to get page to enter the points
            HashMap<String, Integer> valueTable = GetValues.checkValue();
            int bug = valueTable.get("bug");
            int enhancement = valueTable.get("enhancement");
            int newtask = valueTable.get("newtask");

            String pageToDisplay = null;
            String pageToView = null;

            if (bug == 0) {
                pageToDisplay = "bug";
            } else if (enhancement == 0) {
                pageToDisplay = "enhancement";
            } else if (newtask == 0) {
                pageToDisplay = "newtask";
            }

            if (bug > 0) {
                pageToView = "bug";
            } else if (enhancement > 0) {
                pageToView = "enhancement";
            } else if (newtask > 0) {
                pageToView = "newtask";
            }


        %>



        <tr>
            <td>
                <%                         if (roleId == 1) {%>
                <a href="<%=request.getContextPath()%>/admin/user/addnewuser.jsp">Add	User</a>&nbsp;&nbsp;&nbsp;&nbsp;
                <a href="<%=request.getContextPath()%>/admin/user/waitingForApproval.jsp">Approve User</a>&nbsp;&nbsp;&nbsp;&nbsp;

                <a href="<%=request.getContextPath()%>/admin/user/deniedUsers.jsp">Denied Users</a>&nbsp;&nbsp;&nbsp;&nbsp;
                <a href="<%=request.getContextPath()%>/admin/user/disabledUsers.jsp">Disabled Users</a>&nbsp;&nbsp;&nbsp;&nbsp;
                <%
                    if (pageToDisplay != null) {

                %>
                <a href="<%=request.getContextPath()%>/admin/user/defineValue.jsp?viewpage=<%=pageToDisplay%>">Define Value</a>&nbsp;&nbsp;&nbsp;&nbsp;
                <%
                    }
                    if (pageToView != null) {
                %>
                <a href="<%=request.getContextPath()%>/admin/user/viewValues.jsp?viewpage=<%=pageToView%>">View Values</a> &nbsp;&nbsp;&nbsp;&nbsp;
                <a href="<%=request.getContextPath()%>/admin/dashboard/dailyUserActivity.jsp">User Activity</a>&nbsp;&nbsp;&nbsp;&nbsp;
                <a href="<%=request.getContextPath()%>/admin/user/viewAppraisal.jsp">View Appraisal</a>&nbsp;&nbsp;&nbsp;&nbsp;
                <a href="<%=request.getContextPath()%>/MyTimeSheet/viewTimesheetStatus.jsp">View Timesheet Status</a>&nbsp;&nbsp;&nbsp;&nbsp;
                <a href="<%=request.getContextPath()%>/MyTimeSheet/teamClosedIssueReport.jsp">ESPL User's Rank</a>&nbsp;&nbsp;&nbsp;&nbsp;
                <a href="<%=request.getContextPath()%>/admin/timesheet/timesheetMaintanance.jsp">Timesheet Maintenance</a>
                <a href="<%=request.getContextPath()%>/leave/leaveApproverMaintanance.jsp">Leave Maintenance</a>

                <%
                } else {

                %>
                <a href="<%=request.getContextPath()%>/admin/user/viewuser.jsp" >View User</a>&nbsp;&nbsp;&nbsp;&nbsp;
                <a href="<%=request.getContextPath()%>/MyTimeSheet/viewTimesheetStatus.jsp" style="font: bold;">View Timesheet Status</a>&nbsp;&nbsp;&nbsp;&nbsp;

                <%
                    }

                %>
            </td>&nbsp;&nbsp;&nbsp;&nbsp;

            <%                    }

            %>

            <%
            %>



        </tr>

    </TABLE>
    <br>
    <table width="100%" id="searchTable" class="tablesorter">
        <thead>
            <tr bgcolor="#C3D9FF" width="100%">
                <th class="header" width="20%"><b>TimeSheetId</b></th>
                <th class="header" width="20%"><b>Owner</b></th>
                <th class="header" width="20%"><b>Period</b></th>
                <th class="header" width="20%"><b>Requested On</b></th>
                <th class="header" width="20%"><b>Assigned To</b></th>
            </tr>
        </thead>
        <%    int lineColor = 0;
            String color = "";
            for (Iterator i = l.iterator(); i.hasNext();) {
                Timesheet t = (Timesheet) i.next();
                String timesheet = t.getTimesheetid();
                String month = timesheet.substring(1, 3);
                String year = timesheet.substring(3, 7);
                String timsheetUser = timesheet.substring(7, timesheet.length());

                java.util.Date date = t.getRequestedon();
                SimpleDateFormat sdf = new SimpleDateFormat("dd-MMM-yy HH:mm");
                String requestedOn = "NA";
                if (date != null) {
                    requestedOn = sdf.format(date);
                }

                Users user = t.getUsers();
                int userid = user.getUserid();

                Date d = t.getApprovedon();

                String accountStatus = t.getAccountstatus();
                String url = null;

                String timesheetPeriod = monthSelect.get(Integer.parseInt(month)) + " " + year;

                if (t.getApprovalpercentage() == null && t.getApprovedby() == null && d == null) {
                    url = "timeSheetView.jsp?month=" + month + "&year=" + year + "&userId=" + timsheetUser;
                } else if (t.getAttendenceupdatedby() == null && t.getAttendance() == null) {
                    url = "hrView.jsp?userId=" + userid + "&timeSheetId=" + timesheet + "&period=" + timesheetPeriod;
                } else if (accountStatus == null && t.getAccountupdatedby() == null) {
                    url = "accountsView.jsp?userId=" + userid + "&timeSheetId=" + timesheet;
                }

                if ((lineColor % 2) != 0) {
        %>
        <tr class="zebralinealter" height="22">
            <%
            } else {
            %>
        <tr class="zebraline" height="22">
            <%
                }


            %>

            <td width="20%"><a href="<%=url%>"><%=timesheet%></a></td>
            <td width="20%"><%=GetProjectMembers.getUserName(((Integer) userid).toString())%></td>
            <td width="20%"><%=timesheetPeriod%></td>
            <td width="20%"><%=requestedOn%></td>
            <td width="20%"><%=GetProjectMembers.getUserName(((Integer) (t.getAssignedto()).intValueExact()).toString())%></td>
        </tr>
        <%
                lineColor++;
            }
        } else {
        %>
        <jsp:forward page="/MyAssignment/UpdateIssue.jsp"></jsp:forward>
        <%
                }
            } catch (Exception e) {
                logger.error(e.getMessage());
            }
        %>
    </table>
</body>
</html>
