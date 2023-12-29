<%--
    Document   : editLeave
    Created on : Jun 15, 2009, 9:40:02 AM
    Author     : Tamilvelan
--%>

<%@page import="java.util.HashMap"%>
<%@page import="com.eminentlabs.mom.MoMUtil"%>
<%@page import="java.util.LinkedHashMap"%>
<%@page import="java.util.Map"%>
<%@ page import="org.apache.log4j.*,java.text.*,com.eminent.util.*"%>

<%
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Cache-Control", "no-store");
    response.setDateHeader("Expires", 0);
    response.setHeader("Pragma", "no-cache");
    //Configuring log4j properties

    Logger logger = Logger.getLogger("View Leave");

    String logoutcheck = (String) session.getAttribute("Name");
    if (logoutcheck == null) {
%>
<jsp:forward page="../SessionExpired.jsp"></jsp:forward>
<%    }
%>
<%@ include file="../header.jsp"%> <br>
<%@page import="com.eminent.leaveUtil.*"%>
<%@page import="java.util.List"%>
<html>
    <meta name="keywords" content="GST in SAP, SAP GST Accelerator, GST Success in SAP, GST India in SAP, GST SAP Success, GST Suvidha Provider, GST ASP GSP, GST, CGST,SGST, IGST, UGST,  SAP NW based Product Development, SAP Consulting, SAP Implementation, SAP Support Services, SAP Outsourcing, SAP Implementation India, SAP Implementation Bangalore, SAP Implementation Chennai, SAP Implementation Belgium, SAP Implementation Paris, SAP Implemtation Australia, SAP Implementation France, SAP Implementation Mumbai, SAP Implementation Kerala, SAP Implementation Belgaum, SAP Implementation Thailand, SAP Implementation Mexico, SAP Implementation America">
    <script>
        function trim(str)
        {
            while (str.charAt(str.length - 1) == " ")
                str = str.substring(0, str.length - 1);
            while (str.charAt(0) == " ")
                str = str.substring(1, str.length);
            return str;
        }
        function textCounter(field, cntfield, maxlimit)
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
            var comments = document.theForm.comments.value;
            var leaveid = document.theForm.leaveid.value;
            var approval = 1;
            if (trim(document.theForm.comments.value) === '')
            {
                alert("Please Enter the comments for rejecting Leave ");
                document.theForm.comments.focus();
                return false;
            }

            document.theForm.action = "/eTracker/UserProfile/updateLeave.jsp?comments=" + comments + "&leaveid=" + leaveid + "&approval=" + approval;
            document.theForm.submit();
            leaveRejectSubmit();


        }
        function validateReject() {

            if (trim(document.theForm.comments.value) == '')
            {
                alert("Please Enter the comments for rejecting Leave ");
                document.theForm.comments.focus();
                return false;
            }
            var comments = document.theForm.comments.value;
            var leaveid = document.theForm.leaveid.value;
            var approval = -1;

            document.theForm.action = "/eTracker/UserProfile/updateLeave.jsp?comments=" + comments + "&leaveid=" + leaveid + "&approval=" + approval;
            leaveRejectSubmit();
            document.theForm.submit();
        }
        function validateCancel() {
            leaveCancelSubmit();
            var comments = document.theForm.comments.value;
            var leaveid = document.theForm.leaveid.value;
            var approval = -2;

            document.theForm.action = "/eTracker/UserProfile/updateLeave.jsp?comments=" + comments + "&leaveid=" + leaveid + "&approval=" + approval;
            document.theForm.submit();

        }

    </script>
    <script language=javascript
            src="<%= request.getContextPath()%>/javaScript/checkSubmit.js">
    </script>
    <LINK title=STYLE	href="<%= request.getContextPath()%>/eminentech support files/main_ie.css" type=text/css rel=STYLESHEET>
          <script type="text/javascript" src="<%= request.getContextPath()%>/javaScript/jquery.js"></script>
        <script type="text/javascript" src="<%= request.getContextPath()%>/javaScript/slide.js"></script>
        <script type="text/javascript" src="<%= request.getContextPath()%>/javaScript/tooltip.js"></script>
    <meta http-equiv="Content-Type" content="text/html">

</head>
<body>
    <%
        LinkedHashMap<String, String> avail = new LinkedHashMap<String, String>();
        avail.put("Casual Leave", "Casual");
        avail.put("Sick Leave", "Sick");
        avail.put("Privilege Leave", "Privilege");
        avail.put("Absent", "Absent");
        List<String> duerationList = LeaveUtil.durationList();
    %>


    <%
        int assignedTo = (Integer) session.getAttribute("userid_curr");

        if (request.getParameter("userId") != null) {
            assignedTo = MoMUtil.parseInteger(request.getParameter("userId"), assignedTo);
        }

        String leaveDetailsa[][] = LeaveUtil.waitingForApproval(assignedTo);

        HashMap<Integer, String> hm = new HashMap<Integer, String>();
        hm.put(0, "Yet to Approve");
        hm.put(1, "Approved");
        hm.put(-1, "Rejected");
        hm.put(-2, "Cancelled");

        int defaultleaveId = 0;
        int noOfLeave = leaveDetailsa.length;
        for (int j = 0; j < noOfLeave; j++) {
            defaultleaveId = Integer.parseInt(leaveDetailsa[j][0]);
        }
        logger.info("defaultleaveId" + defaultleaveId);


    %>
    <%            int leaveId = defaultleaveId;
        if (defaultleaveId != 0) {
            if (request.getParameter("leaveid") != null) {
                leaveId = MoMUtil.parseInteger(request.getParameter("leaveid"), defaultleaveId);
                boolean flag = true;
                for (int j = 0; j < noOfLeave; j++) {
                    int approveleaveid = Integer.parseInt(leaveDetailsa[j][0]);
                    if (approveleaveid == leaveId) {
                        if (flag == true) {
                            flag = false;
                        }
                    }
                }
                if (flag == true) {
                    leaveId = defaultleaveId;
                }
            }
        }
        logger.info("leaveId" + leaveId);
        if (leaveId != 0) {
            String leaveDetails[][] = LeaveUtil.getEditRequest(leaveId);
            int i = 0;

    %>


    <%            logger.info("Leave Id" + leaveDetails[i][0]);
        logger.info("From Date" + leaveDetails[i][1]);
        logger.info("To Date" + leaveDetails[i][2]);
        logger.info("Type" + leaveDetails[i][3]);
        logger.info("Desc" + leaveDetails[i][4]);
        logger.info("Requested" + leaveDetails[i][7]);
        logger.info("Assigned to" + leaveDetails[i][8]);
        logger.info("Approval" + leaveDetails[i][9]);

        String from = leaveDetails[i][1];
        String to = leaveDetails[i][2];
        String createdOn = leaveDetails[i][5];
        String type = leaveDetails[i][3];
        String desc = leaveDetails[i][4];
        int requested = Integer.parseInt(leaveDetails[i][7]);
        Map<String,Float> leaveTypeDetails = LeaveUtil.leaveDetailsByUser(requested,GetProjectMembers.getBranchId(requested));
        int assignedto = Integer.parseInt(leaveDetails[i][8]);
        int approve = Integer.parseInt(leaveDetails[i][9]);
        String comments = leaveDetails[i][10];
        String duration = leaveDetails[i][12];
        String noOFDay = leaveDetails[i][13];

       LinkedHashMap<String, String> leaveType = LeaveUtil.hrLeaveTypes(); 

float privilageLeaveNo = LeaveBlancePeriodDAO.getPrivilegeLeave(requested);
             String leaveHisDetails[][] = LeaveUtil.getLeave(requested);

    %>
    <TABLE width="100%">

        <TR >
            <TD align="left"  bgcolor="#E8EEF7">
                <B>View Leave of <%=GetProjectManager.getUserName(requested)%></B>&nbsp;&nbsp;
                <%if(leaveHisDetails.length>1){%>
                <a href="#" onclick="collapse('FAL<%=leaveId%>', 150);return false;"  class="trigger" >View History</a>
                <%}%>
            </TD>
        </TR>
    </TABLE>
    <%
        int requestedby = (Integer) session.getAttribute("userid_curr");
        String leaveRequest[][] = LeaveUtil.waitingForApproval(requestedby);
        int noOfRequest = leaveRequest.length;%>
    <table style="width: 100%;">
        <tr><td style="width: 60%;">
                <table >
                    <tr>
                        <td>
                            <a href="<%=request.getContextPath()%>/UserProfile/employeeHandbook.jsp">Employee Handbook </a>&nbsp;&nbsp;&nbsp;&nbsp;
                            <a href="<%=request.getContextPath()%>/UserProfile/holidayCalendar.jsp">Holiday Calendar</a>&nbsp;&nbsp;&nbsp;&nbsp;
                            <a href="<%=request.getContextPath()%>/UserProfile/leaveRequest.jsp" > Leave Request</a>&nbsp;&nbsp;&nbsp;&nbsp;
                            <%
                                if (noOfRequest > 0) {
                            %>
                            <a href="<%=request.getContextPath()%>/UserProfile/editLeaveRequest.jsp" style="font-weight: bold;">Approve Leave</a>&nbsp;&nbsp;&nbsp;&nbsp;
                            <%                         }
                                if (assignedto == 1189 || assignedto == 104) {%>
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

    <form name="theForm"  method="post">
        <table bgcolor="E8EEF7"  style="width: 100%;">
            <tr>
                <td style="width: 14%;"><B>From</B></td>
                <td style="width: 15%;"><input type="text" id="fromdate" name="fromdate" value="<%=from%>" maxlength="10" size="14" readonly  /></td>
                <td style="width: 14%;"><B>To</B></td>
                <td style="width: 15%;"><input type="text" id="todate" name="todate" value="<%=to%>" maxlength="10" size="14" readonly  /></td>
                <td style="width: 14%;"><b>Type</b></td>
                <td style="width: 15%;">
                    <select name="type">
                       <option value="--Select One--">--Select One--</option>
                            <%for (Map.Entry entry : leaveType.entrySet()) {
                                    if (entry.getValue().equals(type)) {%>  
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
                <td><select name="duration" id="duration" <%if (!from.equals(to)) {%>

                            <%}%>>
                        <%for (String dura : duerationList) {
                                if (duration.equalsIgnoreCase(dura)) {%>
                        <option value="<%=duration%>" selected><%=duration%></option>
                        <%} else {%>
                        <option value="<%=dura%>"><%=dura%></option>
                        <%}
                            }%>  
                    </select></td>
                <td><b>Requested On</b></td>
                <td ><%=createdOn%></td>
            </tr>
            <tr>
                <td><b>Reason for Leave</b></td>
                <td colspan="3"><%=desc%></td>
            </tr>
         

            <tr>
                <td><b>Comments</b></td>

                <td colspan="5">
                    <font size="2"
                          face="Verdana, Arial, Helvetica, sans-serif"> <textarea
                          name="comments" id="comments" wrap="physical" cols="60" rows="2"
                          onKeyDown="textCounter(document.theForm.comments, document.theForm.remLen1, 2000);"
                          onKeyUp="textCounter(document.theForm.comments, document.theForm.remLen1, 2000);" style="width: 86%;" ></textarea></font>
                <input readonly type="text" style="vertical-align: super;"
                                    name="remLen1" size="3" maxlength="3" value="2000"></td>

            </tr>
           
   <%                List<LeavApprovalHistory> approvalHistorys = LeaveApproverDAO.findByLeaveid(leaveId);
                if (!approvalHistorys.isEmpty()) {
                    if(approvalHistorys.size()>1){
            %>
            <tr>
                <td colspan="4">
                    <table align="left" style="width: 100%;">
                        <tr bgcolor="#C3D9FF">
                            <td><b>Updated On</b></td>
                            <td><b>Comments</b></td>
                            <td><b>Updated By</b></td>
                        </tr>
                        <%                 int k = 0;
                            for (LeavApprovalHistory lah : approvalHistorys) {
                                if(k!=0){
                                if ((k % 2) != 0) { 
                                    
                        %>
                        <tr bgcolor="#E8EEF7" >
                            <% } else {%>
                        <tr bgcolor="white" >
                            <%  }%>
                            <td><%=lah.getUpdateon()%></td>
                            <td><%=lah.getComments()%></td>
                            <td><%=GetProjectManager.getUserName(lah.getUpdatedby())%></td>
                        </tr>
                        <%}k++;}%>
                    </table>
                </td>
            </tr>
            <%}}%>
            <tr>

                <%
                    int currentuser = (Integer) session.getAttribute("userid_curr");

                    if (requested != currentuser) {%>
                <td align="right"colspan="2">         <input type="submit" value="Approve" id="submit1" onclick="validateApprove('approve')"/><input type="submit" Value="Reject" id="reject"onclick="return validateReject('approve')"/></td>
                    <%} else {%>
                <td align="right" colspan="2"><input type="submit" value="Cancel Leave" id="submit1" onclick="validateCancel('approve')"/></td>
                    <%}%>
            </tr>
            <tr><td><input type="hidden" name="leaveid" value="<%=leaveId%>"></td></tr>
        </table>
            <div id="FAL<%=leaveId%>" class="hide_me" >
                <%if(leaveHisDetails.length>1){%>
             <table  style="width: 100%;">
                 <tr>
                     <th rowspan="<%=(leaveHisDetails.length)+1%>">Leave History of <%=GetProjectManager.getUserName(requested)%></th>
                 </tr>
                <tr bgcolor="#C3D9FF">
                    <td ><b>Leave Type</b></td>
                    <td ><b>From Date</b></td>
                    <td ><b>To Date</b></td>
                    <td ><b>Created On</b></td>
                    <td ><b>No of Leave days</b></td>
                    <td ><b>Status</b></td>
                </tr>
                 <%
                    int count = 0;
                    for ( int j = 0; j < leaveHisDetails.length; j++) {
if(Integer.parseInt(leaveHisDetails[j][0])!=leaveId){
                         from = leaveHisDetails[j][1];
                         to = leaveHisDetails[j][2];
                         type = leaveHisDetails[j][3];
                        createdOn = leaveHisDetails[j][5];
                        
                        
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
                    <td><%=type%></td>
                    <td><%=from%></td>
                    <td><%=to%></td>
                    <td><%=createdOn%></td>
                    <td><%=leaveHisDetails[j][13]%></td>
                    <td><%=hm.get(Integer.parseInt(leaveHisDetails[j][9]))%></td>
                   
                    

                  
                </tr>
                  <%}}%>
             </table>
              
               <%}%>
            </div>
        <%}%>
        <table align="left" style="width: 100%;">
            <tr bgcolor="#C3D9FF">
                <td><b>Leave Type</b></td>
                <td><b>From Date</b></td>
                <td><b>To Date</b></td>
                <td><b>Created On</b></td>
                <td><b>No of Leave Days</b></td>
                <td><b>RequestedBy</b></td>
                <td><b>Status</b></td>

            </tr>

            <%
                for (int j = 0; j < noOfLeave; j++) {

                    logger.info("Leave Id" + leaveDetailsa[j][0]);
                    logger.info("From Date" + leaveDetailsa[j][1]);
                    logger.info("To Date" + leaveDetailsa[j][2]);
                    logger.info("Type" + leaveDetailsa[j][3]);
                    logger.info("Desc" + leaveDetailsa[j][4]);
                    logger.info("Requested" + leaveDetailsa[j][7]);
                    logger.info("Assigned to" + leaveDetailsa[j][8]);
                    logger.info("Approval" + leaveDetailsa[j][9]);

                    int leaveIda = Integer.parseInt(leaveDetailsa[j][0]);
                    String froma = leaveDetailsa[j][1];
                    String toa = leaveDetailsa[j][2];
                    String createdOna = leaveDetailsa[j][5];
                    String typea = leaveDetailsa[j][3];
                    String desca = leaveDetailsa[j][4];

                    int requesteda = Integer.parseInt(leaveDetailsa[j][7]);
                    int assignedtoa = Integer.parseInt(leaveDetailsa[j][8]);
                    String approvea = hm.get(Integer.parseInt(leaveDetailsa[j][9]));
                    String commentsa = leaveDetailsa[j][10];
                    String durationa = leaveDetailsa[j][11];
                    String noFDay = leaveDetailsa[j][12];

                    if ((j % 2) != 0) {
            %>
            <tr bgcolor="#E8EEF7" height="23">
                <%                                } else {
                %>

            <tr bgcolor="white" height="23">
                <%                                     }
                %>
                <td><a href="<%=request.getContextPath()%>/UserProfile/editLeaveRequest.jsp?leaveid=<%=leaveIda%>&userId=<%=assignedTo%>" title="<%=durationa%>"><%=typea%></a></td>
                <td><%=froma%></td>
                <td><%=toa%></td>
                <td><%=createdOna%></td>
                <td><%=noFDay%></td>
                <td><%=GetProjectManager.getUserName(requesteda)%></td>
                <td><%=approvea%></td>
            </tr>
            <%
                }
                if (noOfLeave < 1) {
            %>

            <%    }
            %>


        </table>
    </form>

</body>
</html>

