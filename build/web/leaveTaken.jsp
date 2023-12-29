<%--
    Document   : leaveTaken.jsp
    Created on : 22 Sep, 2010, 6:14:32 PM
    Author     : Tamilvelan
--%>
<%@page import="com.eminent.util.GetProjectMembers"%>
<%@page  import="org.apache.log4j.*,com.eminent.customer.CustomerUtil,java.text.SimpleDateFormat,java.util.HashMap,com.eminent.util.GetProjectManager"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">
<%
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Cache-Control", "no-store");
    response.setDateHeader("Expires", 0);
    response.setHeader("Pragma", "no-cache");

    Logger logger = Logger.getLogger("Leave Taken");
    String logoutcheck = (String) session.getAttribute("Name");
    if (logoutcheck == null) {
        logger.fatal("==============Session Expired===============");
%>
<jsp:forward page="../SessionExpired.jsp"></jsp:forward>
<%
    }

%>
<html>
    <meta name="keywords" content="GST in SAP, SAP GST Accelerator, GST Success in SAP, GST India in SAP, GST SAP Success, GST Suvidha Provider, GST ASP GSP, GST, CGST,SGST, IGST, UGST,  SAP NW based Product Development, SAP Consulting, SAP Implementation, SAP Support Services, SAP Outsourcing, SAP Implementation India, SAP Implementation Bangalore, SAP Implementation Chennai, SAP Implementation Belgium, SAP Implementation Paris, SAP Implemtation Australia, SAP Implementation France, SAP Implementation Mumbai, SAP Implementation Kerala, SAP Implementation Belgaum, SAP Implementation Thailand, SAP Implementation Mexico, SAP Implementation America">
    <meta http-equiv="Content-Type" content="text/html">
    <TITLE>eTracker&#153; - Eminentlabs&#153; CRM, APM, TQM,  ERM and  EPTS Solution</TITLE>
    <LINK title=STYLE href="<%= request.getContextPath()%>/eminentech support files/main_ie.css" type="text/css" rel="STYLESHEET">
</head>
<body>
    <jsp:useBean id="GetName" class="com.eminent.util.GetName"></jsp:useBean>
    <%@ include file="/header.jsp"%>
    <%
        try {
            String start = request.getParameter("start");
            String end = request.getParameter("end");
            String period = request.getParameter("period");
            int userId = Integer.parseInt(request.getParameter("userId"));
            String leaveRequest[][] = CustomerUtil.userLeave(userId, start, end);
            float leaveDays = 0f;
            leaveDays = CustomerUtil.getLeavedays(userId, start, end);
            SimpleDateFormat sdf = new SimpleDateFormat("dd-MMM-yy");
            SimpleDateFormat dateConversion = new SimpleDateFormat("yyyy-MM-dd");
                            SimpleDateFormat timestamp = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                SimpleDateFormat sdftimestamp = new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss");

            if (leaveRequest.length > 0) {
    %>
    <table width="100%">
        <tr bgcolor="#D8D8D8" align="left"><td width="100%" colspan="7" ><b> Leave Approval Management </b></td></tr>
        <tr height="10">
            <td colspan="11">
                <table width="100%">
                    <tr height="10">
                        <td align="left" width="100%">The total <b style="color: blue">Approved Leave Request</b> for the month of <b style="color: blue"> <%=period%></b> are <b style="color: blue"> <%=leaveDays%>.
                            </b></td>

                </table>
            </td>
        </tr>

        <tr bgcolor="#C3D9FF" height="9" align="left">
            <td width="10%"><font><b>Leave Type</b></font></td>
            <td width="10%"><font><b>RequestedBy</b></font></td>
            <td width="10%"><font><b>From Date </b></font></td>
            <td width="10%"><font><b>To Date </b></font></td>
            <td width="10%"><font><b>Approval Status</b></font></td>
            <td width="10%"><font><b>AssignedTo</b></font></td>
            <td width="10%"><font><b>Approver</b></font></td>
            <td width="15%"><font><b>Requested On</b></font></td>
            <td width="25%"><font><b>Approved On</b></font></td>

        </tr>

           <% HashMap<Integer, String> hm = new HashMap();
           HashMap<Integer, String> member = GetProjectMembers.showUsersSName();
                                        hm.put(0, "Yet to Approve");
                                        hm.put(1, "Approved");
                                        hm.put(-1, "Rejected");
                                        hm.put(-2, "Cancelled");
                                        String fDate = "NA";
                                        String tDate = "NA";
                                        String requestDate = "NA";
                                        String modifiedDate = "NA";
                                        String status = "Yet To Approve";

                                        for (int s = 0; s < leaveRequest.length; s++) {
                                            fDate = "NA";
                                            tDate = "NA";
                                            requestDate = "NA";
                                            modifiedDate = "NA";
                                            status = "Yet To Approve";
                                            String type = leaveRequest[s][0];
                                            String requester = leaveRequest[s][1];
                                            String approvalStatus = leaveRequest[s][2];
                                            String fromDate = leaveRequest[s][3];
                                            String toDate = leaveRequest[s][4];
                                            String requestedOn = leaveRequest[s][5];
                                            String assignedTo = leaveRequest[s][6];
                                            String approver = leaveRequest[s][7];
                                            String modifiedOn = leaveRequest[s][8];

                                            if (requestedOn != null) {
                                                fDate = sdf.format(dateConversion.parse(fromDate));
                                            }
                                            if (requestedOn != null) {
                                                tDate = sdf.format(dateConversion.parse(toDate));
                                            }
                                            if (requestedOn != null) {
                                                requestDate = sdftimestamp.format(timestamp.parse(requestedOn));
                                            }

                                            if (approvalStatus != null) {
                                                status = approvalStatus;
                                            }
                                            if (modifiedOn != null && !approvalStatus.equals("0")) {
                                                modifiedDate = sdftimestamp.format(timestamp.parse(modifiedOn));
                                            }

                                            assignedTo = GetName.getUserName(assignedTo);
                                            requester = GetName.getUserName(requester);
                                            if (approver != null) {
                                                approver = member.get(Integer.parseInt(approver));
                                            } else {
                                                approver = "NA";
                                            }
                                            String color = "";
                                            if ((s % 2) != 0) {
                                                color = "white";
                                            } else {
                                                color = "#E8EEF7";
                                            }

                                    %>
                                    <tr bgcolor="<%=color%>" align="left"><td><%=type%></td><td><%=requester.substring(0, requester.indexOf(" ") + 2)%></td><td><%=fDate%></td><td><%=tDate%></td><td><%=hm.get((Integer) Integer.parseInt(approvalStatus))%></td><td><%=assignedTo.substring(0, assignedTo.indexOf(" ") + 2)%></td><td><%=approver%></td><td><%=requestDate%></td><td><%=modifiedDate%></td></tr>
                                                     <%
                            }
                        }

                    } catch (Exception e) {
                        logger.error(e.getMessage());
                    }

                %>

    </table>
</body>
</html>
