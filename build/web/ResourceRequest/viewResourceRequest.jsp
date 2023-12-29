<%@page import="com.eminentlabs.erm.ERMUtil"%>
<%@page import="com.eminent.timesheet.CreateTimeSheet"%>
<%@page import="com.eminent.leaveUtil.LeaveUtil"%>
<%@page import="com.eminent.tqm.TestCasePlan"%>
<%@ page language="java" contentType="text/html"
	pageEncoding="UTF-8" import="com.eminent.util.*,java.util.*,org.apache.log4j.*,java.util.Calendar,javax.mail.*,javax.mail.internet.*,javax.mail.internet.MimeMessage"%>
<%
    String logoutcheck=(String)session.getAttribute("Name");
	if(logoutcheck==null)
	{
%>
<jsp:forward page="../SessionExpired.jsp"></jsp:forward>
<%
	}
        Logger logger = Logger.getLogger("Resource Request View");
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<meta name="keywords" content="GST in SAP, SAP GST Accelerator, GST Success in SAP, GST India in SAP, GST SAP Success, GST Suvidha Provider, GST ASP GSP, GST, CGST,SGST, IGST, UGST,  SAP NW based Product Development, SAP Consulting, SAP Implementation, SAP Support Services, SAP Outsourcing, SAP Implementation India, SAP Implementation Bangalore, SAP Implementation Chennai, SAP Implementation Belgium, SAP Implementation Paris, SAP Implemtation Australia, SAP Implementation France, SAP Implementation Mumbai, SAP Implementation Kerala, SAP Implementation Belgaum, SAP Implementation Thailand, SAP Implementation Mexico, SAP Implementation America">
<meta http-equiv="Content-Type" content="text/html ">
<TITLE>eTracker&#0153; - Eminentlabs CRM,APM,ERM and EPTS Solution</TITLE>
<LINK title=STYLE href="<%= request.getContextPath()%>/eminentech support files/main_ie.css?test=261020151225" type="text/css" rel="STYLESHEET">
        <script src="<%=request.getContextPath()%>/javaScript/XMLHttpRequest.js" type="text/javascript"></script>
        <script type="text/javascript" src="<%= request.getContextPath()%>/javaScript/fileAttach.js"></script></head>
<body>
<%@ include file="../header.jsp"%>
<%
          int role  =  (Integer) session.getAttribute("Role");
%>
<table cellpadding="0" cellspacing="0" width="100%">
	<tr border="2" bgcolor="#E8EEF7">
		<td bgcolor="#C3D9FF" border="1" align="left"><font size="4"
			COLOR="#0000FF"> <b> <%if(role==2){%>Assigned<%}%> Resource Requisition</b></font><FONT SIZE="3"
			COLOR="#0000FF"> </FONT></td>
		
		
	</tr>

</table>
<jsp:useBean id="CRMIssue" class="com.pack.CRMIssueBean" />
<jsp:useBean id="ResourceRequest" class="com.eminent.resource.ResourceRequestBean" /> 
		<%@ page import="java.sql.*,pack.eminent.encryption.*,com.pack.StringUtil,java.text.*"%>
<%!

        String recipientMobile,recipientOperator,from,subject,host;
		int requestpage,pageone,pageremain,rowcount,age;
		static int totalpage,pagemanipulation,presentpage,extra,issuenofrom,issuenoto;
%>
		<%
                 session.setAttribute("forwardpage","/ResourceRequest/viewResourceRequest.jsp");
		Connection connection 		=	null;
        PreparedStatement 	ps		=	null;
        ResultSet rs				=	null;
        
        String requestid			=	null;
		String project				=	null;
		String team					=	null;
		String position				=	null;
		String skillset				=	null;
		String responsibility_p1	=	null;
		String responsibility_p2	=	null;
		String responsibility_p3	=	null;
        String responsibility_p4	=	null;
		String responsibility_p5	=	null;
		String responsibility_s1	=	null;
        String responsibility_s2	=	null;
		String responsibility_s3	=	null;
		String responsibility_s4	=	null;
		String responsibility_s5	=	null;
		
		String createdon			=	null;
        String modifiedon			=	null;
        
        String createdby			=	null;
        String assignedto			=	null;
               	
    	String duedate				=	null;
    	String exp_years			=	null;
    	String exp_months			=	null;
    	String status				=	null;
    	java.sql.Date dueDateFormat =   null;
    	java.sql.Date created		=   null;
    	java.sql.Date modified		=   null;
    	
    	try{
    		connection=MakeConnection.getConnection();
    		if(connection!=null){
    			
    			Integer userid_curr =(Integer)session.getAttribute("userid_curr");
    			int userid_curri= userid_curr.intValue();
    			
    			logger.info("Reso");
    			 
    		rs=ResourceRequest.getResourceRequest(connection,userid_curri);
    		rs.last();
			rowcount = rs.getRow();
                        String user=String.valueOf(userid_curri);
            int assinmentNo = UserIssueCount.getAssignmentCount(user);
            List tce = TestCasePlan.listUserExecution(userid_curri);
            int crmIssues = CRMIssue.getCRMIssues(connection, userid_curri);
            int noOfTce = tce.size();
            String leaveDetails[][] = LeaveUtil.waitingForApproval(userid_curri);
            int noOfRequests = leaveDetails.length;
            List l = CreateTimeSheet.GetTimeSheet(userid_curri);
            int noOfTimeSheet = l.size();
            int ermAssignment = ERMUtil.getAssignedApplicantCount(userid_curri);
            int resourceRequest = ResourceRequest.getResourceRequestNo(connection, userid_curri);
            String for_ward = CRMIssue.getHigestCRMIssues(connection, userid_curri, userid_curri);
            logger.info("noOfRequests"+noOfRequests);
            
            if(rowcount>0){
			rs.beforeFirst();
			
			pageone = rowcount/15;
			pageremain=rowcount%15;
// Pagination Starts Here
			logger.debug("Total No of records:"+rowcount);
			if(pageremain>0)
			{
				totalpage=pageone+1;
			}
			else
			{
				totalpage=pageone;	
			}
			logger.debug("Total no of pages"+totalpage);
			try
			{
				String requestpag=request.getParameter("manipulation");
				logger.debug("Requested page"+requestpag);
				if(requestpag!=null)
				{
					requestpage=Integer.parseInt(requestpag);
					if(requestpage==1)
					{
						presentpage=1;
						issuenofrom=1;
						issuenoto=issuenofrom+14;
						if(issuenoto>rowcount)
						{
						    extra=issuenoto-rowcount;
						    issuenoto=issuenoto-extra;
						}
						rs.beforeFirst();
						logger.debug("Requested page First"+presentpage);					
					}
					if(requestpage==2)
					{
						presentpage=presentpage-1;
						if(presentpage<=0)
						{
							presentpage=1;
						}
						if(presentpage==1)
						{
							rs.beforeFirst();
							issuenofrom=1;
							issuenoto=issuenofrom+14;
							if(issuenoto>rowcount)
							{
							    extra=issuenoto-rowcount;
							    issuenoto=issuenoto-extra;
							}
						}
						else
						{
						    issuenofrom=((presentpage-1)*15+1);
							rs.absolute(issuenofrom-1);	
							issuenoto=issuenofrom+14;
							if(issuenoto>rowcount)
							{
							    extra=issuenoto-rowcount;
							    issuenoto=issuenoto-extra;
							}						
						}
						logger.debug("Requested page Prev"+presentpage);					
					}
					if(requestpage==3)
					{
						presentpage=presentpage+1;
						if(presentpage>=totalpage)
						{
							presentpage=totalpage;
						}
						issuenofrom=((presentpage-1)*15+1);
						rs.absolute(issuenofrom-1);	
						logger.debug("Requested page Next"+presentpage);		
						issuenoto=issuenofrom+14;
						if(issuenoto>rowcount)
						{
						    extra=issuenoto-rowcount;
						    issuenoto=issuenoto-extra;
						}				
					}
					if(requestpage==4)
					{
					
						presentpage=totalpage;
						logger.debug("Requested page Last"+presentpage);			
						issuenofrom=((presentpage-1)*15+1);
						rs.absolute(issuenofrom-1);	
						issuenoto=issuenofrom+14;
						if(issuenoto>rowcount)
						{
						    extra=issuenoto-rowcount;
						    issuenoto=issuenoto-extra;
						}
					}
				}
				else
				{
                    presentpage=1;
					if(rowcount>0)
                    {
                        issuenofrom=1;
                    }
                    else
                    {
                          issuenofrom=0;
                    }
					rs.beforeFirst();
					issuenoto=issuenofrom+14;
					if(issuenoto>rowcount)
					{
					    extra=issuenoto-rowcount;
					    issuenoto=issuenoto-extra;
					}
				}
		   }
		   catch(Exception pagination)
		   {
		   		logger.error("pagination Exception:"+pagination);
		   }
//Pagination Ends here


%>
<table width="100%" >

<tr><td align="left" width="50%" colspan="4">This list shows <b> <%=rowcount %> </b> resource requisitions.</td> <td align="left" width="10%" ><a href="<%=request.getContextPath() %>/ResourceRequest/createRequest.jsp">Create Request</a></td>
		
		
		<TD align="right" width="25" ></td>
		<td align="right" colspan="3">Issues <%=issuenofrom %>-<%=issuenoto %></td></tr>
<TR bgcolor="#C3D9FF" height="21">
		<TD width="11%"><font><b>Request ID</b></font></TD>
		<TD width="13%"><font><b>Project</b></font></TD>
		<TD width="9%"><font><b>Team</b></font></TD>
		<TD width="10%"><font><b>Position</b></font></TD>
		<TD width="7%"><font><b>Expertise</b></font></TD>
		<TD width="10%"><font><b>Experience</b></font></TD>
		<TD width="10%"><font><b>Status</b></font></TD>
		<TD width="7%"><font><b>DueDate</b></font></TD>
                <TD width="8%"><font><b>CreatedBy</b></font></TD>
		<TD width="5%" TITLE="In Days" ALIGN="center"><font><b>Age</b></font></TD>
		<TD width="7%" ALIGN="CENTER"><font><b>Profile</b></font></TD>
</TR>
<%
		SimpleDateFormat sdf    = new SimpleDateFormat("dd-MMM-yy");
		if(rs!=null){
			for(int i=1;i<=15;i++){
				if(rs.next()){
					requestid		=	rs.getString("requestid");
					project			=	rs.getString("project");
					team			=	rs.getString("team");
					position		=	rs.getString("position");
					exp_years		=	rs.getString("exp_years");
//					exp_months		=	rs.getString("exp_months");
					assignedto		=	rs.getString("assignedto");
                                        createdby               =       rs.getString("createdby");
					dueDateFormat   = 	rs.getDate("duedate");
					created			=	rs.getDate("createdon");
					modified		=	rs.getDate("modifiedon");
					responsibility_p1=  rs.getString("responsibility_p1");
					skillset		=	rs.getString("skillset");
					status			=	rs.getString("status");
					
					
					duedate="NA";
					if(dueDateFormat!=null){
						duedate=sdf.format(dueDateFormat);
					}
					createdon="NA";
					if(dueDateFormat!=null){
						createdon=sdf.format(created);
					}
					modifiedon="NA";
					if(dueDateFormat!=null){
						modifiedon=sdf.format(modified);
					}
					 if(( i % 2 ) != 0)                    
		                {
				%>
							<tr bgcolor="white" height="22">
		<%
                		}
		                else
		                {
%>
	
							<tr bgcolor="#E8EEF7" height="22">
		<%
                		}
				
//                                        String  roh =   ResourceRequest.getROHCount(skillset,requestid,exp_years);
                                        String  roh =   "NA";
				%>
					<td><A HREF="<%=request.getContextPath()%>/ResourceRequest/editRequest.jsp?requestid=<%=requestid%>"><font face="Verdana, Arial, Helvetica, sans-serif" size="1" ><%=requestid %></font></A></td>
					<td><font face="Verdana, Arial, Helvetica, sans-serif" size="1"><%=GetProjects.getProjectName(project) %></font></td>
					<td><font face="Verdana, Arial, Helvetica, sans-serif" size="1" ><%=team %></font></td>
					<td TITLE="<%=StringUtil.escapeHtmlTag(responsibility_p1) %>"><font face="Verdana, Arial, Helvetica, sans-serif" size="1" ><%=position %></font></td>
					<td ><font face="Verdana, Arial, Helvetica, sans-serif" size="1" ><%=skillset %></font></td>
					<td><font face="Verdana, Arial, Helvetica, sans-serif" size="1" ><%=exp_years %><%="  "%>Yrs</font></td>
					<td><font face="Verdana, Arial, Helvetica, sans-serif" size="1" ><%=status %></font></td>
					<td TITLE="<%= modifiedon %>"><font face="Verdana, Arial, Helvetica, sans-serif" size="1" ><%=duedate %></font></td>
                                        <td><font face="Verdana, Arial, Helvetica, sans-serif" size="1" ><%=GetProjectManager.getUserName(Integer.parseInt(createdby)) %></font></td>
					<td align="center"><font face="Verdana, Arial, Helvetica, sans-serif" size="1" ><%=GetAge.getContactAge(connection,createdon) %></font></td>
					<td align=center>
                                            <%
        int fileCount   =   ResourceRequest.getAttachedFileCount(requestid);
        if(fileCount>0){
%>
        <A onclick="viewFileAttachForIssue('<%=requestid%>');" href="#"
>View Files</A>
<%
        }else{
%>
            <font face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000">No Files</font>
<%
        }
%>

                                        </td>
					</tr>
				<%
				
				
				}
			}
			}
		 %>
</table>
<%
		   
		   
            }else if(noOfTimeSheet > 0){
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
        <%}else if(ermAssignment>0){
        %>
            <jsp:forward page="/ERM/assignedApplicants.jsp"/>
        <%}else{%>
            <jsp:forward page="/admin/dashboard/chartForUsers.jsp"/>
        <%}
    		}
    		
    	}
    	catch(Exception e){
    		logger.error(e.getMessage());
    	}
    	finally{
    		if(rs!=null){
    			rs.close();
    		}
    		if(ps!=null){
    			ps.close();
    		}
    		if(connection!=null){
    			connection.close();
    		}
    		
    	}
    	
    	if(rowcount>0)
		{
			if(request.getParameter("manipulation")==null && (rowcount/16==0))
		{
			logger.debug("Caught in 1");
		    %> <%
		
		}

		else if(request.getParameter("manipulation")==null)
		{
		    %>
<table align=right>
	<tr>
		<td>First</td>
		<td>Prev</td>
		<td><a href="<%=request.getContextPath()%>/ResourceRequest/viewResourceRequest.jsp?manipulation=3">Next</a></td>
		<td><a href="<%=request.getContextPath()%>/ResourceRequest/viewResourceRequest.jsp?manipulation=4">Last</a></td>
	</tr>
</table>
<%
			
		}
		else if(request.getParameter("manipulation").equals("4"))
		{
			logger.debug("Caught in 2");
		    %>
<table align=right>
	<tr>
		<td><a href="<%=request.getContextPath()%>/ResourceRequest/viewResourceRequest.jsp?manipulation=1">First</a></td>
		<td><a href="<%=request.getContextPath()%>/ResourceRequest/viewResourceRequest.jsp?manipulation=2">Prev</a></td>
		<td>Next</td>
		<td>Last</td>
	</tr>
</table>
<%
		}
		
		else if(request.getParameter("manipulation").equals("1"))
		{
		    %>
<table align=right>
	<tr>
		<td>First</td>
		<td>Prev</td>
		<td><a href="<%=request.getContextPath()%>/ResourceRequest/viewResourceRequest.jsp?manipulation=3">Next</a></td>
		<td><a href="<%=request.getContextPath()%>/ResourceRequest/viewResourceRequest.jsp?manipulation=4">Last</a></td>
	</tr>
</table>
<%
		}
			
		else if(request.getParameter("manipulation").equals("3") && issuenoto==rowcount)
		{
			logger.debug("Caught in 3");
		    %>
<table align=right>
	<tr>
		<td><a href="<%=request.getContextPath()%>/ResourceRequest/viewResourceRequest.jsp?manipulation=1">First</a></td>
		<td><a href="<%=request.getContextPath()%>/ResourceRequest/viewResourceRequest.jsp?manipulation=2">Prev</a></td>
		<td>Next</td>
		<td>Last</td>
	</tr>
</table>
<%
			
		}
		else if(request.getParameter("manipulation").equals("3"))
		{
			logger.debug("Caught in 4");
		    %>
<table align=right>
	<tr>
		<td><a href="<%=request.getContextPath()%>/ResourceRequest/viewResourceRequest.jsp?manipulation=1">First</a></td>
		<td><a href="<%=request.getContextPath()%>/ResourceRequest/viewResourceRequest.jsp?manipulation=2">Prev</a></td>
		<td><a href="<%=request.getContextPath()%>/ResourceRequest/viewResourceRequest.jsp?manipulation=3">Next</a></td>
		<td><a href="<%=request.getContextPath()%>/ResourceRequest/viewResourceRequest.jsp?manipulation=4">Last</a></td>
	</tr>
</table>
<%
			
		}
		else if(request.getParameter("manipulation").equals("2") && issuenofrom == 1)
		{
			logger.debug("Caught in 5");
		    %>
<table align=right>
	<tr>
		<td>First</td>
		<td>Prev</td>
		<td><a href="<%=request.getContextPath()%>/ResourceRequest/viewResourceRequest.jsp?manipulation=3">Next</a></td>
		<td><a href="<%=request.getContextPath()%>/ResourceRequest/viewResourceRequest.jsp?manipulation=4">Last</a></td>
	</tr>
</table>
<%
			
		}
		else if(request.getParameter("manipulation").equals("2"))
		{
			logger.debug("Caught in 6");
		    %>
<table align=right>
	<tr>
		<td><a href="<%=request.getContextPath()%>/ResourceRequest/viewResourceRequest.jsp?manipulation=1">First</a></td>
		<td><a href="<%=request.getContextPath()%>/ResourceRequest/viewResourceRequest.jsp?manipulation=2">Prev</a></td>
		<td><a href="<%=request.getContextPath()%>/ResourceRequest/viewResourceRequest.jsp?manipulation=3">Next</a></td>
		<td><a href="<%=request.getContextPath()%>/ResourceRequest/viewResourceRequest.jsp?manipulation=4">Last</a></td>
	</tr>
</table>
<%
			
		}
	}
    
    	
      %>

</body>
<div id="MDAVpopup" class="popup">
        <h3 class="popupHeading">View Attached Files</h3>
        <div>
            <div class="clear"></div>
            <div class="tableshow">
                <div id="IssuePopupFiles">

                </div>
                <button class="custom-popup-close" onclick="closeIssuePopup();" type="button">close</button>

            </div>
        </div>
    </div>
</html>