<%-- 
    Document   : myTimeWiseDashboard
    Created on : Oct 21, 2013, 2:34:47 PM
    Author     : E0288
--%>

<%@page import="pack.eminent.encryption.MakeConnection"%>
<%@page import="java.sql.Connection"%>
<%@page import="com.eminent.tqm.TestCasePlan"%>
<%@page import="com.eminent.leaveUtil.LeaveUtil"%>
<%@page import="com.eminentlabs.erm.ERMUtil"%>
<%@page import="com.eminentlabs.mom.MoMUtil"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<%@ page import="org.apache.log4j.*"%>
<%@ page import="com.eminent.util.GetProjectMembers"%>
<%@ page import="com.eminentlabs.appraisal.AppraisalUtil"%>
<%@page import="dashboard.*, java.applet.*,java.util.*,com.eminent.timesheet.ChartGeneration,com.eminent.timesheet.CreateTimeSheet"%>
<%@ include file="/header.jsp"%>
<%
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Cache-Control", "no-store");
    response.setDateHeader("Expires", 0);
    response.setHeader("Pragma", "no-cache");

    //Configuring log4j properties

    

    Logger logger = Logger.getLogger("myTimeWiseDashboard");
    

    String logoutcheck = (String) session.getAttribute("Name");
    if (logoutcheck == null) {

%>
<jsp:forward page="/SessionExpired.jsp"></jsp:forward>
<%    }
    

    //           String Values[][]=ChartGeneration.getValue(userId);
%>

<html>
    <meta name="keywords" content="GST in SAP, SAP GST Accelerator, GST Success in SAP, GST India in SAP, GST SAP Success, GST Suvidha Provider, GST ASP GSP, GST, CGST,SGST, IGST, UGST,  SAP NW based Product Development, SAP Consulting, SAP Implementation, SAP Support Services, SAP Outsourcing, SAP Implementation India, SAP Implementation Bangalore, SAP Implementation Chennai, SAP Implementation Belgium, SAP Implementation Paris, SAP Implemtation Australia, SAP Implementation France, SAP Implementation Mumbai, SAP Implementation Kerala, SAP Implementation Belgaum, SAP Implementation Thailand, SAP Implementation Mexico, SAP Implementation America">
        <meta http-equiv="Content-Type" content="text/html">
        <TITLE>eTracker&#153; - Eminentlabs&#153; CRM, APM, TQM,  ERM and  EPTS Solution</TITLE>
        <LINK title=STYLE href="<%= request.getContextPath()%>/eminentech support files/main_ie.css" type="text/css" rel="STYLESHEET">
                <script type="text/javascript" src="<%=request.getContextPath()%>/fusion/fusioncharts.js?version=30032016"></script>

<script type="text/javascript">
        function call(theForm)
        {
                var x=document.getElementById("userId").value;
                theForm.action='/eTracker/MyTimeSheet/myTimeWiseDashboard.jsp?userId='+x;
                theForm.submit();
        }
</script>
    </head>
    <body>
        <jsp:useBean id="ResourceRequest" class="com.eminent.resource.ResourceRequestBean" />
        <jsp:useBean id="CRMIssue" class="com.pack.CRMIssueBean" /> 
        <%            Connection connection    =   null;
        try{
        int userId_cuuri = (Integer) session.getAttribute("uid");
    int userId = 0;
    if (request.getParameter("userId") != null) {
        userId = MoMUtil.parseInteger(request.getParameter("userId"), userId_cuuri);
    }
    HashMap<Integer, String> eminentMember = GetProjectMembers.showUsers();
    HashMap<String,Integer> hm = dashboard.MaxIssue.getIssueCountForUser(String.valueOf(userId),String.valueOf(userId_cuuri));
        %>
        <table cellpadding="0" cellspacing="0" width="100%">
            <tr bgColor="#C3D9FF">
                <td bgcolor="#C3D9FF" align="left" width="100%"><font
                        size="4" COLOR="#0000FF"><b><%=eminentMember.get(userId)%> Time Wise Dashboard </b></font></td>
            </tr>
        </table>
        <table width="100%">
            <tr height="10">

                <%
                
                    connection   =MakeConnection.getConnection();
                    Map<String, Integer> issueList = ChartGeneration.myTimeWiseDashboardValues(userId, userId_cuuri);
                    String mail = (String) session.getAttribute("theName");
                    String url = null;

                    if (mail != null) {
                        url = mail.substring(mail.indexOf("@") + 1, mail.length());
                    }
                    int maxvalues = 0;
                    for (Map.Entry<String, Integer> entry : issueList.entrySet()) {
                        if (entry.getValue() > maxvalues) {
                            maxvalues = entry.getValue();
                        }
                    }
                    int maximum = maxvalues;

                    int yetToAdd = 10 - (maximum % 10);

                    int chartScale = (maximum + yetToAdd) / 10;

                %>
            </tr>
        </table>
            <table width="100%" >
	<tr height="10">
            		<td align="left" width="15%">This list shows <b> <%=( hm.get("altogether")) %> </b>issues assigned to <%

                if(userId==userId_cuuri||userId_cuuri==104){ %>You<%}else{%><%=eminentMember.get(userId)%>.<%}%></td>
		<%
                logger.info("Selected User"+userId);
                if(userId==userId_cuuri||userId_cuuri==104){
                    
                    int crmIssues=CRMIssue.getCRMIssues(connection,userId);
                    String for_ward="";
                    if(userId_cuuri==104){
                        for_ward=CRMIssue.getHigestCRMIssues(connection,userId,userId_cuuri);
                    }else{
                        for_ward=CRMIssue.getHigestCRMIssues(connection,userId,userId_cuuri);
                    }


            int resourceRequest=ResourceRequest.getResourceRequestNo(connection,userId);
            String leaveDetails[][]=LeaveUtil.waitingForApproval(userId);
            int noOfRequests    =   leaveDetails.length;
            List l =CreateTimeSheet.GetTimeSheet(userId);
            int noOfTimeSheet =   l.size();
            int ermAssignment   = ERMUtil.getAssignedApplicantCount(userId);
            int appraisalReq =   AppraisalUtil.getNoOfAppraisalRequest(userId);

           // List tce          =   TestCasePlan.listUserExecutionCountJDBC(user);
            int noOfTce      =   TestCasePlan.listUserExecutionCountJDBC(userId);
            if(resourceRequest>0){ %>
		<TD align="left" width="10%">You have <a href="<%=request.getContextPath()%>/ResourceRequest/viewResourceRequest.jsp "><%=resourceRequest %></a> ERM Issues</TD>
		<%}
         if(noOfTce>0){ %>
		<TD align="left" width="10%">You have <a href="<%=request.getContextPath()%>/MyAssignment/listTestCases.jsp?userId=<%=userId%>"><%=noOfTce %></a> Test Cases</TD>
		<%}
           if(crmIssues>0){ %>
		<TD align="left" width="10%">You have <a href="<%=request.getContextPath() %><%=for_ward%>"><%=crmIssues %></a> CRM Issues</TD>
		<%}
            if(noOfRequests>0){
                %>
                <TD align="left" width="10%">You have <a href="<%=request.getContextPath()%>/UserProfile/editLeaveRequest.jsp?userId=<%=userId%>"><%=noOfRequests %></a> Leave Requests</TD>
                <%
            }
             if(noOfTimeSheet>0){
                   %>
                   <TD align="left" width="10%">You have <a href="<%=request.getContextPath()%>/MyTimeSheet/timeSheetList.jsp?userId=<%=userId%> "><%=noOfTimeSheet%></a> TimeSheet Requests</TD>
                 <%
             }
            if(appraisalReq>0){
                   %>
                   <TD align="left" width="11%">You have <a href="<%=request.getContextPath()%>/MyAssignment/viewAppraisal.jsp "><%=appraisalReq%></a> Appraisal Request</TD>
                 <%
             }
            if(ermAssignment>0){
                   %>
                   <TD align="left" width="11%">You have <a href="<%=request.getContextPath()%>/ERM/assignedApplicants.jsp "><%=ermAssignment%></a> Candidate </TD>
                 <%
             }     
            }
                
                %>
		
		
	</tr>
</table>
    
    
     
    <%boolean member = GetProjectMembers.isBDMembers(userId);
        String totalPallateColors = "";
        if (url.equals("eminentlabs.net")) {
            totalPallateColors = "#58FA58";
            if (member) {
                totalPallateColors = totalPallateColors + "#6495ED,#B404AE,#DAA520,#800000";
            }
        } else {
            totalPallateColors = totalPallateColors + "FF8000,#58FA58,#088A08";
        }
    
   
   %>
    
   
   <script type="text/javascript">

                FusionCharts.ready(function () {
                var hourlySalesChart = new FusionCharts({
                type: 'msline',
                        renderAt: 'chart-container',
                        width: '990',
                        height: '450',
                        dataFormat: 'json',
                        dataSource: {

                        //Vertical divline configuration
                        "chart": {
                        "caption": "Time Wise Issues",
                                "xaxisname": "Month",
                                "showvalues": "0",
                                "paletteColors": "<%=totalPallateColors%>",
                                "bgColor": "#ffffff",
                                "showBorder":"0",
                                "showcanvasborder":"0",
                                "showXaxisline":"1",
                                "showYAxisline":"1",
                                "yAxisMinValue": "0",
                                "vDivLineColor": "#C3D9FF",
                                "numVDivLines": "10",
                                "numDivLines": "9",
                                "showAlternateHGridColor":"0",
                                "legendPosition":"RIGHT",
                                "exportEnabled": "1"

                        },
                                "categories": [
                                {"category": [
        <%

           int count=0;
               for (Map.Entry<String, Integer> entry : issueList.entrySet()) {
                    count++;
        %>
                                { "label": "<%=entry.getKey()%>" },
        <%}%>
            
                                ]
                                }
                                ],
        
                        "dataset": [
                            
        {"data": [

        <%  count=0;for (Map.Entry<String, Integer> entry : issueList.entrySet()) {
                    count++;
        if(count==1){
        %>
        { "value": "<%=entry.getValue()%>",
        "link":'<%= request.getContextPath()%>/MyTimeSheet/myTimeWiseIssues.jsp?assignmentType=backlog&userId=<%=userId%>,_self' },
   
   <%}else if(count==2){
        %>
        { "value": "<%=entry.getValue()%>",
        "link":'<%= request.getContextPath()%>/MyTimeSheet/myTimeWiseIssues.jsp?assignmentType=currentWeek&userId=<%=userId%>,_self'},
   
   <%}else{
        %>
        { "value": "<%=entry.getValue()%>",
        "link":'<%= request.getContextPath()%>/MyTimeSheet/myTimeWiseIssues.jsp?assignmentType=nextWeek&weekNumber=<%=count%>&userId=<%=userId%>,_self' },
   
   <%}}%>]},]},}).render();});
   </script>
               <div id="chart-container" class="chartarea"></div>

   
<form name="theForm" onSubmit='return fun(this)'>
<table width="100%" border="0" bgcolor="#E8EEF7" cellpadding="0"
	align="center">


	<tr>
        <td><font face="Book Antiqua"><b>Select Time Wise Dashboard of : </b></font></td>
		<td><select id="userId" name="userId" size=1 onchange="javascript:call(this.form)">
			<%
                                            int role  = (Integer)session.getAttribute("Role");
                                            ArrayList<String> al = null;
                                            if(role == 1){
                                                 al = CountIssue.getAllUsers();
                                            } else {
                                                 al = CountIssue.getSpecificUsers(String.valueOf(userId_cuuri));
                                            }
                                            String getUser = null;
                                            
                                            for(int i = 0;i < al.size();i+=2){
                                                
                                                getUser = al.get(i);
                                                logger.info(getUser+"compare"+userId);
                                                 if(getUser.equals(String.valueOf(userId))){
                                        %>
                <option value="<%= getUser %>" selected><%= al.get(i + 1) %>
			<%
                                           
                      
                                                 }else{
                                        %>
			
                <option value="<%= getUser %>"><%= al.get(i + 1) %> <%
                                                 }
                                            }
                                         %>
            </select>
		</td>
                <% if(url.equalsIgnoreCase("eminentlabs.net")){%>
                <td><a href="<%=request.getContextPath()%>/admin/dashboard/chartForUsers.jsp?userId=<%=userId%>">My Dashboard</a></td>
                <%}%>
                <td><font face="Book Antiqua"><b>Total</b>&nbsp;:&nbsp;<a href="<%=request.getContextPath()%>/admin/dashboard/userIssue.jsp?userId=<%=userId%>"><%= ( hm.get("altogether")) %></a></font></td>

	</tr>

</table>
<% }catch(Exception e){
                logger.error(e.getMessage());
            }finally{
                    if(connection!=null){
                        connection.close();
                    }
                }%>
</form>
</body>
<script src="//code.jquery.com/jquery-1.10.2.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/fusion/fusiontrailremover.js"></script>
</html>

