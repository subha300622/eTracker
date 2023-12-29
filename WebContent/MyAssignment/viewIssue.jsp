<%-- 
    Document   : viewIssue
    Created on : Dec 11, 2009, 2:30:26 PM
    Author     : Administrator
--%>
<%@ page import="java.util.List,com.eminent.tqm.IssueTestCaseUtil, com.eminent.tqm.TqmPtcm, com.eminent.util.GetProjectManager,com.eminent.util.GetProjects,java.sql.*,java.text.*,java.util.HashMap,java.util.LinkedHashMap,com.pack.*,pack.eminent.encryption.*,org.apache.log4j.*,com.eminent.util.*,java.util.Collection, java.util.ArrayList, java.util.Iterator" buffer="1024kb" autoFlush="false"%>
<%@ page import="com.eminent.issue.Issue,com.eminent.issue.IssueAccess"%>
<%
        response.setHeader("Cache-Control","no-cache");
        response.setHeader("Cache-Control","no-store");
        response.setDateHeader("Expires", 0);
        response.setHeader("Pragma","no-cache");

		Logger logger = Logger.getLogger("UpdateIssueView");
		String logoutcheck=(String)session.getAttribute("Name");
		if(logoutcheck==null)
		{
			logger.fatal("==============Session Expired===============");
		%>
<jsp:forward page="../SessionExpired.jsp"></jsp:forward>
<%
		}

%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <meta name="keywords" content="GST in SAP, SAP GST Accelerator, GST Success in SAP, GST India in SAP, GST SAP Success, GST Suvidha Provider, GST ASP GSP, GST, CGST,SGST, IGST, UGST,  SAP NW based Product Development, SAP Consulting, SAP Implementation, SAP Support Services, SAP Outsourcing, SAP Implementation India, SAP Implementation Bangalore, SAP Implementation Chennai, SAP Implementation Belgium, SAP Implementation Paris, SAP Implemtation Australia, SAP Implementation France, SAP Implementation Mumbai, SAP Implementation Kerala, SAP Implementation Belgaum, SAP Implementation Thailand, SAP Implementation Mexico, SAP Implementation America">
<TITLE>eTracker&#153; - Eminentlabs&#153; CRM, APM, TQM,  ERM and  EPTS
Solution</TITLE>
    <script language=javascript
        src="<%= request.getContextPath() %>/javaScript/checkSubmit.js">
    </script>

<LINK title=STYLE href="<%=request.getContextPath()%>/eminentech support files/main_ie.css"
	type="text/css" rel=STYLESHEET>
    <script language=javascript src="<%= request.getContextPath() %>/javaScript/feedbackSelect.js"></script>
    </HEAD>
    <%@ include file="../header.jsp"%>
    <body>
       <%
                        String issueId = request.getParameter("issueid");
                        Issue issue=IssueAccess.GetDetails(issueId);

                        int role	= (Integer)session.getAttribute("Role");
                        int uid         = (Integer)session.getAttribute("userid_curr");
  
                        SimpleDateFormat sdf=new SimpleDateFormat("dd MMM yyyy");
   
                        String pName        =   (issue.getProjectid()).getPname();
                        int pmanager        =   Integer.parseInt((issue.getProjectid().getPmanager()));
                        String mName        =   (issue.getModules()).getModule();
                        String customer     =   (issue.getProjectid()).getCustomer();
                        String fndVersion   =   (issue.getProjectid()).getVersion();
                        String platform     =   (issue.getProjectid()).getPlatform();
                        String fixVersion   =   issue.getFoundVersion();
                        String type         =   issue.getType();
                        String Priority     =   issue.getPriority();
                        String Severity     =   issue.getSeverity();
                        String status       =   issue.getIssuestatus();
                        String createdby    =   issue.getAssignedto().getFirstname();
                        int creby           =   Integer.parseInt((issue.getProjectid().getPmanager()));
                        String assignedto   =   issue.getCreatedby().getFirstname();
                        String subject      =   issue.getSubject();
                        String desc         =   issue.getDescription();
                        String expRslt      =   issue.getExpectedResult();
                        String dueDate      =   sdf.format(issue.getDueDate());
                        String createdOn    =   sdf.format(issue.getCreatedon());
                        String modifiedOn   =   sdf.format(issue.getModifiedon());

                        String severity[]={"S1- Fatal","S2- Critical","S3- Important","S4- Minor"};
                        String priority[]={"P1-Now","P2-High","P3-Medium","P4-Low"};
                      
        %>
        <table cellpadding="0" cellspacing="0" width="100%">
	<tr border="2" bgcolor="#C3D9FF">
		<td border="1" align="left" width="70%"><font size="4"
			COLOR="#0000FF"><b>My Assignments</b></font><FONT SIZE="3"
			COLOR="#0000FF"> </FONT></td>

	</tr>
</table>
<br>

<table width="100%" bgcolor="#C3D9FF">
	<tr>
		<td><b>Issue Number <font color="#0000FF"><%= issueId %></font></b></td>
		<td align="right"><a
			href="<%=request.getContextPath()%>/viewIssueDetails.jsp?issueid=<%= issueId %>"
			target="_blank">Print this Issue</a></td>
	</tr>
</table>
<table width="100%" border="0" bgcolor="E8EEF7" cellpadding="0">
     <tbody id="mainBody">
	<tr height="21">
		<td width="12%"><B>Customer </B></td>
                <td width="24%"><%= customer %></td>
		<td width="11%"><B>Product </B></td>
		<td width="22%"><%=pName %></td>
		<td width="11%"><B>FoundVersion </B></td>
                <td width="20%"><%= fndVersion %></td>
	</tr>
        <tr height="21">
		<td width="12%"><B>Type </B></td>
		<td width="24%"><%= type %></td>
		<td width="11%"><B>Module </B></td>
		<td width="22%"><%=mName %></td>
		<td width="11%"><B>Platform</B></td>
		<td width="20%"><%= platform %></td>
	</tr>

         <tr>
           
                 <td width="12%"><B>Severity </B></td>
                 <td width="24%">
 <!-- If User is Project Manager we should give Drop Down box to change Severity and Priority else just a Non Editable text box-->
                     <%
                     if((role==1)||pmanager==uid)
				{
					%> <select name="severity">
			<%
                                    for(int s=0;s<severity.length;s++){
                                        if (severity[s].equalsIgnoreCase(Severity))
                                        {

                %>
                                        <option value="<%=severity[s]%>" selected><%=severity[s]%></option>
                                        <%
                                        }
                                        else
                                        {
                %>
                                        <option value="<%=severity[s]%>"><%=severity[s]%></option>
                                        <%
                                        }

                                    }
                %>
		</select> <%
				}
				else{

                                        for(int s=0;s<severity.length;s++){
					if(severity[s].equalsIgnoreCase(Severity))
					{
%> <input type=text size="11" name="severity" value="<%=severity[s]%>" readonly="true" />

		<%
					}

                                        }

				}
%>
                 </td>
                  <td width="12%"><B>Priority </B></td>
                 <td width="24%">
<!--   If User is Project Manager we should give Drop Down box to change Severity and Priority else just a Non Editable text box-->
                     <%
                     if((role==1)||pmanager==uid)
				{
					%> <select name="priority">
			<%
                                    for(int s=0;s<priority.length;s++){
                                        if (priority[s].equalsIgnoreCase(Priority))
                                        {

                %>
                                        <option value="<%=priority[s]%>" selected><%=priority[s]%></option>
                                        <%
                                        }
                                        else
                                        {
                %>
                                        <option value="<%=priority[s]%>"><%=priority[s]%></option>
                                        <%
                                        }

                                    }
                %>
		</select> <%
				}
				else{

                                        for(int s=0;s<priority.length;s++){
					if(priority[s].equalsIgnoreCase(Priority))
					{
%> <input type=text size="11" name="priority" value="<%=priority[s]%>" readonly="true" />

		<%
					}

                                        }

				}
%>
                 </td>
                 <td width="11%"><B>IssueStatus</B>

		<%
                ArrayList<String> issueStatus = StatusSelector.getStatusList(status);
		if ( role==1 || pmanager==uid)
                    {
             //       	logger.info("Status"+sta);
              //      	logger.info("Role"+role);
             //       	logger.info("Uid"+uid);
             //       	logger.info("P Manager"+pmanager);
%>
		<td width="20%"><B></B> <SELECT NAME="issuestatus" id="issuestatus" size="1" ONCHANGE="javascript: assignedusers();javascript:originalRowCount();javascript:newRow()">
                    <option value="<%= status %>" selected><%= status %></option>
			<%

			for( String stat : issueStatus) {

                            %>
                                <option value="<%= stat %>"><%= stat %></option>
                            <%

                        }
                        %>

		</SELECT></td>
		<%
                    }else if(status.equalsIgnoreCase("Unconfirmed") && ( !(pmanager==uid) || !(role==1))){

              //          logger.info("Status for ordinory users"+sta);
%>
		<td width="20%"><B></B> <%= status %><input type="hidden" id="issuestatus"
			name="issuestatus" value="<%= status %>" /></td>




		<%
                        }else{
                        	%>
		<td width="20%"><B></B> <SELECT NAME="issuestatus" id="issuestatus" size="1" ONCHANGE="javascript: assignedusers();javascript:originalRowCount();javascript:newRow()">
			<option value="<%= status %>" selected><%= status %></option>
			<%

			for( String stat : issueStatus) {
                            if( !stat.equalsIgnoreCase("Closed")) {
                        %>
                            <option value="<%= stat %>"><%= stat %></option>
                            <%
                            } else {
                               if( uid == creby ) {
                            %>
                            <option value="<%= stat %>"><%= stat %></option>
                            <%
                            }
                        }
                        }
                        }
                        %>
		</SELECT></td>

        </tr>
      <tr height="21">
		<td width="12%"><B>DateCreated </B></td>
		<td width="24%"><%= createdOn  %></td>

        <td width="11%"><B>DateModified </B></td>
		<td width="22%"><%= modifiedOn %></td>

        <td width="11%"><B>CreatedBy </B></td>
		<td width="20%"><%= createdby %></td>
	</tr>
     </tbody>
</table>
    </body>
</html>
