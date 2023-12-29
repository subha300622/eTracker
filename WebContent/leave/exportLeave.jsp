<%-- 
    Document   : ExportLeave.jsp
    Created on : 2 Nov, 2015, 3:21:23 PM
    Author     : mukesh
--%>
<%@page import="com.eminent.leaveUtil.Leave"%>
<%@ page language="java"  contentType="application/vnd.ms-excel;" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*,pack.eminent.encryption.*"%>
<%@ page import="java.text.*"%>
<%@ page import="java.sql.Date"%>
<%@ page language="java"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.HashMap, java.text.*, org.apache.log4j.*"%>
<%@ page import="com.eminent.util.*, dashboard.CheckDate"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
    <meta name="keywords" content="GST in SAP, SAP GST Accelerator, GST Success in SAP, GST India in SAP, GST SAP Success, GST Suvidha Provider, GST ASP GSP, GST, CGST,SGST, IGST, UGST,  SAP NW based Product Development, SAP Consulting, SAP Implementation, SAP Support Services, SAP Outsourcing, SAP Implementation India, SAP Implementation Bangalore, SAP Implementation Chennai, SAP Implementation Belgium, SAP Implementation Paris, SAP Implemtation Australia, SAP Implementation France, SAP Implementation Mumbai, SAP Implementation Kerala, SAP Implementation Belgaum, SAP Implementation Thailand, SAP Implementation Mexico, SAP Implementation America">
        <TITLE>eTracker&#153; - Eminentlabs&#153; CRM, APM, TQM,  ERM and  EPTS
            Solution</TITLE>
        <META NAME="Generator" CONTENT="EditPlus">
        <META NAME="Author" CONTENT="">
        <META NAME="Keywords" CONTENT="">
        <META NAME="Description" CONTENT="">
        <style>
            td{
                border: 1px solid black;
                text-align: center;
            }
        </style>
    </HEAD>


    <BODY BGCOLOR="#FFFFFF">

        <jsp:useBean id="lrc" class="com.eminent.leaveUtil.LeaveRequestController"></jsp:useBean>

        <%
            String logoutcheck = (String) session.getAttribute("Name");
            if (logoutcheck == null) {
        %>
        <jsp:forward page="../SessionExpired.jsp"></jsp:forward>
        <%
            }
            response.setHeader("Content-Disposition", "attachment; filename=\"excelExport.xls\"");
            //Configuring log4j properties

            Logger logger = Logger.getLogger("excelExport");

            String requestPage = null;
            String fromdate = request.getParameter("fromDate");
            String todate = request.getParameter("toDate");
            requestPage = request.getParameter("export");
            if (requestPage.equals("leaveView")) {
                lrc.excelAll(fromdate, todate);
            }
        %>


        <TABLE width="100%">
            <tr bgColor="#C3D9FF">
                <td>Leave Type</td>
                <td>Requested By</td>
                <td >From Date</td>
                <td  >To Date</td>
                <td >Created On</td>
                <td >No of Leave Day</td>
                <td  >Assigned To</td>
                <td >Status</td>
                <td>Approved By</td>
            </tr>

            <%
                for (Leave leaveRequest : lrc.getLeaveRequests()) {
            %>
            <tr>                 
                <td ><a href="<%=request.getContextPath()%>/admin/user/leaveRequest.jsp?userId=<%=leaveRequest.getRequestedby()%>&leaveid=<%=leaveRequest.getLeaveid()%>" title="<%=leaveRequest.getDuration()%>"><%=leaveRequest.getType()%></a></td>
                <td ><%=GetProjectManager.getUserName(leaveRequest.getRequestedby().intValue())%></td>
                <td><%=leaveRequest.getFromdate()%></td>
                <td ><%=leaveRequest.getTodate()%></td>
                <td ><%=leaveRequest.getCreatedon()%></td>
                <td ><%=leaveRequest.getNoOfLeaveDays()%></td>
                <td ><%=GetProjectManager.getUserName(leaveRequest.getAssignedto().intValue())%></td>
                <td ><%=lrc.getLeaveStatus().get(leaveRequest.getApproval().intValue())%></td>
                <%if (leaveRequest.getApprover() == null) {%>
                <td >NA</td>
                <%} else {%>
                <td ><%=GetProjectManager.getUserName(leaveRequest.getApprover().intValue())%></td>
                <%}%>
            </tr>
            <%}%>
        </table>
    </BODY>
</html>

