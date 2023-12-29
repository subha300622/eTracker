<%@page import="org.apache.log4j.Logger"%>
<%@ page language="java" contentType="text/html"
	pageEncoding="UTF-8"%>
<%@ page import="pack.eminent.encryption.*"%>
<%@ page import="java.sql.*"%>
<%@ page errorPage="changepwderror.jsp"%>
<%@ page import="org.apache.commons.codec.language.*"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<meta name="keywords" content="GST in SAP, SAP GST Accelerator, GST Success in SAP, GST India in SAP, GST SAP Success, GST Suvidha Provider, GST ASP GSP, GST, CGST,SGST, IGST, UGST,  SAP NW based Product Development, SAP Consulting, SAP Implementation, SAP Support Services, SAP Outsourcing, SAP Implementation India, SAP Implementation Bangalore, SAP Implementation Chennai, SAP Implementation Belgium, SAP Implementation Paris, SAP Implemtation Australia, SAP Implementation France, SAP Implementation Mumbai, SAP Implementation Kerala, SAP Implementation Belgaum, SAP Implementation Thailand, SAP Implementation Mexico, SAP Implementation America">
<meta http-equiv="Content-Type" content="text/html ">
<TITLE>eTracker&#153; - Eminentlabs&#153; CRM, APM, TQM,  ERM and  EPTS Solution</TITLE>
</head>
<body>

<%Logger logger = Logger.getLogger("change_pwd");
	Encryption encryption = new Encryption();
	Connection connection = null;
	PreparedStatement ps=null,ps1 = null;
	ResultSet rs = null;
	String user_email = (String)session.getAttribute("Name");
	try
	{
		connection=MakeConnection.getConnection();
		ps = connection.prepareStatement("select password from users where email=?");
		ps.setString(1,user_email);
		rs = ps.executeQuery();
		if(rs.next())
		{
			// RefinedSoundex class from Apache Software Foundation
	//		RefinedSoundex rf = new RefinedSoundex();
//			System.out.println("New Password:"+request.getParameter("newpwd"));
			String db_pwd = rs.getString("password");
			if(db_pwd.equals(Encryption.encrypt(request.getParameter("currentpwd"))))
			{
				
				ps1 = connection.prepareStatement("update users set password=? where email=?");
				ps1.setString(1,Encryption.encrypt(request.getParameter("newpwd")));
				ps1.setString(2,user_email);
				int x = ps1.executeUpdate();
				if(x>0)
				{
				
					%>
<jsp:forward page="changepwdsuccess.jsp" />
<%		
				}
			}
			else
			{
				%>
<jsp:forward page="Changepass_Denied.jsp"></jsp:forward>
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
	    if(ps!=null)
		{
			ps.close();
		}
	    if(ps1!=null)
	    {
	    	ps1.close();
	    }
		if(connection!=null)
		{
			connection.close();
		}
	}
%>


</body>
</html>