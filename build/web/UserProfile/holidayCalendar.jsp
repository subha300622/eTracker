<%-- 
    Document   : leaveCalendar
    Created on : Jun 13, 2009, 9:46:41 AM
    Author     : Tamilvelan
--%>

<%@page import="com.eminent.leaveUtil.LeaveUtil"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.eminent.holidays.Holidays"%>
<%@page import="java.util.List"%>
<%@page import="java.util.GregorianCalendar"%>
<%@page import="java.util.Calendar"%>
<%@page import="com.eminent.holidays.HolidaysUtil"%>
<%@ page import="org.apache.log4j.*"%>

<%
    //Configuring log4j properties

    Logger logger = Logger.getLogger("Holiday Calendar");

    String logoutcheck = (String) session.getAttribute("Name");
    if (logoutcheck == null) {
%>
<jsp:forward page="../SessionExpired.jsp"></jsp:forward>
<%    }
%>
<%@ include file="../header.jsp"%> <br>
<html>
    <meta name="keywords" content="GST in SAP, SAP GST Accelerator, GST Success in SAP, GST India in SAP, GST SAP Success, GST Suvidha Provider, GST ASP GSP, GST, CGST,SGST, IGST, UGST,  SAP NW based Product Development, SAP Consulting, SAP Implementation, SAP Support Services, SAP Outsourcing, SAP Implementation India, SAP Implementation Bangalore, SAP Implementation Chennai, SAP Implementation Belgium, SAP Implementation Paris, SAP Implemtation Australia, SAP Implementation France, SAP Implementation Mumbai, SAP Implementation Kerala, SAP Implementation Belgaum, SAP Implementation Thailand, SAP Implementation Mexico, SAP Implementation America">
    <LINK title=STYLE	href="<%= request.getContextPath()%>/eminentech support files/main_ie.css" type=text/css rel=STYLESHEET>

    <meta http-equiv="Content-Type" content="text/html">

</head>
<body>
    <jsp:useBean id="mwd" class="com.eminent.branch.BranchController"></jsp:useBean>
    <%mwd.getAllBranchMap();%>
    <%
        int roleId = (Integer) session.getAttribute("Role");
        int assignedto = (Integer) session.getAttribute("userid_curr");
        int branch = (Integer) session.getAttribute("branch");
        String mail = (String) session.getAttribute("theName");
        SimpleDateFormat sdf = new SimpleDateFormat("dd-MMM-yyyy");
        SimpleDateFormat formatter = new SimpleDateFormat("EEEEEE");
        Calendar cu = new GregorianCalendar();
        int year = cu.get(Calendar.YEAR);
        String start = "01-Jan-" + year;
        String end = "31-Dec-" + year;
        Date startDate = sdf.parse(start);
        Date endDate = sdf.parse(end);
        List<Holidays> holidaysList = null;
        if (roleId == 1) {
            holidaysList = HolidaysUtil.findCalendarYearHolidays(startDate, endDate);
        } else {
            holidaysList = HolidaysUtil.findCalendarYearHolidaysByBranch(startDate, endDate, branch);

        }
        String leaveDetails[][] = LeaveUtil.waitingForApproval(assignedto);
        int noOfRequests = leaveDetails.length;

    %>
    <TABLE width="100%">

        <TR>
            <TD align="left"  bgcolor="#E8EEF7">
                <B>List of Eminent Holidays for <%=year%></B>
            </TD>
        </TR>

    </TABLE>

    <table>
        <tr>
            <td>
                <a href="employeeHandbook.jsp"> Employee Handbook</a>&nbsp;&nbsp;&nbsp;&nbsp;
                <a href="holidayCalendar.jsp"> Holiday Calendar</a>&nbsp;&nbsp;&nbsp;&nbsp;
                <a href="leaveRequest.jsp"> Leave Management</a>&nbsp;&nbsp;&nbsp;&nbsp;
                <%                            if (noOfRequests > 0) {
                %>
                <a href="editLeaveRequest.jsp"> Approve Leave</a>&nbsp;&nbsp;&nbsp;&nbsp;
                <%                }
                    if (assignedto == 104 || assignedto == 103 || roleId == 1) {%>
                <a href="<%=request.getContextPath()%>/admin/user/addHoliday.jsp">Holiday Maintenance</a>&nbsp;&nbsp;&nbsp;&nbsp;
                <a href="<%=request.getContextPath()%>/admin/user/branceMaintenance.jsp">Branch Maintenance</a>&nbsp;&nbsp;&nbsp;&nbsp;
                <a href="<%=request.getContextPath()%>/admin/user/leaveRequest.jsp">Leave  Request For User </a>&nbsp;&nbsp;&nbsp;&nbsp;
                <% }
                    if (assignedto == 112 || assignedto == 103 || assignedto == 104 || roleId == 4 || mail.equals("accounts@eminentlabs.net")) {%>
                <a href="<%=request.getContextPath()%>/leave/leaveView.jsp">Leaves </a>&nbsp;&nbsp;&nbsp;&nbsp;
                <a href="<%=request.getContextPath()%>/leave/LeaveViewByPeriod.jsp">Leaves Summary </a>&nbsp;&nbsp;&nbsp;&nbsp;
                <% }%>

            </td>

        </tr>
    </table>


    <br/>
    <br/>

    <table style="width: 50%;" >
        <tr style="background-color: #C3D9FF;font-weight: bold;height: 21px;">
            <td>SI.No</td>
            <td>Holiday Date</td>
            <td>Day</td>
            <td>Holiday Name</td>
            <td>Location</td>
        </tr>
        <%
            int i = 0;
            for (Holidays holidays : holidaysList) {

                if (i % 2 == 0) {%>
        <tr style="height: 21px;">  
            <%} else {%>
        <tr style="background-color: #E8EEF7;height: 21px;">
            <%}
                i++;
            %>
            <td><%=i%></td>
            <td><%=sdf.format(holidays.getHolidayDate())%></td>
            <td><%=formatter.format(holidays.getHolidayDate())%> </td>
            <td><%=holidays.getHolidayName()%></td>
            <td><%=mwd.getBranchMap().get(holidays.getBranchId())%> </td>

            <%}
            %>

        </tr>

    </table>
</body>
</html>
