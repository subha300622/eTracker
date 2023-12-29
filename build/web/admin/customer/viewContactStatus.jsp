<%@ page language="java" contentType="text/html"
	pageEncoding="UTF-8"%>
<%@ page import="org.apache.log4j.*,com.eminent.util.*,pack.eminent.encryption.*"%>
<%@ page import="java.text.*"%>
<%

		response.setHeader("Cache-Control","no-cache");
		response.setHeader("Cache-Control","no-store");
		response.setDateHeader("Expires", 0);
		response.setHeader("Pragma","no-cache");
	//Configuring log4j properties
	
	
	
	Logger logger = Logger.getLogger("viewcontact");
	
	
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
<TITLE>eTracker&#0153; - Eminentlabs&#0153; CRM,APM,ERM and PTS
Solution</TITLE>
<script language="JavaScript">
    function check(searchContact)  {  
    if ((searchContact.contactName.value==null)||(searchContact.contactName.value==""))
		{
			alert("Please Enter Name or Account Name")
			searchContact.contactName.focus()
			return false
		}
                monitorSubmit();
                }
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
		alert("Please select at least one record to be disabled")
		return false;
	}
        function setFocus()  {
		document.searchContact.contactName.focus();
	}
	
	window.onload = setFocus;
</script>
</head>
<body>
<%@ page import="java.sql.*"%>
<%! 
	int requestpage,pageone,pageremain,rowcount;
	static int totalpage,pagemanipulation,presentpage,issuenofrom,issuenoto,extra;
	String status=null;
%>
<%@ include file="/header.jsp"%>


<form name="searchContact" onsubmit="return check(this);"
	action="searchContact.jsp">
<table cellpadding="0" cellspacing="0" width="100%" bgColor="#C3D9FF">
	<tr>
		<td align="left"><font size="4" COLOR="#0000FF"><b>Contact
		Administration</b> </font>
		<td align="center"><b>Enter the Name or Contact Name:</b></td>
		<td align="left"><input type="text" name="contactName"
			maxlength="20" size="15"></td>
		<td><input type="submit" id="submit" name="submit" value="Search"></td>
		<td><input type="reset" id="reset" name="reset" value="Reset"></td>
		<td></td>
	</tr>
</table>
</form>



<% 
	if(request.getParameter("rating")==null){
			
			
			status=(String)session.getAttribute("rating");
			
	}else{
		status=request.getParameter("rating");
		session.setAttribute("rating",status);
		
	}
	session.setAttribute("forwardpage","viewContactStatus.jsp");
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
			
			logger.info("Rating"+status);
                       
                                rs = st.executeQuery("SELECT contactid,FIRSTNAME,LASTNAME,ACCOUNTNAME,TITLE,PHONE,MOBILE,EMAIL,CREATEDON,DUEDATE,ASSIGNEDTO,CONTACT_OWNER,MODIFIEDON from CONTACT where roleid=2 and rating='"+status+"' order by duedate ASC ");
                               

                        
			rs.last();
			int rowcount=rs.getRow();
                        if(rowcount == 0){
                            %>
<table align="center" height="70%">
	<tr>
		<td>
		<h3>No contacts are available</h3>
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
			if(request.getParameter("newcontact")!=null)
			{
%>

<table width="100%" align=center border="0" bgcolor="E8EEF7">
	<tr>
		<td align=center><FONT SIZE="4" COLOR="#33CC33">
		A Contact has been <%= request.getParameter("newcontact")%> successfully!: </FONT> <FONT SIZE="4" COLOR="#0000FF"><%= request.getParameter("email")%></FONT>
		</td>
	</tr>
</table>
<%
			}
                        
%>
<TABLE width="100%" border="0">
	<%
				if(request.getParameter("update")!=null && request.getParameter("update").equalsIgnoreCase("disabled"))
				{
				    %>
	<Tr>
		<td align="center"><font color="red"><%= request.getParameter("noofrecords")%>
		Contact(s) have been disabled!</font></td>
	</Tr>
	<%
				}
				if(request.getParameter("update")!=null && request.getParameter("update").equalsIgnoreCase("enabled"))
				{
				    %>
	<Tr>
		<td align="center"><font color="green"><%= request.getParameter("noofrecords")%>
		Contact(s) have been Enabled!</font></td>
	</Tr>
	<%
				}
			
			%>
	<tr>
		<td>
			<a href="<%=request.getContextPath() %>/admin/customer/addnewcontact.jsp">Add Contact</a>&nbsp;&nbsp;&nbsp;&nbsp;
			<a href="<%=request.getContextPath() %>/admin/customer/viewcontact.jsp">View All Contacts</a>&nbsp;&nbsp;&nbsp;&nbsp; 
			<a href="<%=request.getContextPath() %>/admin/customer/waitingContacts.jsp">Approve Contact</a>&nbsp;&nbsp;&nbsp;&nbsp; 
			<a href="<%=request.getContextPath() %>/admin/customer/deniedContacts.jsp">Denied Contact</a>&nbsp;&nbsp;&nbsp;&nbsp; 
			<a href="<%=request.getContextPath() %>/admin/customer/disabledContacts.jsp">Disabled Contact</a></td>
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
		<td align="right"><a href="javascript:SetChecked(1,'approve')"><font
			face="Arial, Helvetica, sans-serif" size="2">Select All</font></a> <a
			href="javascript:SetChecked(0,'approve')"><font
			face="Arial, Helvetica, sans-serif" size="2">Clear All</font></a></td>
	</tr>
	<form name="showleads" action="approveContacts.jsp"
		onSubmit="return ValidateForm(this,'approve')">
</TABLE>
<br>
<table width=100%>
	<TR bgColor="#C3D9FF" height="9">
		<TD width="20%"><font><b>Name</b></font></TD>
		<TD width="13%"><font><b>Account</b></font></TD>
		
		<TD width="11%"><font><b>Phone</b></font></TD>
		<TD width="18%"><font><b>Email</b></font></TD>

		<TD width="12%"><font><b>Owner</b></font></TD>
		<TD width="8%"><font><b>Due Date</b></font></TD>
		<TD width="13%"><font><b>Assigned To</b></font></TD>
		<TD width="5%" TITLE="In Days" ALIGN="center"><font><b>Age</b></font></TD>
		
	</TR>

	<%
			int contactid=9999,age;
			String fname="",lname="",title="",account="",email="",phone="",mobile=null,fullname="",createdon=null,duedate=null,assignedTo=null,owner=null;
			
		
			if(rs!=null)
			{ 
			    for(int i=1;i<=15;i++)
				{
					if(rs.next())
					{
						contactid=rs.getInt("contactid");
						fname=rs.getString("firstname");
						if (fname==null)
							fname="";
						lname=rs.getString("lastname");
						if (lname==null)
							lname="";
                                                fullname=fname+" "+lname;
						title=rs.getString("title");
						if (title==null)
							title="nil";
						account=rs.getString("accountname");
						if (account==null)
							account="nil";
						email=rs.getString("email");
						if (email==null)
							email="";
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
						
						mobile=rs.getString("mobile");
						
						
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
                        
                        String own		= rs.getString("contact_owner");
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
                                                if (fullname.length()<25)
                                                    {
%>
		<td width="20%" title="<%= StringUtil.encodeHtmlTag(title) %>"><input type="checkbox" name="approve" value="<%= email %>"><font
			face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><A HREF="editContact.jsp?contactid=<%=contactid%>"><%= StringUtil.encodeHtmlTag(fname)%>&nbsp;<%= StringUtil.encodeHtmlTag(lname) %></A></font></td>
		<%
                                                        }
                                                        else
                                                            {
                                                        %>
		<td width="20%" title="<%= StringUtil.encodeHtmlTag(title) %>"><input type="checkbox" name="approve" value="<%= email %>"><font
			face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><A HREF="editContact.jsp?contactid=<%=contactid%>"><%= fullname.substring(0,22)+"..."%></A></font></td>
		<%
                                                        }
                                                        %>
		<td width="13%"><font
			face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%= StringUtil.encodeHtmlTag(account) %></font></td>
		
		<td width="11%" title="Mobile No. <%=  mobile%>"><font
			face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%= phone %></font></td>
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

		<%if (owner.length()<15)
                                                    {
 %>
		<td width="12%"><font
			face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%= StringUtil.encodeHtmlTag(owner) %></font></td>
		<%
                                                        }
                                                        else
                                                            {
                                                            %>
		<td width="12%"><font
			face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%= owner.substring(0,15)+"..." %></font></td>
		<%
                                                            }
                                                            %>
		<TD width="8%" title="Last Modified On <%= modified %>"><font><%=dueDate %></font></TD>
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
		<td colspan="8" align="center"><input type="submit" name="submit"
			value="Disable"></td>
	</tr>
	<%
	
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
			<td><a href=viewContactStatus.jsp?manipulation=3>Next</a></td>
			<td><a href=viewContactStatus.jsp?manipulation=4>Last</a></td>
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
			<td><a href=viewContactStatus.jsp?manipulation=3>Next</a></td>
			<td><a href=viewContactStatus.jsp?manipulation=4>Last</a></td>
		</tr>
	</table>
	<%
			}	
			else if(request.getParameter("manipulation").equals("4"))
			{
%>
	<table align=right>
		<tr>
			<td><a href=viewContactStatus.jsp?manipulation=1>First</a></td>
			<td><a href=viewContactStatus.jsp?manipulation=2>Prev</a></td>
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
			<td><a href=viewContactStatus.jsp?manipulation=1>First</a></td>
			<td><a href=viewContactStatus.jsp?manipulation=2>Prev</a></td>
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
			<td><a href=viewContactStatus.jsp?manipulation=1>First</a></td>
			<td><a href=viewContactStatus.jsp?manipulation=2>Prev</a></td>
			<td><a href=viewContactStatus.jsp?manipulation=3>Next</a></td>
			<td><a href=viewContactStatus.jsp?manipulation=4>Last</a></td>
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
			<td><a href=viewContactStatus.jsp?manipulation=3>Next</a></td>
			<td><a href=viewContactStatus.jsp?manipulation=4>Last</a></td>
		</tr>
	</table>
	<%
			}
			else if(request.getParameter("manipulation").equals("2"))
			{
%>
	<table align=right>
		<tr>
			<td><a href=viewContactStatus.jsp?manipulation=1>First</a></td>
			<td><a href=viewContactStatus.jsp?manipulation=2>Prev</a></td>
			<td><a href=viewContactStatus.jsp?manipulation=3>Next</a></td>
			<td><a href=viewContactStatus.jsp?manipulation=4>Last</a></td>
		</tr>
	</table>
	<%
			}
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