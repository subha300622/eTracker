<%@ page language="java" contentType="text/html"
	pageEncoding="UTF-8"%>
<%@ page import="org.apache.log4j.*,pack.eminent.encryption.*,com.eminent.util.*,java.text.*"%>
<%
	//Configuring log4j properties
	
	
	
	Logger logger = Logger.getLogger("waitingLead");
	
	
	String logoutcheck=(String)session.getAttribute("Name");
	if(logoutcheck==null)
	{
            logger.fatal("================Session expired===================");
		%>
<jsp:forward page="../SessionExpired.jsp"></jsp:forward>
<%

	}
	
	session.setAttribute("forwardpage","deniedLeads.jsp");
%>
<%@ page import="com.pack.*"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<meta name="keywords" content="GST in SAP, SAP GST Accelerator, GST Success in SAP, GST India in SAP, GST SAP Success, GST Suvidha Provider, GST ASP GSP, GST, CGST,SGST, IGST, UGST,  SAP NW based Product Development, SAP Consulting, SAP Implementation, SAP Support Services, SAP Outsourcing, SAP Implementation India, SAP Implementation Bangalore, SAP Implementation Chennai, SAP Implementation Belgium, SAP Implementation Paris, SAP Implemtation Australia, SAP Implementation France, SAP Implementation Mumbai, SAP Implementation Kerala, SAP Implementation Belgaum, SAP Implementation Thailand, SAP Implementation Mexico, SAP Implementation America">
<meta http-equiv="Content-Type" content="text/html ">
<LINK title=STYLE
	href="<%= request.getContextPath() %>/eminentech support files/main_ie.css"
	type="text/css" rel=STYLESHEET>
<TITLE>eTracker&#0153; - Eminentlabs CRM,APM,ERM and PTS
Solution</TITLE>
<script language="JavaScript">
	function printpost(post)
	{
		pp = window.open('./profile.jsp?post_id=' + post,'pp','size = maximize,location=no,statusbar=no,menubar=no,scrollbars=no width=900,height=400');
		pp.focus();
	}	
</script>
<script language="JavaScript">
	function printpost(post)
	{
		pp = window.open('./profile.jsp?post_id=' + post,'pp','size = maximize,location=no,statusbar=no,menubar=no,scrollbars=no width=900,height=400');
		pp.focus();
	}
	
	var form='showleads' //form name

	function SetChecked(val,chkName) 
	{
		dml=document.forms[form];
		len = dml.elements.length;
		var i=0;
		for( i=0 ; i<len ; i++) 
		{
			if (dml.elements[i].name==chkName) 
			{
				dml.elements[i].checked=val;
			}
		}
	}

	function ValidateForm(dml,chkName)
	{
		len = dml.elements.length;
		var i=0;
		for( i=0 ; i<len ; i++) 
		{
			if ((dml.elements[i].name==chkName) && (dml.elements[i].checked==1)) return true
                        
		}
		alert("Please select at least one record to be approved/denied")
		return false;
	}
        

</script>

</head>
<body>
<%@ page import="java.sql.*"%>
<%! 
	int requestpage,pageone,pageremain,rowcount;
	static int totalpage,pagemanipulation,presentpage,issuenofrom,issuenoto,extra;
%>
<%@ include file="/header.jsp"%>
<form name="searchLead" onsubmit="return check(this);"
	action="searchLead.jsp">
<table cellpadding="0" cellspacing="0" width="100%" bgColor="#C3D9FF">
	<tr>
		<td align="left"><font size="4" COLOR="#0000FF"><b>Denied Lead
		</b> </font>
		<td align="center"><b>Enter the Name or Company:</b></td>
		<td align="left"><input type="text" name="leadName"
			maxlength="20" size="15"></td>
		<td align="left"><input type="submit" name="submit"
			value="Search"></td>
		<td align="left"><input type="reset" name="reset" value="Reset">
		</td>
		<td></td>
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
			int x=-1;
			st = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
			rs = st.executeQuery("SELECT LEADID,TITLE,FIRSTNAME, LASTNAME, COMPANY, STATE,PHONE,MOBILE,EMAIL,LEADSTATUS,CREATEDON,MODIFIEDON,LEAD_OWNER from lead where roleid='"+x+"' order by FIRSTNAME ASC");
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
			if(request.getParameter("newlead")!=null)
			{
%>

<table width="100%" align=center border="0" bgcolor="E8EEF7">
	<tr>
		<td align=center><FONT SIZE="4" COLOR="#33CC33">New Lead
		has been added successfully!: </FONT> <FONT SIZE="4" COLOR="#0000FF"><%= request.getParameter("company")%></FONT>
		</td>
	</tr>
</table>
<%
			}
%>
<TABLE width="100%" border="0">
	<tr>
		<td>
<!--                <a href="<%=request.getContextPath() %>/admin/customer/addnewlead.jsp">Add	Lead</a>&nbsp;&nbsp;&nbsp;&nbsp; -->
                    <a href="<%=request.getContextPath() %>/admin/customer/viewlead.jsp">View Leads</a>&nbsp;&nbsp;&nbsp;&nbsp;
                    <a href="<%=request.getContextPath() %>/admin/customer/waitingLead.jsp">Approve Leads</a>&nbsp;&nbsp;&nbsp;&nbsp;
                    <b><a href="javascript:void(0)">Denied Leads</a></b>&nbsp;&nbsp;&nbsp;&nbsp;
                    <a href="<%=request.getContextPath() %>/admin/customer/disabledLead.jsp">Disabled Leads</a></td>


		<%
			if(rowcount==0)
			{
%>
				<table align="center" height="70%">
	
					<tr>
						<td>
						<h3>No leads are available</h3>
						</td>
					</tr>
				</table>
		<%
			}
			else
			{
%>
		<td width="20%" colspan=3>Displaying&nbsp;<%=issuenofrom%>&nbsp;-<%=issuenoto%>&nbsp;of&nbsp;<b><%=rowcount%></b></td>
		
		<td align="right"><a href="javascript:SetChecked(1,'approve')"><font
			face="Arial, Helvetica, sans-serif" size="2">Select All</font></a> <a
			href="javascript:SetChecked(0,'approve')"><font
			face="Arial, Helvetica, sans-serif" size="2">Clear All</font></a></td>
	</tr>
</TABLE>
<br>
<form name="showleads" action="approveLeads.jsp"
	onSubmit="return ValidateForm(this,'approve')">
<table width=100%>
	<TR bgColor="#C3D9FF" height="9">
		<TD width="18%"><font><b>Lead Name</b></font></TD>
		<TD width="13%"><font><b>Company</b></font></TD>
		<TD width="12%"><font><b>Phone</b></font></TD>
		<TD width="13%"><font><b>Email</b></font></TD>
		<TD width="12%"><font><b>Lead Status</b></font></TD>
		
		<TD width="5%" TITLE="In Days" ALIGN="center"><font><b>Age</b></font></TD>
	
	</TR>

	<%
	String firstname=null,lastname=null,company=null,state=null,email=null,leadstatus=null,phone=null,duedate=null,assignedTo=null,createdon=null,owner=null,mobile=null,title=null,rate=null;
	int leadid=9999,age=0;
	if(rs!=null)
	{ 
	    for(int i=1;i<=15;i++)
		{
			if(rs.next())
			{
				leadid=rs.getInt("leadid");
				title=rs.getString("TITLE");
				
				firstname=rs.getString("firstname");
				
				lastname=rs.getString("lastname");
				
				company=rs.getString("company");
				
				state=rs.getString("state");
				
				email=rs.getString("email");
				
				leadstatus=rs.getString("leadstatus");
				
				phone=rs.getString("phone");
				
				mobile=rs.getString("mobile");
				
				
				SimpleDateFormat sdf = new SimpleDateFormat("dd-MMM-yy");
				
				Date createdOn=rs.getDate("createdon");
				
				if(createdOn!=null){
					createdon=sdf.format(createdOn);
					age=GetAge.getContactAge(connection,createdon);
					createdon=((Integer)age).toString();
				}else{
					createdon="NA";
				}
				
                String own		= rs.getString("lead_owner");
                owner="NA";
                if(own!=null){
                	owner    = GetProjectManager.getUserName(Integer.parseInt(own));
                }
                
				Date modifiedOn = rs.getDate("modifiedon");
				
				String modified = "NA";
                if(modifiedOn != null){
                
                	modified = sdf.format(modifiedOn);
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
					
				
                String name=firstname+" "+lastname;
                if(name.length()<26)
                {
                %>
<td width="18%" title="<%=  title%>"><input type="checkbox" name="approve" value="<%= leadid %>"><font
	face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><A
	HREF="editLead.jsp?leadid=<%=leadid%>"><%= StringUtil.encodeHtmlTag(name)%></A></font></td>
<%
                }
                else
                {
                %>
<td width="18%" title="<%=  title%>"><input type="checkbox" name="approve" value="<%= leadid %>"><font
	face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><A
	HREF="editLead.jsp?leadid=<%=leadid%>"><%=name.substring(0,25)+"..." %></A></font></td>

<%
                }
                if(company.length()<20)
                {
                %>
<td width="13%"><font
	face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%= StringUtil.encodeHtmlTag(company)%></font></td>
<%
                }
                else
                {
                %>
<td width="13%"><font
	face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%=company.substring(0,20)+"..." %></font></td>

<%
                }
                
                
                %>

<td width="12%" title="Mobile No. <%=  mobile%>"><font face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%= StringUtil.encodeHtmlTag(phone) %></font></td>
<%if (email.length()<20)
  {
 %>
<td width="18%"><font
	face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%= StringUtil.encodeHtmlTag(email) %></font></td>
<%
  }else
  {
  %>
<td width="18%"><font
	face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%= email.substring(0,20)+"..." %></font></td>
<%
  }
%>


<td width="12%" title="Rating : <%= rate %>"><font face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%= StringUtil.encodeHtmlTag(leadstatus) %></font></td>


<td width="5%" align="center"><font face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%=createdon%></font></td>





</tr>
<% 
			}
		}
	}
			if(rowcount>0)
			{
				%>
	<tr>
		<td colspan="6" align="center"><input type="submit" name="submit"
			value="Approve"></td>
	</tr>
	<%
			}
			
			if(request.getParameter("manipulation")==null && (rowcount/16==0))
			{
%>

	<%
			}
			else if(request.getParameter("manipulation")==null)
			{
%>
	<table align=right>
		<tr>
			<td>First</td>
			<td>Prev</td>
			<td><a href=deniedLeads.jsp?manipulation=3>Next</a></td>
			<td><a href=deniedLeads.jsp?manipulation=4>Last</a></td>
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
			<td><a href=deniedLeads.jsp?manipulation=3>Next</a></td>
			<td><a href=deniedLeads.jsp?manipulation=4>Last</a></td>
		</tr>
	</table>
	<%
			}	
			else if(request.getParameter("manipulation").equals("4"))
			{
%>
	<table align=right>
		<tr>
			<td><a href=deniedLeads.jsp?manipulation=1>First</a></td>
			<td><a href=deniedLeads.jsp?manipulation=2>Prev</a></td>
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
			<td><a href=deniedLeads.jsp?manipulation=1>First</a></td>
			<td><a href=deniedLeads.jsp?manipulation=2>Prev</a></td>
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
			<td><a href=deniedLeads.jsp?manipulation=1>First</a></td>
			<td><a href=deniedLeads.jsp?manipulation=2>Prev</a></td>
			<td><a href=deniedLeads.jsp?manipulation=3>Next</a></td>
			<td><a href=deniedLeads.jsp?manipulation=4>Last</a></td>
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
			<td><a href=deniedLeads.jsp?manipulation=3>Next</a></td>
			<td><a href=deniedLeads.jsp?manipulation=4>Last</a></td>
		</tr>
	</table>
	<%
			}
			else if(request.getParameter("manipulation").equals("2"))
			{
%>
	<table align=right>
		<tr>
			<td><a href=deniedLeads.jsp?manipulation=1>First</a></td>
			<td><a href=deniedLeads.jsp?manipulation=2>Prev</a></td>
			<td><a href=deniedLeads.jsp?manipulation=3>Next</a></td>
			<td><a href=deniedLeads.jsp?manipulation=4>Last</a></td>
		</tr>
	</table>
	<%
			}

			}
		}
    }
	catch(Exception e)
	{
	//		System.err.println(e.getMessage());
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
</form>
</body>
</html>