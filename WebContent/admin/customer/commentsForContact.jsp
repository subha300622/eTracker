
<%@ page language="java" contentType="text/html"
	pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<meta name="keywords" content="GST in SAP, SAP GST Accelerator, GST Success in SAP, GST India in SAP, GST SAP Success, GST Suvidha Provider, GST ASP GSP, GST, CGST,SGST, IGST, UGST,  SAP NW based Product Development, SAP Consulting, SAP Implementation, SAP Support Services, SAP Outsourcing, SAP Implementation India, SAP Implementation Bangalore, SAP Implementation Chennai, SAP Implementation Belgium, SAP Implementation Paris, SAP Implemtation Australia, SAP Implementation France, SAP Implementation Mumbai, SAP Implementation Kerala, SAP Implementation Belgaum, SAP Implementation Thailand, SAP Implementation Mexico, SAP Implementation America">
<meta http-equiv="Content-Type" content="text/html ">
<title>Comment History</title>
</head>
<body bgcolor="#ffffee">

<%
	String logoutcheck=(String)session.getAttribute("Name");
	if(logoutcheck==null)
	{
		
		%>
<jsp:forward page="../SessionExpired.jsp"></jsp:forward>
<%
		
	}
        
        String contactName = (String)session.getAttribute("contactName");
%>

<%@ page
	import="java.sql.*,pack.eminent.encryption.*,com.eminent.util.*, org.apache.log4j.*"%>

<center><strong><font face="Tahoma" size="2"
	color="blue">Comment History for <%= contactName %></font></strong></center>
<br>

<%  

    //Configuring log4j properties

			
			Logger logger = Logger.getLogger("commentsForContact");
			
    Connection connection = null;
	PreparedStatement st = null;
	ResultSet rs = null;
	GetName g=null;
	
	try
	{
		connection=MakeConnection.getConnection();
		st = connection.prepareStatement("select commentedby,to_char(comment_date,'dd-Mon-yyyy') as commentdate,comment_date,comments from contact_comments where contactid=? order by comment_date asc");
		st.setInt(1,Integer.parseInt(request.getParameter("contactid")));
		rs = st.executeQuery();
		
		if(rs.next())		
		{
			%>
<table width="100%">
	<tr>
		<th>Commented By</th>
		<th>TimeStamp</th>
		<th>Comments</th>
	</tr>
	<%
			do
			{
				g=new GetName();
				%>
	<tr>
		<td align="center" width="25%"><%=g.getUserName(rs.getString(1))  %></td>
		<td align="center" width="25%"><%= rs.getString("commentdate") %>&nbsp;<%= rs.getTime("comment_date") %></td>
		<td align="center" width="50%"><%= rs.getString(4) %></td>
	</tr>
	<tr>
		<td colspan="3">--------------------------------------------------------------------------------------------------------</td>
	</tr>
	<%
			}while(rs.next());
			%>
</table>
<%
			
		}
		else
		{
			%>
<%= "Nothing to display"%>
<%
		}
	}
	catch(Exception e)
	{
		logger.error(e);
	}
	finally
	{
		if(rs!=null)
		{
			rs.close();
		}
		if(st!=null)
		{
			st.close();
		}
                if(connection!=null)
		{
			connection.close();
		}
	}
	
%>
</body>
</html>