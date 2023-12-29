<%@ page language="java" contentType="text/html"
	pageEncoding="UTF-8"%>
<%@ page import="org.apache.log4j.*,pack.eminent.encryption.*,com.eminent.util.*,java.text.*"%>
<%
	//Configuring log4j properties
	

	
	Logger logger = Logger.getLogger("searchLead");
	
	
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
<script type="text/javaScript">
     function check(searchLead)  {
    if ((searchLead.leadName.value==null)||(searchLead.leadName.value==""))
		{
			alert("Please Enter Name or Company ")
			searchLead.leadName.focus()
			return false
		}
                monitorSubmit();
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
  </script>
</head>
<body>
<%@ page import="java.sql.*"%>

<%@ include file="/header.jsp"%>
<form name="searchLead" onsubmit="return check(this);"
	action="searchLead.jsp">
<table cellpadding="0" cellspacing="0" width="100%">
	<tr border="2" bgcolor="#E8EEF7">
		<td bgcolor="#E8EEF7" border="1" align="left"><font size="4"
			COLOR="#0000FF"> <b> CRM Lead Search </b></font><FONT SIZE="3"
			COLOR="#0000FF"> </FONT></td>
		<td align="right"><b>Enter the Name or Company:</b></td>
		<td align="left"><input type="text" name="leadName" maxlength="40"
			size="15"></td>
		<td><input type="submit" id="submit" name="submit" value="Search"></td>
		<td><input type="reset" id="reset" name="reset" value="Reset"></td>
		<td width="25%" border="1" align="right"><font size="2"
			face="Verdana, Arial, Helvetica, sans-serif"></font></td>
	</tr>
</table>
</form>
<%

     // Checking whether the user has entered the name to search for
     String leadName = request.getParameter("leadName");

session.setAttribute("forwardpage","viewlead.jsp");
     
      
        Connection  connection = null;
	Statement st=null;
	ResultSet rs=null;
	try{
		connection=MakeConnection.getConnection();
		logger.debug("Connection has been created:"+connection);
	
		if(connection != null)  
		{
			st = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
                        
                                leadName = leadName.trim();
                                rs = st.executeQuery("SELECT LEADID,TITLE,FIRSTNAME, LASTNAME, COMPANY, STATE,PHONE,MOBILE,EMAIL,LEADSTATUS,RATING,DUEDATE,ASSIGNEDTO,CREATEDON,MODIFIEDON,LEAD_OWNER from lead where (upper(firstname) like upper('%"+leadName+"%"+"') or upper(lastname) like upper('%"+leadName+"%"+"') or upper(company) like upper('%"+leadName+"%"+"')) and roleid=2 order by FIRSTNAME ASC ");
                                
			rs.last();
			int rCount=rs.getRow();
			rs.beforeFirst();
                        if(rCount == 0){
                            %>
<table>
	<tr>
		<td><a
			href="<%=request.getContextPath() %>/admin/customer/addnewlead.jsp">Add
		Lead</a>&nbsp;&nbsp;&nbsp;&nbsp; <a
			href="<%=request.getContextPath() %>/admin/customer/waitingLead.jsp">Approve
		Lead</a>&nbsp;&nbsp;&nbsp;&nbsp; <a
			href="<%=request.getContextPath() %>/admin/customer/deniedLeads.jsp">Denied
		Lead</a>&nbsp;&nbsp;&nbsp;&nbsp; <a
			href="<%=request.getContextPath() %>/admin/customer/disabledLead.jsp">Disabled
		Lead</a></td>


	</tr>

</table>
<table align="center" height="70%">
	<tr>
		<td>
		<h3>No leads are available while matching the name.</h3>
		</td>
	</tr>
</table>

<%
                        }else{
			

			%>
            <table>
	<tr>
		<td><a
			href="<%=request.getContextPath() %>/admin/customer/addnewlead.jsp">Add
		Lead</a>&nbsp;&nbsp;&nbsp;&nbsp; <a
			href="<%=request.getContextPath() %>/admin/customer/waitingLead.jsp">Approve
		Lead</a>&nbsp;&nbsp;&nbsp;&nbsp; <a
			href="<%=request.getContextPath() %>/admin/customer/deniedLeads.jsp">Denied
		Lead</a>&nbsp;&nbsp;&nbsp;&nbsp; <a
			href="<%=request.getContextPath() %>/admin/customer/disabledLead.jsp">Disabled
		Lead</a></td>


	</tr>

</table>
<table width="100%">
	<tr>
		<td>This list shows <b> <%=rCount %></b>leads searched by you.</td>

		<td align="right"><a href="javascript:SetChecked(1,'approve')"><font
			face="Arial, Helvetica, sans-serif" size="2">Select All</font></a> <a
			href="javascript:SetChecked(0,'approve')"><font
			face="Arial, Helvetica, sans-serif" size="2">Clear All</font></a></td>
	</tr>
</table>
<br>
<form name="showusers" action="approveLeads.jsp"
	onSubmit="return ValidateForm(this,'approve')">
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
		<TD width="5%"><font><b>Manage</b></font></TD>
	</TR>

	<%
	String firstname=null,lastname=null,company=null,state=null,email=null,leadstatus=null,phone=null,duedate=null,assignedTo=null,createdon=null,owner=null,mobile=null,title=null,rate=null;
	int leadid=9999,age=0;
	if(rs!=null)
	{ 
	    for(int i=1;i<=rCount;i++)
		{
			if(rs.next())
			{
				logger.info("Inside loop");
				
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
				
				
				logger.info("Got every thing from DB");
				
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
<td width="18%" title="<%=  title%>"><font
	face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"><A
	HREF="editLead.jsp?leadid=<%=leadid%>"><%= StringUtil.encodeHtmlTag(name)%></A></font></td>
<%
                }
                else
                {
                %>
<td width="18%" title="<%=  title%>"><font
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




<td width="10%"><input type="checkbox" name="approve" value="<%= leadid %>"></td>
</tr>
<% 
			}
		}
	}
			if(rCount>0)
			{
				%>
	<tr>
		<td colspan="6" align="center"><input type="submit" name="submit"
			value="Disable"></td>
	</tr>
	<%
	
	   		}
			
                      }  
		}
                }
    
	catch(Exception e)
	{
            logger.error(e);
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