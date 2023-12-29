<%-- 
    Document   : showContact
    Created on : 26 Jun, 2010, 11:59:42 AM
    Author     : ADAL
--%>
<%@ page language="java" contentType="text/html"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*,pack.eminent.encryption.*,java.util.*,com.eminent.util.*,org.apache.log4j.*,java.text.*"%>
<%

	
	Logger logger = Logger.getLogger("Add New Contact");

	String logoutcheck=(String)session.getAttribute("Name");
	if(logoutcheck==null)
	{
		%>
<jsp:forward page="../SessionExpired.jsp"></jsp:forward>
<%

	}
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>

<meta name="keywords" content="GST in SAP, SAP GST Accelerator, GST Success in SAP, GST India in SAP, GST SAP Success, GST Suvidha Provider, GST ASP GSP, GST, CGST,SGST, IGST, UGST,  SAP NW based Product Development, SAP Consulting, SAP Implementation, SAP Support Services, SAP Outsourcing, SAP Implementation India, SAP Implementation Bangalore, SAP Implementation Chennai, SAP Implementation Belgium, SAP Implementation Paris, SAP Implemtation Australia, SAP Implementation France, SAP Implementation Mumbai, SAP Implementation Kerala, SAP Implementation Belgaum, SAP Implementation Thailand, SAP Implementation Mexico, SAP Implementation America">
<meta http-equiv="Content-Type" content="text/html ">
<LINK title=STYLE href="<%= request.getContextPath() %>/eminentech support files/main_ie.css" type="text/css" rel=STYLESHEET>
<title>eTracker&#0153; - Eminentlabs&#0153; CRM,APM,ERM and PTS Solution</title>

</head>
<body>
<jsp:include page="/header.jsp" />
<BR>
<!-- Table To Display The Formatted String "Add New User" -->
<table  width="100%">
	<tr  bgcolor="#c3d9ff">
		<td  align="left" ><font size="4"
			COLOR="#0000FF"><b> Contact Information</b></font> <FONT SIZE="3"
			COLOR="#0000FF"> </FONT></td>
		
	</tr>
</table>
<BR>
<FORM name=theForm onsubmit="return fun(this)"
	action="<%=request.getContextPath() %>/admin/customer/updatecontact.jsp"
	method=post onReset="return setFocus()"><%@ page
	import="java.sql.*,pack.eminent.encryption.*"%> <%
int contactid=Integer.parseInt(request.getParameter("contactid"));
Connection connection = null;
Statement st=null;
ResultSet rs=null;
try  {
	connection=MakeConnection.getConnection();
	if(connection != null)  {
		st = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);

		rs = st.executeQuery("Select EMAIL,FIRSTNAME,LASTNAME,ACCOUNTNAME, contact_owner, TITLE,PHONE,MOBILE,REPORTSTO,MAILINGSTREET,MAILINGCITY,MAILINGSTATE,MAILINGZIP,MAILINGCOUNTRY,OTHERSTREET,OTHERCITY,OTHERSTATE,OTHERZIP,OTHERCOUNTRY,FAX,HOMEPHONE,OTHERPHONE,ASSISTANT,ASSTPHONE,LEADSOURCE,BIRTHDATE,DEPARTMENT,DESCRIPTION,assignedto,company,duedate,rating,modifiedon,INTERESTED,ROLEID  from contact where contactid="+contactid);
		if(rs!=null)
		{
			while(rs.next())
			{

				String firstname=rs.getString("FIRSTNAME");
				String lastname=rs.getString("LASTNAME");
                String contactOwner=rs.getString("CONTACT_OWNER");
				String accountname=rs.getString("ACCOUNTNAME");
				String title=rs.getString("TITLE");
				String phone=rs.getString("PHONE");
				String mobile=rs.getString("MOBILE");
				String reportsto=rs.getString("REPORTSTO");
				String company=rs.getString("company");
				String email=rs.getString("EMAIL");
				String mailingstreet=rs.getString("MAILINGSTREET");
				String mailingcity=rs.getString("MAILINGCITY");
                String mailingstate=rs.getString("MAILINGSTATE");
				String mailingzip=rs.getString("MAILINGZIP");
				String mailingcountry=rs.getString("MAILINGCOUNTRY");
                String otherstreet=rs.getString("OTHERSTREET");
                String othercity=rs.getString("OTHERCITY");
				String otherstate=rs.getString("OTHERSTATE");
                String otherzip=rs.getString("OTHERZIP");
                String othercountry=rs.getString("OTHERCOUNTRY");
				String fax=rs.getString("FAX");
				String homephone=rs.getString("HOMEPHONE");
				String otherphone=rs.getString("OTHERPHONE");
				String assistant=rs.getString("ASSISTANT");
				String asstphone=rs.getString("ASSTPHONE");
				String leadsource=rs.getString("LEADSOURCE");
				String birthdate=rs.getString("BIRTHDATE");
				String department=rs.getString("DEPARTMENT");
				String description=rs.getString("DESCRIPTION");


				String rating=rs.getString("rating");

				int assi=rs.getInt("assignedto");

				java.util.Date due=rs.getDate("duedate");

				SimpleDateFormat dfm =  new SimpleDateFormat("dd-MMM-yy");
				String dueDate = "NA";
                if(due != null){
                    dueDate = dfm.format(due);
                }

                SimpleDateFormat sdf = new SimpleDateFormat("dd-MMM-yy");

                java.sql.Date modifiedOn = rs.getDate("modifiedon");

				String modified = "NA";
                if(modifiedOn != null){
                	modified = sdf.format(modifiedOn);
                }

                String product=rs.getString("INTERESTED");
                int	   roleid		=	rs.getInt("ROLEID");


                if (firstname==null) firstname="NA";
                if (lastname==null) lastname="NA";
                if (accountname==null) accountname="NA";
				if (phone==null) phone="NA";
				if (mobile==null) mobile="NA";
				if (title==null) title="NA";
				if (reportsto==null) reportsto="NA";
				if (email==null) email="NA";
				if (mailingstreet==null) mailingstreet="NA";
				if (mailingcity==null) mailingcity="NA";
				if (mailingstate==null)	mailingstate="NA";
				if (mailingzip==null) mailingzip="NA";
				if (mailingcountry==null) mailingcountry="NA";
				if (otherstreet==null) otherstreet="NA";
				if (othercity==null) othercity="NA";
				if (otherstate==null)	otherstate="NA";
				if (otherzip==null) otherzip="NA";
				if (othercountry==null) othercountry="NA";
				if (fax==null) fax="NA";
				if (homephone==null) homephone="NA";
				if (otherphone==null) otherphone="NA";
				if (assistant==null) assistant="NA";
				if (asstphone==null)	asstphone="NA";
				if (birthdate==null)birthdate="NA";
				if (department==null) department="NA";
				if (description==null) description="NA";
				if (company==null) company="NA";
				if(rating==null) rating="NA";
				if(product==null) product="NA";
				if(leadsource==null) leadsource="NA";



		%>

<table width="100%" bgColor=#E8EEF7  align="center">
	<TBODY>


		<tr>
			<td width="10%"><strong>Title</strong></td>
			<td width="21%"><%=title%></td>
			<td width="10%"><strong>First Name</strong></td>
			<td width="25%"><%=firstname%></td>
			<td width="12%"><strong>Last Name </strong></td>
			<td width="23%"><%=lastname%></strong></td>
		</tr>

		<tr>


			<td width="10%"><strong>Phone</strong></td>
			<td width="21%"><%=phone%></td>
			<td width="10%"><strong>Email</strong></td>
			<td width="25%"><%=email%></td>
			<td width="12%"><strong>Assigned To </strong></td>
			<td width="23%"><%=GetProjectMembers.getUserName(((Integer)assi).toString())%></td>





		</tr>
		<tr>
			<td width="10%"><strong>Mobile</strong></td>
			<td width="21%"><%=mobile%></td>

			<td width="10%"><strong>Company</strong></td>
			<td width="23%"><%=company%></td>

			<td width="12%"><strong>Reports to</strong></td>
			<td width="23%"><%=reportsto%></td>
		</tr>
		<tr>
			<td width="10%"><strong>Rating</strong></td>
			<td width="21%"> <%=rating%></td>


			<td width="10%"><strong>Accounts</strong></td>
		
			<td width="23%"><%=accountname%></td>


			<td width="12%"><strong>Contact Owner</strong></td>
			<td width="23%"><%= GetProjectMembers.getUserName(contactOwner) %></td>


		</tr>
		<tr>
					<td width="10%"><strong>Due Date</strong></td>
					<td width="21%"><%=dueDate%></td>
					<td width="10%"><strong>Modified On</strong></td>
					<td width="21%"><%=modified%></td>
					<td width="12%"><strong>Interested In </strong></td>
			<td width="23%"><%= product%></td>

		</tr>

		<tr><td width="100%" bgcolor="white" colspan=6 height="10"></td></tr>
		<tr bgcolor="C3D9FF">
			<td colspan=5><strong >Address Information</strong></td>
			<td><input type="hidden" name="contactid" value="<%=contactid %>"></td>
			<td><input type="hidden" name="contactowner" value="<%=contactOwner %>"></td>
		</tr>

		<tr>
			<td width="10%"><strong>Street</strong></td>
			<td width="21%"><%=mailingstreet%></td>


			<td width="10%"><strong>City</strong></td>
			<td width="23%"><%=mailingcity%></td>


			<td width="12%"><strong>State</strong></td>
			<td width="23%"><%=mailingstate%></td>

		</tr>
		<tr>
			<td width="10%"><strong>Zip</strong></td>
			<td width="21%"><%=mailingzip%></td>

			<td width="10%"><strong>Country</strong></td>
			<td width="23%"><%=mailingcountry%></strong></td>
			
		</tr>

		<tr><td width="100%" bgcolor="white" colspan=6 height="10"></td></tr>

		<tr bgcolor="C3D9FF">
			<td colspan=6><strong>Additional Information</strong></td>
		</tr>


		<tr>
			<td width="10%"><strong>Fax</strong></td>
			<td width="21%"<%=fax%></td>
			<td width="10%"><strong>Home Phone</strong></td>
			<td width="23%"><%=homephone%></td>
			<td width="12%"><strong>Other Phone</strong></td>
			<td width="23%"><%=otherphone%></td>

		</tr>

		<tr>

			<td width="10%"><strong>Department</strong></td>
			<td width="21%"><%=department%></td>

			<td width="10%"><strong>Assistant</strong></td>
			<td width="23%"><%=assistant%></td>

			<td width="12%"><strong>Asst. Phone</strong></td>
			<td width="23%"><%=asstphone%></td>
		</tr>
<tr>
			<td width="10%"><strong>Birthdate</strong></td>
			<td width="21%"><%=birthdate%></td>
			<td width="10%"><strong>Lead Source</strong></td>

			<td align="left" width="23%"><%= leadsource %></td>



		</tr>
	<tr><td width="100%" bgcolor="white" colspan=6 height="10"></td></tr>
		<tr bgcolor="C3D9FF" width="100%">
			<td colspan=6 width="100%"><strong>Description</strong></td>
		</tr>

		<tr >

			<td colspan=6><%=description%></td>
		</tr>

	

	
</TBODY>
</table>
<%
                   session.setAttribute("name",firstname);
                   session.setAttribute("category","contact");
                %> <iframe
	src="./comments.jsp?contactId=<%= contactid %>" scrolling="auto"
	frameborder="2" height="45%" width="100%"></iframe> <br>
<br>
<br>


</FORM>

<%
			}
		}
	}
}catch(Exception ex)
		{
			logger.error(ex.getMessage());
		}finally
				{
			if(rs!=null)
			{
					rs.close();
			}
			if(st!=null)
			{
					st.close();
			}
//					rs.close();
					if (connection!=null)
					{
						connection.close();
					}

				}
%>
<BR>
</body>
</html>
