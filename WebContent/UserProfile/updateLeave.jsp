<%--
    Document   : createLeave
    Created on : Jun 15, 2009, 11:36:07 AM
    Author     : Tamilvelan
--%>

<%@page import="com.eminentlabs.erm.ERMUtil"%>
<%@page import="com.eminent.timesheet.CreateTimeSheet"%>
<%@page import="com.eminent.tqm.TestCasePlan"%>
<%@page import="com.eminent.util.UserIssueCount"%>
<%@ page import="java.util.HashMap,com.eminent.util.SendMail,com.eminent.util.GetProjectManager,java.text.*,com.eminent.leaveUtil.*,org.apache.log4j.*,java.util.Date,java.util.Calendar,java.sql.Connection,java.sql.PreparedStatement,java.sql.Statement,java.sql.ResultSet,pack.eminent.encryption.MakeConnection,java.util.List"%>

<%
    //Configuring log4j properties

    Logger logger = Logger.getLogger("Update Leave");

    String logoutcheck = (String) session.getAttribute("Name");
    if (logoutcheck == null) {
%>
<jsp:forward page="../SessionExpired.jsp"></jsp:forward>
<%    }
%>

<html>
    <meta name="keywords" content="GST in SAP, SAP GST Accelerator, GST Success in SAP, GST India in SAP, GST SAP Success, GST Suvidha Provider, GST ASP GSP, GST, CGST,SGST, IGST, UGST,  SAP NW based Product Development, SAP Consulting, SAP Implementation, SAP Support Services, SAP Outsourcing, SAP Implementation India, SAP Implementation Bangalore, SAP Implementation Chennai, SAP Implementation Belgium, SAP Implementation Paris, SAP Implemtation Australia, SAP Implementation France, SAP Implementation Mumbai, SAP Implementation Kerala, SAP Implementation Belgaum, SAP Implementation Thailand, SAP Implementation Mexico, SAP Implementation America">
    <meta http-equiv="Content-Type" content="text/html">
</head>
<body>
    <jsp:useBean id="CRMIssue" class="com.pack.CRMIssueBean" /> 
    <jsp:useBean id="ResourceRequest" class="com.eminent.resource.ResourceRequestBean" />
    <%
        Connection connection = null;
        PreparedStatement stmt = null;

        String comments = request.getParameter("comments");
        String leaveId = request.getParameter("leaveid");
        String approval = request.getParameter("approval");
        String Type = request.getParameter("type");
        String duration = request.getParameter("duration");
        if (comments == null) {
            comments = "NA";
        }
        int app = Integer.parseInt(approval);
        String leaveDetails[][] = LeaveUtil.getEditRequest(Integer.parseInt(leaveId));
        if (duration == null) {
            duration = leaveDetails[0][12];
        }

        Date date = new Date();
        SimpleDateFormat sdf = new SimpleDateFormat("dd-MMM-yy");
        String mod_date = sdf.format(date);

        int userId = (Integer) session.getAttribute("uid");
        java.util.Date d = new java.util.Date();

        Calendar cal = Calendar.getInstance();
        Date dat = cal.getTime();
        java.sql.Timestamp timeStampDate = new java.sql.Timestamp(dat.getTime());
        int hour = cal.get(Calendar.HOUR_OF_DAY);
        int min = cal.get(Calendar.MINUTE);
        int sec = cal.get(Calendar.SECOND);
        String time = hour + ":" + min + ":" + sec;

        cal.setTime(d);

        int leaveid = Integer.parseInt(leaveId);
        int approvalLevel = 1;
        int assignedTo = Integer.parseInt(leaveDetails[0][7]);
        HashMap<Integer, String> hm = new HashMap<Integer, String>();
        hm.put(0, "Yet to Approve");
        hm.put(1, "Approved");
        hm.put(-1, "Rejected");
        hm.put(-2, "Cancelled");

        try {
            if (app == 1) {

                List<LeavApprovalHistory> approvalHistorys = LeaveApproverDAO.findByLeaveid(leaveid);
                List<LeaveApproverMaintenance> list = LeaveApproverDAO.findByRequester(assignedTo);
                if (list == null) {

                } else {
                    if (list.size() == 1) {
                    } else if (list.size() > 1) {
                        app = 0;
                        for (LeavApprovalHistory history : approvalHistorys) {
                            approvalLevel = history.getApprovallevel();
                        }
                      if (list.size() == approvalLevel) {
                            app = 1;
                        }
                        approvalLevel++;
                        for (LeaveApproverMaintenance lam : list) {
                            if (lam.getApprovalLevel() == approvalLevel) {
                                assignedTo = lam.getApprover();
                            }
                        }
                    }
                }
            }
            connection = MakeConnection.getConnection();
            stmt = connection.prepareStatement("update leave set approval=?,modifiedon=?,comments=?,type=?,approver=?,duration=?,assignedto=? where leaveid=?");
            stmt.setInt(1, app);
            stmt.setTimestamp(2, timeStampDate);
            stmt.setString(3, comments);
            stmt.setString(4, Type);
            stmt.setInt(5, userId);
            stmt.setString(6, duration);
            stmt.setInt(7, assignedTo);
            stmt.setInt(8, leaveid);
            stmt.executeUpdate();

            stmt = connection.prepareStatement("insert into LEAV_APPROVAL_HISTORY (LEAVEID,APPROVALLEVEL,APPROVER,UPDATEON,UPDATEDBY,COMMENTS) values(?,?,?,?,?,?)");
            stmt.setLong(1, leaveid);
            stmt.setInt(2, approvalLevel);
            stmt.setInt(3, assignedTo);
            stmt.setTimestamp(4, timeStampDate);
            stmt.setInt(5, userId);
            stmt.setString(6, comments);
            stmt.executeQuery();

            int i = 0;

            String fname = (String) session.getAttribute("fName");
            String lname = (String) session.getAttribute("lName");
            String Name = fname + " " + lname;
            String fromdate = leaveDetails[i][1];
            String todate = leaveDetails[i][2];
            String type = leaveDetails[i][3];
            String desc = leaveDetails[i][4];
            String createdon = leaveDetails[i][5];
            String modifiedon = leaveDetails[i][6];
            int requested = Integer.parseInt(leaveDetails[i][7]);
            int assignedto = Integer.parseInt(leaveDetails[i][8]);
            int approve = Integer.parseInt(leaveDetails[i][9]);
            String status = hm.get(app);
            String htmlContent = "<b><font face=Verdana, Arial, Helvetica, sans-serif size=2 color=blue>Leave Details</font></b><table align='center'>"
                    + "<tr bgcolor=#E8EEF7>"
                    + "<td ><b><font face=Verdana, Arial, Helvetica, sans-serif size=2 >From Date</b></td><td><font face=Verdana, Arial, Helvetica, sans-serif size=2 >" + fromdate + "</td><td><b><font face=Verdana, Arial, Helvetica, sans-serif size=2 >To Date</b></td><td><font face=Verdana, Arial, Helvetica, sans-serif size=2 >" + todate + "</td>"
                    + "</tr>"
                    + "<tr>"
                    + "<td><b><font face=Verdana, Arial, Helvetica, sans-serif size=2 >Leave Type</b></td><td><font face=Verdana, Arial, Helvetica, sans-serif size=2 >" + Type + "</td><td><b><font face=Verdana, Arial, Helvetica, sans-serif size=2 >Status</b></td><td><font face=Verdana, Arial, Helvetica, sans-serif size=2 >" + status + "</td>"
                    + "</tr>"
                    + "<tr bgcolor=#E8EEF7><td><b><font face=Verdana, Arial, Helvetica, sans-serif size=2 >Requested by</b></td><td><font face=Verdana, Arial, Helvetica, sans-serif size=2 >" + GetProjectManager.getUserName(requested) + "</td><td><b><font face=Verdana, Arial, Helvetica, sans-serif size=2 >Updated by</b></td><td><font face=Verdana, Arial, Helvetica, sans-serif size=2 >" + Name + "</td>"
                    + "</tr>"
                    + "<tr><td><b><font face=Verdana, Arial, Helvetica, sans-serif size=2 >Created On</b></td><td><font face=Verdana, Arial, Helvetica, sans-serif size=2 >" + createdon + "</td><td><b><font face=Verdana, Arial, Helvetica, sans-serif size=2 >Updated On</b></td><td><font face=Verdana, Arial, Helvetica, sans-serif size=2 >" + mod_date + " " + time + "</td>"
                    + "</tr>"
                    + "<tr  bgcolor=#E8EEF7>"
                    + "<td><b><font face=Verdana, Arial, Helvetica, sans-serif size=2 >Reason</b></td><td colspan=3><font face=Verdana, Arial, Helvetica, sans-serif size=2 >" + desc + "</td>"
                    + "</tr>"
                    + "<tr><td><b><font face=Verdana, Arial, Helvetica, sans-serif size=2 >Comments</b></td><td colspan=3><font face=Verdana, Arial, Helvetica, sans-serif size=2 >" + comments + "</td>"
                    + "</tr>"
                    + "</table>";

            String endLine = "</table><br>Thanks,";
            String signature = "<br>eTracker&trade;<br>";
            String emi = "<br><b><a href=http://www.eminentlabs.com/>SAP GST Accelerator from Eminentlabs&trade; </a>&nbsp;-&nbsp;Readiness for GST and Audit ready of GST Reports!</b></br><br>ERPDS&trade;, EWE&trade;, eTracker&trade;, eOutsource&trade;, Rightshore&trade;, KPITracker&trade; are registered trademarks of Eminentlabs&trade; Software Private Limited<br>";
            String lineBreak = "<br>";

            String htmlTableEnd = "<br>For further details log on to <a href=http://www.eminentlabs.com/eTracker/login.jsp target=_new>eTracker&trade;</a>";

            htmlContent = htmlContent + endLine + signature + emi + lineBreak + htmlTableEnd;

            String Subject = GetProjectManager.getUserName(requested) + " Leave Request " + status;

            SendMail.leaveMailUpdate(htmlContent, requested, assignedto, Name, Subject);

            if (status.equalsIgnoreCase("Approved") || status.equalsIgnoreCase("Cancelled")) {
                String leaveContent = "<b><font face=Verdana, Arial, Helvetica, sans-serif size=2 color=blue>Leave Details</font></b><table align='center'>"
                        + "<tr bgcolor=#E8EEF7>"
                        + "<td ><b><font face=Verdana, Arial, Helvetica, sans-serif size=2 >From Date</b></td><td><font face=Verdana, Arial, Helvetica, sans-serif size=2 >" + fromdate + "</td><td><b><font face=Verdana, Arial, Helvetica, sans-serif size=2 >To Date</b></td><td><font face=Verdana, Arial, Helvetica, sans-serif size=2 >" + todate + "</td>"
                        + "</tr>"
                        + "<tr>"
                        + "<td><b><font face=Verdana, Arial, Helvetica, sans-serif size=2 >Leave Type</b></td><td><font face=Verdana, Arial, Helvetica, sans-serif size=2 >" + Type + "</td><td><b><font face=Verdana, Arial, Helvetica, sans-serif size=2 >Status</b></td><td><font face=Verdana, Arial, Helvetica, sans-serif size=2 >" + status + "</td>"
                        + "</tr>"
                        + "<tr bgcolor=#E8EEF7><td><b><font face=Verdana, Arial, Helvetica, sans-serif size=2 >Requested by</b></td><td><font face=Verdana, Arial, Helvetica, sans-serif size=2 >" + GetProjectManager.getUserName(requested) + "</td><td><b><font face=Verdana, Arial, Helvetica, sans-serif size=2 >Updated by</b></td><td><font face=Verdana, Arial, Helvetica, sans-serif size=2 >" + Name + "</td>"
                        + "</tr>"
                        + "<tr><td><b><font face=Verdana, Arial, Helvetica, sans-serif size=2 >Created On</b></td><td><font face=Verdana, Arial, Helvetica, sans-serif size=2 >" + createdon + "</td><td><b><font face=Verdana, Arial, Helvetica, sans-serif size=2 >Updated On</b></td><td><font face=Verdana, Arial, Helvetica, sans-serif size=2 >" + mod_date + " " + time + "</td>"
                        + "</tr>"
                        + "<tr bgcolor=#E8EEF7 height=20><td colspan=4></td>"
                        + "</tr>"
                        + "</table>";
                leaveContent = leaveContent + endLine + signature + emi + lineBreak + htmlTableEnd;
                SendMail.leaveMailTeamUpdate(leaveContent, requested, assignedto, Name, Subject);
            }

            if (status.equalsIgnoreCase("Yet to Approve") ||status.equalsIgnoreCase("Approved") || status.equalsIgnoreCase("Rejected")) {
                String user = String.valueOf(userId);
                int assinmentNo = UserIssueCount.getAssignmentCount(user);
                List tce = TestCasePlan.listUserExecution(userId);
                int crmIssues = CRMIssue.getCRMIssues(connection, userId);
                int noOfTce = tce.size();
                String leaveDetailsa[][] = LeaveUtil.waitingForApproval(userId);
                int noOfRequests = leaveDetailsa.length;
                List l = CreateTimeSheet.GetTimeSheet(userId);
                int noOfTimeSheet = l.size();
                int ermAssignment = ERMUtil.getAssignedApplicantCount(userId);
                int resourceRequest = ResourceRequest.getResourceRequestNo(connection, userId);
                String for_ward = CRMIssue.getHigestCRMIssues(connection, userId, userId);
                System.out.println(noOfRequests);
                if (noOfRequests > 0) {%>
    <jsp:forward page="/UserProfile/editLeaveRequest.jsp"></jsp:forward>
    <%} else if (noOfTimeSheet > 0) {
    %>
    <jsp:forward page="/MyTimeSheet/timeSheetList.jsp"/>
    <%} else if (crmIssues > 0) {
    %>
    <jsp:forward page="<%=for_ward%>"/>
    <%} else if (assinmentNo > 0) {
    %>
    <jsp:forward page="/MyAssignment/UpdateIssue.jsp"/>
    <%} else if (noOfTce > 0) {
    %>
    <jsp:forward page="/MyAssignment/listTestCases.jsp"/>
    <%} else if (resourceRequest > 0) {
    %>
    <jsp:forward page="/ResourceRequest/viewResourceRequest.jsp"/>
    <%} else if (ermAssignment > 0) {
    %>
    <jsp:forward page="/ERM/assignedApplicants.jsp"/>
    <%} else {%>
    <jsp:forward page="/admin/dashboard/chartForUsers.jsp"/>
    <%}
    %>
    <%
    } else {
    %>
    <jsp:forward page="leaveRequest.jsp"></jsp:forward>
    <%        }

        } catch (Exception e) {
            e.printStackTrace();
            logger.error(e.getMessage());
        } finally {
            try {
                if (stmt != null) {
                    stmt.close();
                }

            } catch (Exception ex) {
                logger.error(ex.getMessage());
            }
            try {
                if (connection != null) {
                    connection.close();
                }

            } catch (Exception ex) {
                ex.printStackTrace();

                logger.error(ex.getMessage());
            }
        }

    %>
</body>
</html>
