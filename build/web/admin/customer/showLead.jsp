<%-- 
    Document   : showLead
    Created on : 29 Jun, 2010, 6:36:36 PM
    Author     : Tamilvelan
--%>
<%@ page language="java" contentType="text/html"
	pageEncoding="UTF-8"%>
<%@ page import="org.apache.log4j.*,java.text.*" %>
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
<script type="text/javascript"	src="<%= request.getContextPath() %>/eminentech support files/simpleUtilities.js"></script>
<title>eTracker&#0153; - Eminentlabs CRM,APM,ERM and PTS Solution</title>
<script type="text/javascript"	src="<%= request.getContextPath() %>/eminentech support files/datetimepicker.js"></script>
<script type="text/javascript" src="<%= request.getContextPath() %>/javaScript/checkSubmit.js"></script>
</head>

<body>
<jsp:include page="/header.jsp" />
<BR>
<!-- Table To Display The Formatted String "Add New User" -->
<table cellpadding="0" cellspacing="0" width="100%">
	<tr border="2" bgcolor="#c3d9ff">
		<td border="1" align="left" width="100%"><font size="4"
			COLOR="#0000FF"><b> Lead Information</b></font> <FONT SIZE="3"
			COLOR="#0000FF"> </FONT></td>
	</tr>
</table>
<BR>

<%@ page import="java.sql.*,pack.eminent.encryption.*,com.eminent.util.*,java.util.*"%> <%
int leadid=Integer.parseInt(request.getParameter("leadid"));
Connection connection = null;
Statement st=null;
ResultSet rs=null;
int assi=0;
try  {
	connection=MakeConnection.getConnection();
	if(connection != null)  {
		st = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);

		rs = st.executeQuery("Select COMPANY,FIRSTNAME,LASTNAME,TITLE,LEADSTATUS,PHONE,EMAIL,RATING,STREET,CITY,STATE,ZIP,COUNTRY,WEBSITE,NOOFEMPLOYEES,ANNUALREVENUE,LEADSOURCE,INDUSTRY,DESCRIPTION,MOBILE,LEADPOTENTIAL,INTERESTED,ASSIGNEDTO,DUEDATE,LEAD_OWNER,ROLEID from lead where leadid="+leadid);
		if(rs!=null)
		{
			while(rs.next())
			{
				String company		=	rs.getString("COMPANY");
				String firstname	=	rs.getString("FIRSTNAME");
				String lastname		=	rs.getString("LASTNAME");
				String title		=	rs.getString("TITLE");
				String leadstatus	=	rs.getString("LEADSTATUS");
				String phone		=	rs.getString("PHONE");
				String email		=	rs.getString("EMAIL");
				String website		=	rs.getString("WEBSITE");
				String annualrevenue=	rs.getString("ANNUALREVENUE");
				String leadsource	=	rs.getString("LEADSOURCE");
				String industry		=	rs.getString("INDUSTRY");
                String noofemployees=	rs.getString("NOOFEMPLOYEES");
				String rating		=	rs.getString("RATING");
				String description	=	rs.getString("DESCRIPTION");
                String street		=	rs.getString("STREET");
                String city			=	rs.getString("CITY");
				String state		=	rs.getString("STATE");
                String zip			=	rs.getString("ZIP");
                String country		=	rs.getString("COUNTRY");
                String mobile		=	rs.getString("MOBILE");
                String leadpotential=	rs.getString("LEADPOTENTIAL");
                String product		=   rs.getString("INTERESTED");
                String assignedto	=   rs.getString("ASSIGNEDTO");
                String owner		=   rs.getString("LEAD_OWNER");
                int	   roleid		=	rs.getInt("ROLEID");

				java.util.Date due=rs.getDate("duedate");

				SimpleDateFormat dfm =  new SimpleDateFormat("dd-MMM-yy");
				String dueDate = "NA";
                if(due != null){
                    dueDate = dfm.format(due);
                }

                if (company==null) company="NA";
                if (firstname==null) firstname="NA";
                if (lastname==null) lastname="NA";
                if (phone==null) phone="NA";
                if (email==null) email="NA";
                if (title==null) title="NA";
                if (website==null) website="NA";
                if (leadsource==null) leadsource="NA";
                if (leadstatus==null) leadstatus="NA";
                if (industry==null)	industry="NA";
                if (rating==null)	rating="NA";
                if (noofemployees==null)noofemployees="NA";
                if (annualrevenue==null) annualrevenue="NA";
                if (description==null) description="NA";
                if (street==null) street="NA";
                if (city==null) city="NA";
                if (state==null)	state="NA";
                if (zip==null) zip="NA";
                if (country==null) country="NA";
                if (mobile==null) mobile="NA";
                if (leadpotential==null) leadpotential="NA";
                if (product==null)
                        product="NA";


                if(assignedto!=null){
                	assi=Integer.parseInt(assignedto);
                }


		%>

<table width="100%"  bgcolor="C3D9FF" border="0" align="center">
	<TBODY>
		<tr>
			<td><strong>Lead Information</strong></td>
			<td align="right"><strong><font size="10"
				COLOR="#FF0000">*</font> = Required Information</strong></td>
		</tr>
	</tbody>
</table>
<table width="100%" bgColor=#E8EEF7 border="0" align="center">
	<TBODY>
		<tr>
			<td width="10%"><strong>Title</strong></td>
			<td width="21%"><%=title%></td>
			<td width="10%"><strong>First Name</strong></td>
			<td width="25%"><%=firstname%></td>
			<td width="12%"><strong>Last Name </strong></td>
			<td width="23%"><%=lastname%></td>
		</tr>
		<tr>

			<td width="10%"><strong>Phone</strong></td>
			<td width="21%"><%=phone%></td>
			<td width="10%"><strong>Email</strong></td>
			<td width="25%"><%=email%></td>
			<td width="12%"><strong>Company</strong></td>
			<td width="23%"><%=company%></td>
		</tr>
		<tr>
		<td width="10%"><strong>Mobile</strong></td>
			<td width="21%"><%=mobile%></td>
			<td width="10%"><strong>Lead Status</strong></td>
			<td align="left" width="25%"><%= leadstatus %></td>
			<td width="12%"><strong>Assigned To </strong></td>
                        <td width="23%"><%=GetProjectMembers.getUserName(((Integer)assi).toString())%></td>
		</tr>



		<tr>
			<td width="10%"><strong>Rating</strong></td>
			<td><%= rating %></td>
			<td width="10%"><strong>Web Site</strong></td>
			<td><%=website%></td>
			<td width="10%"><strong>Lead Potential</strong></td>
			<td><%=leadpotential%></td>

		</tr>
		<tr>
			<td width="10%"><strong>Due Date</strong></td>
			<td width="21%"><%=dueDate%></td>
			<td width="10%"><strong>Interested In</strong></td>
			<td width="25%"><%= product %></td>
			<td width="10%"><strong>Lead Owner</strong></td>
			<td><%=GetProjectManager.getUserName(Integer.parseInt(owner))%></td>
		</tr>


		<tr><td width="100%" bgcolor="white" colspan=6 height="10"></td></tr>
		<tr bgcolor="C3D9FF">
			<td colspan=6  bgcolor="C3D9FF"><strong>Address Information</strong>
			<input type="hidden" name="leadid" value="<%=leadid %>">
			<input type="hidden" name="owner" value="<%=owner %>"></td>
		</tr>



		<tr>
			<td width="10%"><strong>Street</strong></td>
			<td width="21%"><%=street%></td>


			<td width="10%"><strong>City</strong></td>
			<td width="25%"><%=city%></td>

			<td width="12%"><strong>State</strong></td>
			<td width="23%"><%=state%></td>
		</tr>
		<tr>
			<td width="10%"><strong>Zip</strong></td>
			<td width="21%"><%=zip%></td>

			<td width="10%"><strong>Country</strong></td>
			<td width="25%"><%=country%></td>
			
		</tr>
		<tr><td width="100%" bgcolor="white" colspan=6 height="10"></td></tr>


		<tr bgcolor="C3D9FF">
			<td colspan=6><strong>Additional Information</strong></td>
		</tr>


		<tr>
			<td width="10%" ><strong>Annual Revenue</strong></td>
			
			<td colspan="3"><%= annualrevenue %><strong class="style20"></strong></td>

			<td width="10%"><strong>No of employees</strong></td>
			<td colspan="2"><%= noofemployees %></td>
			</tr>
			<tr>

			<td width="10%"><strong>Industry</strong></td>
			
			<td align="left" width="35%" colspan="3"><%= industry %></td>

			<td width="10%"><strong>Lead Source</strong></td>
			
			<td align="left" width="35%"><%= leadsource %></td>
		</tr>

		<tr><td width="100%" bgcolor="white" colspan=6 height="10"></td></tr>
		<tr bgcolor="C3D9FF">
			<td colspan=6><strong>Descriptive Information</strong></td>
		</tr>

		<tr>
			<td width="10%" colspan=6><strong>Description</strong></td>
		</tr>
		<tr colspan=6>
			<td ><%=description%></td>
		</tr>

	
	</table>
<%
                   session.setAttribute("name",firstname);
                   session.setAttribute("category","lead");

                %> <iframe src="./comments.jsp?leadId=<%= leadid %>"
	scrolling="auto" frameborder="2" height="45%" width="100%"></iframe> <br>
<br>
<br>


<%
			}
		}
	}
}catch(Exception ex)
		{
			logger.error(ex.getMessage());
		}finally
				{
					if(rs!=null){
                        rs.close();
                    }
                    if(st!=null){
                        st.close();
                    }
					if (connection!=null)
					{
						connection.close();
					}
				}
%>
<BR>
</body>
</html>