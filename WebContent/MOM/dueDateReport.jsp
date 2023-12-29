<%-- 
    Document   : dueDateReport
    Created on : Sep 15, 2014, 12:30:31 PM
    Author     : E0288
--%>

<%@page import="com.eminent.issue.formbean.DueDateTodayAndExceFormBean"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    String logoutcheck = (String) session.getAttribute("Name");
    if (logoutcheck == null) {
%>
<jsp:forward page="../SessionExpired.jsp"></jsp:forward>
<%
    }
%>
<html>
    <meta name="keywords" content="GST in SAP, SAP GST Accelerator, GST Success in SAP, GST India in SAP, GST SAP Success, GST Suvidha Provider, GST ASP GSP, GST, CGST,SGST, IGST, UGST,  SAP NW based Product Development, SAP Consulting, SAP Implementation, SAP Support Services, SAP Outsourcing, SAP Implementation India, SAP Implementation Bangalore, SAP Implementation Chennai, SAP Implementation Belgium, SAP Implementation Paris, SAP Implemtation Australia, SAP Implementation France, SAP Implementation Mumbai, SAP Implementation Kerala, SAP Implementation Belgaum, SAP Implementation Thailand, SAP Implementation Mexico, SAP Implementation America">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>eTracker&#153; - Eminentlabs&#153; CRM, APM, TQM,  ERM and  EPTS Solution</title>
        <LINK title=STYLE href="<%= request.getContextPath()%>/eminentech support files/main_ie.css" type="text/css" rel="STYLESHEET"> 
    </head>
    <body>
        <%@ include file="/header.jsp"%>
        <jsp:useBean id="pir" class="com.eminent.issue.formbean.PlannedIssueReport"></jsp:useBean>
                <jsp:useBean id="ddr" class="com.eminent.issue.controller.DueDateReport"></jsp:useBean>
        <jsp:useBean id="mas" class="com.eminent.issue.formbean.MyAsignmentIssues" /> 
        <jsp:useBean id="smmc" class="com.eminentlabs.mom.controller.SendMomMaintainController"></jsp:useBean>
        <%int wrmSize= mas.wrmIssues().size();%>
            <table cellpadding="0" cellspacing="0" width="100%">
                <tr border="2" bgcolor="#C3D9FF">
                    <td border="1" align="left" width="70%">
                        <font size="4" COLOR="#0000FF"><b>Due Date Report</b></font>
                    </td>
                </tr>
            </table>
        <%int assignedto = (Integer) session.getAttribute("userid_curr");
         smmc.getLocationNBranch(assignedto);%>
        <table cellpadding="0" cellspacing="0" width="100%">

            <tr>
                <td style="height: 25px;">
                    <a href="<%=request.getContextPath()%>/MOM/addTask.jsp"> Add Issue / Task</a>&nbsp;&nbsp;&nbsp;&nbsp;
                    <a href="<%=request.getContextPath()%>/MOM/viewTask.jsp" style="cursor: pointer;">View Issue / Task</a> &nbsp;&nbsp;&nbsp;
                    <%if (smmc.getSendMomMaintenance() != null && smmc.getSendMomMaintenance().getUserId() != null && smmc.getSendMomMaintenance().getUserId().intValue() == assignedto) {
                    %>
                    <a href="<%=request.getContextPath()%>/MOM/mom.jsp" style="cursor: pointer;">Send MOM</a> &nbsp;&nbsp;&nbsp;
                    <a href="<%=request.getContextPath()%>/MOM/plannedIssuesReport.jsp" style="cursor: pointer;">Planned Issue Report</a> &nbsp;&nbsp;&nbsp;
                    <a href="<%=request.getContextPath()%>/MOM/feedBackCommand.jsp" style="cursor: pointer;">FeedBack</a> &nbsp;&nbsp;&nbsp;
                    <a title="Fine Management" href="<%=request.getContextPath()%>/MOM/addFineAmtForUser.jsp" style="cursor: pointer;">Fine Mgmt</a> &nbsp;&nbsp;
                    <a href="<%=request.getContextPath()%>/MOM/projectWiseClosedReport.jsp" style="cursor: pointer;">PM'S Rank</a> &nbsp;&nbsp;&nbsp;
                    <%                 } else {
                    %>
                    <a href="<%=request.getContextPath()%>/MOM/fineAmtReort.jsp" style="cursor: pointer;">Fine Amount </a> &nbsp;&nbsp;&nbsp;
                    <a href="<%=request.getContextPath()%>/MOM/fineReport.jsp" style="cursor: pointer;">Fine Report</a> &nbsp;&nbsp;&nbsp;
                    <%}%>
                    <a href="<%=request.getContextPath()%>/MOM/weekPerformers.jsp" style="cursor: pointer;">Team Performance</a> &nbsp;&nbsp;&nbsp;
                    <a href="<%=request.getContextPath()%>/MOM/bestPMNTeam.jsp" style="cursor: pointer;">Best PM/Team</a> &nbsp;&nbsp;&nbsp;
                    <a href="<%=request.getContextPath()%>/MOM/dueDateReport.jsp" style="cursor: pointer; font-weight: bold;">DDR</a> &nbsp;&nbsp;&nbsp;
                    <a href="<%=request.getContextPath()%>/MOM/wrmIssues.jsp" style="cursor: pointer; ">WRM Issues (<%=wrmSize%>)</a> &nbsp;&nbsp;&nbsp;
                    <a href="<%=request.getContextPath()%>/Reimbursement/reimbursementUpload.jsp" style="cursor: pointer; ">Reimbursement</a> &nbsp;&nbsp;&nbsp;
                </td>
            </tr>
        </table>
        <br/>


    <%
       
       ddr.setAll();
            if (ddr.getFinalized() != null) {%>
        <p>The below list shows <b><%=ddr.getFinalized().size()%></b> projects have Due date exceeded / today issues  </p>
        <table style="width: 100%;">
            <tr style="height: 23px;background-color: #C3D9FF;font-weight: bold;">
                <td>Project Name</td>
                <td>Project Manager</td>
                <td>Due date Exceed Count</td>
                <td>Due date Today Count</td>
            </tr>

            <%int i = 0;
                for (DueDateTodayAndExceFormBean ddtaefb : ddr.getFinalized()) {

                    if ((i % 2) != 0) {
            %>
            <tr bgcolor="#E8EEF7" height="21">
                <%} else {%>
            <tr bgcolor="white" height="21">
                <%                    }
                        i++;%>
                <td><%=ddtaefb.getPname()%></td>
                <td><%=ddtaefb.getPmanager()%></td>
                <td style="text-align: right;color: red;"><%=ddtaefb.getExcCount()%></td>
                <td style="text-align: right;"><%=ddtaefb.getTodCont()%></td>
            </tr>
            <%}%>

        </table>
        <%} else {%>
        No Project have due date exceeded/due date today issues.
        <%}%>
    </body>
</html>
