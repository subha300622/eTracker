<%-- 
    Document   : viewLeave
    Created on : Jun 15, 2009, 9:40:02 AM
    Author     : Tamilvelan
--%>

<%@ page import="org.apache.log4j.*,java.text.*,java.util.*,com.eminent.util.*"%>

<%
    int requestedby = (Integer) session.getAttribute("userid_curr");

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
<%
    }
%>
<%@ include file="../header.jsp"%> <br>
<%@page import="com.eminent.leaveUtil.*"%>
<%@page import="java.util.List"%>
<html>
    <meta name="keywords" content="GST in SAP, SAP GST Accelerator, GST Success in SAP, GST India in SAP, GST SAP Success, GST Suvidha Provider, GST ASP GSP, GST, CGST,SGST, IGST, UGST,  SAP NW based Product Development, SAP Consulting, SAP Implementation, SAP Support Services, SAP Outsourcing, SAP Implementation India, SAP Implementation Bangalore, SAP Implementation Chennai, SAP Implementation Belgium, SAP Implementation Paris, SAP Implemtation Australia, SAP Implementation France, SAP Implementation Mumbai, SAP Implementation Kerala, SAP Implementation Belgaum, SAP Implementation Thailand, SAP Implementation Mexico, SAP Implementation America">
        <LINK title=STYLE	href="<%= request.getContextPath()%>/eminentech support files/main_ie.css" type=text/css rel=STYLESHEET>

        <meta http-equiv="Content-Type" content="text/html">

    </head>
    <body>
        <TABLE width="100%">

            <TR >
                <TD align="left"  bgcolor="#E8EEF7">
                    <B>View Leave</B>
                </TD>
            </TR>
        </TABLE>
        <%
            String leaveRequest[][] = LeaveUtil.waitingForApproval(requestedby);
            int noOfRequest = leaveRequest.length;
        %>
        <table>
            <tr>
                <td>
                    <a href="holidayCalendar.jsp"> Holiday Calendar</a>&nbsp;&nbsp;&nbsp;&nbsp;
                    <a href="employeeHandbook.jsp"> Employee Handbook</a>&nbsp;&nbsp;&nbsp;&nbsp;
                    <a href="leaveRequest.jsp">Leave Request</a>&nbsp;&nbsp;&nbsp;&nbsp;
                    <%
                        if (noOfRequest > 0) {
                    %>
                    <a href="waitingForApproval.jsp">Approve Leave</a>&nbsp;&nbsp;&nbsp;&nbsp;
                    <%
                        }
                        if (requestedby == 1189) {%>
                    <a href="<%=request.getContextPath()%>/leave/leaveView.jsp">Leaves </a>&nbsp;&nbsp;&nbsp;&nbsp;
                    <a href="<%=request.getContextPath()%>/leave/LeaveViewByPeriod.jsp">Leaves Summary </a>&nbsp;&nbsp;&nbsp;&nbsp;

                    <% }
                    %>
                </td>
            </tr>
        </table>
        <br>
        <br>
        <br>
        <%
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
        <table align="center">
            <tr bgcolor="#C3D9FF">
                <td><b>Leave Type</b></td>
                <td><b>From Date</b></td>
                <td><b>To Date</b></td>
                <td><b>Created On</b></td>
                <td><b>AsignedTo</b></td>
                <td><b>Status</b></td>

            </tr>

            <%                    for (int i = 0; i < noOfLeave; i++) {

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
                    String approve = hm.get(Integer.parseInt(leaveDetails[i][9]));

                    if ((i % 2) != 0) {
            %>
            <tr bgcolor="#E8EEF7" height="23">
                <%
                } else {
                %>

            <tr bgcolor="white" height="23">
                <%
                    }
                %>
                <td><a href="viewRequest.jsp?leaveid=<%=leaveId%>"><%=type%></a></td>
                <td><%=from%></td>
                <td><%=to%></td>
                <td><%=createdOn%></td>
                <td><%=GetProjectManager.getUserName(assignedto)%></td>
                <td><%=approve%></td>
            </tr>
            <%
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

