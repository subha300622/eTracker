<%-- 
    Document   : timeSheetView
    Created on : Oct 30, 2009, 12:02:52 PM
    Author     : Administrator
--%>
<%@page import="com.eminentlabs.mom.MoMUtil"%>
<%@ page import="org.apache.log4j.*,com.eminent.util.GetProjectMembers,com.eminent.timesheet.Users,java.util.HashMap,java.util.Date,java.text.SimpleDateFormat,java.util.List,com.eminent.timesheet.CreateTimeSheet,com.eminent.timesheet.Timesheet,java.util.Iterator"%>
<%


        session.setAttribute("forwardpage","/MyTimeSheet/timeSheetList.jsp");



	//Configuring log4j properties
	

	Logger logger = Logger.getLogger("TimeSheet List");
	

	String logoutcheck=(String)session.getAttribute("Name");
	if(logoutcheck==null)
	{
		logger.fatal("=========================Session Expired======================");
		%>
<jsp:forward page="../SessionExpired.jsp"></jsp:forward>
<%
		//response.sendRedirect(request.getContextPath()+"/SessionExpired.jsp");
	}

%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">
<%@ include file="../header.jsp"%>
<html>
    <meta name="keywords" content="GST in SAP, SAP GST Accelerator, GST Success in SAP, GST India in SAP, GST SAP Success, GST Suvidha Provider, GST ASP GSP, GST, CGST,SGST, IGST, UGST,  SAP NW based Product Development, SAP Consulting, SAP Implementation, SAP Support Services, SAP Outsourcing, SAP Implementation India, SAP Implementation Bangalore, SAP Implementation Chennai, SAP Implementation Belgium, SAP Implementation Paris, SAP Implemtation Australia, SAP Implementation France, SAP Implementation Mumbai, SAP Implementation Kerala, SAP Implementation Belgaum, SAP Implementation Thailand, SAP Implementation Mexico, SAP Implementation America">
        <meta http-equiv="Content-Type" content="text/html">
        <title>eTracker&#153; - Eminentlabs&#153; CRM, APM, TQM,  ERM and  EPTS Solution</title>
        <LINK title=STYLE  href="<%= request.getContextPath() %>/eminentech support files/main_ie.css" type="text/css" rel="STYLESHEET">
        <script src="<%=request.getContextPath()%>/javaScript/jquery.js" type="text/javascript"></script>
<script src="<%=request.getContextPath()%>/javaScript/jquery.tablesorter.min.js" type="text/javascript"></script>
    <script type="text/javascript">

            $.tablesorter.addParser({ 
    // set a unique id 
    id: 'ddMMMyy', 
    is: function(s) { 
        // return false so this parser is not auto detected 
        return false; 
    }, 
    format: function(s) { 
        // parse the string as a date and return it as a number 
        return +new Date(s);
    }, 
    // set type, either numeric or text 
    type: 'numeric' 
});

$(document).ready(function()
            {
                $("#searchTable").tablesorter({
                     widgets     : ['zebra'],
                     widgetZebra : {css: ['zebraline', 'zebralinealter']},
                    // change the multi sort key from the default shift to alt button 
                    sortMultiSortKey: 'altKey'
                    
                });
            }
            );

        </script>   
    </head>
    <body>
       
       <table cellpadding="0" cellspacing="0" width="100%">
	<tr border="2" bgcolor="#E8EEF7">
		<td align="left"><b> TimeSheet Approval </b></td>

	</tr>
      
</table>
 <%
        try{
                int userId =(Integer)session.getAttribute("uid");
                int roleId =(Integer)session.getAttribute("uid");
                List l     =     null;
                if(userId!=GetProjectMembers.getAdminID()){
                     l =CreateTimeSheet.GetTimeSheet(userId);
                }else if(request.getParameter("userId")!=null){
                    userId=MoMUtil.parseInteger(request.getParameter("userId"),userId);
                    logger.info("----------->"+userId);
                    l =CreateTimeSheet.GetTimeSheet(userId);
                }else{
                     l =CreateTimeSheet.GetTimeSheet();
                }
                int noOfRecords =   l.size();

                HashMap<Integer,String> monthSelect = new HashMap<Integer,String>();

	  

	    monthSelect.put(0,"Jan");
	    monthSelect.put(1,"Feb");
	    monthSelect.put(2,"Mar");
	    monthSelect.put(3,"Apr");
	    monthSelect.put(4,"May");
	    monthSelect.put(5,"Jun");
	    monthSelect.put(6,"Jul");
	    monthSelect.put(7,"Aug");
	    monthSelect.put(8,"Sep");
	    monthSelect.put(9,"Oct");
	    monthSelect.put(10,"Nov");
	    monthSelect.put(11,"Dec");

	
 if(noOfRecords>0){
 %>
 <br>
<table width="100%">
	<tr height="10">
		<td align="left" width="100%">This list shows <b> <%=noOfRecords %></b> TimeSheet requests assigned to you.</td>
		
	</tr>
</table>
<br>
<table width="100%" id="searchTable" class="tablesorter">
    <thead>
    <tr bgcolor="#C3D9FF" width="100%">
        <th class="header" width="20%"><b>TimeSheetId</b></th>
        <th class="header" width="20%"><b>Owner</b></th>
        <th class="header" width="20%"><b>Period</b></th>
        <th class="header" width="20%"><b>Requested On</b></th>
        <th class="header" width="20%"><b>Status</b></th>
    </tr>
    </thead>
<%
     int k=0;
     for (Iterator i = l.iterator(); i.hasNext();k++ ) {
            Timesheet t =(Timesheet)i.next();
            String timesheet = t.getTimesheetid();
            String month     = timesheet.substring(1, 3);
            String year      = timesheet.substring(3,7);
            String timsheetUser   =   timesheet.substring(7,timesheet.length());

            java.util.Date date =t.getRequestedon();
            SimpleDateFormat sdf = new SimpleDateFormat("dd-MMM-yy HH:mm");
            String requestedOn  =   "NA";
            String status  =   "NA";
            if(date!=null){
                requestedOn  =   sdf.format(date);
            }

            Users user=t.getUsers();
            int userid =user.getUserid();

            Date d=t.getApprovedon();
 
            String accountStatus    =   t.getAccountstatus();
            String url=null;

            String timesheetPeriod  =   monthSelect.get(Integer.parseInt(month))+" "+year;
            
            if(t.getApprovalpercentage()==null&&t.getApprovedby()==null&&d==null){
                    url=request.getContextPath()+"/MyTimeSheet/timeSheetView.jsp?month="+month+"&year="+year+"&userId="+timsheetUser;
                    status = t.getApprovalstatus()==null?"Need Info":t.getApprovalstatus();
              }else if(t.getAttendenceupdatedby()==null&&t.getAttendance()==null){
                    status = "Attendance Approval";
                    url=request.getContextPath()+"/MyTimeSheet/hrView.jsp?userId="+userid+"&timeSheetId="+timesheet+"&period="+timesheetPeriod;
              }else if(accountStatus==null&&t.getAccountupdatedby()==null){
                    status = "Accounts Approval";
                    url=request.getContextPath()+"/MyTimeSheet/accountsView.jsp?userId="+userid+"&timeSheetId="+timesheet;
              }

%>
   <%
        if(( k % 2 ) != 0)                    
        {
        %>
	<tr class="zebralinealter" height="22">
		<%
            }
            else
            {
            %>
	
        <tr class="zebraline" height="22">
		<%
            }
            %>
        <td width="20%"><a href="<%=url%>"><%=timesheet%></a></td>
        <td width="20%"><%=GetProjectMembers.getUserName(((Integer)userid).toString())%></td>
        <td width="20%"><%=timesheetPeriod%></td>
        <td width="20%"><%=requestedOn%></td>
        <td width="20%"><%=status%></td>
    </tr>
<%
        }
}else{
%>
<jsp:forward page="/MyAssignment/UpdateIssue.jsp"></jsp:forward>
<%
}
            }catch(Exception e){
                logger.error(e.getMessage());
            }
%>
</table>
 </body>
</html>
