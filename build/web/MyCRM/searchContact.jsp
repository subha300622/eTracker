<%@ page language="java" contentType="text/html"
	pageEncoding="UTF-8"%>
<%@ page import="org.apache.log4j.*,pack.eminent.encryption.*,java.text.*,com.eminent.util.*"%>
<%
	//Configuring log4j properties
	
	
	
	Logger logger = Logger.getLogger("User's searchContact");
	
	
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
<TITLE>eTracker&#0153; - Eminentlabs CRM,APM,ERM and PTS
Solution</TITLE>
<script language="JavaScript">
    function check(searchContact)  {
    if ((searchContact.contactName.value==null)||(searchContact.contactName.value==""))
		{
			alert("Please Enter Contact Name ")
			searchContact.contactName.focus()
			return false
		}
                return true
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
        
</script>
</head>
<body>
<%@ page import="java.sql.*,java.util.HashMap"%>
<jsp:useBean id="CRMIssue" class="com.pack.CRMIssueBean" />

<%@ include file="/header.jsp"%>
<form name="searchContact" onsubmit="return check(this);"
	action="searchContact.jsp">
<table cellpadding="0" cellspacing="0" width="100%" bgColor="#E8EEF7">
	<tr>
		<td align="left"><font size="4" COLOR="#0000FF"><b>Contact
		Search</b> </font>
		<td align="center"><b>Enter the Name or Company Name:</b></td>
		<td align="left"><input type="text" name="contactName"
			maxlength="20" size="15"></td>
		<td><input type="submit" name="submit" value="Search"></td>
		<td><input type="reset" name="reset" value="Reset"></td>
		<td></td>
	</tr>
</table>
</form>
<%
    HashMap<String,Integer> hm=null;
     // Checking whether the user has entered the name to search for
     String contactName = request.getParameter("contactName");
	String firstname=null,lastname=null;
		if(contactName!=null){
			
			int index =contactName.indexOf(" ");
			if(index>0){
				firstname=contactName.substring(0,contactName.indexOf(" "));
				lastname=contactName.substring(contactName.indexOf(" "),contactName.length());
			}
			else{
				firstname=contactName;
				lastname=contactName;
			}
		}
     int adminUserId =   0;
    HashMap<String,String> Admin=GetProjectMembers.getAdminDetail();
    if(Admin!=null){
        adminUserId=Integer.parseInt(Admin.get("userid"));
    }

    int pmanager =	Integer.parseInt(GetProjectManager.getManager("CRM","1.0"));

     

	Connection  connection = null;
	Statement st=null;
	ResultSet rs=null;
	try
        {
		connection=MakeConnection.getConnection();
		logger.debug("Connection has been created:"+connection);
	
		if(connection != null)  
		{

            Integer userid_curr =(Integer)session.getAttribute("userid_curr");
			int userid_curri= userid_curr.intValue();

            int apmIssues=CRMIssue.getAPMIssues(connection,userid_curri);
			hm=CRMIssue.getCRMIssuesCounts(connection,userid_curri);
			int contact=hm.get("Contact");
			int lead=hm.get("Lead");
			int opportunity=hm.get("Opportunity");
			int accountno=hm.get("Account");

           

			st = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
            contactName = contactName.trim();
            if(adminUserId==userid_curri||pmanager==userid_curri){
                        rs = st.executeQuery("SELECT contactid,FIRSTNAME,LASTNAME,ACCOUNTNAME,TITLE,PHONE,MOBILE,EMAIL,CREATEDON,DUEDATE,ASSIGNEDTO,MODIFIEDON from CONTACT where (upper(firstname) like upper('%"+firstname+"%"+"') or upper(lastname) like upper('%"+lastname+"%"+"') or upper(accountname) like upper('%"+contactName+"%"+"')) and roleid=2 order by FIRSTNAME ASC ");
            }else{
                 rs = st.executeQuery("SELECT contactid,FIRSTNAME,LASTNAME,ACCOUNTNAME,TITLE,PHONE,MOBILE,EMAIL,CREATEDON,DUEDATE,ASSIGNEDTO,MODIFIEDON from CONTACT where (upper(firstname) like upper('%"+firstname+"%"+"') or upper(lastname) like upper('%"+lastname+"%"+"') or upper(accountname) like upper('%"+contactName+"%"+"')) and assignedto='"+ userid_curri+"'and roleid=2 order by FIRSTNAME ASC ");
            }
                        rs.last();
			int rowcount=rs.getRow();
                        if(rowcount == 0){
                            %>
   <table width="100%">
	<tr>
		<td colspan="3">


		<%
		if(lead>0){
		%>
		<a href="<%=request.getContextPath() %>/MyCRM/crmLeadIssues.jsp">Lead Issues</a>&nbsp;&nbsp;&nbsp;&nbsp;
		<%}
		if(opportunity>0){
		%>
		<a href="<%=request.getContextPath() %>/MyCRM/crmOpportunityIssues.jsp">Opportunity Issues</a>&nbsp;&nbsp;&nbsp;&nbsp;
		<%}
		if(accountno>0){
		%>
		<a href="<%=request.getContextPath() %>/MyCRM/crmAccountIssues.jsp">Account Issues</a>
		<%} %>
		</td>

		<%if(apmIssues>0){ %>
		<td align="left" width="20%">You have <a href="<%=request.getContextPath() %>/MyAssignment/UpdateIssue.jsp"><%=apmIssues %></a> APM Issues</td>
		<%}%>





	</tr>
</table>
<table align="center" height="70%">
	<tr>
		<td>
		<h3>No contacts are available while matching the name.</h3>
		</td>
	</tr>
</table>

<%
                        }else{
			

%>

    <table width="100%">
	<tr>
		<td colspan="3">


		<%
		if(lead>0){
		%>
		<a href="<%=request.getContextPath() %>/MyCRM/crmLeadIssues.jsp">Lead Issues</a>&nbsp;&nbsp;&nbsp;&nbsp;
		<%}
		if(opportunity>0){
		%>
		<a href="<%=request.getContextPath() %>/MyCRM/crmOpportunityIssues.jsp">Opportunity Issues</a>&nbsp;&nbsp;&nbsp;&nbsp;
		<%}
		if(accountno>0){
		%>
		<a href="<%=request.getContextPath() %>/MyCRM/crmAccountIssues.jsp">Account Issues</a>
		<%} %>
		</td>
	</tr>
	<tr>
		<%
		if(rowcount==0)
		{
			%>
		<td align="left" width="40%">This list shows <b> <%=rowcount %>
		</b>contacts searched by you.</td>
		<%
		}
		else
		{
			%>
		<td align="left" width="40%">This list shows <b> <%=rowcount %>
		</b>contacts searched by you.</td>
		<%
		}
	%>
		<%if(apmIssues>0){ %>
		<td align="left" width="40%">You have <a href="<%=request.getContextPath() %>/MyAssignment/UpdateIssue.jsp"><%=apmIssues %></a> APM Issues</td>
		<%}else{ %>
		<td align="right" width="25" ></td>
		<%} %>
		


		
		
	</tr>
</table>


<table width=100%>
	<TR bgColor="#C3D9FF" height="9">
		<TD width="18%"><font><b>Name</b></font></TD>
		<TD width="13%"><font><b>Account</b></font></TD>
		<TD width="12%"><font><b>Title</b></font></TD>
		<TD width="12%"><font><b>Phone</b></font></TD>
		<TD width="13%"><font><b>Email</b></font></TD>
		<TD width="9%"><font><b>Due Date</b></font></TD>
		<TD width="13%"><font><b>Assigned To</b></font></TD>
		<TD width="5%" TITLE="In Days" ALIGN="center"><font><b>Age</b></font></TD>
		
	</TR>


	<%
			int contactid=9999,age;
	String fname="",lname="",title="",account="",email="",phone="",mobile=null,fullname="",createdon=null,duedate=null,assignedTo=null;
                        rs.beforeFirst();
			if(rs!=null)
			{ 
			    for(int i=1;i<=rowcount;i++)
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
                        
						Date modifiedOn = rs.getDate("modifiedon");
						
						String modified = "NA";
                        if(modifiedOn != null){
                        	modified = sdf.format(modifiedOn);
                        }
						
						if(( i % 2 ) != 0){
%>
	<tr bgcolor="white" height="21">
		<%
						}else{
%>
	
	<tr bgcolor="#E8EEF7" height="21">
		<%
						}
						 if (fullname.length()<25)
                         {
%>
<td width="18%"><font
face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><A HREF="contactIssueView.jsp?contactid=<%=contactid%>"><%= StringUtil.encodeHtmlTag(fname)%>&nbsp;<%= StringUtil.encodeHtmlTag(lname) %></A></font></td>
<%
                             }
                             else
                                 {
                             %>
<td width="18%"><font
face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><A HREF="contactIssueView.jsp?contactid=<%=contactid%>"><%= fullname.substring(0,25)+"..."%></A></font></td>
<%
                             }
                             %>
<td width="13%"><font
face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%= StringUtil.encodeHtmlTag(account) %></font></td>
<%if (title.length()<15)
                         {
%>
<td width="12%"><font
face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%= StringUtil.encodeHtmlTag(title) %></font></td>
<%
                             }
                             else
                                 {
                                 %>
<td width="12%"><font
face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%= title.substring(0,15)+"..." %></font></td>
<%
                                 }
                                 %>
<td width="12%" title="Mobile No. <%=  mobile%>"><font
face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%= phone %></font></td>
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
<TD width="9%" title="Last Modified On <%= modified %>"><font><%=dueDate %></font></TD>
<TD width="13%"><font><%=assignedTo %></font></TD>
<td width="5%" align="center"><font face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><%=createdon%></font></td>


</tr>
	<% 
					}
				}
			}
                        
				%>

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