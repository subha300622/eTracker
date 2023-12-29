<%-- 
    Document   : leaveReqest
    Created on : Jun 13, 2009, 12:56:12 PM
    Author     : Tamilvelan
--%>

<%@page import="com.eminent.leaveUtil.LeaveBlancePeriodDAO"%>
<%@page import="com.eminent.leaveUtil.LeaveBalancePeriod"%>
<%@page import="com.eminent.util.GetProjectMembers"%>
<%@page import="com.eminentlabs.mom.MoMUtil"%>
<%@page import="java.util.List"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.LinkedHashMap"%>
<%@page import="com.eminent.util.GetProjectManager"%>
<%@page import="java.util.HashMap"%>
<%@ page import="org.apache.log4j.*"%>
<%@ page import="com.eminent.leaveUtil.LeaveUtil"%>

<%
    //Configuring log4j properties
    Logger logger = Logger.getLogger("Request Leave");

    String logoutcheck = (String) session.getAttribute("Name");
    if (logoutcheck == null) {
%>
<jsp:forward page="../SessionExpired.jsp"></jsp:forward>
<%    }
%>
<%@ include file="/header.jsp"%> <br>

<html>
    <meta name="keywords" content="GST in SAP, SAP GST Accelerator, GST Success in SAP, GST India in SAP, GST SAP Success, GST Suvidha Provider, GST ASP GSP, GST, CGST,SGST, IGST, UGST,  SAP NW based Product Development, SAP Consulting, SAP Implementation, SAP Support Services, SAP Outsourcing, SAP Implementation India, SAP Implementation Bangalore, SAP Implementation Chennai, SAP Implementation Belgium, SAP Implementation Paris, SAP Implemtation Australia, SAP Implementation France, SAP Implementation Mumbai, SAP Implementation Kerala, SAP Implementation Belgaum, SAP Implementation Thailand, SAP Implementation Mexico, SAP Implementation America">
        <script language=javascript src="<%= request.getContextPath()%>/javaScript/checkSubmit.js"></script>
        <script language=javascript src="<%= request.getContextPath()%>/javaScript/XMLHttpRequest.js"></script>
        <script>
            function callovelapcheck() {
                xmlhttp = createRequest();

                if (xmlhttp != null) {

                    var fromdate = document.theForm.fromdate.value;
                    var todate = document.theForm.todate.value;
                    var url = "<%=request.getContextPath()%>/UserProfile/overLapDetails.jsp";
                    url = url + "?fromdate=" + fromdate;
                    url = url + "?todate=" + todate;
                    url = url + "&rand=" + Math.random();

                    xmlhttp.onreadystatechange = callbackovelapcheck;
                    xmlhttp.open("GET", url, false);
                    xmlhttp.send(null);



                }
            }

            function callbackovelapcheck() {

                if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {


                    var name = xmlhttp.responseText;

                    var result = xmlhttp.responseText.split(";");

                    var flag = result[1];

                    if (flag === 'Yes') {

                        alert("Alredy you have a Leave Request for this period");

                    }
                }
            }


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
                }
                while (pos === 1 && i < str.length)
                if (pos === 0)
                    return false;
                return true;
            }
            var hDateres;
            function checkeHoliday() {
                xmlhttp = createRequest();
                var fromDate = document.getElementById("fromdate").value;
                var toDate = document.getElementById("todate").value;
                var userId = document.getElementById("userId").value;
                if (xmlhttp !== null) {

                    xmlhttp.open("GET", "/eTracker/getHoliday.jsp?fromDate=" + fromDate + "&toDate=" + toDate+"&userId=" + userId, false);

                    xmlhttp.onreadystatechange = function() {
                        if (xmlhttp.readyState === 4)
                        {
                            if (xmlhttp.status === 200)
                            {
                                hDateres = xmlhttp.responseText;

                            }
                        }
                    };
                    xmlhttp.send(null);
                } else {
                    alert('no ajax request');
                }

            }
            function validate() {

                if (trim(document.theForm.fromdate.value) === '')
                {
                    alert("Please Enter the From Date ");
                    document.theForm.fromdate.focus();
                    return false;
                }
                if (!isDate(trim(theForm.fromdate.value)))
                {
                    alert('Please enter the valid From Date');
                    document.theForm.fromdate.value = "";
                    theForm.fromdate.focus();
                    return false;
                }
                var str = document.theForm.fromdate.value;

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

                if (trim(document.theForm.todate.value) === '')
                {
                    alert("Please Enter the To Date ");
                    document.theForm.todate.focus();
                    return false;
                }
                if (!isDate(trim(theForm.todate.value)))
                {
                    alert('Please enter the valid To Date');
                    document.theForm.todate.value = "";
                    theForm.todate.focus();
                    return false;
                }
                var str1 = document.theForm.todate.value;
                var duration = document.theForm.duration.value;
                if (duration === 'First Half' || duration === 'Second Half') {
                    if (str1 !== str) {
                        alert(' More than one day leave is not allowed for first half/second half');
                        theForm.duration.focus();
                        return false;
                    }
                }
                var first = str1.indexOf("-");
                var last = str1.lastIndexOf("-");
                var year = str1.substring(last + 1, last + 5);
                var month = str1.substring(first + 1, last);
                var date = str1.substring(0, first);
                var form_date1 = new Date(year, month - 1, date);
                var current_date = new Date();



                if (form_date1 < form_date) {
                    alert('To Date cannot be less than From Date');
                    document.theForm.todate.value = "";
                    theForm.todate.focus();
                    return false;
                }
                checkeHoliday();
                if (hDateres !== undefined) {
                    if (trim(hDateres) !== '') {
                        var res = trim(hDateres);
                        if (theForm.fromdate.value === res && theForm.todate.value === res) {
                            alert(res + " Already Holiday Available");
                            document.theForm.fromdate.value = "";
                            theForm.fromdate.focus();
                            document.theForm.todate.value = "";
                            theForm.todate.focus();
                        }
                        else if (theForm.fromdate.value === res) {
                            alert(res + " Already Holiday Available");

                            document.theForm.fromdate.value = "";
                            theForm.fromdate.focus();
                        } else if (theForm.todate.value === res) {
                            alert(res + " Already Holiday Available");
                            document.theForm.todate.value = "";
                            theForm.todate.focus();
                        }
                        return false;
                    }
                }
                if (document.getElementById('reason').value === '--Select One--')
                {
                    alert("Please choose a Leave Type");
                    document.getElementById('reason').focus();
                    return false;
                }
                if (trim(document.getElementById('description').value) === '')
                {
                    alert("Please Provide the reason for the leave");
                    document.getElementById('description').focus();
                    return false;
                }
                leaveSubmit();
            }
            function textCounter(field, cntfield, maxlimit)
            {
                if (field.value.length > maxlimit)
                {
                    field.value = field.value.substring(0, maxlimit);
                    if (maxlimit === 2000)
                        alert('Description size is exceeding 4000 characters');
                    else
                        alert('Expected Result size is exceeding 2000 characters');
                }
                else
                    cntfield.value = maxlimit - field.value.length;
            }
            function edittextCounter(field, cntfield, maxlimit)
            {
                if (field.value.length > maxlimit)
                {
                    field.value = field.value.substring(0, maxlimit);
                    if (maxlimit == 2000)
                        alert('Description size is exceeding 4000 characters');
                    else
                        alert('Expected Result size is exceeding 2000 characters');
                }
                else
                    cntfield.value = maxlimit - field.value.length;
            }

            function validateApprove() {
                leaveRejectSubmit();
                var comments = document.theForm.comments.value;
                var leaveid = document.theForm.leaveid.value;
                var approval = 1;

                document.theForm.action = "updateLeave.jsp?comments=" + comments + "&leaveid=" + leaveid + "&approval=" + approval;
                document.theForm.submit();


            }
            function validateReject() {
                leaveRejectSubmit();
                if (trim(document.theForm.comments.value) == '')
                {
                    alert("Please Enter the comments for rejecting Leave ");
                    document.theForm.comments.focus();
                    return false;
                }
                var comments = document.theForm.comments.value;
                var leaveid = document.theForm.leaveid.value;
                var approval = -1;

                document.theForm.action = "updateLeave.jsp?comments=" + comments + "&leaveid=" + leaveid + "&approval=" + approval;
                document.theForm.submit();

            }
            function validateCancel() {

                var approval = -2;
                document.theForm.action = "updateLeave.jsp?comments=" + comments + "&leaveid=" + leaveid + "&approval=" + approval + "&type=" + type;
            }


        </script>
        <script type="text/javascript">
            function call()
            {
                var x = document.getElementById("approvalStatus").value;
                theForm.action = '/eTracker/admin/user/leaveRequest.jsp?approvalStatus=' + x;
                theForm.submit();
            }
            function callRequstor() {
                var userId = document.getElementById('userId').value;
                document.userForm.action = "leaveRequest.jsp?userId=" + userId;
                document.userForm.submit();
            }
        </script>
        <meta http-equiv="Content-Type" content="text/html">
        <LINK title=STYLE	href="<%= request.getContextPath()%>/eminentech support files/main_ie.css" type=text/css rel=STYLESHEET>
        <script language=javascript src="<%= request.getContextPath()%>/eminentech support files/datetimepicker.js"></script>

    </head>

    <body>
        <%
            String requestor = request.getParameter("userId");
            int requestedby = (Integer) session.getAttribute("userid_curr");
            if (requestor != null) {
                requestedby = Integer.valueOf(requestor);
            }
            LinkedHashMap<String, String> leaveType = LeaveUtil.hrLeaveTypes();
             Map<String,Float> leaveTypeDetails  = LeaveUtil.leaveDetailsByUser(requestedby,GetProjectMembers.getBranchId(requestedby));
            int editleaveId = 0;
            String editLeaveDetails[][];
            int j = 0;
            String editfrom = null;
            String editto = null;
            String edittype = null;
            String editdesc = null;
            String editcomments = null;
            String editDuration = null;
            String editNoOFDay = null;
            int editapprove = 0;
            if (request.getParameter("leaveid") != null) {
                SimpleDateFormat sdc = new SimpleDateFormat("dd-MMM-yyyy");
                SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy");
                editleaveId = Integer.parseInt(request.getParameter("leaveid"));
                editLeaveDetails = LeaveUtil.getEditRequest(editleaveId);
                editfrom = editLeaveDetails[j][1];
                editfrom = sdf.format(sdc.parse(editfrom));
                editto = editLeaveDetails[j][2];
                editto = sdf.format(sdc.parse(editto));
                edittype = editLeaveDetails[j][3];
                editdesc = editLeaveDetails[j][4].trim();
                editcomments = editLeaveDetails[j][10];
                editapprove = Integer.parseInt(editLeaveDetails[j][9]);
                editDuration = editLeaveDetails[j][12];
                editNoOFDay = editLeaveDetails[j][13];
            }

            if (editcomments == null) {
                editcomments = "NA";
            }
            if (editfrom == null || editfrom == "null") {
                editfrom = "";
            }
            if (editto == null) {
                editto = "";
            }
            if (edittype == null) {
                edittype = "";
            }
            if (editdesc == null) {
                editdesc = "";
            }
            if (editfrom == null) {
                editfrom = "";
            }
            if (editfrom == null) {
                editfrom = "";
            }


        %>


        <%
        %>
        <%            String approvalStatus = "All Requests";
            if (request.getParameter("approvalStatus") != null) {
                approvalStatus = request.getParameter("approvalStatus");
            }
            HashMap<Integer, String> member = GetProjectMembers.getEminentUsers();
        %>
        <form name="userForm" id="userForm" method="get">
            <TABLE width="100%">
                <TR>
                    <TD align="left"  bgcolor="#E8EEF7">
                        <B>Leave Request For &nbsp;&nbsp;&nbsp;&nbsp;<select id="userId" name="userId" size=1 onchange="javascript:callRequstor()">
                                <%for (Map.Entry entry : member.entrySet()) {
                                        int use = (Integer) (entry.getKey());
                                        if (requestedby == use) {%>
                                <option value="<%=entry.getKey()%>" selected><%=entry.getValue()%></option>
                                <%} else {
                                %>
                                <option value="<%=entry.getKey()%>"><%=entry.getValue()%></option>
                                <%}
                                    }%>
                            </select></B>
                    </TD>
                </TR>
            </TABLE>
        </form>
        <%
            float privilageLeaveNo = LeaveBlancePeriodDAO.getPrivilegeLeave(requestedby);
            String leaveRequest[][] = LeaveUtil.waitingForApproval(requestedby);
            int noOfRequest = leaveRequest.length;
        %>
        <table style="width: 100%;">
            <tr><td style="width: 60%;">
                    <table >
                        <tr>
                            <td>
                                <a href="<%=request.getContextPath()%>/UserProfile/employeeHandbook.jsp">Employee Handbook </a>&nbsp;&nbsp;&nbsp;&nbsp;
                                <a href="<%=request.getContextPath()%>/UserProfile/holidayCalendar.jsp">Holiday Calendar</a>&nbsp;&nbsp;&nbsp;&nbsp;
                                <a href="leaveRequest.jsp?userId=<%=requestedby%>" style="font-weight: bold;"> Leave Request</a>&nbsp;&nbsp;&nbsp;&nbsp;

                                <%
                                    if (noOfRequest > 0) {
                                %>
                                <a href="<%=request.getContextPath()%>/UserProfile/editLeaveRequest.jsp?userId=<%=requestedby%>">Approve Leave</a>&nbsp;&nbsp;&nbsp;&nbsp;
                                <%                         }
                                    if (requestedby == 1189 || requestedby == 104) {%>
                                <a href="<%=request.getContextPath()%>/leave/leaveView.jsp">Leaves </a>&nbsp;&nbsp;&nbsp;&nbsp;
                                <a href="<%=request.getContextPath()%>/leave/LeaveViewByPeriod.jsp">Leaves Summary </a>&nbsp;&nbsp;&nbsp;&nbsp;
                                <% }
                                %>
                            </td>
                        </tr>

                    </table>
                </td><td style="width: 40%;">
                  <table  style="border-collapse: collapse;border:1px solid black;">
                        <tr style="font-weight: bold;border:1px solid black; "><td style="border:1px solid black; ">Leave Type</td><td style="text-align: center;border:1px solid black;">Eligible</td><td style="text-align: center;border:1px solid black;">Availed</td><td style="text-align: center;border:1px solid black;">Balance</td></tr>
                        <% float total = 0, availed = 0, balance = 0;
                            for (Map.Entry<String, String> entry : leaveType.entrySet()) { total = 0;
                                balance = 0;
                                availed = 0;%>
                        <tr style="border:1px solid black; "> 
                                <%if (entry.getKey().equals("Sick Leave") || entry.getKey().equals("Casual Leave") || entry.getKey().equals("Privilege Leave")) {%>
                            <td style="font-weight: bold;">  <%=entry.getKey()%>    </td>
                            <%
                                total = 0; balance = 0;
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
                </td>
            </tr></table>

        <%
            List<String> duerationList = LeaveUtil.durationList();
            if (editleaveId != 0) {
                SimpleDateFormat sdc = new SimpleDateFormat("dd-MMM-yyyy");
                SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy");
                java.util.Date toDate = sdf.parse(editfrom);
                java.util.Date endDate = sdf.parse(editto);
                String cur = sdf.format(new java.util.Date());
                java.util.Date currDate = sdf.parse(cur);
                logger.info(currDate + "," + toDate);

                if (editapprove != -1 && editapprove != -2) {
                    if (currDate.compareTo(endDate) <= 0) {

        %>
        <form name="theForm" action="createLeaveForUser.jsp" method="post" onsubmit="return validate(this);">
            <table bgcolor="E8EEF7"  style="width: 100%;">
                <tr>

                    <td style="width: 14%;"><B>From</B></td>

                    <td style="width: 15%;">
                        <%if (currDate.compareTo(toDate) <= 0) {%>
                        <input type="text" id="fromdate" name="fromdate" maxlength="10" size="10" value="<%=editfrom%>" readonly  /><a href="javascript:NewCal('fromdate','ddMMyyyy')"> <img src="<%=request.getContextPath()%>/images/newhelp.gif" border="0" width="16" height="16" alt="Pick a date"></a>
                            <%} else {%>
                        <input type="hidden" id="fromdate" name="fromdate" maxlength="10" size="10" value="<%=editfrom%>" readonly  />
                        <%=editfrom%>
                        <%}%>
                    </td>
                    <td style="width: 2%;text-align: right;"><B>To</B></td>
                    <td style="width: 20%;">
                        <input type="text" id="todate" name="todate" value="<%=editto%>" maxlength="10" size="10" readonly  /><a href="javascript:NewCal('todate','ddMMyyyy')"> <img src="<%=request.getContextPath()%>/images/newhelp.gif" border="0" width="16" height="16" alt="Pick a date"></a></td>

                    <td style="width: 4%;"><b>Type</b></td>
                    <td style="width: 46%;">
                        <select name="reason" id="reason">
                            <option value="--Select One--">--Select One--</option>
                            <%for (Map.Entry entry : leaveType.entrySet()) {
                                    if (entry.getValue().equals(edittype)) {%>  
                            <option value="<%=entry.getValue()%>" selected=""><%=entry.getValue()%></option>
                            <%} else {%>
                            <option value="<%=entry.getValue()%>" ><%=entry.getValue()%></option>

                            <%}
                                }%>     

                        </select>
                    </td>

                </tr>
                <tr>
                    <td><b>Duration</b></td>
                    <td>
                        <select name="duration" id="duration">
                            <%for (String duration : duerationList) {
                                    if (editDuration.equalsIgnoreCase(duration)) {%>
                            <option value="<%=duration%>" selected><%=duration%></option>
                            <%} else {%>
                            <option value="<%=duration%>"><%=duration%></option>
                            <%}
                                }%>  
                        </select></td>
                </tr>
                <tr>
                    <td style="width: 14%;"><b>Reason for Leave</b></td>
                    <td colspan="5">
                        <font size="2"
                              face="Verdana, Arial, Helvetica, sans-serif"> <textarea
                              name="description" id="description" wrap="physical" cols="60" rows="4"
                              onKeyDown="edittextCounter(document.theForm.description, document.theForm.remLen1, 2000);"
                              onKeyUp="edittextCounter(document.theForm.description, document.theForm.remLen1, 2000);"><%=editdesc%></textarea></font>
                        <input readonly type="text"
                               name="remLen1" size="3" maxlength="3" value="2000"></td>
                </tr>
                <tr><td><input type="hidden" name="userId" id="userId"  value="<%=requestedby%>"/><input type="hidden" name="leaveid" value="<%=editleaveId%>"></td></tr>

                <tr>
                    <td align="right" colspan="2"><input id="submit1" type="submit" value="Update Leave" /></td>
                </tr> 

        </form>
        <%} else {%>
        <form name="theForm" action="createLeaveForUser.jsp" method="post" onsubmit="return validate(this);">
            <table bgcolor="E8EEF7"  style="width: 100%;">
                <tr>
                    <td style="width: 14%;"><B>From</B></td>
                    <td style="width: 10%;"><%=editfrom%></td>
                    <td style="width: 4%;text-align: right;"><B>To</B></td>
                    <td style="width: 10%;"><%=editto%> </td>
                    <td style="width: 4%;"><b>Type</b></td>
                    <td style="width: 10%;">
                        <%=edittype%>
                    </td>
                    <td style="width: 4%;"><b>Duration</b></td>
                    <td style="width: 10%;"><%=editDuration%></td>
                </tr>

                <tr>
                    <td style="width: 14%;"><b>Reason for Leave</b></td>
                    <td colspan="5">
                        <font size="2"
                              face="Verdana, Arial, Helvetica, sans-serif"><%=editdesc%></font>

                </tr>            <tr><td><input type="hidden" name="userId" id="userId"  value="<%=requestedby%>"/><input type="hidden" name="leaveid" value="<%=editleaveId%>"></td></tr>
                        <%
                            }
                        } else {%>
                <table bgcolor="E8EEF7"  style="width: 100%;">
                    <tr>
                        <td style="width: 14%;"><B>From</B></td>
                        <td style="width: 10%;"><%=editfrom%></td>
                        <td style="width: 4%;text-align: right;"><B>To</B></td>
                        <td style="width: 10%;"><%=editto%> </td>
                        <td style="width: 4%;"><b>Type</b></td>
                        <td style="width: 10%;">
                            <%=edittype%>
                        </td>
                        <td style="width: 4%;"><b>Duration</b></td>
                        <td style="width: 10%;"><%=editDuration%></td>
                    </tr>

                    <tr>
                        <td style="width: 14%;"><b>Reason for Leave</b></td>
                        <td colspan="5">
                            <font size="2"
                                  face="Verdana, Arial, Helvetica, sans-serif"><%=editdesc%></font>

                    </tr>            <tr><td><input type="hidden" name="userId" id="userId"  value="<%=requestedby%>"/><input type="hidden" name="leaveid" value="<%=editleaveId%>"></td></tr>       
                            <%}%>
                    </tr>
                </table>
                <%} else {
                %>
                <form name="theForm" action="createLeaveForUser.jsp" method="post" onsubmit="return validate(this)">
                    <table bgcolor="E8EEF7"  style="width: 100%;">
                        <tr>
                            <td style="width: 14%;"><B>From</B></td>
                            <td style="width: 15%;"><input type="text" id="fromdate" name="fromdate" maxlength="10" size="10" value="<%=editfrom%>" readonly  /><a href="javascript:NewCal('fromdate','ddMMyyyy')"> <img src="<%=request.getContextPath()%>/images/newhelp.gif" border="0" width="16" height="16" alt="Pick a date"></a></td>
                            <td style="width: 2%;text-align: right;"><B>To</B></td>
                            <td style="width: 20%;"><input type="text" id="todate" name="todate" value="<%=editto%>" maxlength="10" size="10" readonly  /><a href="javascript:NewCal('todate','ddMMyyyy')"> <img src="<%=request.getContextPath()%>/images/newhelp.gif" border="0" width="16" height="16" alt="Pick a date"></a></td>
                            <td style="width: 4%;"><b>Type</b></td>
                            <td style="width: 46%;">
                                <select name="reason" id="reason">
                                    <option value="--Select One--">--Select One--</option>
                                    <%for (Map.Entry entry : leaveType.entrySet()) {
                                            if (entry.getValue().equals(edittype)) {%>  
                                    <option value="<%=entry.getValue()%>" selected=""><%=entry.getValue()%></option>
                                    <%} else {%>
                                    <option value="<%=entry.getValue()%>" ><%=entry.getValue()%></option>

                                    <%}
                                        }%>     

                                </select>
                            </td>

                        </tr>
                        <tr>
                            <td><b>Duration</b></td>
                            <td><select name="duration" id="duration">
                                    <%for (String duration : duerationList) {%>
                                    <option value="<%=duration%>"><%=duration%></option>
                                    <%}%>  
                                </select></td>
                        </tr>
                        <tr>
                            <td style="width: 14%;"><b>Reason for Leave</b></td>
                            <td colspan="5">
                                <font size="2"
                                      face="Verdana, Arial, Helvetica, sans-serif"> <textarea
                                      name="description" id="description" wrap="physical" cols="60" rows="4"
                                      onKeyDown="textCounter(document.theForm.description, document.theForm.remLen1, 2000);"
                                      onKeyUp="textCounter(document.theForm.description, document.theForm.remLen1, 2000);"></textarea></font>
                                <input readonly type="text"
                                       name="remLen1" size="3" maxlength="3" value="2000"></td>
                        </tr>
                        <tr>
                            <td align="right" colspan="2"><input type="hidden" name="userId" id="userId"  value="<%=requestedby%>"/><input id="submit1" type="submit" value="Submit" /></td><td align="left"><input id="reset" type="reset" Value="Reset" /></td>
                        </tr>
                    </table>
                </form>

                <%}

                    LinkedHashMap<String, String> leaveStatuses = new LinkedHashMap<String, String>();
                    leaveStatuses.put("All Requests", "All Requests");
                    leaveStatuses.put("Yet to Approve", "Yet to Approve");
                    leaveStatuses.put("Approved", "Approved");
                    leaveStatuses.put("Cancelled", "Cancelled");
                    leaveStatuses.put("Rejected", "Rejected");

                    HashMap<Integer, String> hm = new HashMap<Integer, String>();
                    hm.put(0, "Yet to Approve");
                    hm.put(1, "Approved");
                    hm.put(-1, "Rejected");
                    hm.put(-2, "Cancelled");

                    String leaveDetails[][] = LeaveUtil.getLeave(requestedby);

                    int noOfLeave = leaveDetails.length;

                    logger.info("No of Leave" + noOfLeave);

                    if (noOfLeave > 0) {

                %>
                <p><b>Note</b>: For every financial period from 1<sup>st</sup> April to 31<sup>st</sup> March, the leaves would be renewed. The unclaimed leave would be expired on 31<sup>st</sup> March.</p>
                <p style="text-align: left;vertical-align: bottom;">The leave requests and the status are<select name="approvalStatus" id="approvalStatus" onchange="javascript:call();" >
                        <%for (Map.Entry entry : leaveStatuses.entrySet()) {
                                if (entry.getValue().equals(approvalStatus)) {%>
                        <option value="<%=entry.getValue()%>" selected><%=entry.getValue()%></option>
                        <%} else {%>
                        <option value="<%=entry.getValue()%>"><%=entry.getValue()%></option>
                        <%}
                            }%>

                    </select> </p>

                <table  style="width: 100%;">
                    <tr bgcolor="#C3D9FF">
                        <td><b>Leave Type</b></td>
                        <td><b>From Date</b></td>
                        <td><b>To Date</b></td>
                        <td><b>Created On</b></td>
                        <td><b>No of Leave Days</b></td>
                        <td><b>Assigned To</b></td>
                        <td><b>Status</b></td>
                        <td><b>Approved By</b></td>
                        <td><b>Cancel</b></td>

                    </tr>

                    <%
                        int count = 0;
                        for (int i = 0; i < noOfLeave; i++) {

                            logger.info("Leave Id" + leaveDetails[i][0]);
                            logger.info("From Date" + leaveDetails[i][1]);
                            logger.info("To Date" + leaveDetails[i][2]);
                            logger.info("Type" + leaveDetails[i][3]);
                            logger.info("Requested" + leaveDetails[i][7]);
                            logger.info("Assigned to" + leaveDetails[i][8]);
                            logger.info("Approval" + leaveDetails[i][9]);

                            int leaveId = Integer.parseInt(leaveDetails[i][0]);
                            String from = leaveDetails[i][1];
                            String to = leaveDetails[i][2];
                            String type = leaveDetails[i][3];
                            String createdOn = leaveDetails[i][5];
                            int requested = Integer.parseInt(leaveDetails[i][7]);
                            int assignedto = Integer.parseInt(leaveDetails[i][8]);
                            String duration = leaveDetails[i][12];
                            String noOFday = leaveDetails[i][13];
                            int approver = 0;

                            String approve = hm.get(Integer.parseInt(leaveDetails[i][9]));
                            if (leaveDetails[i][11] != null) {
                                if (!approve.equalsIgnoreCase("Cancelled")) {
                                    approver = Integer.parseInt(leaveDetails[i][11]);
                                }
                            }
                            if (!approvalStatus.equalsIgnoreCase("All Requests")) {
                                if (approve.equalsIgnoreCase(approvalStatus)) {
                                    if (count == 0) {
                                        count++;
                    %>
                    <tr bgcolor="white" height="23">
                        <%                                } else {
                            count = 0;
                        %>

                    <tr bgcolor="#E8EEF7" height="23">
                        <%                                     }
                        %>
                        <td><a href="leaveRequest.jsp?userId=<%=requestedby%>&leaveid=<%=leaveId%>" title="<%=duration%>"><%=type%></a></td>
                        <td><%=from%></td>
                        <td><%=to%></td>
                        <td><%=createdOn%></td>
                        <td><%=noOFday%></td>
                        <td><%=GetProjectManager.getUserName(assignedto)%></td>
                        <td><%=approve%></td>
                        <%if (approver == 0) {%>
                        <td>NA</td>
                        <%} else {%>
                        <td><%=GetProjectManager.getUserName(approver)%></td>
                        <%}%>
                        <%SimpleDateFormat sdc = new SimpleDateFormat("dd-MMM-yy");
                            SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yy");
                            java.util.Date toDate = sdc.parse(from);
                            String cur = sdf.format(new java.util.Date());
                            java.util.Date currDate = sdf.parse(cur);
                            logger.info(currDate + "," + toDate + "," + approve);
                            if (approve.equalsIgnoreCase("Cancelled")) {%>
                        <td></td>
                        <% } else {
                            if (currDate.compareTo(toDate) <= 0) {%>
                        <td><a href="<%= request.getContextPath()%>/UserProfile/updateLeave.jsp?approval=-2&leaveid=<%=leaveId%>&type=<%=type%>">Cancel</a></td>

                        <%} else {%>
                        <td></td>

                        <%}
                            }%>
                    </tr>
                    <%
                        }
                    } else {
                        if (count == 0) {
                            count++;
                    %>
                    <tr bgcolor="white" height="23">
                        <%                                } else {
                            count = 0;
                        %>

                    <tr bgcolor="#E8EEF7" height="23">
                        <%                                     }
                        %>
                        <td><a href="leaveRequest.jsp?userId=<%=requestedby%>&leaveid=<%=leaveId%>" title="<%=duration%>"><%=type%></a></td>
                        <td><%=from%></td>
                        <td><%=to%></td>
                        <td><%=createdOn%></td>
                        <td><%=noOFday%></td>
                        <td><%=GetProjectManager.getUserName(assignedto)%></td>
                        <td><%=approve%></td>
                        <%if (approver == 0) {%>
                        <td>NA</td>
                        <%} else {%>
                        <td><%=GetProjectManager.getUserName(approver)%></td>
                        <%}%>
                        <%SimpleDateFormat sdc = new SimpleDateFormat("dd-MMM-yy");
                            SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yy");
                            java.util.Date toDate = sdc.parse(from);
                            String cur = sdf.format(new java.util.Date());
                            java.util.Date currDate = sdf.parse(cur);
                            logger.info(currDate + "," + toDate + "," + approve);
                            if (approve.equalsIgnoreCase("Cancelled")) {%>
                        <td></td>
                        <% } else {
                            if (currDate.compareTo(toDate) <= 0) {%>
                        <td><a href="<%= request.getContextPath()%>/UserProfile/updateLeave.jsp?approval=-2&leaveid=<%=leaveId%>&type=<%=type%>">Cancel</a></td>

                        <%} else {%>
                        <td></td>

                        <%}%></tr><%}
                                }
                            }
                        } else {
                        %>
                    <table align="center">
                        <tr align="center"><td><b>No Leave Requests available</b></td></tr>
                                    <%}%>
                    </table>
                </table>

                </body>
                </html>
