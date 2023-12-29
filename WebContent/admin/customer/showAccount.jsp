<%-- 
    Document   : showAccount
    Created on : 29 Jun, 2010, 6:37:16 PM
    Author     : Tamilvelan
--%>
<%@ page language="java" contentType="text/html"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*,com.eminent.util.*,org.apache.log4j.*,java.text.*" %>
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
<title>eTracker&#0153; - Eminentlabs CRM,APM,ERM and PTS Solution</title>
</head>

<body>
<jsp:include page="/header.jsp" />
<BR>
<!-- Table To Display The Formatted String "Add New User" -->
<table cellpadding="0" cellspacing="0" width="100%">
	<tr border="2" bgcolor="#c3d9ff">
		<td border="1" align="left" width="100%"><font size="4"
			COLOR="#0000FF"><b> Account Information</b></font> <FONT SIZE="3"
			COLOR="#0000FF"> </FONT></td>
	</tr>
</table>
<BR>
<%@ page import="java.sql.*,pack.eminent.encryption.*"%> <%
int accountid=Integer.parseInt(request.getParameter("accountid"));
Connection connection = null;
Statement st=null;
ResultSet rs=null;
try  {
	connection=MakeConnection.getConnection();
	if(connection != null)  {
		st = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);

		rs = st.executeQuery("SELECT ACCOUNT_OWNER,ACCOUNTNAME,PARENTACCOUNT,PHONE,FAX,WEBSITE,TYPE,INDUSTRY,EMPLOYEES,ANNUALREVENUE,DESCRIPTION,BILLINGSTREET,BILLINGCITY,BILLINGSTATE,BILLINGZIP,BILLINGCOUNTRY,SHIPPINGSTREET,SHIPPINGCITY,SHIPPINGSTATE,SHIPPINGZIP,SHIPPINGCOUNTRY,ASSIGNEDTO,duedate,account_amount from account where accountid="+accountid);
		if(rs!=null)
		{
			while(rs.next())
			{
				String owner=rs.getString("ACCOUNT_OWNER");
				String accountname=rs.getString("ACCOUNTNAME");
				String parentaccount=rs.getString("PARENTACCOUNT");
				String phone=rs.getString("PHONE");
				String fax=rs.getString("FAX");
				String website=rs.getString("WEBSITE");
				String type=rs.getString("type");
				String industry=rs.getString("INDUSTRY");
               	String employees=rs.getString("EMPLOYEES");
				String annualrevenue=rs.getString("ANNUALREVENUE");
				String description=rs.getString("DESCRIPTION");
                String billingstreet=rs.getString("BILLINGSTREET");
                String billingcity=rs.getString("BILLINGCITY");
				String billingstate=rs.getString("BILLINGSTATE");
                String billingzip=rs.getString("BILLINGZIP");
                String billingcountry=rs.getString("BILLINGCOUNTRY");

                String shippingstreet=rs.getString("SHIPPINGSTREET");
                String shippingcity=rs.getString("SHIPPINGCITY");
				String shippingstate=rs.getString("SHIPPINGSTATE");
                String shippingzip=rs.getString("SHIPPINGZIP");
                String shippingcountry=rs.getString("SHIPPINGCOUNTRY");
                int assi=rs.getInt("assignedto");

                java.util.Date due=rs.getDate("duedate");
                logger.info("Due Date"+due);
				SimpleDateFormat dfm =  new SimpleDateFormat("dd-MMM-yy");
				String dueDate = "NA";
                if(due != null){
                    dueDate = dfm.format(due);
                }

                int account_amount=rs.getInt("account_amount");

                if (accountname==null) accountname="NA";
				if (parentaccount==null) parentaccount="NA";
				if (phone==null) phone="NA";
				if (fax==null) fax="NA";
				if (website==null) website="NA";
				if (type==null) type="NA";
				if (industry==null)	industry="NA";
				if (employees==null)employees="NA";
				if (annualrevenue==null) annualrevenue="NA";
				if (description==null) description="NA";
				if (billingstreet==null) billingstreet="NA";
				if (billingcity==null) billingcity="NA";
				if (billingstate==null)	billingstate="NA";
				if (billingzip==null) billingzip="NA";
				if (billingcountry==null) billingcountry="NA";
				if (shippingstreet==null) shippingstreet="NA";
				if (shippingcity==null) shippingcity="NA";
				if (shippingstate==null)	shippingstate="NA";
				if (shippingzip==null) shippingzip="NA";
				if (shippingcountry==null) shippingcountry="NA";



		%>

<table width="100%" bgColor=#E8EEF7 border="0" align="center">
	<TBODY>

		<tr>
			<td width="15%"><strong>Account Name</strong></td>
			<td width="25%"><%=accountname%></td>
			<td width="15%"><strong>Parent Account </strong></td>
			<td width="25%"><%=parentaccount%></td>


		</tr>
		<tr>

			<td width="15%"><strong>Phone</strong></td>
			<td width="25%"><%=phone%></td>
			<td width="15%"><strong>Fax</strong></td>
			<td width="25%"><%=fax%></td>
		</tr>
		<tr>

			<td width="15%"><strong>website</strong></td>
			<td width="25%"><%=website%></td>
			<td width="15%"><strong>Assigned To</strong> </td>
			<td width="25%"><%=GetProjectMembers.getUserName(((Integer)assi).toString())%></td>

		</tr>
		<tr>
			<td width="15%"><strong>Due Date</strong></td>
			<td width="25%"><%=dueDate%></td>
			<td width="15%"><strong>Account Owner</strong></td>
			<td width="25%"><%=GetProjectManager.getUserName(Integer.parseInt(owner))%></td>
		</tr>
<tr>

		<td width="10%"><strong>Account Amount</strong></td>
                <td width="25%"><%=account_amount%></td>
		</tr>

		<tr bgcolor="C3D9FF">
			<td colspan=3><strong>Additional Information</strong></td>
			<td><input type="hidden" name="accountid" value="<%=accountid %>"></td>
		</tr>

		<tr>
			<td width="15%"><strong>Billing Street</strong></td>
			<td width="25%"><%=billingstreet%></td>
			<td width="15%"><strong>Shipping Street</strong></td>
			<td width="25%"> <%=shippingstreet%></td>
		</tr>
		<tr>
			<td width="15%"><strong>Billing City</strong></td>
			<td width="25%"><%=billingcity%></td>
			<td width="15%"><strong>Shipping City</strong></td>
			<td width="25%"><%=shippingcity%></td>
		</tr>
		<tr>
			<td width="15%"><strong>Billing State</strong></td>
			<td width="25%"><%=billingstate%></td>
			<td width="15%"><strong>Shipping State</strong></td>
			<td width="25%"><%=shippingstate%></td>
		</tr>
		<tr>
			<td width="15%"><strong>Billing Zip</strong></td>
			<td width="25%"><%=billingzip%></td>
			<td width="15%"><strong>Shipping Zip</strong></td>
			<td width="25%"><%=shippingzip%></td>
		</tr>
		<tr>
			<td width="15%"><strong>Billing Country</strong></td>
			<td width="25%"><%=billingcountry%></td>
			<td width="15%"><strong>Shipping Country</strong></td>
			<td width="25%"><%=shippingcountry%></td>
		</tr>

		<tr>
			<td width="15%"><strong>Type</strong></td>
			
			<td width="25%"><%= type %></td>
			<td width="15%"><strong>Industry</strong></td>
			<td width="25%"><%= industry %></td>

		</tr>
		<tr>

			<td width="15%"><strong>Annual Revenue</strong></td>
			
			<td width="25%"><%= annualrevenue %></td>
			
			<td width="25%"><%= employees %>
				
		</td>
		</tr>


		<tr>
			<td width="100%" colspan=4><strong>Description</strong></td>
		</tr>
		<tr>
			<td width="100%" colspan=4><%=description%></td>
		</tr>
</table>
<%
                   session.setAttribute("name",accountname);
                   session.setAttribute("category","account");

                %> <iframe
	src="./comments.jsp?accountId=<%= accountid %>" scrolling="auto"
	frameborder="2" height="45%" width="100%"></iframe> 
        



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

</body>
</html>