<%-- 
    Document   : updateCandidate
    Created on : Sep 7, 2013, 6:11:58 PM
    Author     : Tamilvelan
--%>

<%@page import="org.apache.log4j.Logger"%>
<%@page import="java.util.Map"%>
<%@page import="pack.eminent.encryption.MakeConnection"%>
<%@page import="java.sql.Connection"%>
<%@page import="com.eminent.timesheet.CreateTimeSheet"%>
<%@page import="com.eminent.leaveUtil.LeaveUtil"%>
<%@page import="com.eminent.tqm.TestCasePlan"%>
<%@page import="java.util.List"%>
<%@page import="com.eminent.util.UserIssueCount"%>
<%@page import="com.eminentlabs.erm.ERMUtil,java.util.HashMap,com.eminent.util.GetProjectMembers" %>
<%@ page import="dashboard.CurrentDay,com.eminent.util.SendMail,java.util.ArrayList" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">
<jsp:useBean id="CRMIssue" class="com.pack.CRMIssueBean" /> 
        <jsp:useBean id="ResourceRequest" class="com.eminent.resource.ResourceRequestBean" />
        <%!    Connection connection;
        %>
<%Logger logger = Logger.getLogger("updateCandidate");
try{
    connection = MakeConnection.getConnection();
    String comments     =   request.getParameter("comments");
    String applicantId  =   request.getParameter("applicantId");
    String statusId     =   request.getParameter("statusid");
    String assTo        =   request.getParameter("assignedto");

    int userId          =   (Integer)session.getAttribute("uid");
    ERMUtil.addERMComments(comments, userId, Integer.parseInt(statusId), userId,applicantId,Integer.parseInt(assTo));

    
    String name     =   request.getParameter("name");
    String location =   request.getParameter("location");
    String grad     =   request.getParameter("grd");
    String grdYear =   request.getParameter("gradyear");
    String percentage     =   request.getParameter("percentage");
    String areaofexpertise =   request.getParameter("areaofexpertise");
    String sapyears     =   request.getParameter("sapyears");
    String sapmonths =   request.getParameter("sapmonths");
    String totalyears     =   request.getParameter("totalyears");
    String totalmonths =   request.getParameter("totalmonths");
    
            
                        Map hm =new HashMap<Integer,String>();
                        hm=ERMUtil.ermApplicantStatus();
                         ArrayList<String> dateAndTime = CurrentDay.getDateTime();

    
  // Sending Mail to Gopal and Tamil
        String adminMail ="<table>"+

	"<tr>"+
		"<td colspan=4><b><font color=blue >Candidate Details</font></b></td>"+
	"</tr>"+
        "<tr bgcolor=#E8EEF7>"+
		"<td>Name</td><td>"+name+"</td>"+
                "<td>Location</td><td>"+location+"</td>"+
	"</tr>"+
	"<tr>"+
		"<td>Qualification</td><td>"+grad+"</td>"+
                "<td>Graduation Year</td><td>"+grdYear+"</td>"+
	"</tr>"+
	"<tr bgcolor=#E8EEF7>"+
                "<td>Percentage</td><td>"+percentage+"</td>"+
                "<td>Module</td><td>"+areaofexpertise+"</td>"+
	"</tr>"+
	"<tr  >"+
		"<td>SAP Experience</td><td>"+sapyears+"Y "+sapmonths+"M</td>"+
                "<td>Overall Experience</td><td>"+totalyears+"Y "+totalmonths+"M</td>"+
	"</tr>"+
        "<tr  bgcolor=#E8EEF7>"+
		"<td>Update By</td><td>"+GetProjectMembers.getUserName(((Integer)userId).toString()) +"</td>"+
                "<td>Assigned To</td><td>"+GetProjectMembers.getUserName(assTo) +"</td>"+
	"</tr>"+
        "<tr  >"+
		"<td>Status</td><td>"+hm.get(Integer.parseInt(statusId))+"</td>"+
                "<td>Updated On</td><td>"+dateAndTime.get(0)+" "+dateAndTime.get(1)+"</td>"+
	"</tr>"+
         "<tr bgcolor=#E8EEF7 >"+
		"<td>Comments</td>"+
                "<td colspan=3>"+comments+"</td>"+
	"</tr>"+
"</table>";
                       String endLine="</table><br>Thanks,";
                            String signature="<br>eTracker&trade;<br>";
                            String emi      =   "<br><b><a href=http://www.eminentlabs.com/>SAP GST Accelerator from Eminentlabs&trade; </a>&nbsp;-&nbsp;Readiness for GST and Audit ready of GST Reports!</b></br><br>ERPDS&trade;, EWE&trade;, eTracker&trade;, eOutsource&trade;, Rightshore&trade;, KPITracker&trade; are registered trademarks of Eminentlabs&trade; Software Private Limited<br>";
                            String lineBreak =  "<br>";

                            String htmlTableEnd="<br>For further details log on to <a href=http://www.eminentlabs.com/eTracker/login.jsp target=_new>eTracker&trade;</a>";
                            adminMail = adminMail+endLine+signature+htmlTableEnd+lineBreak+emi; 
                            String senderName = (String)session.getAttribute("fName")+" "+ (String)session.getAttribute("lName");
                             String content = "eTracker ERM "+hm.get(Integer.parseInt(statusId))+": "+applicantId;
                              try{
                         SendMail.ERMUpdation(senderName,adminMail,content,GetProjectMembers.getMail(assTo),GetProjectMembers.getMail(((Integer)userId).toString()));
                       }catch(Exception e){
                           logger.error(e.getMessage());
                       }
                String user=String.valueOf(userId);
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
    logger.error(e.getMessage());
}finally {

                            if (connection != null && !connection.isClosed()) {
                                connection.close();

                            }

                        }
%>
