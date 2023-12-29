<%@ page language="java" contentType="text/html"
	pageEncoding="UTF-8"%>
<%@ page import="org.apache.log4j.*,pack.eminent.encryption.*,com.eminent.util.*,java.text.*"%>
<%
	//Configuring log4j properties
	
	
	Logger logger = Logger.getLogger("ViewleadStatus");
	
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
<script type="text/javascript" src="<%= request.getContextPath() %>/javaScript/checkSubmit.js"></script>
<LINK title=STYLE
	href="<%= request.getContextPath() %>/eminentech support files/main_ie.css"
	type="text/css" rel=STYLESHEET>
<TITLE>eTracker&#0153; - Eminentlabs CRM,APM,ERM and PTS
Solution</TITLE>
<script language="JavaScript">
  function check(searchLead)  {  
    if ((searchLead.leadName.value==null)||(searchLead.leadName.value==""))
		{
			alert("Please Enter Name or Company ")
			searchLead.leadName.focus()
			return false
		}
                 monitorSubmit();
                }
	function printpost(post)
	{
		pp = window.open('./profile.jsp?post_id=' + post,'pp','size = maximize,location=no,statusbar=no,menubar=no,scrollbars=no width=900,height=400');
		pp.focus();
	}	
	var form='showusers' //form name

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
		alert("Please select at least one record to be disabled")
		return false;
	}
        /** Function To Set Focus On The First Name Field In The Form */
	
	function setFocus()  {
		document.searchLead.leadName.focus();
	}
	
	window.onload = setFocus;
</script>
</head>
<body>
<%@ page import="java.sql.*"%>
<%! 
	int requestpage,pageone,pageremain,rowcount;
	static int totalpage,pagemanipulation,presentpage,issuenofrom,issuenoto,extra;
%>
<%@ include file="/header.jsp"%>
<%

     // Checking whether the user has entered the name to search for
   
     
        
             %>
<form name="searchLead" onsubmit="return check(this);"
	action="viewlead.jsp">
<table cellpadding="0" cellspacing="0" width="100%" bgColor="#C3D9FF">
	<tr>
		<td align="left"><font size="4" COLOR="#0000FF"><b>Lead
		Administration</b> </font>
		<td align="center"><b>Enter the Name or Company:</b></td>
		<td align="left"><input type="text" name="leadName"
			maxlength="20" size="15"></td>
		<td align="left"><input type="submit" id="submit" name="submit"
			value="Search"></td>
		<td align="left"><input type="reset" name="reset" id="reset" value="Reset">
		</td>
		<td></td>
	</tr>
</table>
</form>

<% 
        
    
 


	Connection  connection = null;
	Statement st=null;
	PreparedStatement pt=null;
	ResultSet rs=null;
	
	
	String status=request.getParameter("status");
	if(status!=null){
		session.removeAttribute("status");
		session.setAttribute("status",status);
	}else{
		status=(String)session.getAttribute("status");
	}
	logger.info("status"+status);
	try
    {
		connection=MakeConnection.getConnection();
		logger.debug("Connection has been created:"+connection);
	
		if(connection != null)  
		{
			st = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
          	pt = connection.prepareStatement("SELECT LEADID,FIRSTNAME, LASTNAME, COMPANY, STATE,PHONE,EMAIL,LEADSTATUS from lead where roleid=2 and upper(leadstatus)=? order by UPPER(FIRSTNAME) ASC ",ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            pt.setString(1,status.toUpperCase());
            rs= pt.executeQuery();
                                		
                                	
			rs.last();
			int rowcount=rs.getRow();
                        if(rowcount == 0){
                            %>
<table align="center" height="70%">
	<tr>
		<td>
		<h3>No leads are available while matching the name.</h3>
		</td>
	</tr>
</table>

<%
                        }else{
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
		<td><a
			href="<%=request.getContextPath() %>/admin/customer/addnewlead.jsp">Add
		Lead</a>&nbsp;&nbsp;&nbsp;&nbsp; <a
			href="<%=request.getContextPath() %>/admin/customer/viewlead.jsp">View
		All Leads</a>&nbsp;&nbsp;&nbsp;&nbsp; <a
			href="<%=request.getContextPath() %>/admin/customer/waitingLead.jsp">Approve
		Lead</a>&nbsp;&nbsp;&nbsp;&nbsp; <a
			href="<%=request.getContextPath() %>/admin/customer/deniedLeads.jsp">Denied
		Lead</a>&nbsp;&nbsp;&nbsp;&nbsp; <a
			href="<%=request.getContextPath() %>/admin/customer/disabledLead.jsp">Disabled
		Lead</a></td>

		<%
			if(rowcount==0)
			{
%>
		
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
	<form name="showusers" action="approveLeads.jsp"
		onSubmit="return ValidateForm(this,'approve')">
</TABLE>
<br>
<table width=100%>

		<TR bgColor="#C3D9FF" height="9">
		<TD width="18%"><font><b>Lead Name</b></font></TD>
		<TD width="13%"><font><b>Company</b></font></TD>
		<TD width="12%"><font><b>Phone</b></font></TD>
		<TD width="13%"><font><b>Email</b></font></TD>
		<TD width="12%"><font><b>Lead Status</b></font></TD>
		<TD width="9%"><font><b>Due Date</b></font></TD>
		<TD width="13%"><font><b>Assigned To</b></font></TD>
		<TD width="5%" TITLE="In Days" ALIGN="center"><font><b>Age</b></font></TD>
		
	</TR>

</table>
<TABLE width="100%">
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
				Date dueDateFormat	 = rs.getDate("duedate");
                
                String dueDate = "NA";
                if(dueDateFormat != null){
                	
                    dueDate = sdf.format(dueDateFormat);
                }
							
                String typ		= rs.getString("assignedto");
                assignedTo="NA";
                if(typ!=null){
                	assignedTo    = GetProjectManager.getUserName(Integer.parseInt(typ));
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
				
				
				rate=rs.getString("rating");
				
				
				
				
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
<td width="13%"><font
	face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%= StringUtil.encodeHtmlTag(email) %></font></td>
<%
  }else
  {
  %>
<td width="13%"><font
	face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%= email.substring(0,20)+"..." %></font></td>
<%
  }
%>


<td width="12%" title="Rating : <%= rate %>"><font face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%= StringUtil.encodeHtmlTag(leadstatus) %></font></td>

<TD width="9%" title="Last Modified On <%= modified %>"><font><%=dueDate %></font></TD>
<TD width="13%"><font><%=assignedTo %></font></TD>
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
	value="Disable"></td>
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
			<td><a href=viewleadstatus.jsp?manipulation=3>Next</a></td>
			<td><a href=viewleadstatus.jsp?manipulation=4>Last</a></td>
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
			<td><a href=viewleadstatus.jsp?manipulation=3>Next</a></td>
			<td><a href=viewleadstatus.jsp?manipulation=4>Last</a></td>
		</tr>
	</table>
	<%
			}	
			else if(request.getParameter("manipulation").equals("4"))
			{
%>
	<table align=right>
		<tr>
			<td><a href=viewleadstatus.jsp?manipulation=1>First</a></td>
			<td><a href=viewleadstatus.jsp?manipulation=2>Prev</a></td>
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
			<td><a href=viewleadstatus.jsp?manipulation=1>First</a></td>
			<td><a href=viewleadstatus.jsp?manipulation=2>Prev</a></td>
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
			<td><a href=viewleadstatus.jsp?manipulation=1>First</a></td>
			<td><a href=viewleadstatus.jsp?manipulation=2>Prev</a></td>
			<td><a href=viewleadstatus.jsp?manipulation=3>Next</a></td>
			<td><a href=viewleadstatus.jsp?manipulation=4>Last</a></td>
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
			<td><a href=viewleadstatus.jsp?manipulation=3>Next</a></td>
			<td><a href=viewleadstatus.jsp?manipulation=4>Last</a></td>
		</tr>
	</table>
	<%
			}
			else if(request.getParameter("manipulation").equals("2"))
			{
%>
	<table align=right>
		<tr>
			<td><a href=viewleadstatus.jsp?manipulation=1>First</a></td>
			<td><a href=viewleadstatus.jsp?manipulation=2>Prev</a></td>
			<td><a href=viewleadstatus.jsp?manipulation=3>Next</a></td>
			<td><a href=viewleadstatus.jsp?manipulation=4>Last</a></td>
		</tr>
	</table>
	<%
			}

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
</body>
</html>