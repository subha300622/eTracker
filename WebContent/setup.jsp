<%@ page language="java" contentType="text/html"
	pageEncoding="UTF-8" errorPage="/errorpage.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%@page session="false" import="org.apache.log4j.*"%>
<%@ page import="javax.xml.parsers.*"%>
<%@ page import="org.w3c.dom.*"%>
<html>
<meta name="keywords" content="GST in SAP, SAP GST Accelerator, GST Success in SAP, GST India in SAP, GST SAP Success, GST Suvidha Provider, GST ASP GSP, GST, CGST,SGST, IGST, UGST,  SAP NW based Product Development, SAP Consulting, SAP Implementation, SAP Support Services, SAP Outsourcing, SAP Implementation India, SAP Implementation Bangalore, SAP Implementation Chennai, SAP Implementation Belgium, SAP Implementation Paris, SAP Implemtation Australia, SAP Implementation France, SAP Implementation Mumbai, SAP Implementation Kerala, SAP Implementation Belgaum, SAP Implementation Thailand, SAP Implementation Mexico, SAP Implementation America">
<meta http-equiv="Content-Type" content="text/html ">
<title>eTracker&#153; - Eminentlabs&#153; CRM, APM, TQM,  ERM and  EPTS
Solution</title>
</head>
<body>
<%@ page errorPage="/errorpage.jsp"%>
<%@ page language="java"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="pack.eminent.encryption.*"%>

<jsp:useBean id="RightsSetup" class="com.pack.RightsSetupBean" />

<%

	Logger logger = Logger.getLogger("Setup");
	
	Connection connection = null;
	ResultSet resultset = null;
	Statement statement = null;
	ArrayList al = null;

	try
	{
		
		
		//String sessionID = session.getId();
		//logger.debug("SessionID:"+sessionID);
		
		//logger.debug("SessionID Status:"+session.isNew());		
		//session.setAttribute("SessionID",sessionID);

	
		
			connection = MakeConnection.getConnection();
			logger.info("---------------->>>Setup Connection has been established<<<--------------------");	
			
			
			

//			logger.debug("SESSION ID:"+session.getId());
//			session.setAttribute("SESSIONID",session.getId());
			if (connection!=null)
			{
				al=RightsSetup.Query(connection);
			}
			
			if(al.contains(1))
			{
				logger.info("User's RoleID:\t"+al);
				response.sendRedirect("./login.jsp");
		 	}
	     	else  
			{
	     		logger.info("--------->>>Redirecting to Admin Creation Page<<<-------");
	     		response.sendRedirect("./admin/user/adminaccount.jsp");
			}
		
		
	
	}
	catch(Exception e)
	{
		logger.error("Exception in setup:"+e);
                logger.error(e.getMessage());
	}
	finally
	{
		if(connection!=null)
			connection.close();
		if(resultset!=null)
			resultset.close();
		if(statement!=null)
			statement.close();
		logger.info("Connection resources have been closed");
	}
%>
</body>
</html>