<%@page import="org.apache.log4j.Logger"%>
<%@ page language="java" contentType="text/html"
	pageEncoding="UTF-8"%>
<%Logger logger = Logger.getLogger("updatecontact");
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
<TITLE>eTracker&#153; - Eminentlabs&#153; CRM, APM, TQM,  ERM and  EPTS
Solution</TITLE>
</head>
<body>
<table width="100%" bgcolor="#EEEEEE" height="5%" border="0">
	<tr>
		<td align="left" width="800"><b><font size="3"
			COLOR="#0000FF"> Current User: </font></b> <FONT SIZE="3" COLOR="#0000FF">
		&nbsp; <b> &nbsp;<%=session.getAttribute("fName")%>&nbsp; <%=session.getAttribute("lName")%></b></FONT></td>
		<td width="6%" align="center"><font size="2"
			face="Verdana, Arial, Helvetica, sans-serif"> <a
			href="<%=request.getContextPath() %>/profile.jsp">Profile</a></font></td>
		<td width="6%" align="center"><font size="2"
			face="Verdana, Arial, Helvetica, sans-serif"> <A
			HREF="<%= request.getContextPath() %>/logout.jsp" target="_parent">Logout</A></font></td>
		<%@ page import="java.sql.*,pack.eminent.encryption.*,com.pack.*,java.util.Calendar"%>
		<%
		Connection connection = null;
        PreparedStatement ps=null;
        String firstname="";
		String lastname="";
		String accounts="";
		String title="";
		String phone="";
		String mobile="";
		String email="";
                String pmail="";
		String reportsto="";
        String mailingstreet="";
		String mailingcity = "";
		String mailingstate="";
        String mailingzip = "";
		String mailingcountry="";
        
		String otherstreet="";
		String othercity = "";
		String otherstate="";
        String otherzip = "";
		String othercountry="";
		String fax="";
		String homephone="";
		String otherphone="";
		String assistant="";
        String asstphone="";
        String leadsource="";
        String birthdate="";
        String department="";
        String description = "";
		int contactid=9999;
        contactid=Integer.parseInt(request.getParameter("contactid"));
		firstname=request.getParameter("firstname");
		lastname=request.getParameter("lastname");
		accounts=request.getParameter("accounts");
		title=request.getParameter("title");
		phone=request.getParameter("phone");
		mobile=request.getParameter("mobile");
		email=request.getParameter("email");
                pmail=request.getParameter("personalemail");
		reportsto=request.getParameter("reportsto");
		
		mailingstreet=request.getParameter("mailingstreet");
		mailingcity=request.getParameter("mailingcity");
		mailingstate=request.getParameter("mailingstate");
		mailingzip=request.getParameter("mailingzip");
		mailingcountry=request.getParameter("mailingcountry");
		otherstreet=request.getParameter("otherstreet");
		othercity=request.getParameter("othercity");
		otherstate=request.getParameter("otherstate");
		otherzip=request.getParameter("otherzip");
		othercountry=request.getParameter("othercountry");

		fax=request.getParameter("fax");
		homephone=request.getParameter("homephone");
		otherphone=request.getParameter("otherphone");
		assistant=request.getParameter("assistant");
		asstphone=request.getParameter("asstphone");

		leadsource=request.getParameter("leadsource");
		birthdate=request.getParameter("birthdate");
		department=request.getParameter("department");
        description=request.getParameter("description");
        
        String company=request.getParameter("company");
        
		try{
			connection=MakeConnection.getConnection();
			if(connection != null)  {
				
				
				java.util.Date d = new java.util.Date();

    			Calendar cal = Calendar.getInstance();
    			cal.setTime(d);
    			//Timestamp ts = new Timestamp(cal.getTimeInMillis());
    			Timestamp ts = new Timestamp(d.getYear(),d.getMonth(),d.getDate(),d.getHours(),d.getMinutes(),d.getSeconds(),d.getSeconds());

				ps = connection.prepareStatement("update contact set title=?,firstname=?, lastname=?,phone=?,email=?,company=?, mobile=?, reportsto=?, mailingstreet=?, mailingcity=?, mailingstate=?, mailingzip=?, mailingcountry=?, fax=?, homephone=?, otherphone=?, department=?, assistant=?, asstphone=?, birthdate=?, leadsource=?,modifiedon=?,personalemail=? where contactid=?", ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
				
				ps.setString(1,StringUtil.fixSqlFieldValue(title));
				ps.setString(2,StringUtil.fixSqlFieldValue(firstname));
				ps.setString(3,StringUtil.fixSqlFieldValue(lastname));
			
				
				ps.setString(4,StringUtil.fixSqlFieldValue(phone));
				ps.setString(5,StringUtil.fixSqlFieldValue(email));
				ps.setString(6,StringUtil.fixSqlFieldValue(company));
				
				ps.setString(7,StringUtil.fixSqlFieldValue(mobile));
				ps.setString(8,StringUtil.fixSqlFieldValue(reportsto));
				
				ps.setString(9,StringUtil.fixSqlFieldValue(mailingstreet));
				ps.setString(10,StringUtil.fixSqlFieldValue(mailingcity));
				ps.setString(11,StringUtil.fixSqlFieldValue(mailingstate));
				ps.setString(12,StringUtil.fixSqlFieldValue(mailingzip));
				ps.setString(13,StringUtil.fixSqlFieldValue(mailingcountry));
				
				
				ps.setString(14,StringUtil.fixSqlFieldValue(fax));
				ps.setString(15,StringUtil.fixSqlFieldValue(homephone));
				ps.setString(16,StringUtil.fixSqlFieldValue(otherphone));
				
				ps.setString(17,StringUtil.fixSqlFieldValue(department));
				ps.setString(18,StringUtil.fixSqlFieldValue(assistant));
				ps.setString(19,StringUtil.fixSqlFieldValue(asstphone));
				
				ps.setString(20,StringUtil.fixSqlFieldValue(birthdate));
				ps.setString(21,StringUtil.fixSqlFieldValue(leadsource));
				ps.setTimestamp(22,ts);
                                ps.setString(23,StringUtil.fixSqlFieldValue(pmail));
			
				
				ps.setInt(24,contactid);
				ps.executeUpdate();
				connection.commit();
	%>
		<jsp:forward page="/contact/viewcontact.jsp" />
		<%
			}
		}
		catch(Exception e)  {
			logger.error(e.getMessage());
	    }finally
		{
			if (ps!=null)
				ps.close();
			if (connection!=null)
				connection.close();
		} 
	%>
	</tr>
</table>
<br>
</body>
</html>