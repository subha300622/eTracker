<%@ page language="java" contentType="text/html"
	pageEncoding="UTF-8"%>
<%@ page import="org.apache.log4j.*,pack.eminent.encryption.*,java.text.*,com.eminent.util.*"%>
<%
	//Configuring log4j properties
	
	
	
	Logger logger = Logger.getLogger("ViewAccounts");

	
	
	
	response.setHeader("Cache-Control","no-cache");
	response.setHeader("Cache-Control","no-store");
	response.setDateHeader("Expires", 0);
 	response.setHeader("Pragma","no-cache");
 	
 	
	String logoutcheck=(String)session.getAttribute("Name");
	if(logoutcheck==null)
	{
            logger.fatal("================Session expired===================");
		%>
<jsp:forward page="../SessionExpired.jsp"></jsp:forward>
<%

	}
%>
<%@ page import="com.pack.*"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<meta name="keywords" content="GST in SAP, SAP GST Accelerator, GST Success in SAP, GST India in SAP, GST SAP Success, GST Suvidha Provider, GST ASP GSP, GST, CGST,SGST, IGST, UGST,  SAP NW based Product Development, SAP Consulting, SAP Implementation, SAP Support Services, SAP Outsourcing, SAP Implementation India, SAP Implementation Bangalore, SAP Implementation Chennai, SAP Implementation Belgium, SAP Implementation Paris, SAP Implemtation Australia, SAP Implementation France, SAP Implementation Mumbai, SAP Implementation Kerala, SAP Implementation Belgaum, SAP Implementation Thailand, SAP Implementation Mexico, SAP Implementation America">
<meta http-equiv="Content-Type" content="text/html ">
<LINK title=STYLE
	href="<%= request.getContextPath() %>/eminentech support files/main_ie.css"
	type="text/css" rel=STYLESHEET>
<script type="text/javascript" src="<%= request.getContextPath() %>/javaScript/checkSubmit.js"></script>
<TITLE>eTracker&#0153; - Eminentlabs CRM,APM,ERM and PTS
Solution</TITLE>
<script language="JavaScript">
	function printpost(post)
	{
		pp = window.open('./profile.jsp?post_id=' + post,'pp','size = maximize,location=no,statusbar=no,menubar=no,scrollbars=no width=900,height=400');
		pp.focus();
	}
    function check(searchAccount)  {
    if ((searchAccount.accountName.value==null)||(searchAccount.accountName.value==""))
		{
			alert("Please Enter Account Name ")
			searchAccount.accountName.focus()
			return false
		}
                monitorSubmit();
                }
</script>
</head>
<body>
<jsp:useBean id="CRMIssue" class="com.pack.CRMIssueBean" />
<%@ page import="java.sql.*"%>
<%! 
	int requestpage,pageone,pageremain,rowcount;
	static int totalpage,pagemanipulation,presentpage,issuenofrom,issuenoto,extra;
%>
<%@ include file="/header.jsp"%>
<form name="serachAccount" onsubmit="return check(this);"
	action="<%=request.getContextPath()%>/admin/customer/searchAccount.jsp">
<table cellpadding="0" cellspacing="0" width="100%">
	<tr border="2" bgcolor="#E8EEF7">
		<td bgcolor="#E8EEF7" border="1" align="left"><font size="4"
			COLOR="#0000FF"> <b> Account Administration </b></font><FONT SIZE="3"
			COLOR="#0000FF"> </FONT></td>
		<td align="right"><b>Enter Account Name:</b></td>
		<td align="left"><input type="text" name="accountName" maxlength="12"
			size="15"></td>
		<td><input type="submit" name="submit" id="submit" value="Search"></td>
		<td><input type="reset" name="reset" id="reset" value="Reset"></td>
		<td width="25%" border="1" align="right"><font size="2"
			face="Verdana, Arial, Helvetica, sans-serif"></font></td>
	</tr>
</table>
</form>
<% 

	Connection  connection = null;
	Statement st=null;
	ResultSet rs=null;
	try
    {
		connection=MakeConnection.getConnection();
		logger.debug("Connection has been created:"+connection);
	
		if(connection != null)  
		{
			st = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
			rs = st.executeQuery("SELECT ACCOUNTID,ACCOUNTNAME,BILLINGSTATE,PHONE,TYPE,DUEDATE,ACCOUNT_AMOUNT,ASSIGNEDTO,CREATEDON,OPPORTUNITY_REFERENCE,MODIFIEDON from account order by DUEDATE ASC ");
			rs.last();
			int rowcount=rs.getRow();
			logger.debug("Total No of records:"+rowcount);
			rs.beforeFirst();
			pageone=rowcount/15;
			pageremain=rowcount%15;
					
			if(pageremain>0)
			{
				totalpage=pageone+1;
			}
			else
			{
				totalpage=pageone;	
			}
			try
			{
				String requestpag=request.getParameter("manipulation");
				logger.debug("Requested Page:"+requestpag);
				if(requestpag!=null)
				{
					requestpage=Integer.parseInt(requestpag);
					if(requestpage==1)
					{
						presentpage=1;
						rs.beforeFirst();
						logger.debug("Requested page First"+presentpage);	
						issuenofrom=1;
						issuenoto=issuenofrom+14;
						if(issuenoto>rowcount)
						{
							extra=issuenoto-rowcount;
							issuenoto=issuenoto-extra;
						}
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
					issuenofrom=1;
					rs.beforeFirst();
					issuenoto=issuenofrom+14;
					if(issuenoto>rowcount)
					{
					    extra=issuenoto-rowcount;
					    issuenoto=issuenoto-extra;
					}
				}
		   }
		   catch(Exception e)
		   {
		   		logger.error("Exception:"+e);
		   }
			if(request.getParameter("newaccount")!=null)
			{
%>

<table width="100%" align=center border="0" bgcolor="E8EEF7">
	<tr>
		<td align=center><FONT SIZE="4" COLOR="#33CC33">New
		Account has been added successfully!: </FONT> <FONT SIZE="4" COLOR="#0000FF"><%= request.getParameter("accountname")%></FONT>
		</td>
	</tr>
</table>
<%
			}
%>
<TABLE width="100%" border="0">
	<tr>
		<td><b> <a
			href="<%=request.getContextPath() %>/admin/customer/addnewaccount.jsp">Add
		Account</a></b></td>
		<%
			if(rowcount==0)
			{
%>
		<td>Displaying&nbsp;<%= "0"%>&nbsp;-<%=issuenoto%>&nbsp;of&nbsp;<b><%=rowcount%></b></td>
		<%
			}
			else
			{
%>
		<td>Displaying&nbsp;<%=issuenofrom%>&nbsp;-<%=issuenoto%>&nbsp;of&nbsp;<b><%=rowcount%></b></td>
		<%
			}
%>
	</tr>
</TABLE>
<br>
<table width=100%>
	<TR bgColor="#C3D9FF" height="9">
		<TD width="20%"><font><b>Account Name</b></font></TD>
		<TD width="10%"><font><b>Billing State</b></font></TD>
		<TD width="12%"><font><b>Phone</b></font></TD>
		<TD width="10%"><font><b>Type</b></font></TD>
		<TD width="10%"><font><b>Deal Value</b></font></TD>
		<TD width="13%"><font><b>Account Value</b></font></TD>
		<TD width="12%"><font><b>Assigned To</b></font></TD>
		<TD width="8%"><font><b>Due Date</b></font></TD>
		<TD width="5%"><font><b>Age</b></font></TD>
		
	</TR>

	<%
			String accountname=null,billingstate=null,type=null,phone=null,duedate=null,account_amount=null,createdon=null,opportunity_reference=null,dealValue=null;
			int accountid=9999,assignedto=0,age=0;
			if(rs!=null)
			{ 
			    for(int i=1;i<=15;i++)
				{
					if(rs.next())
					{
						accountid=rs.getInt("accountid");
						accountname=rs.getString("accountname");
						if (accountname==null)
							accountname="";
						billingstate=rs.getString("billingstate");
						if (billingstate==null)
							billingstate="nil";
						type=rs.getString("type");
						if (type==null || type.equals("--Select One--"))
							type="nil";
						phone=rs.getString("phone");
						if (phone==null)
							phone="nil";
						
						SimpleDateFormat sdf = new SimpleDateFormat("dd-MMM-yy");
						Date createdOn=rs.getDate("createdon");
						if(createdOn!=null){
							createdon=sdf.format(createdOn);
							age=GetAge.getContactAge(connection,createdon);
							createdon=((Integer)age).toString();
						}else{
							createdon="NA";
						}
						 Date dueDateFormat	 = rs.getDate("duedate");
                                                 Date modifiedOn=rs.getDate("modifiedon");
	                        
	                        String dueDate = "NA";
	                        if(dueDateFormat != null){
	                        	
	                            dueDate = sdf.format(dueDateFormat);
	                        }
                                String modified = "NA";
	                        if(modifiedOn != null){
	                        	
	                            modified = sdf.format(modifiedOn);
	                        }
						
						
						String amount = "NA";
						account_amount=rs.getString("account_amount");
						
						if(amount!=null){
							amount=account_amount;
						}
						
						assignedto=rs.getInt("assignedto");
						
						opportunity_reference=rs.getString("opportunity_reference");
						
						if(opportunity_reference!=null){
							dealValue=CRMIssue.getOpportunityValue(connection,Integer.parseInt(opportunity_reference));
						}
						else{
							dealValue="NA";
						}
						
						if(( i % 2 ) != 0)                    
		                {
%>
	<tr bgcolor="white" height="21">
		<%
						}
		                else
				        {
%>
	
	<tr bgcolor="#E8EEF7" height="21">
		<%
						}
%>
		<td width="20%"><font
			face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><A HREF="editAccount.jsp?accountid=<%=accountid%>"><%= StringUtil.encodeHtmlTag(accountname)%></A></font></td>
		<td width="10%"><font
			face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%= StringUtil.encodeHtmlTag(billingstate) %></font></td>
		<td width="12%"><font
			face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%= StringUtil.encodeHtmlTag(phone) %></font></td>
		<td width="10%"><font
			face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%= StringUtil.encodeHtmlTag(type) %></font></td>
		<td width="10%"><font
			face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%=dealValue %></font></td>
		<td width="13%"><font
			face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%= amount%></font></td>
		<td width="12%"><font
			face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%= GetProjectManager.getUserName(assignedto) %></font></td>
		<td width="8%" title="<%=modified%>"><font
			face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%= dueDate %></font></td>
		<td width="5%"><font
			face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%= createdon %></font></td>

	</tr>
	<% 
					}
				}
			}	
			if(request.getParameter("manipulation")==null && (rowcount/16==0))
			{
%>
	<table align=right>
		<tr>
			
		</tr>
	</table>
	<%
			}
			else if(request.getParameter("manipulation")==null)
			{
%>
	<table align=right>
		<tr>
			<td>First</td>
			<td>Prev</td>
			<td><a href=viewaccount.jsp?manipulation=3>Next</a></td>
			<td><a href=viewaccount.jsp?manipulation=4>Last</a></td>
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
			<td><a href=viewaccount.jsp?manipulation=3>Next</a></td>
			<td><a href=viewaccount.jsp?manipulation=4>Last</a></td>
		</tr>
	</table>
	<%
			}	
			else if(request.getParameter("manipulation").equals("4"))
			{
%>
	<table align=right>
		<tr>
			<td><a href=viewaccount.jsp?manipulation=1>First</a></td>
			<td><a href=viewaccount.jsp?manipulation=2>Prev</a></td>
			<td>Next</td>
			<td>Last</td>
		</tr>
	</table>
	<%
			}
			else if(request.getParameter("manipulation").equals("3") && issuenoto==rowcount)
			{
%>
	<table align=right>
		<tr>
			<td><a href=viewaccount.jsp?manipulation=1>First</a></td>
			<td><a href=viewaccount.jsp?manipulation=2>Prev</a></td>
			<td>Next</td>
			<td>Last</td>
		</tr>
	</table>
	<%
			}
			else if(request.getParameter("manipulation").equals("3"))
			{
%>
	<table align=right>
		<tr>
			<td><a href=viewaccount.jsp?manipulation=1>First</a></td>
			<td><a href=viewaccount.jsp?manipulation=2>Prev</a></td>
			<td><a href=viewaccount.jsp?manipulation=3>Next</a></td>
			<td><a href=viewaccount.jsp?manipulation=4>Last</a></td>
		</tr>
	</table>
	<%
			}
			else if(request.getParameter("manipulation").equals("2") && issuenofrom == 1)
			{
%>
	<table align=right>
		<tr>
			<td>First</td>
			<td>Prev</td>
			<td><a href=viewaccount.jsp?manipulation=3>Next</a></td>
			<td><a href=viewaccount.jsp?manipulation=4>Last</a></td>
		</tr>
	</table>
	<%
			}
			else if(request.getParameter("manipulation").equals("2"))
			{
%>
	<table align=right>
		<tr>
			<td><a href=viewaccount.jsp?manipulation=1>First</a></td>
			<td><a href=viewaccount.jsp?manipulation=2>Prev</a></td>
			<td><a href=viewaccount.jsp?manipulation=3>Next</a></td>
			<td><a href=viewaccount.jsp?manipulation=4>Last</a></td>
		</tr>
	</table>
	<%
			}
		}
    }
	catch(Exception e)
	{
			logger.error(e.getMessage());
	}	
	finally
	{
		if(rs!=null)
			rs.close();
		if(st!=null)
			st.close();
        if(connection!=null)
			connection.close();
		logger.debug("Closing JDBC Resources");
	}
%>
</table>
</body>
</html>