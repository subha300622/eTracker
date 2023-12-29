<%-- 
    Document   : viewLostOpportunities
    Created on : May 26, 2009, 3:08:53 PM
    Author     : Tamilvelan
--%>

<%@ page language="java" contentType="text/html"
	pageEncoding="UTF-8"%>
	<%@ page import="com.eminent.util.*,org.apache.log4j.*,java.util.*"%>
<%


	Logger logger = Logger.getLogger("Edit Opportunity");
	

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
<LINK title=STYLE	href="<%= request.getContextPath() %>/eminentech support files/main_ie.css"
	type="text/css" rel="STYLESHEET">
<script type="text/javascript" src="<%= request.getContextPath() %>/javaScript/checkSubmit.js"></script>
<title>eTracker&#0153; - Eminentlabs CRM,APM,ERM and PTS Solution</title>

</head>

<body>
<jsp:include page="/header.jsp" />
<BR>
<!-- Table To Display The Formatted String "Add New User" -->
<table cellpadding="0" cellspacing="0" width="100%">
	<tr border="2" bgcolor="#c3d9ff">
		<td border="1" align="left" width="100%"><font size="4"
			COLOR="#0000FF"><b> View Opportunity</b></font> <FONT SIZE="3"
			COLOR="#0000FF"> </FONT></td>
	</tr>
</table>
<BR>
<%@ page import="java.sql.*,pack.eminent.encryption.*,java.text.*"%> <%
int opportunityid=Integer.parseInt(request.getParameter("opportunityid"));
Connection connection = null;
Statement st=null;
ResultSet rs=null;
try  {
	connection=MakeConnection.getConnection();
	if(connection != null)  {
		st = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
		rs = st.executeQuery("SELECT OPPORTUNITYNAME,TYPE,CLOSE_DATE,STAGE,PROBABILITY,AMOUNT,LEADSOURCE,NEXTSTEP,DESCRIPTION,OPPORTUNITY_OWNER,ASSIGNEDTO,PHONE,WEBSITE from OPPORTUNITY where OPPORTUNITYID="+opportunityid);
		if(rs!=null)
		{
			while(rs.next())
			{
				String opportunityname	=	rs.getString("OPPORTUNITYNAME");
				String owner			=	rs.getString("OPPORTUNITY_OWNER");
				String typ				=	rs.getString("TYPE");
				java.sql.Date closedate		=	rs.getDate("CLOSE_DATE");
				String stage			=	rs.getString("STAGE");
				String probability		=	rs.getString("PROBABILITY");
				String amount			=	rs.getString("AMOUNT");
                String leadsourc		=	rs.getString("LEADSOURCE");
				String nextstep			=	rs.getString("NEXTSTEP");
				String description		=	rs.getString("DESCRIPTION");
				int assi				=	rs.getInt("ASSIGNEDTO");
                String phone            =   rs.getString("PHONE");
                String website          =   rs.getString("WEBSITE");

				String type = "NA";
                if(typ != null){
                	type =typ;
                }

                SimpleDateFormat dfm =  new SimpleDateFormat("d-M-yyyy");
				String dueDate = "NA";
                if(closedate != null){
                    dueDate = dfm.format(closedate);
                }
                String leadsource = "NA";
                if(leadsourc != null){
                	leadsource =leadsourc;
                }
                String NextStep = "NA";
                if(nextstep != null){
                	NextStep =nextstep;
                }
                String Description = "";
                if(description != null){
                	Description =description;
                }

		%>

<table width="100%" bgColor=#E8EEF7 border="0" align="center">
	<TBODY>

		<tr>
			<td width="20%"><b>Opportunity Name</b></td>
			<td><%=opportunityname%></td>
			<td width="20%"><b>Stage</b></td>
			<td ><%=stage%></td>
		</tr>
		<tr>


			<td width="20%"><strong>Probability(%)</strong></td>
			<td><%=probability%></td>
			<td width="20%"><strong>Amount</strong></td>
			<td><%=amount%></td>

		</tr>
		<tr>
			
			<td width="20%"><strong>Type</strong></td>
		<td><%=type%></td>
			<td width="12%"><strong>Assigned To </strong></td>
				<td width="23%"><%=GetProjectManager.getUserName(assi)%>	</td>
		</tr>
		<tr>

			<td width="20%"><strong>Closing Date</strong><font size="10" COLOR="#FF0000">*</font></td>
			<td><%=dueDate%></td>
			<td width="20%"><strong>opportunity Owner</strong></td>
			<td><%=GetProjectManager.getUserName(Integer.parseInt(owner))%></td>
		</tr>

		<tr bgcolor="C3D9FF">
			<td colspan=2><strong>Additional Information</strong></td>
			<td><input type="hidden" name="owner"  size=25 value="<%=owner%>"></td>
			<td><input type="hidden" name="opportunityid" value="<%=opportunityid %>"></td>
		</tr>

		<tr>
			
			<td width="20%"><strong>Lead Source</strong></td>
			<td align="left"><%=leadsource%></td>
			
		</tr>
		<tr>
			<td width="20%"><strong>Next Step</strong></td>
			<td><%=NextStep%></td>
		</tr>

		<tr bgcolor="C3D9FF" >
			<td colspan="4"><strong>Descriptive Information</strong></td>
		</tr>

		<tr>
			<td width="10%"><strong>Description</strong></td>
			<td colspan=3><%=Description %></td>
		</tr>

	
</table>
<%
                   session.setAttribute("name",opportunityname);
                   session.setAttribute("category","opportunity");

                %>
 <iframe
	src="./comments.jsp?opportunityId=<%= opportunityid %>"
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