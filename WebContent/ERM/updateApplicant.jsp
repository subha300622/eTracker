<%-- 
    Document   : updateApplicant
    Created on : Feb 28, 2014, 3:38:15 PM
    Author     : E0288
--%>

<%@page import="org.apache.log4j.PropertyConfigurator"%>
<%@page import="org.apache.log4j.Logger"%>
<%@page import="com.eminentlabs.erm.ERMUtil"%>
<%@page import="com.eminent.timesheet.CreateTimeSheet"%>
<%@page import="com.eminent.leaveUtil.LeaveUtil"%>
<%@page import="pack.eminent.encryption.MakeConnection"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.util.List"%>
<%@page import="com.eminent.tqm.TestCasePlan"%>
<%@page import="com.eminent.util.UserIssueCount"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <meta name="keywords" content="GST in SAP, SAP GST Accelerator, GST Success in SAP, GST India in SAP, GST SAP Success, GST Suvidha Provider, GST ASP GSP, GST, CGST,SGST, IGST, UGST,  SAP NW based Product Development, SAP Consulting, SAP Implementation, SAP Support Services, SAP Outsourcing, SAP Implementation India, SAP Implementation Bangalore, SAP Implementation Chennai, SAP Implementation Belgium, SAP Implementation Paris, SAP Implemtation Australia, SAP Implementation France, SAP Implementation Mumbai, SAP Implementation Kerala, SAP Implementation Belgaum, SAP Implementation Thailand, SAP Implementation Mexico, SAP Implementation America">
        <%
      
        Logger logger = Logger.getLogger("updateApplicant");
        

        String logoutcheck = (String) session.getAttribute("Name");
        if (logoutcheck == null) {
            logger.fatal("================Session expired===================");
    %>
    <jsp:forward page="../SessionExpired.jsp"></jsp:forward>
    <%
        }
    %>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <jsp:useBean id="CRMIssue" class="com.pack.CRMIssueBean" /> 
        <jsp:useBean id="ResourceRequest" class="com.eminent.resource.ResourceRequestBean" />
        <jsp:useBean id="up" class="com.eminentlabs.erm.UpdateApplicant"></jsp:useBean>
        <%!    Connection connection;
        %>
        <%
            try {
                connection = MakeConnection.getConnection();

                up.updateApplicant(request);
                int userId = (Integer) session.getAttribute("uid");
                String user = String.valueOf(userId);
                int assinmentNo = UserIssueCount.getAssignmentCount(user);
                List tce = TestCasePlan.listUserExecution(userId);
                int crmIssues = CRMIssue.getCRMIssues(connection, userId);
                int noOfTce = tce.size();
                String leaveDetails[][] = LeaveUtil.waitingForApproval(userId);
                int noOfRequests = leaveDetails.length;
                List l = CreateTimeSheet.GetTimeSheet(userId);

                int noOfTimeSheet = l.size();

                int ermAssignment = ERMUtil.getAssignedApplicantCount(userId);
                int resourceRequest = ResourceRequest.getResourceRequestNo(connection, userId);
                String for_ward = CRMIssue.getHigestCRMIssues(connection, userId, userId);

if(ermAssignment>0){
        %>
            <jsp:forward page="/ERM/assignedApplicants.jsp"/>
        <%}else if(noOfTimeSheet > 0){
        %>
        <jsp:forward page="/MyTimeSheet/timeSheetList.jsp"/>
        <%}else if(noOfRequests > 0){
        %>
            
        <jsp:forward page="/UserProfile/editLeaveRequest.jsp"/>
        <%}else if(crmIssues>0){
        %>
        <jsp:forward page="<%=for_ward%>"/>
        <%}else if(assinmentNo>0){ 
        %>
            <jsp:forward page="/MyAssignment/UpdateIssue.jsp"/>
        <%}else if(noOfTce>0){
        %>
            <jsp:forward page="/MyAssignment/listTestCases.jsp"/>
        <%}else if(resourceRequest>0){
        %>
            <jsp:forward page="/ResourceRequest/viewResourceRequest.jsp"/>
        <%}else{%>
            <jsp:forward page="/admin/dashboard/chartForUsers.jsp"/>
        <%}
}catch(Exception e){
e.printStackTrace();
    logger.error(e.getMessage());
}finally {

                            if (connection != null && !connection.isClosed()) {
                                connection.close();

                            }

                        }%>
    </body>
</html>
